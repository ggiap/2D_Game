//
// Created by george on 17/7/20.
//

#include "RayCastCallback.hpp"

#include <Box2D/Dynamics/b2Fixture.h>
#include "../Utils/Context.hpp"
#include "../core/World.h"

RayCastCallback::RayCastCallback(Context* context, World* world) : m_Context(context), m_World(world),
                                 m_fixture(nullptr), m_fraction(), m_normal(), m_point()
{
}

float RayCastCallback::ReportFixture(b2Fixture *fixture, const b2Vec2 &point, const b2Vec2 &normal, float32 fraction)
{
    m_fixture = fixture;
    m_point = point;
    m_normal = normal;
    m_fraction = fraction;

    return fraction;
}
