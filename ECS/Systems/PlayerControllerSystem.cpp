//
// Created by george on 4/7/20.
//

#include "PlayerControllerSystem.hpp"
#include <SFML/Window/Event.hpp>
#include "../Utils/AnimatedSprite.h"
#include "../Utils//Context.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Raycast.hpp"
#include "../Components/C_Animation.hpp"

PlayerControllerSystem::PlayerControllerSystem(Context& context) :
BaseSystem(context),
m_State(),
m_RaycastCallback()
{

}

void PlayerControllerSystem::update(sf::Time dt)
{
    UpdateRaycastOrigins();
    handleEvents(dt);
}

void PlayerControllerSystem::handleEvents(sf::Time dt)
{
    auto view = m_Context->registry->view<C_PlayerTag, C_Animation>();

    for (auto &entity : view)
    {
        auto &anim = view.get<C_Animation>(entity);
        b2Vec2 velocity = m_Context->bodies[entity]->GetLinearVelocity();

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        {
            velocity.x -= 1.f;

            if (m_State != PlayerState::Jumping)
            {
                m_State = PlayerState::Walking;
            }
        }

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        {
            velocity.x += 1.f;

            if (m_State != PlayerState::Jumping)
            {
                m_State = PlayerState::Walking;
            }
        }

        velocity.x = std::clamp(velocity.x, -5.f, 5.f);
        //velocity.y = std::clamp(velocity.y, 0.f, 10.f);
        m_Context->bodies[entity]->SetLinearVelocity(velocity);

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space))
        {
            if (velocity.y <= 0.001f && velocity.y >= -0.001f)
            {
                //m_Context->bodies[entity]->ApplyLinearImpulseToCenter(b2Vec2(0.f, -3.f), true);
                m_Context->bodies[entity]->ApplyForceToCenter(b2Vec2(0.f, -200.f), true);
            }

            if (m_State == PlayerState::Standing || m_State == PlayerState::Walking)
            {
                m_State = PlayerState::Jumping;
            }
        }

        if (velocity.x <= 0.01f && velocity.x >= -0.01f &&
            velocity.y <= 0.01f && velocity.y >= -0.01f)
        {
            m_State = PlayerState::Standing;
        }

        switch (m_State)
        {
            case PlayerState::Standing:
                anim.animatedSprite.play(Animations::Standing);
                break;

            case PlayerState::Walking:
                anim.animatedSprite.play(Animations::Walking);
                break;

            case PlayerState::Jumping:
                anim.animatedSprite.play(Animations::Jumping);
                break;
        }
    }
}

void PlayerControllerSystem::UpdateRaycastOrigins()
{
    auto view = m_Context->registry->view<C_PlayerTag, C_Raycast, C_Rigidbody>();

    for (auto &entity : view)
    {
        //auto &rayComp = view.get<C_Raycast>(entity);
        auto &rb = view.get<C_Rigidbody>(entity);

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
            auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
            if (shape == nullptr) return;
            auto bounds = shape->getGlobalBounds();

//            rayComp.raycastOrigins.topLeft = utils::sfVecToB2Vec(sf::Vector2f(bounds.left, bounds.top));
//            rayComp.raycastOrigins.topRight = utils::sfVecToB2Vec(sf::Vector2f(bounds.left, bounds.top));
//            rayComp.raycastOrigins.bottomLeft = utils::sfVecToB2Vec(sf::Vector2f(bounds.left, bounds.top + bounds.height));
//            rayComp.raycastOrigins.bottomRight = utils::sfVecToB2Vec(sf::Vector2f(bounds.left + bounds.width, bounds.top + bounds.height));
        }
    }
}
