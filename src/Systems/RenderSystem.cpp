#include "RenderSystem.hpp"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include "../Components/C_Tilemap.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../core/World.h"

#include <vector>

RenderSystem::RenderSystem(Context& context, World *world) :
BaseSystem(context, world),
debugDraw()
{
    // Initialize SFML Debug Draw
    debugDraw.SetWindow(m_Context->window);
    debugDraw.ClearFlags(debugDraw.e_aabbBit & debugDraw.e_centerOfMassBit &
                         debugDraw.e_jointBit & debugDraw.e_pairBit & debugDraw.e_shapeBit);
    debugDraw.SetFlags( b2Draw::e_jointBit | debugDraw.e_shapeBit); // Debug draw shapes and joints only
	m_World->getB2World()->SetDebugDraw(&debugDraw);
}


void RenderSystem::draw()
{
	m_World->getEntityRegistry()->view<C_Tilemap>().each([&](auto entity, auto& tilemap)
	{
		for(const auto &l : tilemap.m_TileLayers)
			m_Context->window->draw(*l);
	});

	m_World->getEntityRegistry()->view<C_Animation>().each([&](auto entity, auto &anim)
	{
		m_Context->window->draw(anim.animatedSprite);
	});

	if (m_World->sfmlDebugging())
	{
		m_World->getEntityRegistry()->view<C_Rigidbody>().each([&](auto entity, auto& rb)
			{
				drawDebugInfo(entity, rb);
			});
	}

	if (m_World->b2dDebugging())
		m_World->getB2World()->DrawDebugData();
}

void RenderSystem::drawDebugInfo(entt::entity& entity, C_Rigidbody& rb)
{
    for(b2Fixture* fixture = m_Context->bodies[entity]->GetFixtureList(); fixture != nullptr; fixture = fixture->GetNext())
    {
        auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
        if (shape == nullptr) return;
        m_Context->window->draw(*shape);

        if(m_World->getEntityRegistry()->has<C_Raycast>(entity))
        {
            auto &raycastComp = m_World->getEntityRegistry()->get<C_Raycast>(entity);

	        for(size_t i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
	        	// Above
		        sf::Vertex line[2];
		        line[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topLeft) + math::VECTOR_RIGHT * (raycastComp.verticalRaySpacing * i);
		        line[1].position = line[0].position + (math::VECTOR_UP  * raycastComp.rayLength);
		        line[0].color = sf::Color::Red;
		        line[1].color = sf::Color::Red;

		        m_Context->window->draw(line, 2, sf::Lines);

		        // Below
		        line[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomRight) + math::VECTOR_LEFT * (raycastComp.verticalRaySpacing * i);
		        line[1].position = line[0].position + (math::VECTOR_DOWN  * raycastComp.rayLength );
		        line[0].color = sf::Color::Red;
		        line[1].color = sf::Color::Red;

		        m_Context->window->draw(line, 2, sf::Lines);
	        }

            for(size_t i = 0; i < raycastComp.horizontalRayCount; ++i)
            {
	            // Right
	            sf::Vertex line[2];
	            line[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topRight) + math::VECTOR_DOWN * (raycastComp.horizontalRaySpacing * i);
	            line[1].position = line[0].position + (math::VECTOR_RIGHT  * raycastComp.rayLength );
	            line[0].color = sf::Color::Red;
	            line[1].color = sf::Color::Red;

	            m_Context->window->draw(line, 2, sf::Lines);

	            // Left
	            line[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomLeft) + math::VECTOR_UP * (raycastComp.horizontalRaySpacing * i);
		        line[1].position = line[0].position + (math::VECTOR_LEFT * raycastComp.rayLength );
		        line[0].color = sf::Color::Red;
		        line[1].color = sf::Color::Red;

		        m_Context->window->draw(line, 2, sf::Lines);
            }
        }
    }
}