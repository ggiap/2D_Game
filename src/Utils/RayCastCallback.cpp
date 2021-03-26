#include "RayCastCallback.hpp"

#include <Box2D/Dynamics/b2Fixture.h>
#include "../Utils/Context.hpp"
#include "../Utils/FixtureUserData.hpp"
#include "../core/World.h"
#include "../Components/C_Tag.h"

RayCastCallback::RayCastCallback(Context* context, World* world) : m_Context(context), m_World(world),
                                 m_fixture(nullptr), m_fraction(), m_normal(), m_point()
{
}

float RayCastCallback::ReportFixture(b2Fixture *fixture, const b2Vec2 &point, const b2Vec2 &normal, float32 fraction)
{
    b2Filter filterData = fixture->GetFilterData();

    if (filterData.categoryBits == BodyCategory::Coin || filterData.categoryBits == BodyCategory::Ladder)
    {
        return -1.f;
    }
    
    m_fixture = fixture;
    m_point = point;
    m_normal = normal;
    m_fraction = fraction;

    return fraction;
}
