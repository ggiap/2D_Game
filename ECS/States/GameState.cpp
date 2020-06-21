#include "GameState.h"
#include "StateStack.h"

GameState::GameState(StateStack& stack, Context& context)
	:
	State(stack, context),
	m_World(context)
{
}

void GameState::draw()
{
	m_World.draw();
}

bool GameState::update(const sf::Time dt)
{
	m_World.update(dt);

	return true;
}

bool GameState::handleEvent(const sf::Event& event)
{
	
	return true;
}
