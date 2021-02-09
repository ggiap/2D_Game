#include "Game.h"
#include <SFML/Window/Event.hpp>
#include "../States/GameState.h"

const sf::Time Game::TimePerFrame = sf::seconds(1 / 60.f);

Game::Game() :
	m_window(sf::VideoMode(1200, 800), "Application",
	        sf::Style::Close | sf::Style::Resize, sf::ContextSettings(0,0,0,1,1)),
	m_Textures(),
	m_Fonts(),
	m_B2DWorld(b2Vec2(0, 9.81)),
	m_StateStack(Context(m_window, m_Textures, m_Fonts, m_Registry, m_B2DWorld)),
	m_StatisticsText(),
	m_StatisticsUpdateTime(),
	m_StatisticsNumFrames(0),
	m_CountdownTimer(sf::seconds(1001))
{
	m_window.setKeyRepeatEnabled(false);

	m_B2DWorld.SetAllowSleeping(true);

	loadResources();

	m_StatisticsText.setFont(m_Fonts.get(Fonts::ARJULIAN));
	m_StatisticsText.setOutlineThickness(3);

	m_StatisticsText.setCharacterSize(20u);

	registerStates();
	m_StateStack.pushState(States::Game);

	m_CountdownTimer.start();
	m_TimerLabel.setFont(m_Fonts.get(Fonts::ARJULIAN));
	m_TimerLabel.setOutlineThickness(3);
	m_TimerLabel.setCharacterSize(20u);
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

    m_StatisticsText.setPosition(m_window.getView().getCenter().x - m_window.getView().getSize().x / 2.f,
                                 m_window.getView().getCenter().y - m_window.getView().getSize().y / 2.f);
    m_StatisticsText.setScale(m_window.getView().getSize().x /  m_window.getDefaultView().getSize().x,
                              m_window.getView().getSize().y /  m_window.getDefaultView().getSize().y);

	m_TimerLabel.setPosition(m_window.getView().getCenter().x + m_window.getView().getSize().x / 2.4f,
							 m_window.getView().getCenter().y - m_window.getView().getSize().y / 2.f);
	m_TimerLabel.setScale(m_window.getView().getSize().x / m_window.getDefaultView().getSize().x,
						  m_window.getView().getSize().y / m_window.getDefaultView().getSize().y);
						  
	m_CountdownTimer.update(dt);
	if (m_CountdownTimer.getRemainingTime() <= 0)
		m_window.close();
}

void Game::Render()
{
	m_window.clear();
	m_StateStack.draw();
	m_window.draw(m_StatisticsText);
	m_window.draw(m_TimerLabel);
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
		m_StatisticsUpdateTime -= sf::seconds(1.0f);
		m_StatisticsNumFrames = 0;
	}
	m_TimerLabel.setString("Time: " + std::to_string(static_cast<int>(m_CountdownTimer.getRemainingTime())));
}
