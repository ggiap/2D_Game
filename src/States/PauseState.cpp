#include "PauseState.hpp"
#include "../Utils/Utility.hpp"
#include <SFML/Window/Event.hpp>
#include "../utils/Context.hpp"

PauseState::PauseState(StateStack& stack, Context& context) :
	State(stack, context)
{
	m_Text.setFont(m_Context.fonts->get(Fonts::ARJULIAN));
	m_Text.setString("Paused");
	m_Text.setCharacterSize(20u);
	m_Text.setOutlineThickness(3.f);
	utils::centerOrigin(m_Text);
}

void PauseState::draw()
{
	sf::RectangleShape background;
	background.setFillColor(sf::Color(0, 0, 0, 150));
	background.setSize(sf::Vector2f(m_Context.window->getSize()));

	m_Context.window->draw(background);
	m_Context.window->draw(m_Text);
}

bool PauseState::update(sf::Time dt)
{
	m_Text.setPosition(m_Context.window->getView().getCenter());
	m_Text.setScale(m_Context.window->getView().getSize().x / m_Context.window->getDefaultView().getSize().x,
					m_Context.window->getView().getSize().y / m_Context.window->getDefaultView().getSize().y);

	return false;
}

bool PauseState::handleEvent(const sf::Event& event)
{
	if (event.type != sf::Event::KeyPressed)
		return false;

	if (event.key.code == sf::Keyboard::Escape)
	{
		requestStackPop();
		m_Context.isPaused = false;
	}

	if (event.key.code == sf::Keyboard::BackSpace)
	{
		requestStackClear();
		requestStackPush(States::Menu);
	}

	return false;
}