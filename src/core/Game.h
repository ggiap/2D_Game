#pragma once

#include "../States/StateStack.h"
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"
#include "../core/MusicPlayer.hpp"

class Game : private sf::NonCopyable
{
public:
	Game();
	void Run();

private:
	void HandleEvents();
	void Update(sf::Time dt);
	void Render();

	void loadResources();
	void registerStates();
	void updateStatistics(sf::Time dt);

private:
    static const sf::Time TimePerFrame;

	sf::RenderWindow m_window;
	FontHolder m_Fonts;
	TextureHolder m_Textures;
	StateStack m_StateStack;
	MusicPlayer m_MusicPlayer;

	sf::Text m_StatisticsText;
	sf::Time m_StatisticsUpdateTime;
	std::size_t	m_StatisticsNumFrames;

	bool m_IsPaused{ false };
};

