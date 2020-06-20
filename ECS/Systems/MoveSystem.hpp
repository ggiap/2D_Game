#pragma once

#include "BaseSystem.hpp"

class MoveSystem : public BaseSystem
{
public:
	MoveSystem() = default;
	MoveSystem(entt::registry& reg, sf::RenderWindow& win);

	void update(sf::Time dt) override;
};