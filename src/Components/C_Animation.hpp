#pragma once

#include "Utils/AnimatedSprite.h"

struct C_Animation
{
    C_Animation() = default;
    C_Animation(sf::Time frameTime, bool paused, bool looped) :
    animatedSprite(frameTime, paused, looped)
    {
        
    }

    AnimatedSprite animatedSprite{};
};
