#pragma once

#include "BaseSystem.hpp"

class MoveSystem : public BaseSystem
{
public:
	MoveSystem() = default;
	explicit MoveSystem(Context& context);

	void update(sf::Time& dt) override;
};