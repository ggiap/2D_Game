#include "World.h"

World::World(sf::RenderWindow& window) :
	m_Window(window),
	m_WorldView(window.getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_spawnPosition(m_WorldView.getSize().x / 2, m_WorldView.getSize().y / 2),
	m_Textures(),
	m_Fonts()
{
	loadTextures();
	buildScene();

	m_WorldView.setCenter(m_spawnPosition);
}

void World::update(sf::Time dt)
{
	m_SceneGraph.update(dt);

	sf::FloatRect viewBounds(m_WorldView.getCenter() - m_WorldView.getSize() / 2.f, m_WorldView.getSize());
	const float borderDistance = 40.f;
}

void World::draw()
{
	m_Window.setView(m_WorldView);
	m_Window.draw(m_SceneGraph);
}

void World::loadTextures()
{
	
}

void World::buildScene()
{
	for (size_t i = 0; i < LayerCount; ++i)
	{
		SceneNode::Ptr layer(new SceneNode());
		m_SceneLayers[i] = layer.get();

		m_SceneGraph.attachChild(std::move(layer));
	}
}
