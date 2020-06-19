#include "MoveSystem.hpp"

#include <SFML/System/Time.hpp>
#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/RectangleShape.hpp>
#include "../Components/C_Body.hpp"
#include "../Components/C_Velocity.hpp"
#include "../Components/C_Position.hpp"

void MoveSystem::update(sf::Time dt)
{
    registry->view<Body, velocity, position>().each([&](auto& body,
        auto& vel, auto& pos)
		{
            if (window->getView().getSize().x - 10.f < pos.x)
            {
                vel.dx = -vel.dx;
            }
            if (window->getView().getSize().y - 10.f < pos.y)
            {
                vel.dy = -vel.dy;
            }
            if (0.0f > pos.y)
            {
                vel.dy = -vel.dy;
            }
            if (0.0f > pos.x)
            {
                vel.dx = -vel.dx;
            }
            pos.x += vel.dx * dt.asSeconds();
            pos.y += vel.dy * dt.asSeconds();

            body.shape.setPosition(pos.x, pos.y);
		});
}
