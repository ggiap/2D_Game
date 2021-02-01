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
}
