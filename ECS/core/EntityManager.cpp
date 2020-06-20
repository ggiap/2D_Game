#include "EntityManager.hpp"

EntityManager::EntityManager(entt::registry* reg) :
	m_Registry(reg)
{

}

void EntityManager::update(sf::Time dt)
{
	for (auto& system : m_Systems)
		system->update(dt);
}

void EntityManager::draw()
{
	for (auto& system : m_RenderSystems)
		system->update(sf::Time());
}

void EntityManager::addSystem(std::unique_ptr<BaseSystem> sys)
{
	m_Systems.push_back(std::move(sys));
}

void EntityManager::addRenderSystem(std::unique_ptr<BaseSystem> sys)
{
	m_RenderSystems.push_back(std::move(sys));
}