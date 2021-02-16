#pragma once

#include "State.h"
#include <vector>

class MenuState : public State
{
public:
	MenuState(StateStack& stack, Context& context);

	void draw() override;
	bool update(sf::Time dt) override;
	bool handleEvent(const sf::Event& event) override;

private:
	void updateOptionsText();


private:
	enum OptionNames
	{
		Play,
		Exit,
	};

	std::vector<sf::Text> m_Options;
	std::size_t optionIndex;
};