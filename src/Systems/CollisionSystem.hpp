#pragma once

#include "BaseSystem.hpp"
#include <SFML/System/Vector2.hpp>
#include <SFML/Graphics.hpp>
#include "../Utils/RayCastCallback.hpp"
#include <array>
#include <vector>

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
    void createLine(b2Vec2 &origin, b2Vec2 &direction, std::vector<std::array<sf::Vertex, 2>>& lines);

    RayCastCallback m_Callback{};
};