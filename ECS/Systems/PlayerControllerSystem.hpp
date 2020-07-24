//
// Created by george on 4/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP
#define ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP

#include "BaseSystem.hpp"
#include "../Utils/Utility.hpp"
#include "../Utils/RayCastCallback.hpp"

namespace sf
{
    class Time;
}

struct Context;

class PlayerControllerSystem : public BaseSystem
{
public:
    friend class CollisionSystem;

    PlayerControllerSystem() = default;
    explicit PlayerControllerSystem(Context& context);

    void update(sf::Time dt) override;
    void handleEvents(sf::Time dt);

private:
    void UpdateRaycastOrigins();

    PlayerState::State m_State{};
    RayCastCallback m_RaycastCallback{};
};


#endif //ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP
