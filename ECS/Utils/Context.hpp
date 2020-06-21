#pragma once

#include <entt/entity/registry.hpp>
#include <SFML/Graphics/RenderWindow.hpp>

#include "Utility.hpp"

struct Context
{
	Context() = default;
	Context(sf::RenderWindow& win, TextureHolder& tex, FontHolder& font, entt::registry& reg)
		:
		window(&win),
		textures(&tex),
		fonts(&font),
		registry(&reg)
	{
	
	}

	sf::RenderWindow* window;
	TextureHolder* textures;
	FontHolder* fonts;
	entt::registry* registry;
};