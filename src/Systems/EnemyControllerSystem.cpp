#include "EnemyControllerSystem.hpp"

#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../core/World.h"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include "../Components/C_Animation.hpp"

#include <SFML/System/Time.hpp>

EnemyControllerSystem::EnemyControllerSystem(Context &context, World* world) :
	BaseSystem(context, world),
	m_Callback()
{
}

void EnemyControllerSystem::update(sf::Time& dt)
{
	m_World->getEntityRegistry()->view<C_EnemyTag, C_Rigidbody, C_Raycast, C_Animation>().each([&](auto entity, auto& rb, auto& raycastComp, auto& animComp)
		{
			b2Vec2 velocity = m_Context->enttToBody[entity]->GetLinearVelocity();

			if (velocity.x < 0.f)
				velocity.x += -1.f;
			else
				velocity.x += 1.f;

			if (raycastComp.collisionInfo.collisionBelow && raycastComp.collisionInfo.groundCheckLeft == false)
				if (velocity.x < 0.f)
					velocity.x = std::abs(velocity.x);

			if (raycastComp.collisionInfo.collisionBelow && raycastComp.collisionInfo.groundCheckRight == false)
				if (velocity.x > 0.f)
					velocity.x = -std::abs(velocity.x);

			if(raycastComp.collisionInfo.collisionLeft)
				velocity.x = std::abs(velocity.x);

			if (raycastComp.collisionInfo.collisionRight)
				velocity.x = -std::abs(velocity.x);


			velocity.x = std::clamp(velocity.x, -1.f, 1.f);
			velocity.y = std::clamp(velocity.y, -10.f, 10.f);
			m_Context->enttToBody[entity]->SetLinearVelocity(velocity);

			if (velocity.x < -0.1f)
				animComp.animatedSprite.setScale(sf::Vector2f(1.f, 1.f));
			else if (velocity.x > 0.1f)
				animComp.animatedSprite.setScale(sf::Vector2f(-1.f, 1.f));

			if (raycastComp.collisionInfo.collisionLeft || raycastComp.collisionInfo.collisionRight || raycastComp.collisionInfo.collisionBelow)
			{
				if(raycastComp.collisionInfo.entityLeft != entt::null &&
					m_World->getEntityRegistry()->has<C_PlayerTag>(raycastComp.collisionInfo.entityLeft))
					m_World->GameOver() = true;
				else if(raycastComp.collisionInfo.entityRight != entt::null &&
					m_World->getEntityRegistry()->has<C_PlayerTag>(raycastComp.collisionInfo.entityRight))
					m_World->GameOver() = true;
				else if (raycastComp.collisionInfo.entityBelow != entt::null &&
					m_World->getEntityRegistry()->has<C_PlayerTag>(raycastComp.collisionInfo.entityBelow))
					m_World->GameOver() = true;
			}
		});
}