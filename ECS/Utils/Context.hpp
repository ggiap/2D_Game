#pragma once

#include <entt/entity/registry.hpp>
#include <SFML/Graphics/RenderWindow.hpp>

#include "Utility.hpp"

struct Context
{
	Context() = default;
	Context(sf::RenderWindow& window, TextureHolder& textures, FontHolder& fonts, entt::registry& registry)
		:
		window(&window),
		textures(&textures),
		fonts(&fonts),
		registry(&registry)
	{
	
	}

	sf::RenderWindow* window;
	TextureHolder* textures;
	FontHolder* fonts;
	entt::registry* registry;
};