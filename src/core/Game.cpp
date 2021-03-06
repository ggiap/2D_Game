#include "Game.h"
#include <SFML/Window/Event.hpp>
#include "../States/GameState.h"
#include "../States/MenuState.hpp"
#include "../States/SplashScreenState.hpp"
#include "../States/PauseState.hpp"

const sf::Time Game::TimePerFrame = sf::seconds(1 / 60.f);

Game::Game() :
	m_window(sf::VideoMode(1200, 800), "Application",
	        sf::Style::Close | sf::Style::Resize, sf::ContextSettings(0,0,0,1,1)),
	m_Fonts(),
	m_MusicPlayer(),
	m_SoundPlayer(),
	m_StateStack(Context(m_window, m_Fonts, m_Textures, m_MusicPlayer, m_SoundPlayer)),
	m_StatisticsText(),
	m_StatisticsUpdateTime(),
	m_StatisticsNumFrames(0)
{
	m_window.setKeyRepeatEnabled(false);

	loadResources();

	m_StatisticsText.setFont(m_Fonts.get(Fonts::ID::ARJULIAN));
	m_StatisticsText.setOutlineThickness(3.f);
	m_StatisticsText.setOutlineColor(sf::Color::Black);
	m_StatisticsText.setCharacterSize(20u);

	registerStates();
	m_StateStack.pushState(States::Title);
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

			if(!m_IsPaused)
				Update(TimePerFrame);

			// Check inside this loop, because stack might be empty before the update() call
			if (m_StateStack.isEmpty())
				m_window.close();
		}

		if (!m_IsPaused)
		{
			updateStatistics(dt);
			Render();
		}
	}
}

void Game::HandleEvents()
{
	sf::Event event{};
	while (m_window.pollEvent(event))
	{
		m_StateStack.handleEvent(event);

		if (event.type == sf::Event::LostFocus)
		{
			m_IsPaused = true;
		}

		if (event.type == sf::Event::GainedFocus)
		{
			m_IsPaused = false;
		}

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
}

void Game::Render()
{
	m_window.clear();
	m_StateStack.draw();
	m_window.draw(m_StatisticsText);
	m_window.display();
}

void Game::loadResources()
{
	m_Fonts.load(Fonts::ID::ARJULIAN, "../res/Font/ARJULIAN.ttf");
	m_Textures.load(Textures::ID::CharactersSpriteSheet, "../res/Sprites/SMB_Characters2.png");
	m_Textures.load(Textures::ID::MonochromeSpriteSheet, "../res/Sprites/Tilemap/monochrome_tilemap_transparent_packed.png");
	m_Textures.load(Textures::ID::SplashScreen, "../res/Sprites/bg.png");
}

void Game::registerStates()
{
	m_StateStack.registerState<SplashScreenState>(States::Title);
	m_StateStack.registerState<MenuState>(States::Menu);
	m_StateStack.registerState<GameState>(States::Game);
	m_StateStack.registerState<PauseState>(States::Pause);
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
}
