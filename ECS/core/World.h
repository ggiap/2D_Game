#pragma once

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include "../Utils/Utility.hpp"
#include "../core/SystemManager.hpp"

class Context;

class World
{
public:
	explicit World(Context& context);

	void update(sf::Time dt);
	void draw();

private:
	void loadTextures();
	void buildScene();
	void createWalls();
	void createAnimations();

private:
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	SystemManager m_SystemManager;
};

