#pragma once

class Context;

namespace sf 
{
	class Time;
}

class BaseSystem
{
public:
	BaseSystem() = default;
	explicit BaseSystem(Context& context);

	virtual void update(sf::Time dt) = 0;

protected:
	Context* m_Context;
};