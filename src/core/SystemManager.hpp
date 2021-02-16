#pragma once

#include <vector>
#include <memory>
#include <entt/entity/registry.hpp>
#include <SFML/System/Time.hpp>
#include "../Systems/BaseSystem.hpp"

class SystemManager
{
public:
	SystemManager() = default;

	void update(sf::Time dt);
	void handleEvents(const sf::Event& event);
	void draw();

	void addSystem(std::unique_ptr<BaseSystem> sys);
	void deleteAllSystems();
	
private:
	std::vector<std::unique_ptr<BaseSystem>> m_Systems{};
};