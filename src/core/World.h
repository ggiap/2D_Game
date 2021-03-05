#pragma once

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include <SFML/Window/Event.hpp>
#include "../Utils/Utility.hpp"
#include "../core/SystemManager.hpp"
#include "../Utils/Timer.hpp"
#include "../Utils/Animation.h"
#include <map>

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
	bool& sfmlDebugging();
	bool& b2dDebugging();
	void spawnEnemy();

private:
	void buildScene();
	void createAnimations();
	void createPlayer();
	void createCamera();
	void createTilemap();
	void createEnemies();

	void unloadScene();
	void updateHUD(const sf::Time& dt);

private:
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;

	Context* m_Context;
	SystemManager m_SystemManager;
	std::unique_ptr<b2World> m_b2World;
	entt::registry m_WorldRegistry;

	std::unordered_map<Animations::ID, Animation*> anims;

	Timer m_CountdownTimer;
	sf::Text m_TimerLabel;

	bool sfmlDebug;
	bool b2dDebug;
};

