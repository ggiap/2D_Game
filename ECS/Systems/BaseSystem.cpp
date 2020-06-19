#include "BaseSystem.hpp"
#include <SFML/Graphics/RenderWindow.hpp>

BaseSystem::BaseSystem(entt::registry& reg, sf::RenderWindow& win) :
	registry(&reg),
	window(&win)
{

}