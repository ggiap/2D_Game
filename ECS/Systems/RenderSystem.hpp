#pragma once

#include "BaseSystem.hpp"

class RenderSystem : public BaseSystem
{
public:
	RenderSystem() = default;
	RenderSystem(entt::registry& reg, sf::RenderWindow& win);
	
	void update(sf::Time dt) override;
};