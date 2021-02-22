#include "BaseSystem.hpp"
#include "../core/World.h"

BaseSystem::BaseSystem(Context& context, World *world) :
    m_Context(&context),
    m_World(world)
{

}