#pragma once

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include "../Utils/Utility.hpp"
#include "../Utils/Context.hpp"
#include "../core/EntityManager.hpp"

class World
{
public:
	explicit World(Context& context);

	void update(sf::Time dt);
	void draw();

private:
	void loadTextures();
	void buildScene();

private:
	sf::RenderWindow* m_Window;
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	EntityManager em;	
};

