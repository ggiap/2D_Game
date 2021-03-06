#include "SoundEffectPlayer.hpp"

SoundEffectPlayer::SoundEffectPlayer() :
	m_SoundBuffers(),
	m_Sounds()
{
	m_SoundBuffers.load(Sounds::ID::CoinPickup, "../res/SoundEffects/coin.wav");
	m_SoundBuffers.load(Sounds::ID::Pause, "../res/SoundEffects/pause.wav");
}

void SoundEffectPlayer::play(Sounds::ID id)
{
	m_Sounds.push_back(sf::Sound(m_SoundBuffers.get(id)));
	m_Sounds.back().setVolume(10.f);
	m_Sounds.back().play();
}

void SoundEffectPlayer::removeStoppedSounds()
{
	m_Sounds.remove_if([&](const sf::Sound& s)
		{
			return s.getStatus() == sf::Sound::Stopped;
		});
}
