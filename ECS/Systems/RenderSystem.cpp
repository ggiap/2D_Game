#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Animation.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Raycast.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"

RenderSystem::RenderSystem(Context& context) :
BaseSystem(context),
debugDraw()
{
    // Initialize SFML Debug Draw
    debugDraw.SetWindow(m_Context->window);
    debugDraw.ClearFlags(debugDraw.e_aabbBit & debugDraw.e_centerOfMassBit &
                         debugDraw.e_jointBit & debugDraw.e_pairBit & debugDraw.e_shapeBit);
    debugDraw.SetFlags(b2Draw::e_aabbBit | b2Draw::e_jointBit); // Debug draw shapes and joints only
    m_Context->b2_World->SetDebugDraw(&debugDraw);
}


void RenderSystem::update(sf::Time dt)
{
	m_Context->registry->view<C_Rigidbody>().each([&](auto entity, auto& rb)
		{
	        drawDebugInfo(entity, rb);
		});

	m_Context->registry->view<C_Animation>().each([&](auto entity, auto& anim)
	{
	    m_Context->window->draw(anim.animatedSprite);
	});
}

void RenderSystem::drawDebugInfo(entt::entity& entity, C_Rigidbody& rb)
{
    for(b2Fixture* fixture = m_Context->bodies[entity]->GetFixtureList(); fixture != nullptr; fixture = fixture->GetNext())
    {
        auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
        if (shape == nullptr) return;
        m_Context->window->draw(*shape);

        if(m_Context->registry->has<C_PlayerTag>(entity))
        {
            auto &raycastComp = m_Context->registry->get<C_Raycast>(entity);

            sf::Vertex line[2];
            line[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topLeft);
            line[1].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topLeft) +
                    math::VECTOR_UP * raycastComp.rayLength;
            line[0].color = sf::Color::Red;
            line[1].color = sf::Color::Red;


            sf::Vertex line2[2];
            line2[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topRight);
            line2[1].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.topRight) +
                               math::VECTOR_RIGHT * raycastComp.rayLength;
            line2[0].color = sf::Color::Red;
            line2[1].color = sf::Color::Red;


            sf::Vertex line3[2];
            line3[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomLeft);
            line3[1].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomLeft) +
                               math::VECTOR_LEFT * raycastComp.rayLength;
            line3[0].color = sf::Color::Red;
            line3[1].color = sf::Color::Red;


            sf::Vertex line4[2];
            line4[0].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomRight);
            line4[1].position = utils::B2VecToSFVec<sf::Vector2f>(raycastComp.raycastOrigins.bottomRight) +
                               math::VECTOR_DOWN * raycastComp.rayLength;
            line4[0].color = sf::Color::Red;
            line4[1].color = sf::Color::Red;


            m_Context->window->draw(line, 2, sf::Lines);
            m_Context->window->draw(line2, 2, sf::Lines);
            m_Context->window->draw(line3, 2, sf::Lines);
            m_Context->window->draw(line4, 2, sf::Lines);
        }
    }
    //m_Context->b2_World->DrawDebugData();
}