#include "../States/GameState.h"

GameState::GameState(StateStack& stack, Context context)
	:
	State(stack, context),
	m_World(getContext())
{
}

void GameState::draw()
{
	m_World.draw();
}

bool GameState::update(sf::Time dt)
{
	m_World.update(dt);

	return true;
}

bool GameState::handleEvent(const sf::Event& event)
{
	
	return true;
}
