//
// Created by george on 22/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP
#define ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP

#include <Box2D/Common/b2Math.h>

struct CollisionInfo
{
    bool collisionAbove{false};
    bool collisionBelow{false};
    bool collisionLeft {false};
    bool collisionRight{false};

    void reset()
    {
        collisionAbove = false;
        collisionBelow = false;
        collisionLeft  = false;
        collisionRight = false;
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

    CollisionInfo collisionInfo;
    RaycastOrigins raycastOrigins;
};

#endif //ENTITY_COMPONENT_SYSTEM_C_RAYCAST_HPP
