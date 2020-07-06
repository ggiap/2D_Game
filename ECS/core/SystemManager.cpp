#include "SystemManager.hpp"

void SystemManager::update(sf::Time dt)
{
	for (auto& system : m_Systems)
		system->update(dt);
}

void SystemManager::draw()
{
	for (auto& system : m_RenderSystems)
		system->update(sf::Time());
}

void SystemManager::addSystem(std::unique_ptr<BaseSystem> sys)
{
	m_Systems.push_back(std::move(sys));
}

void SystemManager::addRenderSystem(std::unique_ptr<BaseSystem> sys)
{
	m_RenderSystems.push_back(std::move(sys));
}