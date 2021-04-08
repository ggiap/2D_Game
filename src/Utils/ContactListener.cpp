#include "ContactListener.hpp"
#include "Context.hpp"
#include "FixtureUserData.hpp"
#include "../core/World.h"
#include "../core/SoundEffectPlayer.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Raycast.hpp"


ContactListener::ContactListener(Context* context, World* world) : m_Context(context), m_World(world)
{
}

void ContactListener::BeginContact(b2Contact* contact)
{
    initMemberData(contact);

    handleCoins();
}

void ContactListener::EndContact(b2Contact* contact)
{

}

void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
    initMemberData(contact);

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

void ContactListener::handleCoins()
{
    FixtureUserData* coinUserData = nullptr;
    if (m_World->getEntityRegistry()->has<C_Coin>(userDataA->entity))
    {
        coinUserData = userDataA;
    }
    else if (m_World->getEntityRegistry()->has<C_Coin>(userDataB->entity))
    {
        coinUserData = userDataB;
    }

    if (coinUserData == nullptr) return;

    m_Context->sounds->play(Sounds::ID::CoinPickup);
    m_World->getMarkedEntities().push_back(coinUserData->entity);
}

void ContactListener::initMemberData(b2Contact* contact)
{
    fixtureA = contact->GetFixtureA();
    fixtureB = contact->GetFixtureB();

    userDataA = static_cast<FixtureUserData*>(fixtureA->GetUserData());
    userDataB = static_cast<FixtureUserData*>(fixtureB->GetUserData());
}
