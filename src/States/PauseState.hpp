#pragma once

#include "State.h"

class PauseState : public State
{
public:
	PauseState(StateStack& stack, Context& context);
	~PauseState();

	void draw() override;
	bool update(sf::Time dt) override;
	bool handleEvent(const sf::Event& event) override;

private:
	sf::Text m_Text;
};