#include "MoveSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"

MoveSystem::MoveSystem(entt::registry& reg, sf::RenderWindow& win) :
    BaseSystem(reg, win)
{

}

void MoveSystem::update(sf::Time dt)
{
    registry->view<Body>().each([&](auto& body)
        {
            body.position += body.velocity * dt.asSeconds();

            body.shape.setPosition(body.position);
        });
}
