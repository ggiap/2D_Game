#pragma once

#include <SFML/Graphics.hpp>
#include <Box2D/Common/b2Math.h>
#include "../Utils/Utility.hpp"

struct Body
{
    Body() = default;
    Body(sf::RectangleShape rect) :
        shape(std::move(rect))
    {
        utils::centerOrigin(shape);
        shape.setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
    }

    sf::RectangleShape shape{};
};