//
// Created by george on 17/7/20.
//

#include "RayCastCallback.hpp"

#include <Box2D/Dynamics/b2Fixture.h>

float RayCastCallback::ReportFixture(b2Fixture *fixture, const b2Vec2 &point, const b2Vec2 &normal, float32 fraction)
{
    m_fixture = fixture;
    m_point = point;
    m_normal = normal;
    m_fraction = fraction;

    return fraction;
}
