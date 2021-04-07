#pragma once

#include "BaseSystem.hpp"

class TilemapSystem : public BaseSystem
{
public:
    TilemapSystem() = default;
    explicit TilemapSystem(Context &context, World *world);

    void update(sf::Time &dt) override;
};