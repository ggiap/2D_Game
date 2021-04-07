#pragma once
#include <vector>
#include <map>
#include <functional>
#include <cassert>

#include <SFML/System/Time.hpp>
#include <SFML/System/NonCopyable.hpp>

#include "State.h"
#include "StateIdentifiers.h"
#include "../Utils/Context.hpp"

class StateStack : private sf::NonCopyable
{
public:
	enum Action
	{
		Push,
		Pop,
		Clear
	};

public:
	StateStack() = default;
	explicit StateStack(Context context);

	template<typename T>
	void registerState(States::ID stateID);

	void update(sf::Time dt);
	void draw();
	void handleEvent(const sf::Event& event);

	void pushState(States::ID stateID);
	void popState();
	void clearStates();

	bool isEmpty() const;

private:
	State::Ptr createState(States::ID stateID);
	void applyPendingChange();

private:
	struct PendingChange
	{
		PendingChange(Action action, States::ID stateID = States::None);

		Action action;
		States::ID stateID;
	};

private:
	std::vector<State::Ptr> m_Stack{};
	std::vector<PendingChange> m_PendingList{};
	Context m_Context{};
	std::map<States::ID, std::function<State::Ptr()>> m_Factories{};
};

template<typename T>
void StateStack::registerState(States::ID stateID)
{
	m_Factories[stateID] = [this]()
	{ 
		return State::Ptr(new T(*this, m_Context));
	};
}
