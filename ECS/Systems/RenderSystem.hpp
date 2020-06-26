#pragma once

#include "BaseSystem.hpp"
#include "../Utils/SFMLDebugDraw.h"

class RenderSystem : public BaseSystem
{
public:
	RenderSystem() = default;
	RenderSystem(Context& context);
	
	void update(sf::Time dt) override;

private:
    SFMLDebugDraw debugDraw;
};