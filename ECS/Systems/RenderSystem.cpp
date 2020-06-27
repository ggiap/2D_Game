#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"

RenderSystem::RenderSystem(Context& context) :
BaseSystem(context)
{
    // Initialize SFML Debug Draw
    debugDraw.SetWindow(m_Context->window);
    debugDraw.ClearFlags(debugDraw.e_aabbBit & debugDraw.e_centerOfMassBit &
    debugDraw.e_jointBit & debugDraw.e_pairBit & debugDraw.e_shapeBit);
    m_Context->world->SetDebugDraw(&debugDraw);
    // Set initial flags for what to draw
    debugDraw.SetFlags(b2Draw::e_aabbBit); //Only draw shapes
}


void RenderSystem::update(sf::Time dt)
{
	m_Context->registry->view<Body>().each([&](auto& body)
		{
            m_Context->window->draw(body.shape);
            //m_Context->world->DrawDebugData();
		});
}