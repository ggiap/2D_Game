#ifndef TILEMAP_SYSTEM_HPP
#define TILEMAP_SYSTEM_HPP

#include "BaseSystem.hpp"

class TilemapSystem : public BaseSystem
{
public:
    TilemapSystem() = default;
    explicit TilemapSystem(Context &context);

    void update(sf::Time &dt) override;
};

#endif