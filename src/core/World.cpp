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

World::World(Context& context) :
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
    m_SystemManager()
{
	loadTextures();
	buildScene();
}

void World::update(const sf::Time dt)
{
    m_SystemManager.update(dt);
}

void World::handleEvents(const sf::Event &event)
{
    m_SystemManager.handleEvents(event);
}

void World::draw()
{
    m_SystemManager.draw();
}

void World::loadTextures()
{
    m_Context->textures->load(Textures::CharactersSpriteSheet, "../res/Sprites/SMB_Characters2.png");
}

void World::buildScene()
{
	createTilemap();
	m_SystemManager.addSystem(std::make_unique<TilemapSystem>(*m_Context));

    createPlayer();
	m_SystemManager.addSystem(std::make_unique<PlayerControllerSystem>(*m_Context));
	m_SystemManager.addSystem(std::make_unique<MoveSystem>(*m_Context));
	m_SystemManager.addSystem(std::make_unique<CollisionSystem>(*m_Context));

    createAnimations();
	m_SystemManager.addSystem(std::make_unique<AnimationSystem>(*m_Context));

    createCamera();
	m_SystemManager.addSystem(std::make_unique<CameraSystem>(*m_Context));
    m_SystemManager.addSystem(std::make_unique<RenderSystem>(*m_Context));
}

void World::createAnimations()
{
    Animation standing;
    standing.setSpriteSheet(m_Context->textures->get(Textures::CharactersSpriteSheet));
    standing.addFrame(sf::IntRect( 1, 22, 32, 32));

    Animation walking;
    walking.setSpriteSheet(m_Context->textures->get(Textures::CharactersSpriteSheet));
    walking.addFrame(sf::IntRect( 145, 22, 32, 32));
    walking.addFrame(sf::IntRect( 178, 22, 32, 32));

    Animation jumping;
    jumping.setSpriteSheet(m_Context->textures->get(Textures::CharactersSpriteSheet));
    jumping.addFrame(sf::IntRect( 322, 22, 32, 32));

    auto view = m_Context->registry->view<C_Animation>();

    for (auto &entity : view)
    {
        if(m_Context->registry->has<C_PlayerController>(entity))
        {
            auto &animComp = m_Context->registry->get<C_Animation>(entity);
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
    const auto entity = m_Context->registry->create();
    auto shape = new sf::RectangleShape(sf::Vector2f(10.f, 20.f));
    utils::centerOrigin(*shape);
    shape->setFillColor(sf::Color::Transparent);
    shape->setOutlineThickness(-1);
    shape->setOutlineColor(sf::Color::Green);

	sf::Vector2f position;
    m_Context->registry->view<C_Tilemap>().each([&](auto entity, auto &c_t)
    {
    	for(const auto &og : c_t.m_ObjectLayers)
	    {
    		if(og->getName() == "Spawner Locations")
		    {
    			for(const auto &o : og->getObjects())
			    {
    				if(o.getName() == "Player Spawn Location")
				    {
    				    position.x = o.getPosition().x;
    				    position.y = o.getPosition().y;
				    }
			    }
		    }
	    }
    });

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
    m_Context->bodies[entity] = m_Context->b2_World->CreateBody(&bodyDef);
    auto fixture = m_Context->bodies[entity]->CreateFixture(&fixtureDef);
    fixture->SetUserData(shape);

    m_Context->registry->emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);
    m_Context->registry->emplace<C_PlayerController>(entity);
    m_Context->registry->emplace<C_Animation>(entity);
    m_Context->registry->emplace<C_PlayerTag>(entity);
    m_Context->registry->emplace<C_Raycast>(entity);
}

void World::createCamera()
{
    const auto cameraEntity = m_Context->registry->create();
    entt::entity playerEntity = entt::null;

    sf::View view;
    view.setSize(500,400);

    m_Context->registry->view<C_PlayerTag>().each([&](auto entity)
    {
        playerEntity = entity;
    });

    m_Context->registry->emplace<C_Camera>(cameraEntity, view, playerEntity);
}

void World::createTilemap()
{
    const auto tilemapEntity = m_Context->registry->create();
    
    m_Context->registry->emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/Tilemap_Test.tmx");
    // m_Context->registry->emplace<C_Tilemap>(tilemapEntity, "../res/Tilemaps/big_map.tmx");
}
