#include "EntityManager.hpp"

EntityManager::EntityManager(entt::registry* reg) :
	m_registry(reg)
{

}

void EntityManager::update(sf::Time dt)
{
	for (auto& system : m_systems)
		system->update(dt);
}

void EntityManager::draw()
{
	
}

void EntityManager::addSystem(std::unique_ptr<BaseSystem> sys)
{
	m_systems.push_back(std::move(sys));
}