//
// Created by george on 4/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP
#define ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP

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
    explicit PlayerControllerSystem(Context& context);

    void update(sf::Time& dt) override;
    void handleEvents(sf::Time dt);

private:
    GameObjectState::State m_State{};
};


#endif //ENTITY_COMPONENT_SYSTEM_PLAYERCONTROLLERSYSTEM_HPP
