//
// Created by george on 3/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_C_ANIMATION_HPP
#define ENTITY_COMPONENT_SYSTEM_C_ANIMATION_HPP

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

#endif //ENTITY_COMPONENT_SYSTEM_C_ANIMATION_HPP
