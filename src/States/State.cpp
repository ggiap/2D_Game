#include "State.h"

#include <utility>
#include "StateStack.h"

State::State(StateStack& stack, Context context) :
	m_Stack(&stack),
	m_Context(std::move(context))
{
}

void State::requestStackPush(States::ID stateID) const
{
	m_Stack->pushState(stateID);
}

void State::requestStackPop() const
{
	m_Stack->popState();
}

void State::requestStackClear() const
{
	m_Stack->clearStates();
}
