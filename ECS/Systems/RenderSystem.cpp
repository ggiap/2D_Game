#include "RenderSystem.hpp"
#include <SFML/System/Time.hpp>
#include "../Components/C_Body.hpp"

void RenderSystem::update(sf::Time dt)
{
	registry->view<Body>().each([&](auto& body) 
		{
			window->draw(body.shape);
		});
}