#ifndef COLLISION_SYSTEM_HPP
#define COLLISION_SYSTEM_HPP

#include "BaseSystem.hpp"

class CollisionSystem : public BaseSystem
{
public:
	void update(sf::Time dt) override;
};

#endif