#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Math.hpp"
#include "../Components/C_Shape.hpp"
#include "../Components/C_Rigidbody.hpp"

MoveSystem::MoveSystem(Context& context) :
    BaseSystem(context)
{

}

void MoveSystem::update(sf::Time dt)
{
    m_Context->registry->view<BodyShape, C_Rigidbody>().each([&](auto entity, auto& bodyShape, auto& rb)
        {
            if(!m_Context->registry->has<BodyShape>(entity)) return;

            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                bodyShape.shape.setRotation(math::radToDeg(rb.rigidbody->GetAngle()));
                bodyShape.shape.setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
            }
        });
}
