#pragma once

#include "BaseSystem.hpp"


class MoveSystem : public BaseSystem
{
public:
	void update(sf::Time dt) override;
};