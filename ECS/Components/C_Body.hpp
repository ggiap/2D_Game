#pragma once

#include <SFML/Graphics.hpp>
#include <utility>
#include "../Utils/Utility.hpp"

struct Body
{
    Body() = default;
    Body(sf::RectangleShape rect, const sf::Vector2f pos, 
         const sf::Vector2f& vel) :
        shape(std::move(rect)),
        position(pos),
        velocity(vel)
    {
        utils::centerOrigin(shape);
        shape.setOutlineColor(sf::Color::White);
    }

    sf::RectangleShape shape{};
    sf::Vector2f position{};
    sf::Vector2f velocity{};
};