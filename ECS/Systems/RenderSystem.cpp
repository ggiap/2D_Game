#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"
#include "spdlog/spdlog.h"

RenderSystem::RenderSystem(entt::registry& reg, sf::RenderWindow& win) :
BaseSystem(reg, win)
{
	
}


void RenderSystem::update(sf::Time dt)
{
	registry->view<Body>().each([&](auto& body) 
		{
			window->draw(body.shape);
		});
}