#pragma once

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include <SFML/Window/Event.hpp>
#include "../Utils/Utility.hpp"
#include "../core/SystemManager.hpp"

struct Context;

class World
{
public:
	explicit World(Context& context);

	void update(sf::Time dt);
	void handleEvents(const sf::Event& event);
	void draw();

private:
	void loadTextures();
	void buildScene();
	void createWalls();
	void createAnimations();
	void createPlayer();
	void createCamera();
	void createTilemap();

private:
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	SystemManager m_SystemManager;
};

