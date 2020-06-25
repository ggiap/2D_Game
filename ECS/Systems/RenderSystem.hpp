#pragma once

#include "BaseSystem.hpp"

class RenderSystem : public BaseSystem
{
public:
	RenderSystem() = default;
	RenderSystem(Context& context);
	
	void update(sf::Time dt) override;
};