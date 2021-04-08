#pragma once

#include <Box2D/Dynamics/b2WorldCallbacks.h>
#include <Box2D/Common/b2Math.h>

class b2Fixture;
class World;
struct Context;

class RayCastCallback : public b2RayCastCallback
{
public:
    RayCastCallback() = default;
    RayCastCallback(Context* context, World* world);
    ~RayCastCallback() override = default;

    float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point,
                                const b2Vec2& normal, float32 fraction) override;

    b2Fixture* m_fixture;
    b2Vec2 m_point;
    b2Vec2 m_normal;
    float32 m_fraction;

    Context* m_Context;
    World* m_World;
};
