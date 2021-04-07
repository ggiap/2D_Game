#pragma once

#include <SFML/System/Vector2.hpp>

struct C_Movable
{
    C_Movable() = default;
    C_Movable(sf::Vector2f vel, sf::Vector2f dir, float maxSpeed) :
        velocity(vel),
        maxSpeed(maxSpeed),
        direction(dir)
    {

    }

    sf::Vector2f velocity{};
    sf::Vector2f direction{};
    float maxSpeed{};
};
