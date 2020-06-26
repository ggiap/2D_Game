#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Utils/Math.hpp"
#include "../Components/C_Body.hpp"
#include "../Components/C_Rigidbody.hpp"

MoveSystem::MoveSystem(Context& context) :
    BaseSystem(context)
{

}

void MoveSystem::update(sf::Time dt)
{
    m_Context->registry->view<Body, C_Rigidbody>().each([&](auto& body, auto& rb)
        {
            if(rb.rigidbody->GetType() != b2_staticBody)
            {
                body.shape.setRotation(math::radToDeg(rb.rigidbody->GetAngle()));
                body.shape.setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
            }
        });
}
