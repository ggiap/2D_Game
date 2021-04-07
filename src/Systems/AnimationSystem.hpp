#pragma once

#include <SFML/System/Time.hpp>
#include "BaseSystem.hpp"

struct Context;

class AnimationSystem : public BaseSystem
{
public:
    AnimationSystem() = default;
    explicit AnimationSystem(Context &context, World *world);

    void update(sf::Time& dt) override;
};
