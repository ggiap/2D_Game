#pragma once

#include "BaseSystem.hpp"

class RenderSystem : public BaseSystem
{
public:
	void update(sf::Time dt) override;
};