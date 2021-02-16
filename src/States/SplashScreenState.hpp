#pragma once

#include "State.h"
#include <SFML/Graphics/Text.hpp>
#include <SFML/Graphics/Sprite.hpp>

class SplashScreenState : public State
{
public:
	SplashScreenState(StateStack& stack, Context context);

	virtual void		draw();
	virtual bool		update(sf::Time dt);
	virtual bool		handleEvent(const sf::Event& event);


private:
	sf::Sprite			m_BackgroundSprite;
	sf::Text			m_Text;

	bool				m_ShowText;
	sf::Time			m_TextEffectTime;
};