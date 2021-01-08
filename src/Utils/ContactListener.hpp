//
// Created by george on 16/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP
#define ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP

#include <Box2D/Box2D.h>
#include <vector>


struct Contacts
{
    b2Fixture* fixtureA;
    b2Fixture* fixtureB;

    bool operator==(const Contacts& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
};

class ContactListener : public b2ContactListener
{
public:
    ContactListener() = default;
    ~ContactListener() override = default;

    void BeginContact(b2Contact* contact) override;
    void EndContact(b2Contact* contact) override;
    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold) override;
    void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) override;

    std::vector<Contacts> m_Contacts{};
};


#endif //ENTITY_COMPONENT_SYSTEM_CONTACTLISTENER_HPP
