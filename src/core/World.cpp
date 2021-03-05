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

World::World(Context& context) :
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	m_SystemManager(),
	m_b2World(new b2World(b2Vec2(0, 9.81))),
	m_WorldRegistry(),
	m_CountdownTimer(sf::seconds(50)),
	sfmlDebug(false),
	b2dDebug(false)
{
	buildScene();

	m_CountdownTimer.start();
	m_TimerLabel.setFont(m_Context->fonts->get(Fonts::ARJULIAN));
	m_TimerLabel.setOutlineThickness(3.f);
	m_TimerLabel.setCharacterSize(20u);
	m_TimerLabel.setOutlineColor(sf::Color::Black);
	utils::centerOrigin(m_TimerLabel);
}

World::~World()
{
	unloadScene();
}

void World::update(const sf::Time dt)
{
	m_SystemManager.update(dt);

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

	const auto entity = m_WorldRegistry.create();
	auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 11.f));
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

	// Fixture shape
	b2PolygonShape bShape;
	b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
	bShape.SetAsBox(size.x, size.y);

	// Fixture definition
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &bShape;
	fixtureDef.density = 0.5f;
	fixtureDef.friction = 1.f;
	fixtureDef.restitution = 0.f;
	fixtureDef.filter.categoryBits = BodyCategory::Enemy;

	// Create and register the body in the world
	m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
	m_Context->bodyToEntt[m_Context->enttToBody[entity]] = entity;
	auto fixture = m_Context->enttToBody[entity]->CreateFixture(&fixtureDef);
	fixture->SetUserData(shape);

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
				animComp.animatedSprite.addAnimation(Animations::EnemyMoving, anims[Animations::EnemyMoving]);
				animComp.animatedSprite.play(Animations::EnemyMoving);

				utils::centerOrigin(animComp.animatedSprite);
			}
		}
	}
}

void World::buildScene()
{
	m_b2World->SetAllowSleeping(true);

	createTilemap();
	m_SystemManager.addSystem(std::make_unique<TilemapSystem>(*m_Context, this));

	createPlayer();
	createEnemies();
	createAnimations();
	createCamera();
	
	m_SystemManager.addSystem(std::make_unique<MoveSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<CollisionSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<AnimationSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<CameraSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<PlayerControllerSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<EnemyControllerSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<RenderSystem>(*m_Context, this));
}

void World::createAnimations()
{
	auto& texture = m_Context->textures->get(Textures::CharactersSpriteSheet);
	auto& monochrome_texture = m_Context->textures->get(Textures::MonochromeSpriteSheet);

	Animation standing;
	standing.setSpriteSheet(texture);
	standing.addFrame(sf::IntRect( 9, 32, 16, 22));
	anims[Animations::Standing] = standing;

	Animation walking;
	walking.setSpriteSheet(texture);
	walking.addFrame(sf::IntRect( 153, 32, 16, 22));
	walking.addFrame(sf::IntRect( 186, 32, 16, 22));
	anims[Animations::Walking] = walking;

	Animation jumping;
	jumping.setSpriteSheet(texture);
	jumping.addFrame(sf::IntRect( 330, 31, 16, 22));
	anims[Animations::Jumping] = jumping;

	Animation enemyMoving;
	enemyMoving.setSpriteSheet(monochrome_texture);
	enemyMoving.addFrame(sf::IntRect(16, 261, 16, 12));
	enemyMoving.addFrame(sf::IntRect(32, 261, 16, 12));
	anims[Animations::EnemyMoving] = enemyMoving;

	auto view = m_WorldRegistry.view<C_Animation>();

	for (auto &entity : view)
	{
		if(m_WorldRegistry.has<C_PlayerTag>(entity))
		{
			auto &animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::Standing, standing);
			animComp.animatedSprite.addAnimation(Animations::Walking, walking);
			animComp.animatedSprite.addAnimation(Animations::Jumping, jumping);
			animComp.animatedSprite.play(Animations::Standing);

			utils::centerOrigin(animComp.animatedSprite);
		}

		if (m_WorldRegistry.has<C_EnemyTag>(entity))
		{
			auto& animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::Walking, enemyMoving);
			animComp.animatedSprite.play(Animations::Walking);

			utils::centerOrigin(animComp.animatedSprite);
		}
	}
}

void World::createPlayer()
{
	const auto entity = m_WorldRegistry.create();
	auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 20.f));
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

	// Fixture shape
	b2PolygonShape bShape;
	b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
	bShape.SetAsBox(size.x, size.y);

	// Fixture definition
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &bShape;
	fixtureDef.density = 1.f;
	fixtureDef.friction = 0.8f;
	fixtureDef.restitution = 0.f;
	fixtureDef.filter.categoryBits = BodyCategory::Player;

	// Create and register the body in the world
	m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
	m_Context->bodyToEntt[m_Context->enttToBody[entity]] = entity;
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
	// m_Context->registry->emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/big_map.tmx");
}

void World::createEnemies()
{
	auto objects = utils::getObjectsByName(m_WorldRegistry, "Spawner Locations", "Enemy");

	for (const auto& obj : objects)
	{
		const auto entity = m_WorldRegistry.create();
		auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 11.f));
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

		// Fixture shape
		b2PolygonShape bShape;
		b2Vec2 size = utils::sfVecToB2Vec(shape->getSize() / 2.f);
		bShape.SetAsBox(size.x, size.y);

		// Fixture definition
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &bShape;
		fixtureDef.density = 0.5f;
		fixtureDef.friction = 1.f;
		fixtureDef.restitution = 0.f;
		fixtureDef.filter.categoryBits = BodyCategory::Enemy;

		// Create and register the body in the world
		m_Context->enttToBody[entity] = m_b2World->CreateBody(&bodyDef);
		m_Context->bodyToEntt[m_Context->enttToBody[entity]] = entity;
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

void World::unloadScene()
{
	for (auto& pair : m_Context->enttToBody)
	{
		for (auto fixture = pair.second->GetFixtureList(); fixture; fixture = fixture->GetNext())
			delete fixture->GetUserData();

		m_b2World->DestroyBody(pair.second);
	}
	m_Context->enttToBody.clear();
	m_Context->bodyToEntt.clear();

	m_WorldRegistry.each([&](auto entity) 
		{
			m_WorldRegistry.destroy(entity);
		});
	
	m_SystemManager.deleteAllSystems();
}

void World::updateHUD(const sf::Time& dt)
{
	if (!m_Context->isPaused)
		m_CountdownTimer.update(dt);

	m_TimerLabel.setString("Time: " + std::to_string(static_cast<int>(m_CountdownTimer.getRemainingTime())));

	m_TimerLabel.setPosition(m_Context->window->getView().getCenter().x + (m_Context->window->getView().getSize().x / 2.4f),
		m_Context->window->getView().getCenter().y - (m_Context->window->getView().getSize().y / 2.f));
	m_TimerLabel.setScale(m_Context->window->getView().getSize().x / m_Context->window->getDefaultView().getSize().x,
		m_Context->window->getView().getSize().y / m_Context->window->getDefaultView().getSize().y);
}
