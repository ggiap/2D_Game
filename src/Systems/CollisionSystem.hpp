#pragma once

#include "BaseSystem.hpp"
#include <SFML/System/Vector2.hpp>
#include "../Utils/RayCastCallback.hpp"

class CollisionSystem : public BaseSystem
{
public:
	CollisionSystem() = default;
	explicit CollisionSystem(Context& context, World* world);

	void update(sf::Time& dt) override;
    void init() override;

private:
    void handleRaycasts();
    void CalculateRaySpacing();
    void UpdateRaycastOrigins();

    RayCastCallback m_Callback{};
};