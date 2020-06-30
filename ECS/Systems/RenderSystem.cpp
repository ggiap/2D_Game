#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Shape.hpp"

RenderSystem::RenderSystem(Context& context) :
BaseSystem(context)
{
    // Initialize SFML Debug Draw
    debugDraw.SetWindow(m_Context->window);
    debugDraw.ClearFlags(debugDraw.e_aabbBit & debugDraw.e_centerOfMassBit &
    debugDraw.e_jointBit & debugDraw.e_pairBit & debugDraw.e_shapeBit);
    m_Context->b2_World->SetDebugDraw(&debugDraw);
    // Set initial flags for what to draw
    debugDraw.SetFlags(b2Draw::e_aabbBit | b2Draw::e_jointBit); //Only draw shapes
}


void RenderSystem::update(sf::Time dt)
{
	m_Context->registry->view<BodyShape>().each([&](auto entity, auto& bodyShape)
		{
            if(!m_Context->registry->has<BodyShape>(entity)) return;

            m_Context->window->draw(bodyShape.shape);
            //m_Context->b2_World->DrawDebugData();
		});
}