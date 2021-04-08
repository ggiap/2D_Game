#pragma once

#include "../Utils/Utility.hpp"
#include "../Utils/ResourceHolder.h"

#include <SFML/Audio/Sound.hpp>
#include <SFML/Audio/SoundBuffer.hpp>

#include <list>

class SoundEffectPlayer : public sf::NonCopyable
{
public:
	SoundEffectPlayer();

	void play(Sounds::ID id);

	void removeStoppedSounds();

private:
	SoundBufferHolder m_SoundBuffers;
	std::list<sf::Sound> m_Sounds;
};