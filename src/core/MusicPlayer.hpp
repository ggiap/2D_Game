#include <map>
#include <SFML/Audio/Music.hpp>
#include "../Utils/Utility.hpp"

class MusicPlayer : sf::NonCopyable
{
public:
	MusicPlayer();

	void play(Music::ID id);
	void stop();
	void setPaused(bool paused);

private:
	sf::Music m_Music;
	std::map<Music::ID, std::string> m_Filenames;
	float m_Volume;
};