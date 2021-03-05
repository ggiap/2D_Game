#pragma once

struct Context;
class World;

namespace sf 
{
	class Time;
	class Event;
}

class BaseSystem
{
public:
	BaseSystem() = default;
	explicit BaseSystem(Context& context, World *world);

	virtual void update(sf::Time& dt) { }
	virtual void handleEvents(const sf::Event& event) { }
	virtual void draw() { }

	virtual void init() { }

protected:
	Context* m_Context{};
	World* m_World;
};