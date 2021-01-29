#include "CollisionSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/CircleShape.hpp>

CollisionSystem::CollisionSystem(Context& context) :
    BaseSystem(context),
    m_Callback()
{

}

void CollisionSystem::update(sf::Time& dt)
{
    m_Context->b2_World->Step(dt.asSeconds(), 8, 5);

    handleRaycasts();
}

void CollisionSystem::handleRaycasts()
{
    auto view = m_Context->registry->view<C_PlayerTag>();

    for(auto entity : view)
    {
        if(!m_Context->registry->has<C_Rigidbody>(entity)) continue;

        auto &rb = m_Context->registry->get<C_Rigidbody>(entity);
        auto &raycastComp = m_Context->registry->get<C_Raycast>(entity);
        raycastComp.collisionInfo.reset();
        raycastComp.rayLength = 1.7f;

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
            auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
            if (shape == nullptr) return;

            // Check above
            auto point1 = raycastComp.raycastOrigins.topLeft;
            auto point2 = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(math::VECTOR_UP * raycastComp.rayLength);
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                raycastComp.collisionInfo.collisionAbove = true;
            }

            m_Callback = RayCastCallback();

            // Check right
            point1 = raycastComp.raycastOrigins.topRight;
            point2 = raycastComp.raycastOrigins.topRight + utils::sfVecToB2Vec(math::VECTOR_RIGHT * raycastComp.rayLength);
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                raycastComp.collisionInfo.collisionRight = true;
            }

            m_Callback = RayCastCallback();

            // Check Left
            point1 = raycastComp.raycastOrigins.bottomLeft;
            point2 = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(math::VECTOR_LEFT * raycastComp.rayLength);
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                raycastComp.collisionInfo.collisionLeft = true;
            }

            m_Callback = RayCastCallback();

            // Check Below
            point1 = raycastComp.raycastOrigins.bottomRight;
            point2 = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(math::VECTOR_DOWN * raycastComp.rayLength);
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                raycastComp.collisionInfo.collisionBelow = true;
            }

            m_Callback = RayCastCallback();
        }
    }
}