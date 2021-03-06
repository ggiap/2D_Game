#include "MusicPlayer.hpp"

MusicPlayer::MusicPlayer() :
	m_Music(),
	m_Filenames(),
	m_Volume(100.f)
{
	m_Filenames[Music::ID::MenuTheme] = "../res/Music/Menu_Select.ogg";
	m_Filenames[Music::ID::GameTheme] = "../res/Music/Stage 1.ogg";
}

void MusicPlayer::play(Music::ID id)
{
	auto filename = m_Filenames.at(id);

	if (!m_Music.openFromFile(filename))
	{
		throw std::runtime_error("Couldn't load " + filename + ".");
	}

	m_Music.setVolume(m_Volume);
	m_Music.setLoop(true);
	m_Music.play();
}

void MusicPlayer::stop()
{
	m_Music.stop();
}

void MusicPlayer::setPaused(bool paused)
{
	if (paused)
		m_Music.pause();
	else
		m_Music.play();
}
