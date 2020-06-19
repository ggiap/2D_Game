#include "World.h"

#include "../Components/C_Body.hpp"
#include "../Components/C_Position.hpp"
#include "../Components/C_Velocity.hpp"

World::World(Context context) :
	m_Window(context.window),
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
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
	em.draw();
}

void World::loadTextures()
{
	
}

void World::buildScene()
{
	entt::registry registry;

	std::srand(std::time(nullptr));
	for (auto i = 0; i < 6000; ++i)
	{
		auto entity = registry.create();
		registry.emplace<position>(entity, float(rand() % 550), float(rand() % 300));
		registry.emplace<velocity>(entity, float(rand() % 100 + 50), float(rand() % 100 + 50));
		registry.emplace<Body>(entity, sf::RectangleShape(sf::Vector2f(5.f, 5.f)));
	}
}
