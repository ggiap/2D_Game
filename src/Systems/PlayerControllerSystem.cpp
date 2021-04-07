#include "PlayerControllerSystem.hpp"
#include "../Utils/AnimatedSprite.h"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Utils/FixtureUserData.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Raycast.hpp"
#include "../core/World.h"
#include "../core/SoundEffectPlayer.hpp"

#include <SFML/Window/Event.hpp>
#include <cmath>
#include <spdlog/spdlog.h>

PlayerControllerSystem::PlayerControllerSystem(Context& context, World* world) :
    BaseSystem(context, world),
    m_State(),
    m_lowJumpMultiplier(1.08f)
{

}

void PlayerControllerSystem::update(sf::Time& dt)
{
    auto registry = m_World->getEntityRegistry();
    auto view = registry->view<C_PlayerTag, C_Animation, C_Raycast>();

    for (auto& entity : view)
    {
        auto& anim = view.get<C_Animation>(entity);
        auto& raycastComp = view.get<C_Raycast>(entity);

        auto userData = static_cast<FixtureUserData*>(m_Context->enttToBody[entity]->GetFixtureList()->GetUserData());
        if (userData == nullptr || userData->shape == nullptr) continue;

        b2Vec2 velocity = m_Context->enttToBody[entity]->GetLinearVelocity();
        velocity.x -= velocity.x > 0 ? .2f : -.2f;
        if (velocity.x < .21f && velocity.x > -.21f) velocity.x = 0;

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        {
            if (!raycastComp.collisionInfo.collisionLeft)
                velocity.x -= 0.6f;

            if (raycastComp.collisionInfo.collisionBelow)
                m_State = GameObjectState::ID::Walking;
        }

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        {
            if (!raycastComp.collisionInfo.collisionRight)
                velocity.x += 0.6f;

            if (raycastComp.collisionInfo.collisionBelow)
                m_State = GameObjectState::ID::Walking;
        }
        velocity.x = math::lerp(velocity.x, velocity.x, 0.5f);

        if (raycastComp.collisionInfo.entityBelow != entt::null)
        {
            if (registry->has<C_EnemyTag>(raycastComp.collisionInfo.entityBelow))
            {
                m_Context->sounds->play(Sounds::ID::Squash);
                spdlog::info("Killed enemy, numOfEnemies: {}", --m_World->getNumberOfEnemies());
                auto* body = m_Context->enttToBody[raycastComp.collisionInfo.entityBelow];
                for (auto* fixture = body->GetFixtureList(); fixture; fixture = fixture->GetNext())
                    delete fixture->GetUserData();

                m_World->getB2World()->DestroyBody(body);
                registry->destroy(raycastComp.collisionInfo.entityBelow);
                m_Context->enttToBody.erase(raycastComp.collisionInfo.entityBelow);

                velocity.y = 0;
                velocity.y -= 5.f;
            }
        }

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
        {
            if (raycastComp.collisionInfo.collisionBelow)
                velocity = { velocity.x, velocity.y - 50.f };

            //m_Context->enttToBody[entity]->ApplyLinearImpulseToCenter(b2Vec2(0.f, -3.f), true);
            //m_Context->enttToBody[entity]->ApplyForceToCenter(b2Vec2(0.f, -200.f), true);

            m_State = GameObjectState::ID::Jumping;
        }

        if (velocity.y < 0 && !sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
        {
            velocity = { velocity.x, velocity.y + utils::sfVecToB2Vec(math::VECTOR_DOWN).y * m_World->getB2World()->GetGravity().y * (m_lowJumpMultiplier - 1) * dt.asMilliseconds() };
        }
        velocity.x = math::lerp(velocity.x, velocity.x, 0.8f);

        if (!raycastComp.collisionInfo.collisionBelow)
            m_State = GameObjectState::ID::Jumping;

        if ((velocity.x >= -0.1f || velocity.x <= 0.1f) && raycastComp.collisionInfo.collisionBelow)
            m_State = GameObjectState::ID::Standing;

        if ((velocity.x < -0.1f || velocity.x > 0.1f) && raycastComp.collisionInfo.collisionBelow)
            m_State = GameObjectState::ID::Walking;


        if (sf::Keyboard::isKeyPressed(sf::Keyboard::W))
        {
            if (raycastComp.collisionInfo.climbingLadder)
            {
                velocity.y = 0.f;
                velocity.y = -2.f;
                m_State = GameObjectState::ID::ClimbingLadder;
            }
        }

        velocity.x = std::clamp(velocity.x, -5.f, 5.f);
        velocity.y = std::clamp(velocity.y, -10.f, 10.f);
        m_Context->enttToBody[entity]->SetLinearVelocity(velocity);

        if (velocity.x < -0.1f)
            anim.animatedSprite.setScale(sf::Vector2f(-1.f, 1.f));
        else if (velocity.x > 0.1f)
            anim.animatedSprite.setScale(sf::Vector2f(1.f, 1.f));

        switch (m_State)
        {
        case GameObjectState::ID::Standing:
            anim.animatedSprite.play(Animations::ID::Standing);
            break;

        case GameObjectState::ID::Walking:
            anim.animatedSprite.play(Animations::ID::Walking);
            break;

        case GameObjectState::ID::Jumping:
            anim.animatedSprite.play(Animations::ID::Jumping);
            break;

        case GameObjectState::ID::ClimbingLadder:
            anim.animatedSprite.play(Animations::ID::ClimbingLadder);
            break;
        }
    }
}
