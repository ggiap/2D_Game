#pragma once

#include <SFML/Graphics/RectangleShape.hpp>
#include <Box2D/Common/b2Math.h>
#include "../Utils/Utility.hpp"

struct BodyShape
{
    BodyShape() = default;
    BodyShape(sf::RectangleShape rect) :
        shape(std::move(rect))
    {

    }

    sf::RectangleShape shape{};
};