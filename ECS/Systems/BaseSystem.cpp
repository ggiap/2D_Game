#include "BaseSystem.hpp"

BaseSystem::BaseSystem(Context& context) :
    m_Context(&context)
{
    /* Initialize SFML Debug Draw */
    debugDraw.SetWindow(m_Context->window);
    m_Context->world->SetDebugDraw(&debugDraw);
    /* Set initial flags for what to draw */
    debugDraw.SetFlags(b2Draw::e_shapeBit); //Only draw shapes
}