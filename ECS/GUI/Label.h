#pragma once

#include <SFML/Graphics/Text.hpp>
#include "Component.h"
#include "../Utils/Utility.hpp"

namespace GUI
{
	class Label : public Component
	{
	public:
		using Ptr = std::shared_ptr<Label>;

	public:
		Label(const std::string& text, FontHolder& fonts);

		virtual bool isSelectable() const;
		void setText(const std::string& text);
		sf::Text& getText();

		virtual void handleEvent(const sf::Event& event);

	private:
		void draw(sf::RenderTarget& target, sf::RenderStates states) const;

	private:
		sf::Text m_Text;
	};
}