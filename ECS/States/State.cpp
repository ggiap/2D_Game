#include "State.h"
#include "StateStack.h"

State::State(StateStack& stack, Context context) :
	m_Stack(&stack),
	m_Context(context)
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

//Context State::getContext() const
//{
//	return m_Context;
//}
