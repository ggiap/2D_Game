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
    fixtureA = contact->GetFixtureA();
    fixtureB = contact->GetFixtureB();

    userDataA = static_cast<FixtureUserData*>(fixtureA->GetUserData());
    userDataB = static_cast<FixtureUserData*>(fixtureB->GetUserData());
    handleCoins(contact);
}

void ContactListener::EndContact(b2Contact* contact)
{
   
}

void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
    fixtureA = nullptr;
    fixtureB = nullptr;
    userDataA = nullptr;
    userDataB = nullptr;
    
    fixtureA = contact->GetFixtureA();
    fixtureB = contact->GetFixtureB();

    userDataA = static_cast<FixtureUserData*>(fixtureA->GetUserData());
    userDataB = static_cast<FixtureUserData*>(fixtureB->GetUserData());

    handleOneWayPlatforms(contact);
}

void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{

}

void ContactListener::handleOneWayPlatforms(b2Contact* contact)
{
    //check if one of the fixtures is the platform
    b2Fixture* platformFixture = nullptr;
    b2Fixture* otherFixture = nullptr;
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

    if (!platformFixture || !otherFixture)
        return;

    b2AABB platformAABB = platformFixture->GetAABB(0);
    b2AABB otherAABB = otherFixture->GetAABB(0);

    auto platformHeight = platformAABB.upperBound.y - platformAABB.lowerBound.y;
    auto halfplatformHeight = platformHeight * 0.5f;

    if (otherAABB.upperBound.y > platformAABB.lowerBound.y + halfplatformHeight &&
        otherAABB.lowerBound.y < platformAABB.upperBound.y)
    {
        contact->SetEnabled(false);
    }
}

void ContactListener::handleCoins(b2Contact* contact)
{
    b2Fixture* coinFixture = nullptr;
    b2Fixture* playerFixture = nullptr;
    FixtureUserData* coinUserData = nullptr;
    if (m_World->getEntityRegistry()->has<C_Coin>(userDataA->entity))
    {
        coinFixture = fixtureA;
        playerFixture = fixtureB;

        coinUserData = userDataA;
    }
    else if (m_World->getEntityRegistry()->has<C_Coin>(userDataB->entity))
    {
        coinFixture = fixtureB;
        playerFixture = fixtureA;

        coinUserData = userDataB;
    }

    if (!coinFixture || !playerFixture) return;

    m_World->getMarkedEntities().push_back(coinUserData->entity);
}
