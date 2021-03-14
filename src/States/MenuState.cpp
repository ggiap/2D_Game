#include "MenuState.hpp"
#include <SFML/Window/Event.hpp>
#include "../Utils/Utility.hpp"
#include "../Components/C_Camera.hpp"
#include "../core/MusicPlayer.hpp"


MenuState::MenuState(StateStack& stack, Context& context) :
	State(stack, context),
	m_Options(),
	optionIndex(0)
{
	auto& font = context.fonts->get(Fonts::ID::ARJULIAN);

	sf::Text playText;
	playText.setFont(font);
	playText.setString("Play");
	utils::centerOrigin(playText);
	m_Options.push_back(playText);

	sf::Text exitText;
	exitText.setFont(font);
	exitText.setString("Exit");
	utils::centerOrigin(exitText);
	m_Options.push_back(exitText);

	updateOptionsText();

	m_Context.music->play(Music::ID::MenuTheme);

	auto windowSize = m_Context.window->getSize();
	m_BackgroundSprite.setTexture(m_Context.textures->get(Textures::ID::MainBackground));
	m_BackgroundSprite.setScale(sf::Vector2f(4.5f, 4.5f));
	utils::centerOrigin(m_BackgroundSprite);
	m_BackgroundSprite.setPosition(windowSize.x / 2.f, windowSize.y / 2.2f);
}

void MenuState::draw()
{
	m_Context.window->setView(m_Context.window->getDefaultView());

	m_Context.window->draw(m_BackgroundSprite);

	for (const auto& text : m_Options)
		m_Context.window->draw(text);
}

bool MenuState::update(sf::Time dt)
{
	for (std::size_t i = 0; i < m_Options.size(); ++i)
	{
		m_Options.at(i).setPosition(m_Context.window->getView().getCenter() - sf::Vector2f(15.f, 15.f) + sf::Vector2f(0, i * 40.f));
	}

	return true;
}

bool MenuState::handleEvent(const sf::Event& event)
{
	// The demonstration menu logic
	if (event.type != sf::Event::KeyPressed)
		return false;

	if (event.key.code == sf::Keyboard::Return)
	{
		if (optionIndex == Play)
		{
			requestStackPop();
			requestStackPush(States::Game);
		}
		else if (optionIndex == Exit)
		{
			// The exit option was chosen, by removing itself, the stack will be empty, and the game will know it is time to close.
			requestStackPop();
		}
	}

	else if (event.key.code == sf::Keyboard::Up)
	{
		// Decrement and wrap-around
		if (optionIndex > 0)
			optionIndex--;
		else
			optionIndex = m_Options.size() - 1;

		updateOptionsText();
	}

	else if (event.key.code == sf::Keyboard::Down)
	{
		// Increment and wrap-around
		if (optionIndex < m_Options.size() - 1)
			optionIndex++;
		else
			optionIndex = 0;

		updateOptionsText();
	}

	return true;
}

void MenuState::updateOptionsText()
{
	if (m_Options.empty())
		return;

	// White color for all text options
	for (auto& text : m_Options)
		text.setFillColor(sf::Color::White);

	// Red color for selected option
	m_Options[optionIndex].setFillColor(sf::Color::Red);
}