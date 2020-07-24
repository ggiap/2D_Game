//
// Created by george on 17/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_RAYCASTCALLBACK_HPP
#define ENTITY_COMPONENT_SYSTEM_RAYCASTCALLBACK_HPP

#include <Box2D/Dynamics/b2WorldCallbacks.h>
#include <Box2D/Common/b2Math.h>

class b2Fixture;

class RayCastCallback : public b2RayCastCallback
{
public:
    ~RayCastCallback() override = default;

    float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point,
                                const b2Vec2& normal, float32 fraction) override;

    b2Fixture* m_fixture;
    b2Vec2 m_point;
    b2Vec2 m_normal;
    float32 m_fraction;
};


#endif //ENTITY_COMPONENT_SYSTEM_RAYCASTCALLBACK_HPP
