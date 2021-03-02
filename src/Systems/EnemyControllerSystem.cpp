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

			if (raycastComp.collisionInfo.collisionBelow && raycastComp.collisionInfo.platformCheckLeft == false)
				if (velocity.x < 0.f)
					velocity.x = std::abs(velocity.x);

			if (raycastComp.collisionInfo.collisionBelow && raycastComp.collisionInfo.platformCheckRight == false)
				if (velocity.x > 0.f)
					velocity.x = -std::abs(velocity.x);

			if(raycastComp.collisionInfo.collisionLeft)
				velocity.x = std::abs(velocity.x);

			if (raycastComp.collisionInfo.collisionRight)
				velocity.x = -std::abs(velocity.x);


			velocity.x = std::clamp(velocity.x, -1.f, 1.f);
			velocity.y = std::clamp(velocity.y, -10.f, 10.f);
			m_Context->bodies[entity]->SetLinearVelocity(velocity);
		});
}