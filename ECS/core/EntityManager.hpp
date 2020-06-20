#pragma once

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
	void addRenderSystem(std::unique_ptr<BaseSystem> sys);
	
private:
	entt::registry* m_Registry{};
	std::vector<std::unique_ptr<BaseSystem>> m_Systems{};
	std::vector<std::unique_ptr<BaseSystem>> m_RenderSystems{};
};