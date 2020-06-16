#include "Label.h"
#include "../Utils/ResourceHolder.h"

#include <SFML/Graphics/RenderStates.hpp>
#include <SFML/Graphics/RenderTarget.hpp>

namespace GUI
{
	Label::Label(const std::string& text, FontHolder& fonts) :
	m_Text(text, fonts.get(Fonts::ARJULIAN), 30)
	{
	}

	bool Label::isSelectable() const
	{
		return false;
	}

	void Label::setText(const std::string& text)
	{
		m_Text.setString(text);
	}

	sf::Text& Label::getText()
	{
		return m_Text;
	}

	void Label::handleEvent(const sf::Event&)
	{

	}

	void Label::draw(sf::RenderTarget& target, sf::RenderStates states) const
	{
		states.transform *= getTransform();

		target.draw(m_Text, states);
	}
}