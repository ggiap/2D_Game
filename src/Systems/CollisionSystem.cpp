#include "CollisionSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/CircleShape.hpp>
#include "../core/World.h"
#include <array>

CollisionSystem::CollisionSystem(Context& context, World* world) :
    BaseSystem(context, world),
    m_Callback()
{
	CalculateRaySpacing();
}

void CollisionSystem::update(sf::Time& dt)
{
    m_World->getB2World()->Step(dt.asSeconds(), 8, 5);
	m_World->getB2World()->ClearForces();

    UpdateRaycastOrigins();
    handleRaycasts();
}

void CollisionSystem::handleRaycasts()
{
    auto view = m_World->getEntityRegistry()->view<C_Raycast>();

    for(auto entity : view)
    {
        auto &rb = m_World->getEntityRegistry()->get<C_Rigidbody>(entity);
        auto &raycastComp = m_World->getEntityRegistry()->get<C_Raycast>(entity);
        raycastComp.collisionInfo.reset();
        raycastComp.rayLength = 1.7f;

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
			auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
			if (shape == nullptr) return;

			if (m_World->getEntityRegistry()->has<C_EnemyTag>(entity))
			{
				b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP);
				b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
				if (m_Callback.m_fixture != nullptr)
				{
					raycastComp.collisionInfo.platformCheckLeft = true;
				}

				std::array<sf::Vertex, 2> line;
				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Blue;
				line[1].color = sf::Color::Blue;
				raycastComp.raycasts.push_back(line);

				m_Callback = RayCastCallback();

				rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_UP);
				rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
				if (m_Callback.m_fixture != nullptr)
				{
					raycastComp.collisionInfo.platformCheckRight = true;
				}

				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Blue;
				line[1].color = sf::Color::Blue;
				raycastComp.raycasts.push_back(line);

				m_Callback = RayCastCallback();
			}

	        // Check Above
	        for (int i = 0; i < raycastComp.verticalRayCount; ++i)
	        {
		        b2Vec2 rayOrigin = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(math::VECTOR_DOWN / 2.f +
					math::VECTOR_RIGHT * (raycastComp.verticalRaySpacing * i));
				b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_UP * raycastComp.rayLength);

				std::array<sf::Vertex, 2> line;
				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Red;
				line[1].color = sf::Color::Red;
				raycastComp.raycasts.push_back(line);

		        m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionAbove = true;
			        raycastComp.collisionInfo.entityAbove = m_Context->bodyToEntt[m_Callback.m_fixture->GetBody()];
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

				std::array<sf::Vertex, 2> line;
				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Red;
				line[1].color = sf::Color::Red;
				raycastComp.raycasts.push_back(line);

				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionBelow = true;
					raycastComp.collisionInfo.entityBelow = m_Context->bodyToEntt[m_Callback.m_fixture->GetBody()];
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

				std::array<sf::Vertex, 2> line;
				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Red;
				line[1].color = sf::Color::Red;
				raycastComp.raycasts.push_back(line);

				m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if (m_Callback.m_fixture != nullptr)
		        {
			        raycastComp.collisionInfo.collisionRight = true;
					raycastComp.collisionInfo.entityRight = m_Context->bodyToEntt[m_Callback.m_fixture->GetBody()];
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

				std::array<sf::Vertex, 2> line;
				line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
				line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
				line[0].color = sf::Color::Red;
				line[1].color = sf::Color::Red;
				raycastComp.raycasts.push_back(line);

		        m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
		        if(m_Callback.m_fixture != nullptr)
                {
                    raycastComp.collisionInfo.collisionLeft = true;
					raycastComp.collisionInfo.entityLeft = m_Context->bodyToEntt[m_Callback.m_fixture->GetBody()];
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
			auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
			if (shape == nullptr) return;

			auto bounds = shape->getGlobalBounds();

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

		auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
		if (shape == nullptr) return;

		auto bounds = shape->getGlobalBounds();
		auto &size = shape->getSize();

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