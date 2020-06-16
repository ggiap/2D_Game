#pragma once

#include <entt/entt.hpp>

#include "World.h"
#include "../States/State.h"
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
	sf::RenderWindow m_window;
	TextureHolder m_Textures;
	FontHolder m_Fonts;
	StateStack m_StateStack;
	entt::registry registry;

	sf::Text m_StatisticsText;
	sf::Time m_StatisticsUpdateTime;
	std::size_t	m_StatisticsNumFrames;
};

