#include "CollisionSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Utils/FixtureUserData.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/CircleShape.hpp>
#include "../core/World.h"

CollisionSystem::CollisionSystem(Context& context, World* world) :
    BaseSystem(context, world),
    m_Callback()
{
	init();
}

void CollisionSystem::update(sf::Time& dt)
{
    m_World->getB2World()->Step(dt.asSeconds(), 8, 5);
	m_World->getB2World()->ClearForces();

    UpdateRaycastOrigins();
    handleRaycasts();
}

void CollisionSystem::init()
{
	CalculateRaySpacing();
}

void CollisionSystem::handleRaycasts()
{
    auto view = m_World->getEntityRegistry()->view<C_Raycast>();

    for(auto entity : view)
    {
        auto &rb = m_World->getEntityRegistry()->get<C_Rigidbody>(entity);
        auto &raycastComp = m_World->getEntityRegistry()->get<C_Raycast>(entity);
        raycastComp.collisionInfo.reset();

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
			// Keep enemies on platforms
			if (m_World->getEntityRegistry()->has<C_EnemyTag>(entity))
			{
				b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP);
				b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
				if (m_Callback.m_fixture != nullptr)
				{
					raycastComp.collisionInfo.groundCheckLeft = true;
				}

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

				m_Callback = RayCastCallback();

				rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_UP);
				rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
				if (m_Callback.m_fixture != nullptr)
				{
					raycastComp.collisionInfo.groundCheckRight = true;
				}

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

				m_Callback = RayCastCallback();
			}

	        // Check Above
	        for (int i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(math::VECTOR_DOWN / 2.f +
					math::VECTOR_RIGHT * (raycastComp.verticalRaySpacing * i));
				b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_UP * raycastComp.rayLength);

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

		        m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
					auto userData = static_cast<FixtureUserData*>(m_Callback.m_fixture->GetUserData());
					if (userData == nullptr) continue;

			        raycastComp.collisionInfo.collisionAbove = true;
			        raycastComp.collisionInfo.entityAbove = userData->entity;
			        break;
		        }
				m_Callback = RayCastCallback();
	        }
	        m_Callback = RayCastCallback();

	        // Check Below
	        for (int i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_UP / 2.f +
					math::VECTOR_LEFT * (raycastComp.verticalRaySpacing * i));
				b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * raycastComp.rayLength);

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
					auto userData = static_cast<FixtureUserData*>(m_Callback.m_fixture->GetUserData());
					if (userData == nullptr) continue;

			        raycastComp.collisionInfo.collisionBelow = true;
					raycastComp.collisionInfo.entityBelow = userData->entity;
					//raycastComp.collisionInfo.normalBelow = m_Callback.m_normal;
			        break;
		        }
				m_Callback = RayCastCallback();
	        }
	        m_Callback = RayCastCallback();

	        // Check Right
	        for (int i = 0; i < raycastComp.horizontalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.topRight + utils::sfVecToB2Vec(math::VECTOR_LEFT / 2.f +
					math::VECTOR_DOWN * (raycastComp.horizontalRaySpacing * i));
				b2Vec2 rayDir = rayOrigin + (utils::sfVecToB2Vec(math::VECTOR_RIGHT * raycastComp.rayLength));

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
					auto userData = static_cast<FixtureUserData*>(m_Callback.m_fixture->GetUserData());
					if (userData == nullptr) continue;

			        raycastComp.collisionInfo.collisionRight = true;
					raycastComp.collisionInfo.entityRight = userData->entity;
			        break;
		        }
				m_Callback = RayCastCallback();
	        }
	        m_Callback = RayCastCallback();

	        // Check Left
	        for (int i = 0; i < raycastComp.horizontalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_RIGHT / 2.f +
					math::VECTOR_UP * (raycastComp.horizontalRaySpacing * i));
				auto rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_LEFT * raycastComp.rayLength);

				createLine(rayOrigin, rayDir, raycastComp.raycasts);

		        m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if(m_Callback.m_fixture != nullptr)
                {
					auto userData = static_cast<FixtureUserData*>(m_Callback.m_fixture->GetUserData());
					if (userData == nullptr) continue;

                    raycastComp.collisionInfo.collisionLeft = true;
					raycastComp.collisionInfo.entityLeft = userData->entity;
                    break;
                }
				m_Callback = RayCastCallback();
            }
	        m_Callback = RayCastCallback();
        }
    }
}

void CollisionSystem::CalculateRaySpacing()
{
	auto view = m_World->getEntityRegistry()->view<C_Raycast>();

	for(auto entity : view)
	{
		auto &rb = m_World->getEntityRegistry()->get<C_Rigidbody>(entity);
		auto &raycastComp = m_World->getEntityRegistry()->get<C_Raycast>(entity);
		for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
		{
			auto userData = static_cast<FixtureUserData*>(fixture->GetUserData());
			if (userData == nullptr || userData->shape == nullptr) continue;

			auto bounds = userData->shape->getGlobalBounds();

			float boundsWidth = bounds.width;
			float boundsHeight = bounds.height;

			raycastComp.horizontalRayCount = std::ceil(boundsHeight / raycastComp.dstBetweenRays);
			raycastComp.verticalRayCount = std::ceil(boundsWidth / raycastComp.dstBetweenRays);

			raycastComp.horizontalRaySpacing = boundsHeight / (raycastComp.horizontalRayCount);
			raycastComp.verticalRaySpacing = boundsWidth / (raycastComp.verticalRayCount);

			raycastComp.horizontalRayCount += 1;
			raycastComp.verticalRayCount += 1;
		}
	}
}

void CollisionSystem::UpdateRaycastOrigins()
{
	m_World->getEntityRegistry()->view<C_Raycast, C_Rigidbody>().each([&](auto entity, auto& raycastComp, auto& rb)
	{
		raycastComp.raycasts.clear();
		auto fixture = rb.rigidbody->GetFixtureList();

		auto userData = static_cast<FixtureUserData*>(fixture->GetUserData());
		if (userData == nullptr || userData->shape == nullptr) return;

		auto bounds = userData->shape->getGlobalBounds();
		auto &size = userData->shape->getSize();

		raycastComp.raycastOrigins.topLeft = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left, bounds.top));
		raycastComp.raycastOrigins.topRight = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left + size.x, bounds.top));
		raycastComp.raycastOrigins.bottomLeft = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left, bounds.top + size.y));
		raycastComp.raycastOrigins.bottomRight = utils::sfVecToB2Vec(
				sf::Vector2f(bounds.left + size.x, bounds.top + size.y));
	});
}

void CollisionSystem::createLine(b2Vec2& origin, b2Vec2& direction, std::vector<std::array<sf::Vertex, 2>>& lines)
{
	std::array<sf::Vertex, 2> line;
	line[0].position = utils::B2VecToSFVec<sf::Vector2f>(origin);
	line[1].position = utils::B2VecToSFVec<sf::Vector2f>(direction);
	line[0].color = sf::Color::Red;
	line[1].color = sf::Color::Red;
	lines.push_back(line);
}
