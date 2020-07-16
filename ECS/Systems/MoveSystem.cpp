#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Math.hpp"
#include "../Utils//Context.hpp"
#include "../Components/C_Shape.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Animation.hpp"

MoveSystem::MoveSystem(Context& context) :
    BaseSystem(context)
{

}

void MoveSystem::update(sf::Time dt)
{
    m_Context->registry->view<BodyShape, C_Rigidbody, C_Animation>().each([&](auto entity, auto& bodyShape, auto& rb, auto& anim)
        {
            if(!m_Context->registry->has<BodyShape>(entity)) return;

            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                bodyShape.shape.setRotation(math::radToDeg(rb.rigidbody->GetAngle()));
                bodyShape.shape.setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));

                anim.animatedSprite.setPosition(bodyShape.shape.getPosition() + sf::Vector2f(0, -6.f));
            }
        });
}
