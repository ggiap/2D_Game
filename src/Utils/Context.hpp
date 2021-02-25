#pragma once

#include <unordered_map>
#include <SFML/Graphics/RenderWindow.hpp>

#include "Utility.hpp"

class MusicPlayer;
class SoundEffectPlayer;

struct Context
{
	Context() = default;
	Context(sf::RenderWindow& win, FontHolder& font, TextureHolder& texture, MusicPlayer& music, SoundEffectPlayer& sounds,
			bool isPaused = false,
			std::unordered_map<entt::entity, b2Body*> bd = {}) :
				window(&win),
				fonts(&font),
				textures(&texture),
				music(&music),
				sounds(&sounds),
				isPaused(isPaused),
				bodies(bd)
	{
	
	}

	sf::RenderWindow* window;
	FontHolder* fonts;
	TextureHolder* textures;
	MusicPlayer* music;
	SoundEffectPlayer* sounds;
	bool isPaused;
	std::unordered_map<entt::entity, b2Body*> bodies;
};