#pragma once

#include <Box2D/Common/b2Math.h>
#include <entt/entity/entity.hpp>

#include <vector>
#include <array>


struct CollisionInfo
{
    bool collisionAbove{false};
    bool collisionBelow{false};
    bool collisionLeft {false};
    bool collisionRight{false};
    bool groundCheckLeft{false};
    bool groundCheckRight{false};
    bool climbingLadder{false};
    entt::entity entityBelow{entt::null};
    entt::entity entityAbove{entt::null};
    entt::entity entityLeft {entt::null};
    entt::entity entityRight{entt::null};
    b2Vec2 normalBelow{};

    void reset()
    {
        collisionAbove = false;
        collisionBelow = false;
        collisionLeft  = false;
        collisionRight = false;
        groundCheckLeft = false;
        groundCheckRight = false;
        climbingLadder = false;
        entityBelow = entt::null;
        entityAbove = entt::null;
        entityLeft = entt::null;
        entityRight = entt::null;
        normalBelow = b2Vec2();
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
    float rayLength{2.f};
	int horizontalRayCount{};
	int verticalRayCount{};
	float dstBetweenRays = .8f;
	float horizontalRaySpacing{};
	float verticalRaySpacing{};

    std::vector<std::array<sf::Vertex, 2>> raycasts;
};
