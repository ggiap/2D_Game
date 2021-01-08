#pragma once

#include "BaseSystem.hpp"
#include <SFML/System/Vector2.hpp>
#include "../Utils/RayCastCallback.hpp"

class CollisionSystem : public BaseSystem
{
public:
	CollisionSystem() = default;
	explicit CollisionSystem(Context& context);

	void update(sf::Time& dt) override;

private:
    void handleRaycasts();

    RayCastCallback m_Callback{};
};