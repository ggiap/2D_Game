#pragma once

#include "BaseSystem.hpp"
#include "../Utils/Utility.hpp"

namespace sf
{
    class Time;
}

struct Context;

class PlayerControllerSystem : public BaseSystem
{
public:
    PlayerControllerSystem() = default;
    explicit PlayerControllerSystem(Context& context, World *world);

    void update(sf::Time& dt) override;

private:
    GameObjectState::ID m_State{};
    float m_lowJumpMultiplier;
    float m_fallMultiplier;
};
