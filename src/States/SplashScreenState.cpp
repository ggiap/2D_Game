#include "SplashScreenState.hpp"
#include "../Utils/Utility.hpp"
#include <SFML/Window/Event.hpp>

SplashScreenState::SplashScreenState(StateStack& stack, Context context) :
	State(stack, context),
	m_BackgroundSprite(),
	m_Text(),
	m_ShowText(true),
	m_TextEffectTime(sf::Time::Zero)
{
	m_Text.setCharacterSize(50u);
	m_Text.setFont(context.fonts->get(Fonts::ID::ARJULIAN));
	m_Text.setString("Press any key to continue");
	utils::centerOrigin(m_Text);
	sf::Vector2f windowSize(context.window->getSize().x, context.window->getSize().y);
	m_Text.setPosition(windowSize.x / 2.f, windowSize.y / 1.1f);

	m_BackgroundSprite.setTexture(m_Context.textures->get(Textures::ID::MainBackground));
	m_BackgroundSprite.setScale(sf::Vector2f(4.5f, 4.5f));
	utils::centerOrigin(m_BackgroundSprite);
	m_BackgroundSprite.setPosition(windowSize.x / 2.f, windowSize.y / 2.2f);
}

void SplashScreenState::draw()
{
	m_Context.window->draw(m_BackgroundSprite);

	if (m_ShowText)
		m_Context.window->draw(m_Text);
}

bool SplashScreenState::update(sf::Time dt)
{
	m_TextEffectTime += dt;

	if (m_TextEffectTime > sf::seconds(0.5f))
	{
		m_ShowText = !m_ShowText;
		m_TextEffectTime = sf::Time::Zero;
	}

	return true;
}

bool SplashScreenState::handleEvent(const sf::Event& event)
{
	if (event.type == sf::Event::KeyPressed)
	{
		requestStackPop();
		requestStackPush(States::Menu);
	}

	return true;
}