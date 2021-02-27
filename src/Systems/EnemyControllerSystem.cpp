#include "EnemyControllerSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../core/World.h"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <spdlog/spdlog.h>

EnemyControllerSystem::EnemyControllerSystem(Context &context, World* world) :
	BaseSystem(context, world),
	m_Callback()
{
}

void EnemyControllerSystem::update(sf::Time& dt)
{
	m_World->getEntityRegistry()->view<C_EnemyTag, C_Rigidbody, C_Raycast>().each([&](auto entity, auto& rb, auto& raycastComp)
		{

			b2Vec2 velocity = m_Context->bodies[entity]->GetLinearVelocity();

			if (velocity.x < 0.f)
				velocity.x += -1.f;
			else
				velocity.x += 1.f;

			bool leftHit = false;
			bool righttHit = false;

			b2Vec2 rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP);
			b2Vec2 rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				spdlog::info("touching left");

				leftHit = true;
			}
			else
			{
				spdlog::info("About to fall off from left");
				leftHit = false;
			}

			raycastComp.groundDetectionLine1[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			raycastComp.groundDetectionLine1[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			raycastComp.groundDetectionLine1[0].color = sf::Color::Blue;
			raycastComp.groundDetectionLine1[1].color = sf::Color::Blue;

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP + math::VECTOR_RIGHT * 2.f);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				spdlog::info("touching left2");

				if (leftHit == false)
					velocity.x = std::abs(velocity.x);
			}
			else
			{
				spdlog::info("About to fall off from left2");
			}

			raycastComp.groundDetectionLine2[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			raycastComp.groundDetectionLine2[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			raycastComp.groundDetectionLine2[0].color = sf::Color::Blue;
			raycastComp.groundDetectionLine2[1].color = sf::Color::Blue;

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_UP);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				spdlog::info("touching right");

				righttHit = true;
			}
			else
			{
				spdlog::info("About to fall off from right");
			}

			raycastComp.groundDetectionLine3[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			raycastComp.groundDetectionLine3[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			raycastComp.groundDetectionLine3[0].color = sf::Color::Blue;
			raycastComp.groundDetectionLine3[1].color = sf::Color::Blue;

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_UP + math::VECTOR_LEFT * 2.f);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				spdlog::info("touching right2");

				if (righttHit == false)
					if (velocity.x > 0)
						velocity.x = -velocity.x;
			}
			else
			{
				spdlog::info("About to fall off from right2");
			}

			raycastComp.groundDetectionLine4[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			raycastComp.groundDetectionLine4[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			raycastComp.groundDetectionLine4[0].color = sf::Color::Blue;
			raycastComp.groundDetectionLine4[1].color = sf::Color::Blue;

			m_Callback = RayCastCallback();


			velocity.x = std::clamp(velocity.x, -1.f, 1.f);
			velocity.y = std::clamp(velocity.y, -10.f, 10.f);
			m_Context->bodies[entity]->SetLinearVelocity(velocity);
		});
}