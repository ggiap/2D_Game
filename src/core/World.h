#pragma once

#include <map>

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/View.hpp>
#include <SFML/Window/Event.hpp>

#include "../core/SystemManager.hpp"
#include "../Utils/Utility.hpp"
#include "../Utils/Timer.hpp"
#include "../Utils/Animation.h"
#include "../Utils/ContactListener.hpp"

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
	std::vector<entt::entity>& getMarkedEntities();
	unsigned& getNumberOfEnemies();
	bool& GameOver();

private:
	void buildScene();
	void createAnimations();
	void createPlayer();
	void createCamera();
	void createTilemap();
	void createEnemies();
	void createCoins();
	void destroyMarkedEntities();

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

	std::vector<entt::entity> markedForDestruction;

	ContactListener m_ContactListener;

	Timer m_CountdownTimer;
	sf::Text m_TimerLabel;

	bool sfmlDebug;
	bool b2dDebug;
	bool gameOver;

	unsigned m_numberOfEnemies;

	sf::Sprite m_coinHudSprite;
	sf::Text m_coinCounLabel;
	unsigned m_coinCount;
};

