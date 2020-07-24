#include "Game.h"
#include <SFML/Window/Event.hpp>
#include "../States/GameState.h"

const sf::Time Game::TimePerFrame = sf::seconds(1 / 60.f);

Game::Game() :
	m_window(sf::VideoMode(1200, 800), "Application",
	        sf::Style::Close | sf::Style::Resize, sf::ContextSettings(0,0,1,1,1)),
	m_Textures(),
	m_Fonts(),
	m_B2DWorld(b2Vec2(0, 9.81)),
	m_StateStack(Context(m_window, m_Textures, m_Fonts, m_Registry, m_B2DWorld)),
	m_StatisticsText(),
	m_StatisticsUpdateTime(),
	m_StatisticsNumFrames(0)
{
	m_window.setKeyRepeatEnabled(false);

	m_B2DWorld.SetAllowSleeping(true);

	loadResources();

	m_StatisticsText.setFont(m_Fonts.get(Fonts::ARJULIAN));
	m_StatisticsText.setOutlineThickness(3);
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

		if(sf::Keyboard::isKeyPressed(sf::Keyboard::R))
        {
            m_window.setView(m_window.getDefaultView());
        }

        if (event.type == sf::Event::MouseWheelScrolled)
        {
            auto zoomAmount = 1.1f;
            if (event.mouseWheelScroll.delta > 0)
                zoomViewAt({ event.mouseWheelScroll.x, event.mouseWheelScroll.y }, (1.f / zoomAmount));
            else if (event.mouseWheelScroll.delta < 0)
                zoomViewAt({ event.mouseWheelScroll.x, event.mouseWheelScroll.y }, zoomAmount);
        }
	}
}

void Game::Update(sf::Time dt)
{
	m_StateStack.update(dt);


    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
    {
        auto view = m_window.getView();
        view.move({0.f, -10.f});
        m_window.setView(view);
    }
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
    {
        auto view = m_window.getView();
        view.move({0.f, 10.f});
        m_window.setView(view);
    }
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
    {
        auto view = m_window.getView();
        view.move({10.f, 0.f});
        m_window.setView(view);
    }
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
    {
        auto view = m_window.getView();
        view.move({-10.f, 0.f});
        m_window.setView(view);
    }
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
}

void Game::zoomViewAt(sf::Vector2i pixel, float zoom)
{
    const sf::Vector2f beforeCoord{ m_window.mapPixelToCoords(pixel) };
    sf::View view{ m_window.getView() };
    view.zoom(zoom);
    m_window.setView(view);
    const sf::Vector2f afterCoord{ m_window.mapPixelToCoords(pixel) };
    const sf::Vector2f offsetCoords{ beforeCoord - afterCoord };
    view.move(offsetCoords);
    m_window.setView(view);
}
