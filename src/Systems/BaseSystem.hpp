#pragma once

struct Context;

namespace sf 
{
	class Time;
	class Event;
}

class BaseSystem
{
public:
	BaseSystem() = default;
	explicit BaseSystem(Context& context);

	virtual void update(sf::Time& dt) { }
	virtual void handleEvents(const sf::Event& event) { }
	virtual void draw() { }

protected:
	Context* m_Context{};
};