#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Math.hpp"
#include "../Utils/FixtureUserData.hpp"
#include "../Utils//Context.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Raycast.hpp"
#include "../Components/C_Tag.h"
#include "../core/World.h"

MoveSystem::MoveSystem(Context& context, World *world) :
    BaseSystem(context, world)
{

}

void MoveSystem::update(sf::Time& dt)
{
    m_World->getEntityRegistry()->view<C_Rigidbody>().each([&](auto entity, auto& rb)
        {
            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                for(auto fixture = rb.rigidbody->GetFixtureList(); fixture != nullptr; fixture = fixture->GetNext())
                {
                    auto userData = static_cast<FixtureUserData*>(fixture->GetUserData());
                    if (userData->shape == nullptr) return;
                    
                    userData->shape->setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
                    userData->shape->setRotation(math::radToDeg(rb.rigidbody->GetAngle()));
                }
            }

            if(m_World->getEntityRegistry()->has<C_Animation>(entity))
            {
            	auto &anim = m_World->getEntityRegistry()->get<C_Animation>(entity);

            	auto bodyPos = utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition());
	            anim.animatedSprite.setPosition(bodyPos);
            }
        });
}
