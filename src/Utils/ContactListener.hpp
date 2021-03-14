//
// Created by george on 16/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP
#define ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP

#include <Box2D/Box2D.h>

class World;
struct Context;

class ContactListener : public b2ContactListener
{
public:
    ContactListener() = default;
    ContactListener(Context* context, World* world);
    ~ContactListener() override = default;

    void BeginContact(b2Contact* contact) override;
    void EndContact(b2Contact* contact) override;
    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold) override;
    void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) override;

    Context* m_Context;
    World* m_World;

    b2Fixture* platformFixture = nullptr;
    b2Fixture* otherFixture = nullptr;
};


#endif //ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP
