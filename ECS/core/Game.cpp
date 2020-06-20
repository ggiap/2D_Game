#include "Game.h"
#include <SFML/Window/Event.hpp>
#include "../States/GameState.h"
#include "spdlog/spdlog.h"

const sf::Time TimePerFrame = sf::seconds(1 / 60.f);

Game::Game() :
	m_window(sf::VideoMode(1200, 800), "Application", sf::Style::Close),
	m_Textures(),
	m_Fonts(),
	m_StateStack(Context(m_window, m_Textures, m_Fonts, registry)),
	m_StatisticsText(),
	m_StatisticsUpdateTime(),
	m_StatisticsNumFrames(0)
{
	m_window.setKeyRepeatEnabled(false);

	loadResources();

	m_StatisticsText.setFont(m_Fonts.get(Fonts::ARJULIAN));
	m_StatisticsText.setPosition(5.f, 5.f);
	m_StatisticsText.setCharacterSize(20u);

	registerStates();
	m_StateStack.pushState(States::Game);
}

void Game::Run()
{
	sf::Clock clock;
	sf::Time timeSinceLastUpdate = sf::Time::Zero;
	
	while (m_window.isOpen())
	{
		const sf::Time dt = clock.restart();
		timeSinceLastUpdate += dt;
		while (timeSinceLastUpdate > TimePerFrame)
		{
			timeSinceLastUpdate -= TimePerFrame;
			HandleEvents();
			Update(TimePerFrame);

			// Check inside this loop, because stack might be empty before the update() call
			if (m_StateStack.isEmpty())
				m_window.close();
		}
		updateStatistics(dt);
		Render();
	}
}

void Game::HandleEvents()
{
	sf::Event event{};
	while (m_window.pollEvent(event))
	{
		m_StateStack.handleEvent(event);

		if (event.type == sf::Event::Closed)
			m_window.close();
	}
}

void Game::Update(sf::Time dt)
{
	m_StateStack.update(dt);
}

void Game::Render()
{
	m_window.clear();
	m_StateStack.draw();
	m_window.draw(m_StatisticsText);

	m_window.setView(m_window.getDefaultView());
	m_window.display();
}

void Game::loadResources()
{
	m_Fonts.load(Fonts::ARJULIAN, "../res/Font/ARJULIAN.ttf");
}

void Game::registerStates()
{
	m_StateStack.registerState<GameState>(States::Game);
}

void Game::updateStatistics(sf::Time dt)
{
	m_StatisticsUpdateTime += dt;
	m_StatisticsNumFrames += 1;
	if (m_StatisticsUpdateTime >= sf::seconds(1.0f))
	{
		m_StatisticsText.setString("FPS: " + std::to_string(m_StatisticsNumFrames));
		spdlog::info(std::to_string(m_StatisticsNumFrames));
		m_StatisticsUpdateTime -= sf::seconds(1.0f);
		m_StatisticsNumFrames = 0;
	}
}
