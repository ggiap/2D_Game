//
// Created by george on 4/7/20.
//

#include "PlayerControllerSystem.hpp"
#include <SFML/Window/Event.hpp>
#include "../Utils/AnimatedSprite.h"
#include "../Utils//Context.hpp"
#include "../Utils//Math.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Raycast.hpp"
#include <cmath>

PlayerControllerSystem::PlayerControllerSystem(Context& context) :
BaseSystem(context),
m_State()
{

}

void PlayerControllerSystem::update(sf::Time& dt)
{
    handleEvents(dt);
}

void PlayerControllerSystem::handleEvents(sf::Time dt)
{
    auto view = m_Context->registry->view<C_PlayerTag, C_Animation, C_Raycast>();

    for (auto &entity : view)
    {
        auto &anim = view.get<C_Animation>(entity);
        auto &raycastComp = view.get<C_Raycast>(entity);

        b2Vec2 velocity = m_Context->bodies[entity]->GetLinearVelocity();

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        {
            if(!raycastComp.collisionInfo.collisionLeft)
                velocity.x -= 1.f;

            if(raycastComp.collisionInfo.collisionBelow)
                m_State = GameObjectState::Walking;
        }

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        {
            if(!raycastComp.collisionInfo.collisionRight)
                velocity.x += 1.f;

            if(raycastComp.collisionInfo.collisionBelow)
                m_State = GameObjectState::Walking;
        }
        velocity.x = math::lerp(velocity.x, velocity.x, 0.4f);

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
        {
            if(raycastComp.collisionInfo.collisionBelow)
                velocity = {velocity.x, velocity.y - 50.f};
                //m_Context->bodies[entity]->ApplyLinearImpulseToCenter(b2Vec2(0.f, -3.f), true);
                //m_Context->bodies[entity]->ApplyForceToCenter(b2Vec2(0.f, -200.f), true);

            m_State = GameObjectState::Jumping;
        }

        if(!raycastComp.collisionInfo.collisionBelow)
        	m_State = GameObjectState::Jumping;

        if(velocity.x == 0 && raycastComp.collisionInfo.collisionBelow)
            m_State = GameObjectState::Standing;

        if(velocity.x != 0 && raycastComp.collisionInfo.collisionBelow)
        	m_State = GameObjectState::Walking;

        velocity.x = std::clamp(velocity.x, -5.f, 5.f);
        velocity.y = std::clamp(velocity.y, -10.f, 10.f);
        m_Context->bodies[entity]->SetLinearVelocity(velocity);

        switch (m_State)
        {
            case GameObjectState::Standing:
                anim.animatedSprite.play(Animations::Standing);
                break;

            case GameObjectState::Walking:
                anim.animatedSprite.play(Animations::Walking);
                break;

            case GameObjectState::Jumping:
                anim.animatedSprite.play(Animations::Jumping);
                break;
        }
    }
}
