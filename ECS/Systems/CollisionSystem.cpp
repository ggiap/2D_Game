#include "CollisionSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Raycast.hpp"
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/CircleShape.hpp>
#include <spdlog/spdlog.h>

CollisionSystem::CollisionSystem(Context& context) :
    BaseSystem(context),
    m_Callback()
{

}

void CollisionSystem::update(sf::Time dt)
{
    m_Context->b2_World->Step(dt.asSeconds(), 8, 5);

   drawDebugInfo();
}

void CollisionSystem::drawDebugInfo()
{
    auto view = m_Context->registry->view<C_PlayerTag>();

    for(auto entity : view)
    {
        if(!m_Context->registry->has<C_Rigidbody>(entity)) continue;

        auto &rb = m_Context->registry->get<C_Rigidbody>(entity);
        auto &raycastComp = m_Context->registry->get<C_Raycast>(entity);

        for(b2Fixture* fixture = rb.rigidbody->GetFixtureList(); fixture; fixture = fixture->GetNext())
        {
            auto shape = static_cast<sf::RectangleShape*>(fixture->GetUserData());
            if (shape == nullptr) return;

//            auto bounds = shape->getGlobalBounds();
//            auto size = shape->getSize();
//            auto halfSize = size / 2.f;
//
//            auto topLeft = sf::Vector2f(bounds.left, bounds.top);
//            auto topRight = sf::Vector2f(bounds.left + size.x, bounds.top);
//            auto bottomLeft = sf::Vector2f(bounds.left, bounds.top + size.y);
//            auto bottomRight = sf::Vector2f(bounds.left + size.x, bounds.top + size.y);

            // Check above
            auto point1 = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(sf::Vector2f(0.f,   1.f));
            auto point2 = raycastComp.raycastOrigins.topLeft + utils::sfVecToB2Vec(sf::Vector2f(0.f,  -5.f ));
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                auto fixtureB = static_cast<sf::RectangleShape *>(m_Callback.m_fixture->GetUserData());
                fixtureB->setFillColor(sf::Color::Red);
            }

            m_Callback = RayCastCallback();

            // Check right
            point1 = raycastComp.raycastOrigins.topRight + utils::sfVecToB2Vec(sf::Vector2f(-1.f, 0.f));
            point2 = raycastComp.raycastOrigins.topRight + utils::sfVecToB2Vec(sf::Vector2f(5.f, 0.f));
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                auto fixtureB = static_cast<sf::RectangleShape *>(m_Callback.m_fixture->GetUserData());
                fixtureB->setFillColor(sf::Color::Green);
            }

            m_Callback = RayCastCallback();

            // Check Left
            point1 = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(sf::Vector2f( 1.f, 0.f));
            point2 = raycastComp.raycastOrigins.bottomLeft + utils::sfVecToB2Vec(sf::Vector2f(-5.f, 0.f));
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                auto fixtureB = static_cast<sf::RectangleShape *>(m_Callback.m_fixture->GetUserData());
                fixtureB->setFillColor(sf::Color::Yellow);
            }

            m_Callback = RayCastCallback();

            // Check Below
            point1 = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(sf::Vector2f(0.f, -1.f));
            point2 = raycastComp.raycastOrigins.bottomRight + utils::sfVecToB2Vec(sf::Vector2f(0.f, 5.f));
            m_Context->b2_World->RayCast(&m_Callback, point1, point2);
            if(m_Callback.m_fixture != nullptr)
            {
                auto fixtureB = static_cast<sf::RectangleShape *>(m_Callback.m_fixture->GetUserData());
                fixtureB->setFillColor(sf::Color::Blue);
            }

            m_Callback = RayCastCallback();
        }
    }
}