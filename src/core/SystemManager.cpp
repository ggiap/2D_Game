#include "SystemManager.hpp"

void SystemManager::update(sf::Time dt)
{
	for (auto& system : m_Systems)
		system->update(dt);
}

void SystemManager::handleEvents(const sf::Event &event)
{
    for (auto& system : m_Systems)
        system->handleEvents(event);
}

void SystemManager::draw()
{
	for (auto& system : m_Systems)
		system->draw();
}

void SystemManager::addSystem(std::unique_ptr<BaseSystem> sys)
{
	m_Systems.push_back(std::move(sys));
}