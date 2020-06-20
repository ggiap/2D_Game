#pragma once

#include "BaseSystem.hpp"
#include "../Components/C_Body.hpp"

class CollisionSystem : public BaseSystem
{
public:
	CollisionSystem() = default;
	CollisionSystem(entt::registry& reg, sf::RenderWindow& win);

	void update(sf::Time dt) override;

private:
	void checkOutOFBorder(Body& body) const;
};