//
// Created by george on 22/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP
#define ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP

#include <Box2D/Common/b2Math.h>
#include <vector>
#include <array>

struct CollisionInfo
{
    bool collisionAbove{false};
    bool collisionBelow{false};
    bool collisionLeft {false};
    bool collisionRight{false};
    bool platformCheckLeft{false};
    bool platformCheckRight{false};

    void reset()
    {
        collisionAbove = false;
        collisionBelow = false;
        collisionLeft  = false;
        collisionRight = false;
        platformCheckLeft = false;
        platformCheckRight = false;
    }
};

struct RaycastOrigins
{
    b2Vec2 topLeft{}, topRight{};
    b2Vec2 bottomLeft{}, bottomRight{};
};

struct C_Raycast
{
    C_Raycast() = default;

    CollisionInfo collisionInfo{};
    RaycastOrigins raycastOrigins{};
    float rayLength{};
	int horizontalRayCount{};
	int verticalRayCount{};
	float dstBetweenRays = .5f;
	float horizontalRaySpacing{};
	float verticalRaySpacing{};

    std::vector<std::array<sf::Vertex, 2>> raycasts;
};

#endif //ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP
