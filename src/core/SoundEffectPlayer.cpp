#include "SoundEffectPlayer.hpp"

SoundEffectPlayer::SoundEffectPlayer() :
	m_SoundBuffers(),
	m_Sounds()
{
	m_SoundBuffers.load(Sounds::ID::CoinPickup, "../res/SoundEffects/coin.wav");
	m_SoundBuffers.load(Sounds::ID::Pause, "../res/SoundEffects/pause.wav");
	m_SoundBuffers.load(Sounds::ID::Squash, "../res/SoundEffects/squash.wav");
}

void SoundEffectPlayer::play(Sounds::ID id)
{
	m_Sounds.push_back(sf::Sound(m_SoundBuffers.get(id)));
	m_Sounds.back().setVolume(10.f);
	m_Sounds.back().play();
}
