#include "World.h"

#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_PlayerController.hpp"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Raycast.hpp"
#include "../Components/C_Camera.hpp"
#include "../Components/C_Tilemap.hpp"
#include "../Systems/CollisionSystem.hpp"
#include "../Systems/MoveSystem.hpp"
#include "../Systems/RenderSystem.hpp"
#include "../Systems/PlayerControllerSystem.hpp"
#include "../Systems/EnemyControllerSystem.hpp"
#include "../Systems/AnimationSystem.hpp"
#include "../Systems/CameraSystem.hpp"
#include "../Systems/TilemapSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Utils/Math.hpp"
#include "../Utils/FixtureUserData.hpp"
#include <Box2D/Box2D.h>
#include <entt/entt.hpp>
#include "../Utils/SFMLDebugDraw.h"
#include <spdlog/spdlog.h>

World::World(Context& context) :
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	m_SystemManager(),
	m_b2World(new b2World(b2Vec2(0, 9.81))),
	m_WorldRegistry(),
	anims(),
	markedForDestruction(),
	m_ContactListener(m_Context, this),
	m_CountdownTimer(sf::seconds(101)),
	sfmlDebug(false),
	b2dDebug(false),
	gameOver(false),
	m_numberOfEnemies(0),
	m_coinHudSprite(),
	m_coinCounLabel(),
	m_coinCount(0)
{
	buildScene();

	m_CountdownTimer.start();
	m_TimerLabel.setFont(m_Context->fonts->get(Fonts::ID::ARJULIAN));
	m_TimerLabel.setOutlineThickness(3.f);
	m_TimerLabel.setCharacterSize(20u);
	m_TimerLabel.setOutlineColor(sf::Color::Black);
	utils::centerOrigin(m_TimerLabel);

	m_coinCounLabel.setFont(m_Context->fonts->get(Fonts::ID::ARJULIAN));
	m_coinCounLabel.setOutlineThickness(3.f);
	m_coinCounLabel.setCharacterSize(20u);
	m_coinCounLabel.setOutlineColor(sf::Color::Black);
	utils::centerOrigin(m_TimerLabel);

	m_coinHudSprite.setTexture(m_Context->textures->get(Textures::ID::CoinAnimation));
	m_coinHudSprite.setTextureRect(sf::IntRect(0, 0, 16, 16));
	utils::centerOrigin(m_coinHudSprite);

	m_b2World->SetContactListener(&m_ContactListener);
}

World::~World()
{
	unloadScene();
}

void World::update(const sf::Time dt)
{
	m_SystemManager.update(dt);
	destroyMarkedEntities();

	updateHUD(dt);
}

void World::handleEvents(const sf::Event &event)
{
	m_SystemManager.handleEvents(event);
}

void World::draw()
{
	m_SystemManager.draw();
	m_Context->window->draw(m_TimerLabel);
	m_Context->window->draw(m_coinCounLabel);
	m_Context->window->draw(m_coinHudSprite);
}

b2World* World::getB2World()
{
	return m_b2World.get();
}

entt::registry* World::getEntityRegistry()
{
	return &m_WorldRegistry;
}

float World::getRemainingTime()
{
	return m_CountdownTimer.getRemainingTime();
}

bool& World::sfmlDebugging()
{
	return sfmlDebug;
}

bool& World::b2dDebugging()
{
	return b2dDebug;
}

void World::spawnEnemy()
{
	auto spawnLocation = utils::getObjectByName(m_WorldRegistry, "Spawner Locations", "Enemy Spawn Location 1");

	//++numberOfEnemies;
	spdlog::info("Spawned enemy, numOfEnemies: {}", ++m_numberOfEnemies);
	const auto entity = m_WorldRegistry.create();
	auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 10.f));
	utils::centerOrigin(*shape);
	shape->setFillColor(sf::Color::Transparent);
	shape->setOutlineThickness(-1);
	shape->setOutlineColor(sf::Color::Green);

	sf::Vector2f position;
	position.x = spawnLocation.getPosition().x;
	position.y = spawnLocation.getPosition().y;

	// Create the body definition
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position = utils::sfVecToB2Vec(position);
	bodyDef.fixedRotation = true;
	bodyDef.gravityScale = 1.5f;
	bodyDef.bullet = true;

	// Fixture shape
	b2PolygonShape bShape;
	b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
	bShape.SetAsBox(size.x, size.y);

	// Fixture definition
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &bShape;
	fixtureDef.density = 0.1f;
	fixtureDef.friction = 1.f;
	fixtureDef.restitution = 0.f;
	fixtureDef.filter.categoryBits = BodyCategory::ID::Enemy;
	fixtureDef.filter.maskBits = BodyCategory::ID::Player | BodyCategory::ID::Enemy | BodyCategory::ID::Other | BodyCategory::OneWayPlatform;

	// Create and register the body in the world
	m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
	auto fixture = m_Context->enttToBody[entity]->CreateFixture(&fixtureDef);
	FixtureUserData* fud = new FixtureUserData();
	fud->entity = entity;
	fud->shape = shape;
	fixture->SetUserData(fud);

	m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);
	m_WorldRegistry.emplace<C_Animation>(entity);
	m_WorldRegistry.emplace<C_EnemyTag>(entity);
	m_WorldRegistry.emplace<C_Raycast>(entity);

	auto view = m_WorldRegistry.view<C_Animation>();

	for (auto& e : view)
	{
		if (entity == e)
		{
			if (m_WorldRegistry.has<C_EnemyTag>(entity))
			{
				auto& animComp = m_WorldRegistry.get<C_Animation>(entity);
				animComp.animatedSprite.addAnimation(Animations::ID::EnemyMoving, anims[Animations::ID::EnemyMoving]);
				animComp.animatedSprite.play(Animations::ID::EnemyMoving);

				utils::centerOrigin(animComp.animatedSprite);
			}
		}
	}

	m_SystemManager.initSystems();
}

std::vector<entt::entity>& World::getMarkedEntities()
{
	return markedForDestruction;
}

unsigned& World::getNumberOfEnemies()
{
	return m_numberOfEnemies;
}

bool& World::GameOver()
{
	return gameOver;
}

void World::buildScene()
{
	m_b2World->SetAllowSleeping(true);

	createTilemap();
	m_SystemManager.addSystem(std::make_unique<TilemapSystem>(*m_Context, this));

	createPlayer();
	createEnemies();
	createCoins();
	createAnimations();
	createCamera();
	
	m_SystemManager.addSystem(std::make_unique<MoveSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<AnimationSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<CameraSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<PlayerControllerSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<EnemyControllerSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<CollisionSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<RenderSystem>(*m_Context, this));
}

void World::createAnimations()
{
	auto& texture = m_Context->textures->get(Textures::ID::CharactersSpriteSheet);
	auto& monochrome_texture = m_Context->textures->get(Textures::ID::MonochromeSpriteSheet);
	auto& coin_animation = m_Context->textures->get(Textures::ID::CoinAnimation);

	Animation* standing = new Animation();
	standing->setSpriteSheet(texture);
	standing->addFrame(sf::IntRect(320, 0, 16, 16));
	anims[Animations::ID::Standing] = standing;

	Animation* walking = new Animation();
	walking->setSpriteSheet(texture);
	walking->addFrame(sf::IntRect(464, 0, 16, 16));
	walking->addFrame(sf::IntRect(416, 0, 16, 16));
	anims[Animations::ID::Walking] = walking;

	Animation* jumping = new Animation();
	jumping->setSpriteSheet(texture);
	jumping->addFrame(sf::IntRect(432, 0, 16, 16));
	anims[Animations::ID::Jumping] = jumping;

	Animation* climbingLadder = new Animation();
	climbingLadder->setSpriteSheet(texture);
	climbingLadder->addFrame(sf::IntRect(384, 0, 16, 16));
	climbingLadder->addFrame(sf::IntRect(400, 0, 16, 16));
	anims[Animations::ID::ClimbingLadder] = climbingLadder;

	Animation* enemyMoving = new Animation();
	enemyMoving->setSpriteSheet(texture);
	enemyMoving->addFrame(sf::IntRect(400, 224, 16, 16));
	enemyMoving->addFrame(sf::IntRect(416, 224, 16, 16));
	enemyMoving->addFrame(sf::IntRect(432, 224, 16, 16));
	anims[Animations::ID::EnemyMoving] = enemyMoving;

	Animation* coin = new Animation();
	coin->setSpriteSheet(coin_animation);
	coin->addFrame(sf::IntRect(0, 0, 16, 16));
	coin->addFrame(sf::IntRect(0, 16, 16, 16));
	coin->addFrame(sf::IntRect(0, 32, 16, 16));
	coin->addFrame(sf::IntRect(0, 48, 16, 16));
	anims[Animations::ID::Coin] = coin;

	auto view = m_WorldRegistry.view<C_Animation>();

	for (auto &entity : view)
	{
		if(m_WorldRegistry.has<C_PlayerTag>(entity))
		{
			auto &animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::ID::Standing, standing);
			animComp.animatedSprite.addAnimation(Animations::ID::Walking, walking);
			animComp.animatedSprite.addAnimation(Animations::ID::Jumping, jumping);
			animComp.animatedSprite.addAnimation(Animations::ID::ClimbingLadder, climbingLadder);
			animComp.animatedSprite.play(Animations::ID::Standing);

			utils::centerOrigin(animComp.animatedSprite);
		}

		if (m_WorldRegistry.has<C_EnemyTag>(entity))
		{
			auto& animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::ID::Walking, enemyMoving);
			animComp.animatedSprite.play(Animations::ID::Walking);

			utils::centerOrigin(animComp.animatedSprite);
		}

		if (m_WorldRegistry.has<C_Coin>(entity))
		{
			auto& animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::ID::Coin, coin);
			animComp.animatedSprite.play(Animations::ID::Coin);

			utils::centerOrigin(animComp.animatedSprite);
		}
	}
}

void World::createPlayer()
{
	const auto entity = m_WorldRegistry.create();
	auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 15.f));
	utils::centerOrigin(*shape);
	shape->setFillColor(sf::Color::Transparent);
	shape->setOutlineThickness(-1);
	shape->setOutlineColor(sf::Color::Green);

	sf::Vector2f position;
	auto obj = utils::getObjectByName(m_WorldRegistry, "Spawner Locations", "Player Spawn Location");
	position.x = obj.getPosition().x;
	position.y = obj.getPosition().y;

	// Create the body definition
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position = utils::sfVecToB2Vec(position);
	bodyDef.fixedRotation = true;
	bodyDef.gravityScale = 1.5f;
	bodyDef.bullet = true;

	// Fixture shape
	b2PolygonShape bShape;
	b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
	bShape.SetAsBox(size.x, size.y);

	// Fixture definition
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &bShape;
	fixtureDef.density = 1.f;
	fixtureDef.friction = 0.f;
	fixtureDef.restitution = 0.f;
	fixtureDef.filter.categoryBits = BodyCategory::ID::Player;
	fixtureDef.filter.maskBits = BodyCategory::ID::Enemy | BodyCategory::ID::Other | BodyCategory::OneWayPlatform | BodyCategory::Coin | BodyCategory::Ladder;

	// Create and register the body in the world
	m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
	auto fixture = m_Context->enttToBody[entity]->CreateFixture(&fixtureDef);
	FixtureUserData* fud = new FixtureUserData();
	fud->entity = entity;
	fud->shape = shape;
	fixture->SetUserData(fud);

	m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);
	m_WorldRegistry.emplace<C_PlayerController>(entity);
	m_WorldRegistry.emplace<C_Animation>(entity);
	m_WorldRegistry.emplace<C_PlayerTag>(entity);
	m_WorldRegistry.emplace<C_Raycast>(entity);
}

void World::createCamera()
{
	const auto cameraEntity = m_WorldRegistry.create();
	entt::entity playerEntity = entt::null;

	sf::View view;
	view.setSize(500,400);

	m_WorldRegistry.view<C_PlayerTag>().each([&](auto &entity)
	{
		playerEntity = entity;
	});

	m_WorldRegistry.emplace<C_Camera>(cameraEntity, view, playerEntity);
}

void World::createTilemap()
{
	const auto tilemapEntity = m_WorldRegistry.create();
	
	m_WorldRegistry.emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/Tilemap_Test.tmx");
	//m_WorldRegistry.emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/Demo_Level.tmx");
	//m_Context->registry->emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/big_map.tmx");
}

void World::createEnemies()
{
	auto objects = utils::getObjectsByName(m_WorldRegistry, "Spawner Locations", "Enemy");

	for (const auto& obj : objects)
	{
		//++numberOfEnemies;
		spdlog::info("Spawned enemy, numOfEnemies: {}", ++m_numberOfEnemies);
		const auto entity = m_WorldRegistry.create();
		auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 10.f));
		utils::centerOrigin(*shape);
		shape->setFillColor(sf::Color::Transparent);
		shape->setOutlineThickness(-1);
		shape->setOutlineColor(sf::Color::Green);

		sf::Vector2f position;
		position.x = obj.getPosition().x;
		position.y = obj.getPosition().y;

		// Create the body definition
		b2BodyDef bodyDef;
		bodyDef.type = b2_dynamicBody;
		bodyDef.position = utils::sfVecToB2Vec(position);
		bodyDef.fixedRotation = true;
		bodyDef.gravityScale = 1.5f;
		bodyDef.bullet = true;

		// Fixture shape
		b2PolygonShape bShape;
		b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
		bShape.SetAsBox(size.x, size.y);

		// Fixture definition
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &bShape;
		fixtureDef.density = 0.1f;
		fixtureDef.friction = 1.f;
		fixtureDef.restitution = 0.f;
		fixtureDef.filter.categoryBits = BodyCategory::ID::Enemy;
		fixtureDef.filter.maskBits = BodyCategory::ID::Player | BodyCategory::ID::Enemy | BodyCategory::ID::Other | BodyCategory::OneWayPlatform;

		// Create and register the body in the world
		m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
		auto fixture = m_Context->enttToBody[entity]->CreateFixture(&fixtureDef);
		FixtureUserData* fud = new FixtureUserData();
		fud->entity = entity;
		fud->shape = shape;
		fixture->SetUserData(fud);
		
		m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);
		m_WorldRegistry.emplace<C_Animation>(entity);
		m_WorldRegistry.emplace<C_EnemyTag>(entity);
		m_WorldRegistry.emplace<C_Raycast>(entity);
	}
}

void World::createCoins()
{
	auto coins = utils::getObjectsByName(m_WorldRegistry, "Spawner Locations", "Coin");

	for (const auto& obj : coins)
	{
		const auto entity = m_WorldRegistry.create();
		auto shape = new sf::RectangleShape(sf::Vector2f(12.f, 12.f));
		utils::centerOrigin(*shape);
		shape->setFillColor(sf::Color::Transparent);
		shape->setOutlineThickness(-1);
		shape->setOutlineColor(sf::Color::Green);

		sf::Vector2f position;
		position.x = obj.getPosition().x;
		position.y = obj.getPosition().y;

		// Create the body definition
		b2BodyDef bodyDef;
		bodyDef.type = b2_dynamicBody;
		bodyDef.position = utils::sfVecToB2Vec(position);
		bodyDef.fixedRotation = true;
		bodyDef.gravityScale = 1.5f;
		bodyDef.bullet = true;

		// Fixture shape
		b2PolygonShape bShape;
		b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
		bShape.SetAsBox(size.x, size.y);

		// Fixture definition
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &bShape;
		fixtureDef.density = 0.1f;
		fixtureDef.friction = 0.1f;
		fixtureDef.restitution = 0.1f;
		fixtureDef.filter.categoryBits = BodyCategory::ID::Coin;
		fixtureDef.filter.maskBits = BodyCategory::ID::Player;

		// Create and register the body in the world
		m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
		m_Context->enttToBody[entity]->SetGravityScale(0);
		auto fixture = m_Context->enttToBody[entity]->CreateFixture(&fixtureDef);
		FixtureUserData* fud = new FixtureUserData();
		fud->entity = entity;
		fud->shape = shape;
		fixture->SetUserData(fud);

		m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);
		m_WorldRegistry.emplace<C_Animation>(entity);
		m_WorldRegistry.emplace<C_Coin>(entity);
	}
}

void World::destroyMarkedEntities()
{
	for (auto entity : markedForDestruction)
	{
		++m_coinCount;
		auto* body = m_Context->enttToBody[entity];
 		if (body == nullptr)
		{
			auto found = std::find(markedForDestruction.begin(), markedForDestruction.end(), entity);
			if (found != markedForDestruction.end())
				markedForDestruction.erase(found);
			m_Context->enttToBody.erase(entity);
			continue;
		}
		for (auto* fixture = body->GetFixtureList(); fixture; fixture = fixture->GetNext())
			delete fixture->GetUserData();

		m_b2World->DestroyBody(body);
		m_WorldRegistry.destroy(entity);
		m_Context->enttToBody.erase(entity);
		auto found = std::find(markedForDestruction.begin(), markedForDestruction.end(), entity);
		if(found != markedForDestruction.end())
			markedForDestruction.erase(found);
	}
}

void World::unloadScene()
{
	for (auto& pair : m_Context->enttToBody)
	{
		if (pair.second == nullptr) continue;
		for (auto fixture = pair.second->GetFixtureList(); fixture; fixture = fixture->GetNext())
			delete fixture->GetUserData();

		m_b2World->DestroyBody(pair.second);
	}
	m_Context->enttToBody.clear();

	m_WorldRegistry.each([&](auto entity) 
		{
			m_WorldRegistry.destroy(entity);
		});
	
	m_SystemManager.deleteAllSystems();
	for (auto& pair : anims)
		delete pair.second;
	anims.clear();
}

void World::updateHUD(const sf::Time& dt)
{
	if (!m_Context->isPaused)
		m_CountdownTimer.update(dt);

	m_TimerLabel.setString("Time: " + std::to_string(static_cast<int>(m_CountdownTimer.getRemainingTime())));
	m_coinCounLabel.setString("x" + std::to_string(static_cast<unsigned>(m_coinCount)));

	m_TimerLabel.setPosition(m_Context->window->getView().getCenter().x + (m_Context->window->getView().getSize().x / 2.4f),
		m_Context->window->getView().getCenter().y - (m_Context->window->getView().getSize().y / 2.f));
	m_TimerLabel.setScale(m_Context->window->getView().getSize().x / m_Context->window->getDefaultView().getSize().x,
		m_Context->window->getView().getSize().y / m_Context->window->getDefaultView().getSize().y);

	m_coinCounLabel.setPosition(m_Context->window->getView().getCenter().x + (m_Context->window->getView().getSize().x / 3.4f),
		m_TimerLabel.getPosition().y);
	m_coinCounLabel.setScale(m_TimerLabel.getScale());

	m_coinHudSprite.setPosition(m_Context->window->getView().getCenter().x + (m_Context->window->getView().getSize().x / 3.52f),
		m_Context->window->getView().getCenter().y - (m_Context->window->getView().getSize().y / 2.065f));
	m_coinHudSprite.setScale(m_TimerLabel.getScale() * 1.5f);
}
