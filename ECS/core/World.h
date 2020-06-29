#pragma once

#include <unordered_map>
#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include "../Utils/Utility.hpp"
#include "../core/EntityManager.hpp"

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

private:
	sf::RenderWindow* m_Window;
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	EntityManager em;
	std::unordered_map<entt::entity, b2Body*> bodies;
};

