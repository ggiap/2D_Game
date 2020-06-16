#include "State.h"
#include "StateStack.h"
#include "../Utils/Utility.hpp"

State::Context::Context(sf::RenderWindow& window, TextureHolder& textures, FontHolder& fonts, entt::registry& registry) :
	window(&window),
	textures(&textures),
	fonts(&fonts),
	registry(&registry)
{

}

State::State(StateStack& stack, Context context) :
	m_Stack(&stack),
	m_Context(context)
{
}

State::~State()
{
}

void State::requestStackPush(States::ID stateID)
{
	m_Stack->pushState(stateID);
}

void State::requestStackPop()
{
	m_Stack->popState();
}

void State::requestStackClear()
{
	m_Stack->clearStates();
}

State::Context State::getContext() const
{
	return m_Context;
}
