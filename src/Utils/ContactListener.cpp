//
// Created by george on 16/7/20.
//

#include "ContactListener.hpp"
#include <algorithm>
#include "Context.hpp"
#include "../core/World.h"

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
    
}

void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{
    
}
