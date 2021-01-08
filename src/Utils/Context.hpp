#pragma once

#include <unordered_map>

#include <entt/entity/registry.hpp>
#include <SFML/Graphics/RenderWindow.hpp>
#include <Box2D/Box2D.h>

#include "Utility.hpp"

struct Context
{
	Context() = default;
	Context(sf::RenderWindow& win, TextureHolder& tex,
	        FontHolder& font, entt::registry& reg,
	        b2World& wr, std::unordered_map<entt::entity, b2Body*> bd = {}) :
            window(&win),
            textures(&tex),
            fonts(&font),
            registry(&reg),
            b2_World(&wr),
            bodies(bd)
	{
	
	}

	sf::RenderWindow* window;
	TextureHolder* textures;
	FontHolder* fonts;
	entt::registry* registry;
	b2World* b2_World;
	std::unordered_map<entt::entity, b2Body*> bodies;
};