#include "../Gui/Button.h"
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"
#include <SFML/Graphics/RenderTarget.hpp>

namespace GUI
{
	Button::Button(const FontHolder& fonts, const TextureHolder&) :
	m_Callback(),
	m_Sprite(),
	m_Text("", fonts.get(Fonts::ARJULIAN), 50),
	isToggled(false)
	{
		sf::FloatRect bounds = m_Sprite.getLocalBounds();
		m_Text.setPosition(bounds.width / 2.f, bounds.height / 2.f);
		m_Text.setFillColor(sf::Color(255, 255, 255, 150));
	}

	void Button::setCallback(Callback callback)
	{
		m_Callback = std::move(callback);
	}

	void Button::setText(const std::string& text)
	{
		m_Text.setString(text);
		utils::centerOrigin(m_Text);
	}

	void Button::setToggle(bool flag)
	{
		isToggled = flag;
	}

	sf::Text& Button::getText()
	{
		return m_Text;
	}

	bool Button::isSelectable() const
	{
		return true;
	}

	void Button::select()
	{
		Component::select();

		m_Text.setFillColor(sf::Color::White);
		//m_Sprite.setTexture(m_SelectedTexture);
	}

	void Button::deselect()
	{
		Component::deselect();

		m_Text.setFillColor(sf::Color(255, 255, 255, 150));
		//m_Sprite.setTexture(m_NormalTexture);
	}

	void Button::activate()
	{
		Component::activate();

		if(isToggled)
			m_Text.setFillColor(sf::Color(50, 255, 50, 255));
			//m_Sprite.setTexture(m_PressedTexture);

		if(m_Callback)
			m_Callback();

		if(!isToggled)
			deactivate();
	}

	void Button::deactivate()
	{
		Component::deactivate();

		if(isToggled)
		{
			if(isSelected())
				m_Text.setFillColor(sf::Color::White);
				//m_Sprite.setTexture(m_SelectedTexture);
			else
				m_Text.setFillColor(sf::Color(255, 255, 255, 100));
				//m_Sprite.setTexture(m_NormalTexture);
		}
	}

	void Button::handleEvent(const sf::Event&)
	{

	}

	void Button::draw(sf::RenderTarget& target, sf::RenderStates states) const
	{
		states.transform *= getTransform();
		target.draw(m_Sprite, states);
		target.draw(m_Text, states);
	}
}