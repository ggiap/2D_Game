#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"
#include "../Components/C_Rigidbody.hpp"

MoveSystem::MoveSystem(Context& context) :
    BaseSystem(context)
{

}

void MoveSystem::update(sf::Time dt)
{
    b2Body* g;
    m_Context->registry->view<Body, C_Rigidbody>().each([&](auto& body, auto& rb)
        {
            body.shape.setPosition(utils::B2VecToSFVec<sf::Vector2f>(rb.rigidbody->GetPosition()));
        });
}
