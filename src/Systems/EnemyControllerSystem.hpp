#pragma once

#include "BaseSystem.hpp"
#include "../Utils/RayCastCallback.hpp"

class EnemyControllerSystem : public BaseSystem
{
public:
    EnemyControllerSystem() = default;
    explicit EnemyControllerSystem(Context &context, World *world);

    void update(sf::Time & dt) override;

private:
    RayCastCallback m_Callback{};
};