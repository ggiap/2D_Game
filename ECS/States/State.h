#pragma once
#include <memory>
#include <entt/entt.hpp>
#include <SFML/Graphics.hpp>

#include "StateIdentifiers.h"
#include "../Utils/Utility.hpp"

class StateStack;

class State
{
public:
	using Ptr = std::unique_ptr<State>;

	struct Context
	{
		Context(sf::RenderWindow &window, TextureHolder& textures, FontHolder& fonts, entt::registry& registry);

		sf::RenderWindow*	window;
		TextureHolder*		textures;
		FontHolder*			fonts;
		entt::registry*		registry;
	};

public:
	State(StateStack& stack, Context context);
	virtual ~State();

	virtual void draw() = 0;
	virtual bool update(sf::Time dt) = 0;
	virtual bool handleEvent(const sf::Event& event) = 0;

protected:
	void requestStackPush(States::ID stateID);
	void requestStackPop();
	void requestStackClear();

	Context getContext() const;

private:
	StateStack* m_Stack;
	Context m_Context;
};

