//
// Created by george on 16/7/20.
//

#include "ContactListener.hpp"
#include <algorithm>
#include "Context.hpp"
#include "../core/World.h"
#include "../Components/C_Tag.h"
#include "../Utils/FixtureUserData.hpp"

ContactListener::ContactListener(Context* context, World* world) : m_Context(context), m_World(world)
{
}

void ContactListener::BeginContact(b2Contact* contact)
{
    Contacts contacts = { contact->GetFixtureA(), contact->GetFixtureB()};
    m_Contacts.push_back(contacts);
}

void ContactListener::EndContact(b2Contact* contact)
{
    Contacts contacts = { contact->GetFixtureA(), contact->GetFixtureB()};
    auto found = std::find(m_Contacts.begin(), m_Contacts.end(), contacts);

    if(found != m_Contacts.end())
        m_Contacts.erase(found);
}

void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
    b2Fixture* fixtureA = contact->GetFixtureA();
    b2Fixture* fixtureB = contact->GetFixtureB();

    auto userDataA = static_cast<FixtureUserData*>(fixtureA->GetUserData());
    auto userDataB = static_cast<FixtureUserData*>(fixtureB->GetUserData());

    //check if one of the fixtures is the platform
    b2Fixture* platformFixture = NULL;
    b2Fixture* otherFixture = NULL;
    if (m_World->getEntityRegistry()->has<C_OneWayPlatform>(userDataA->entity))
    {
        platformFixture = fixtureA;
        otherFixture = fixtureB;
    }
    else if (m_World->getEntityRegistry()->has<C_OneWayPlatform>(userDataB->entity))
    {
        platformFixture = fixtureB;
        otherFixture = fixtureA;
    }

    if (!platformFixture)
        return;

    int numPoints = contact->GetManifold()->pointCount;
    b2WorldManifold worldManifold;
    contact->GetWorldManifold(&worldManifold);

    b2Body* platformBody = platformFixture->GetBody();
    b2Body* otherBody = otherFixture->GetBody();

    //check if contact points are moving into platform
    for (int i = 0; i < numPoints; i++)
    {
        b2Vec2 pointVelPlatform =
            platformBody->GetLinearVelocityFromWorldPoint(worldManifold.points[i]);
        b2Vec2 pointVelOther =
            otherBody->GetLinearVelocityFromWorldPoint(worldManifold.points[i]);
        b2Vec2 relativeVel = -platformBody->GetLocalVector(pointVelOther - pointVelPlatform);

        if (relativeVel.y < 1) //if moving down faster than 1 m/s, handle as before
            return;//point is moving into platform, leave contact solid and exit
        else if (relativeVel.y < 1) 
        { //if moving slower than 1 m/s
            //borderline case, moving only slightly out of platform
            b2Vec2 relativePoint = platformBody->GetLocalPoint(worldManifold.points[i]);
            float platformFaceY = 0.5f;//front of platform, from fixture definition :(
            if (relativePoint.y > platformFaceY - 0.05)
                return;//contact point is less than 5cm inside front face of platfrom
        }
    }

    //no points are moving into platform, contact should not be solid
    contact->SetEnabled(false);
}

void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{
    //reset the default state of the contact in case it comes back for more
    contact->SetEnabled(true);
}
