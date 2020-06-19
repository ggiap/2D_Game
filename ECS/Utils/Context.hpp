#pragma once

#include <entt/entity/registry.hpp>
#include <SFML/Graphics/RenderWindow.hpp>

#include "ResourceHolder.h"

struct Context
{
	Context(sf::RenderWindow& window, TextureHolder& textures, FontHolder& fonts, entt::registry& registry);

	sf::RenderWindow* window;
	TextureHolder* textures;
	FontHolder* fonts;
	entt::registry* registry;
};