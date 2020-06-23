#include "World.h"

#include "../Components/C_Body.hpp"
#include "../Systems/CollisionSystem.hpp"
#include "../Systems/MoveSystem.hpp"
#include "../Systems/RenderSystem.hpp"

World::World(Context& context) :
	m_Window(context.window),
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	em(context.registry)
{
	loadTextures();
	buildScene();
}

void World::update(const sf::Time dt)
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
	std::srand(std::time(nullptr));
	for (auto i = 0; i < 6000; ++i)
	{
		const auto entity = m_Context->registry->create();
		sf::Vector2f position(static_cast<float>(rand() % 1150), static_cast<float>(rand() % 750));
		sf::Vector2f velocity(static_cast<float>(rand() % 200 - 50), static_cast<float>(rand() % 200 - 50));
		m_Context->registry->emplace<Body>(entity, sf::RectangleShape(sf::Vector2f(10.f, 10.f)), position, velocity);
	}

	em.addSystem(std::make_unique<MoveSystem>(*m_Context->registry, *m_Window));
	em.addSystem(std::make_unique<CollisionSystem>(*m_Context->registry, *m_Window));
	em.addRenderSystem(std::make_unique<RenderSystem>(*m_Context->registry, *m_Window));
}
