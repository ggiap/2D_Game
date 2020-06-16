#ifndef COLLISION_SYSTEM_HPP
#define COLLISION_SYSTEM_HPP

#include "BaseSystem.hpp"

class CollisionSystem : public BaseSystem
{
public:
	void update() override;
};

#endif