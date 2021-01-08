#include "StateStack.h"

#include <utility>

StateStack::StateStack(Context context) :
	m_Stack(),
	m_PendingList(),
	m_Context(std::move(context)),
	m_Factories()
{
}

State::Ptr StateStack::createState(States::ID stateID)
{
	const auto found = m_Factories.find(stateID);

	assert(found != m_Factories.end());

	return found->second();
}

void StateStack::applyPendingChange()
{
	for (auto change : m_PendingList)
	{
		switch (change.action)
		{
		case Action::Push:
			m_Stack.push_back(createState(change.stateID));
			break;

		case Action::Pop:
			m_Stack.pop_back();
			break;

		case Action::Clear:
			m_Stack.clear();
			break;

		default:
			break;
		}
	}

	m_PendingList.clear();
}

void StateStack::update(sf::Time dt)
{
	for (auto iter = m_Stack.rbegin(); iter != m_Stack.rend(); ++iter)
	{
		if (!(*iter)->update(dt))
			break;
	}

	applyPendingChange();
}

void StateStack::draw()
{
	for (auto& state : m_Stack)
		state->draw();
}

void StateStack::handleEvent(const sf::Event& event)
{
	for (auto iter = m_Stack.rbegin(); iter != m_Stack.rend(); ++iter)
	{
		if (!(*iter)->handleEvent(event))
			break;
	}

	applyPendingChange();
}

void StateStack::pushState(States::ID stateID)
{
	m_PendingList.emplace_back(Push, stateID);
}

void StateStack::popState()
{
	m_PendingList.emplace_back(Pop);
}

void StateStack::clearStates()
{
	m_PendingList.emplace_back(Clear);
}

bool StateStack::isEmpty() const
{
	return m_Stack.empty();
}

StateStack::PendingChange::PendingChange(Action action, States::ID stateID) :
	action(action), stateID(stateID)
{
}
