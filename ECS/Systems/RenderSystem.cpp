#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"
#include "spdlog/spdlog.h"

RenderSystem::RenderSystem(Context& context) :
BaseSystem(context)
{
	
}


void RenderSystem::update(sf::Time dt)
{
	m_Context->registry->view<Body>().each([&](auto& body)
		{
            m_Context->window->draw(body.shape);
		});
}