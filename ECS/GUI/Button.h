#pragma once

#include <memory>
#include <functional>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/Graphics/Text.hpp>

#include "Component.h"
#include "../Utils/Utility.hpp"

namespace GUI
{
	class Button : public Component
	{
	public:
		using Ptr = std::shared_ptr<Button>;
		using Callback = std::function<void()>;

	public:
		Button(const FontHolder& fonts, const TextureHolder& textures);

		void setCallback(Callback callback);
		void setText(const std::string& text);
		void setToggle(bool flag);

		sf::Text& getText();

		virtual bool isSelectable() const;
		virtual void select();
		virtual void deselect();

		virtual void activate();
		virtual void deactivate();

		virtual void handleEvent(const sf::Event& event);

	private:
		virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const;

	private:
		Callback m_Callback;
		//const sf::Texture& m_NormalTexture;
		//const sf::Texture& m_SelectedTexture;
		//const sf::Texture& m_PressedTexture;
		sf::Sprite m_Sprite;
		sf::Text m_Text;
		bool isToggled;
	};
}