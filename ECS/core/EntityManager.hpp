#ifndef ENTITY_MANAGER
#define ENTITY_MANAGER

#include <vector>
#include <memory>
#include <entt/entity/registry.hpp>
#include <SFML/System/Time.hpp>
#include "../Systems/BaseSystem.hpp"

class EntityManager
{
public:
	EntityManager() = default;
	EntityManager(entt::registry* reg);

	void update(sf::Time dt);
	void draw();

	void addSystem(std::unique_ptr<BaseSystem> sys);
	
private:
	entt::registry* m_registry;
	std::vector<std::unique_ptr<BaseSystem>> m_systems;
};

#endif