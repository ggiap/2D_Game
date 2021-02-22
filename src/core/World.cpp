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
#include "../Systems/AnimationSystem.hpp"
#include "../Systems/CameraSystem.hpp"
#include "../Systems/TilemapSystem.hpp"
#include "../Utils//Context.hpp"
#include "../Utils//Math.hpp"

#include <Box2D/Box2D.h>
#include <entt/entt.hpp>
#include "../Utils/SFMLDebugDraw.h"

World::World(Context& context) :
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	m_SystemManager(),
	m_b2World(b2Vec2(0, 9.81)),
	m_WorldRegistry(),
	m_CountdownTimer(sf::seconds(5))
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
	return &m_b2World;
}

entt::registry* World::getEntityRegistry()
{
	return &m_WorldRegistry;
}

float World::getRemainingTime()
{
	return m_CountdownTimer.getRemainingTime();
}

void World::buildScene()
{
	m_b2World.SetAllowSleeping(true);

	createTilemap();
	m_SystemManager.addSystem(std::make_unique<TilemapSystem>(*m_Context, this));

	createPlayer();
	m_SystemManager.addSystem(std::make_unique<PlayerControllerSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<MoveSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<CollisionSystem>(*m_Context, this));

	createAnimations();
	m_SystemManager.addSystem(std::make_unique<AnimationSystem>(*m_Context, this));

	createCamera();
	m_SystemManager.addSystem(std::make_unique<CameraSystem>(*m_Context, this));
	m_SystemManager.addSystem(std::make_unique<RenderSystem>(*m_Context, this));

	createEnemy();
}

void World::createAnimations()
{
	auto& texture = m_Context->textures->get(Textures::CharactersSpriteSheet);

	Animation standing;
	standing.setSpriteSheet(texture);
	standing.addFrame(sf::IntRect( 1, 22, 32, 32));

	Animation walking;
	walking.setSpriteSheet(texture);
	walking.addFrame(sf::IntRect( 145, 22, 32, 32));
	walking.addFrame(sf::IntRect( 178, 22, 32, 32));

	Animation jumping;
	jumping.setSpriteSheet(texture);
	jumping.addFrame(sf::IntRect( 322, 22, 32, 32));

	auto view = m_WorldRegistry.view<C_Animation>();

	for (auto &entity : view)
	{
		if(m_WorldRegistry.has<C_PlayerController>(entity))
		{
			auto &animComp = m_WorldRegistry.get<C_Animation>(entity);
			animComp.animatedSprite.addAnimation(Animations::Standing, standing);
			animComp.animatedSprite.addAnimation(Animations::Walking, walking);
			animComp.animatedSprite.addAnimation(Animations::Jumping, jumping);
			animComp.animatedSprite.play(Animations::Jumping);

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
	fixtureDef.friction = 1.f;
	fixtureDef.restitution = 0.f;

	// Create and register the body in the world
	m_Context->bodies[entity] = m_b2World.CreateBody(&bodyDef);
	auto fixture = m_Context->bodies[entity]->CreateFixture(&fixtureDef);
	fixture->SetUserData(shape);

	m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);
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

void World::createEnemy()
{
	const auto entity = m_WorldRegistry.create();
	auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 20.f));
	utils::centerOrigin(*shape);
	shape->setFillColor(sf::Color::Transparent);
	shape->setOutlineThickness(-1);
	shape->setOutlineColor(sf::Color::Green);

	sf::Vector2f position;
	auto obj = utils::getObjectByName(m_WorldRegistry, "Spawner Locations", "Enemy Spawn Location 1");
	position.x = obj.getPosition().x;
	position.y = obj.getPosition().y;

	// Create the body definition
	b2BodyDef bodyDef;
	bodyDef.type = b2_kinematicBody;
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
	fixtureDef.friction = 1.f;
	fixtureDef.restitution = 0.f;

	// Create and register the body in the world
	m_Context->bodies[entity] = m_b2World.CreateBody(&bodyDef);
	auto fixture = m_Context->bodies[entity]->CreateFixture(&fixtureDef);
	fixture->SetUserData(shape);

	m_WorldRegistry.emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);
	m_WorldRegistry.emplace<C_Raycast>(entity);
	m_WorldRegistry.emplace<C_EnemyTag>(entity);
}

void World::unloadScene()
{
	for (auto& pair : m_Context->bodies)
		m_b2World.DestroyBody(pair.second);
	m_Context->bodies.clear();

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
