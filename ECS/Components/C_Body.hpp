#pragma once

#include <SFML/Graphics.hpp>
#include "../Utils/Utility.hpp"

struct Body
{
    Body() = default;
    Body(const sf::RectangleShape& rect) :
        rectangle(rect)
    {
        utils::centerOrigin(rectangle);
        rectangle.setOutlineColor(sf::Color::White);
    }

    sf::RectangleShape rectangle;
};