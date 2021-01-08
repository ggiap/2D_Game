#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Math.hpp"
#include "../Utils//Context.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Raycast.hpp"

MoveSystem::MoveSystem(Context& context) :
    BaseSystem(context)
{

}

void MoveSystem::update(sf::Time& dt)
{
    m_Context->registry->view<C_Rigidbody, C_Animation>().each([&](auto entity, auto& rb, auto& anim)
        {
            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                for(auto fixture = rb.rigidbody->GetFixtureList(); fixture != nullptr; fixture = fixture->GetNext())
                {
                    auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
                    if (shape == nullptr) return;
                    shape->setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
                    shape->setRotation(math::radToDeg(rb.rigidbody->GetAngle()));

                    anim.animatedSprite.setPosition(shape->getPosition() + sf::Vector2f(0, -6.f));
                }
            }
        });

    m_Context->registry->view<C_Raycast, C_Rigidbody>().each([&](auto entity, auto& raycastComp, auto& rb)
    {
        auto fixture = rb.rigidbody->GetFixtureList();

        auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
        if (shape == nullptr) return;

        auto bounds = shape->getGlobalBounds();
        auto size = shape->getSize();

        raycastComp.raycastOrigins.topLeft = utils::sfVecToB2Vec(sf::Vector2f(bounds.left, bounds.top) + sf::Vector2f(1.f,   1.f));
        raycastComp.raycastOrigins.topRight = utils::sfVecToB2Vec(sf::Vector2f(bounds.left + size.x, bounds.top) + sf::Vector2f(-1.f, 1.f));
        raycastComp.raycastOrigins.bottomLeft = utils::sfVecToB2Vec(sf::Vector2f(bounds.left, bounds.top + size.y) + sf::Vector2f( 1.f, -1.f));
        raycastComp.raycastOrigins.bottomRight = utils::sfVecToB2Vec(sf::Vector2f(bounds.left + size.x, bounds.top + size.y) + sf::Vector2f(-1.f, -1.f));
    });
}
