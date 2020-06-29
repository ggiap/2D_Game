#pragma once
#include <memory>

#include "StateIdentifiers.h"
#include "../Utils/Context.hpp"

class StateStack;

class State
{
public:
	using Ptr = std::unique_ptr<State>;

public:
	State(StateStack& stack, Context context);
	virtual ~State() {}

	virtual void draw() = 0;
	virtual bool update(sf::Time dt) = 0;
	virtual bool handleEvent(const sf::Event& event) = 0;

protected:
	void requestStackPush(States::ID stateID) const;
	void requestStackPop() const;
	void requestStackClear() const;

	//[[nodiscard]] Context getContext() const;

private:
	StateStack* m_Stack;

protected:
	Context m_Context;
};

