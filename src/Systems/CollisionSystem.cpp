#include "CollisionSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/CircleShape.hpp>

CollisionSystem::CollisionSystem(Context& context) :
    BaseSystem(context),
    m_Callback()
{
	CalculateRaySpacing();
}

void CollisionSystem::update(sf::Time& dt)
{
    m_Context->b2_World->Step(dt.asSeconds(), 8, 5);

    UpdateRaycastOrigins();
    handleRaycasts();
}

void CollisionSystem::handleRaycasts()
{
    auto view = m_Context->registry->view<C_PlayerTag>();

    for(auto entity : view)
    {
        if(!m_Context->registry->has<C_Rigidbody>(entity)) continue;

        auto &rb = m_Context->registry->get<C_Rigidbody>(entity);
        auto &raycastComp = m_Context->registry->get<C_Raycast>(entity);
        raycastComp.collisionInfo.reset();
        raycastComp.rayLength = 1.7f;

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
	        auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
	        if (shape == nullptr) return;

	        // Check Above
	        for (int i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.topLeft +
		                           utils::sfVecToB2Vec(math::VECTOR_UP * (raycastComp.verticalRaySpacing * i));
		        m_Context->b2_World->RayCast(&m_Callback, rayOrigin,
		                                     rayOrigin + utils::sfVecToB2Vec(math::VECTOR_UP * raycastComp.rayLength));
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionAbove = true;
			        break;
		        }
	        }
	        m_Callback = RayCastCallback();

	        // Check Below
	        for (int i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_LEFT* (raycastComp.verticalRaySpacing * i));
		        m_Context->b2_World->RayCast(&m_Callback, rayOrigin, rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * raycastComp.rayLength));
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionBelow = true;
			        break;
		        }
	        }
	        m_Callback = RayCastCallback();

	        // Check Right
	        for (int i = 0; i < raycastComp.horizontalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.topRight +
		                           utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.horizontalRaySpacing * i));
		        m_Context->b2_World->RayCast(&m_Callback, rayOrigin, rayOrigin + (utils::sfVecToB2Vec(
				        math::VECTOR_RIGHT * raycastComp.rayLength)));
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionRight = true;
			        break;
		        }
	        }
	        m_Callback = RayCastCallback();

	        // Check Left
	        for (int i = 0; i < raycastComp.horizontalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP * (raycastComp.horizontalRaySpacing * i));
		        m_Context->b2_World->RayCast(&m_Callback, rayOrigin, rayOrigin + utils::sfVecToB2Vec(math::VECTOR_LEFT * raycastComp.rayLength));
		        if(m_Callback.m_fixture != nullptr)
                {
                    raycastComp.collisionInfo.collisionLeft = true;
                    break;
                }
            }
	        m_Callback = RayCastCallback();
        }
    }
}

void CollisionSystem::CalculateRaySpacing()
{
	auto view = m_Context->registry->view<C_PlayerTag>();

	for(auto entity : view)
	{
		auto &rb = m_Context->registry->get<C_Rigidbody>(entity);
		auto &raycastComp = m_Context->registry->get<C_Raycast>(entity);
		for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
		{
			auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
			if (shape == nullptr) return;

			auto bounds = shape->getGlobalBounds();

			float boundsWidth = bounds.width;
			float boundsHeight = bounds.height;

			raycastComp.horizontalRayCount = std::floor(boundsHeight / raycastComp.dstBetweenRays);
			raycastComp.verticalRayCount = std::floor(boundsWidth / raycastComp.dstBetweenRays);

			raycastComp.horizontalRaySpacing = boundsHeight / (raycastComp.horizontalRayCount);
			raycastComp.verticalRaySpacing = boundsWidth / (raycastComp.verticalRayCount);
		}
	}
}

void CollisionSystem::UpdateRaycastOrigins()
{
	m_Context->registry->view<C_Raycast, C_Rigidbody>().each([&](auto entity, auto& raycastComp, auto& rb)
	{
		auto fixture = rb.rigidbody->GetFixtureList();

		auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
		if (shape == nullptr) return;

		auto bounds = shape->getGlobalBounds();
		auto size = shape->getSize();

		raycastComp.raycastOrigins.topLeft = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left, bounds.top) + sf::Vector2f(1.f, 1.f));
		raycastComp.raycastOrigins.topRight = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left + size.x, bounds.top) + sf::Vector2f(-1.f, 1.f));
		raycastComp.raycastOrigins.bottomLeft = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left, bounds.top + size.y) + sf::Vector2f(1.f, -1.f));
		raycastComp.raycastOrigins.bottomRight = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left + size.x, bounds.top + size.y) + sf::Vector2f(-1.f, -1.f));
	});
}