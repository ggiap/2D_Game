#ifndef BASE_SYSTEM
#define BASE_SYSTEM

#include <entt/entity/registry.hpp>

namespace sf 
{ 
	class RenderWindow;
	class Time;
}

class BaseSystem
{
public:
	BaseSystem() = default;
	BaseSystem(entt::registry& reg, sf::RenderWindow& win);

	virtual void update(sf::Time dt) = 0;

protected:
	entt::registry* registry{};
	sf::RenderWindow* window{};
};

#endif