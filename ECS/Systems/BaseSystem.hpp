#pragma once

#include "../Utils/Context.hpp"

namespace sf 
{
	class Time;
}

class BaseSystem
{
public:
	BaseSystem() = default;
	BaseSystem(Context& context);

	virtual void update(sf::Time dt) = 0;

protected:
	Context* m_Context;
};