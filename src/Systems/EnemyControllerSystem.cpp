#include "EnemyControllerSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../core/World.h"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"

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
				leftHit = true;
			}

			std::array<sf::Vertex, 2> line;
			line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			line[0].color = sf::Color::Blue;
			line[1].color = sf::Color::Blue;
			raycastComp.raycasts.push_back(line);

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_UP + math::VECTOR_RIGHT * 2.f);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				if (leftHit == false)
					velocity.x = std::abs(velocity.x);
			}

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
				righttHit = true;
			}

			line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			line[0].color = sf::Color::Blue;
			line[1].color = sf::Color::Blue;
			raycastComp.raycasts.push_back(line);

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_LEFT + math::VECTOR_UP);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_DOWN * (raycastComp.rayLength * 2));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				if (righttHit == false)
					if (velocity.x > 0)
						velocity.x = -std::abs(velocity.x);
			}

			line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			line[0].color = sf::Color::Blue;
			line[1].color = sf::Color::Blue;
			raycastComp.raycasts.push_back(line);

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(math::VECTOR_RIGHT);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_LEFT * (raycastComp.rayLength));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				velocity.x = std::abs(velocity.x);
			}

			line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			line[0].color = sf::Color::Blue;
			line[1].color = sf::Color::Blue;
			raycastComp.raycasts.push_back(line);

			m_Callback = RayCastCallback();

			rayOrigin = raycastComp.raycastOrigins.topRight + utils::sfVecToB2Vec(math::VECTOR_LEFT);
			rayDir = rayOrigin + utils::sfVecToB2Vec(math::VECTOR_RIGHT * (raycastComp.rayLength));
			m_World->getB2World()->RayCast(&m_Callback, rayOrigin, rayDir);
			if (m_Callback.m_fixture != nullptr)
			{
				velocity.x = -std::abs(velocity.x);
			}

			line[0].position = utils::B2VecToSFVec<sf::Vector2f>(rayOrigin);
			line[1].position = utils::B2VecToSFVec<sf::Vector2f>(rayDir);
			line[0].color = sf::Color::Blue;
			line[1].color = sf::Color::Blue;
			raycastComp.raycasts.push_back(line);

			m_Callback = RayCastCallback();


			velocity.x = std::clamp(velocity.x, -1.f, 1.f);
			velocity.y = std::clamp(velocity.y, -10.f, 10.f);
			m_Context->bodies[entity]->SetLinearVelocity(velocity);
		});
}