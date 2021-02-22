#pragma once

#include "BaseSystem.hpp"

#include <entt/entity/entity.hpp>
#include "../Utils/SFMLDebugDraw.h"

struct C_Rigidbody;

class RenderSystem : public BaseSystem
{
public:
	RenderSystem() = default;
	explicit RenderSystem(Context& context, World *world);
	
	void draw() override;

private:
    void drawDebugInfo(entt::entity& entity, C_Rigidbody& rb);

    SFMLDebugDraw debugDraw;
};