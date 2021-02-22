#pragma once

#include <unordered_map>
#include <SFML/Graphics/RenderWindow.hpp>

#include "Utility.hpp"

struct Context
{
	Context() = default;
	Context(sf::RenderWindow& win, FontHolder& font, TextureHolder& texture,
			bool isPaused = false,
			std::unordered_map<entt::entity, b2Body*> bd = {}) :
				window(&win),
				fonts(&font),
				textures(&texture),
				isPaused(isPaused),
				bodies(bd)
	{
	
	}

	sf::RenderWindow* window;
	FontHolder* fonts;
	TextureHolder* textures;
	bool isPaused;
	std::unordered_map<entt::entity, b2Body*> bodies;
};