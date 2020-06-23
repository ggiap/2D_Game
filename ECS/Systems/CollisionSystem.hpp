#pragma once

#include "BaseSystem.hpp"
#include <SFML/System/Vector2.hpp>

class Body;

class CollisionSystem : public BaseSystem
{
public:
	CollisionSystem() = default;
	CollisionSystem(entt::registry& reg, sf::RenderWindow& win);

	void update(sf::Time dt) override;

private:
	void checkOutOFBorder(Body& body) const;
	bool checkOutOFBorder2(Body& body) const;
};