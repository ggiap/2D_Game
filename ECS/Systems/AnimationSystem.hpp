//
// Created by george on 4/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_ANIMATIONSYSTEM_HPP
#define ENTITY_COMPONENT_SYSTEM_ANIMATIONSYSTEM_HPP

#include <SFML/System/Time.hpp>
#include "BaseSystem.hpp"

struct Context;

class AnimationSystem : public BaseSystem
{
public:
    AnimationSystem() = default;
    explicit AnimationSystem(Context &context);

    void update(sf::Time dt) override;
};

#endif //ENTITY_COMPONENT_SYSTEM_ANIMATIONSYSTEM_HPP
