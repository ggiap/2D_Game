#pragma once
#include "../States/State.h"
#include "../core/World.h"

class StateStack;


class GameState : public State
{
public:
	GameState(StateStack &stack, Context& context);

	void draw() override;
	bool update(sf::Time dt) override;
	bool handleEvent(const sf::Event& event) override;

private:
	World m_World;
};

