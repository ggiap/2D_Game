#pragma once

#include "BaseSystem.hpp"

#include <SFML/System/Time.hpp>

struct Context;

class AnimationSystem : public BaseSystem
{
public:
    AnimationSystem() = default;
    explicit AnimationSystem(Context &context, World *world);

    void update(sf::Time& dt) override;
};
