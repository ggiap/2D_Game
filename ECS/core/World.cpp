#include "World.h"

#include "../Components/C_Body.hpp"
#include "../Systems/CollisionSystem.hpp"
#include "../Systems/MoveSystem.hpp"

World::World(Context context) :
	m_Window(context.window),
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	em(context.registry)
{
	loadTextures();
	buildScene();
}

void World::update(sf::Time dt)
{
	em.update(dt);
}

void World::draw()
{
	
}

void World::loadTextures()
{
	
}

void World::buildScene()
{
	std::srand(std::time(nullptr));
	for (auto i = 0; i < 6000; ++i)
	{
		auto entity = m_Context->registry->create();
		sf::Vector2f position(float(rand() % 550), float(rand() % 300));
		sf::Vector2f velocity(float(rand() % 100 + 50), float(rand() % 100 + 50));
		m_Context->registry->emplace<Body>(entity, sf::RectangleShape(), position, velocity);
	}

	//std::unique_ptr<MoveSystem> mv(new MoveSystem(*m_Context->registry, *m_Window));
	em.addSystem(std::make_unique<MoveSystem>(*m_Context->registry, *m_Window));
	em.addSystem(std::make_unique<CollisionSystem>(*m_Context->registry, *m_Window));
}
