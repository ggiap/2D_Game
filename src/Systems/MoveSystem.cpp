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
    m_Context->registry->view<C_Rigidbody>().each([&](auto entity, auto& rb)
        {
            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                for(auto fixture = rb.rigidbody->GetFixtureList(); fixture != nullptr; fixture = fixture->GetNext())
                {
                    auto shape = static_cast<sf::RectangleShape *>(fixture->GetUserData());
                    if (shape == nullptr) return;
                    shape->setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
                    shape->setRotation(math::radToDeg(rb.rigidbody->GetAngle()));
                }
            }

            if(m_Context->registry->has<C_Animation>(entity))
            {
            	auto &anim = m_Context->registry->get<C_Animation>(entity);

            	auto bodyPos = utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition());
	            anim.animatedSprite.setPosition(bodyPos + sf::Vector2f(0, -6.f));
            }
        });
}
