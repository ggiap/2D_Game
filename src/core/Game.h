#pragma once

#include <entt/entt.hpp>
#include <Box2D/Box2D.h>

#include "../States/StateStack.h"
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"
#include "../Utils/Timer.hpp"

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

    void zoomViewAt(sf::Vector2i pixel, float zoom);
private:
    static const sf::Time TimePerFrame;

	sf::RenderWindow m_window;
	TextureHolder m_Textures;
	FontHolder m_Fonts;
	StateStack m_StateStack;
	entt::registry m_Registry;
	b2World m_B2DWorld;

	sf::Text m_StatisticsText;
	sf::Time m_StatisticsUpdateTime;
	std::size_t	m_StatisticsNumFrames;

	Timer m_CountdownTimer;
	sf::Text m_TimerLabel;
};

