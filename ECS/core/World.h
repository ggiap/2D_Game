#pragma once

#include <algorithm>
#include <memory>
#include <array>
#include <SFML/Graphics/RenderWindow.hpp>
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"
#include "../Utils/Context.hpp"
#include "../core/EntityManager.hpp"

class World
{
public:
	explicit World(Context context);

	void update(sf::Time dt);
	void draw();

private:
	void loadTextures();
	void buildScene();

private:
	sf::RenderWindow* m_Window;
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	EntityManager em;
};

