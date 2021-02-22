#pragma once

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include <SFML/Window/Event.hpp>
#include "../Utils/Utility.hpp"
#include "../core/SystemManager.hpp"
#include "../Utils/Timer.hpp"

struct Context;

class World
{
public:
	explicit World(Context& context);
	~World();

	void update(sf::Time dt);
	void handleEvents(const sf::Event& event);
	void draw();

	b2World* getB2World();
	entt::registry* getEntityRegistry();
	float getRemainingTime();

private:
	void buildScene();
	void createAnimations();
	void createPlayer();
	void createCamera();
	void createTilemap();
	void createEnemy();

	void unloadScene();
	void updateHUD(const sf::Time& dt);

private:
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	SystemManager m_SystemManager;
	b2World m_b2World;
	entt::registry m_WorldRegistry;

	Timer m_CountdownTimer;
	sf::Text m_TimerLabel;
};

