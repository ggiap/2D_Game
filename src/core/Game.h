#pragma once

#include <entt/entt.hpp>
#include <Box2D/Box2D.h>

#include "../States/StateStack.h"
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"

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

	sf::Text m_StatisticsText;
	sf::Time m_StatisticsUpdateTime;
	std::size_t	m_StatisticsNumFrames;

	bool m_IsPaused{ false };
};

