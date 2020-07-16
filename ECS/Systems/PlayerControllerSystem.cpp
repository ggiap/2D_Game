//
// Created by george on 4/7/20.
//

#include "PlayerControllerSystem.hpp"
#include <SFML/Window/Event.hpp>
#include "../Utils/AnimatedSprite.h"
#include "../Utils//Context.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_PlayerInput.hpp"
#include "../Components/C_Animation.hpp"

PlayerControllerSystem::PlayerControllerSystem(Context& context) :
BaseSystem(context),
m_State()
{

}

void PlayerControllerSystem::update(sf::Time dt)
{
    handleEvents(dt);
}

void PlayerControllerSystem::handleEvents(sf::Time dt)
{
    auto view = m_Context->registry->view<C_Rigidbody, C_Animation>();

    for (auto &entity : view)
    {
        if (m_Context->registry->has<C_PlayerInput>(entity))
        {
            auto& anim = view.get<C_Animation>(entity);
            b2Vec2 velocity = m_Context->bodies[entity]->GetLinearVelocity();

            if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
            {
                velocity.x -= 1.f;
                anim.animatedSprite.play(Animations::Walking);
            }

            if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
            {
                velocity.x += 1.f;
                anim.animatedSprite.play(Animations::Walking);
            }

            velocity.x = std::clamp(velocity.x, -5.f, 5.f);
            //velocity.y = std::clamp(velocity.y, 0.f, 10.f);
            m_Context->bodies[entity]->SetLinearVelocity(velocity);

            if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
            {
                if(velocity.y <= 0.001f && velocity.y >= -0.001f)
                {
                    //m_Context->bodies[entity]->ApplyLinearImpulseToCenter(b2Vec2(0.f, -3.f), true);
                    m_Context->bodies[entity]->ApplyForceToCenter(b2Vec2(0.f, -200.f), true);
                }
            }
        }
    }
}
