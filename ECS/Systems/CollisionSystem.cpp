#include "CollisionSystem.hpp"
#include "../Components/C_Body.hpp"

void CollisionSystem::update(sf::Time dt)
{
	registry->view<Body>().each([&](auto& body) 
		{
			
		});
}