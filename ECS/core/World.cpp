#include "World.h"

#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_PlayerController.hpp"
#include "../Components/C_Animation.hpp"
#include "../Components/C_Tag.h"
#include "../Components/C_Raycast.hpp"
#include "../Systems/CollisionSystem.hpp"
#include "../Systems/MoveSystem.hpp"
#include "../Systems/RenderSystem.hpp"
#include "../Systems/PlayerControllerSystem.hpp"
#include "../Systems/AnimationSystem.hpp"
#include "../Utils//Context.hpp"

#include <Box2D/Box2D.h>

World::World(Context& context) :
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
    m_SystemManager()
{
	loadTextures();
	buildScene();
	createAnimations();
}

void World::update(const sf::Time dt)
{
    m_SystemManager.update(dt);
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
    createWalls();
    createPlayer();

    m_SystemManager.addSystem(std::make_unique<PlayerControllerSystem>(*m_Context));
    m_SystemManager.addSystem(std::make_unique<AnimationSystem>(*m_Context));
    m_SystemManager.addSystem(std::make_unique<MoveSystem>(*m_Context));
    m_SystemManager.addSystem(std::make_unique<CollisionSystem>(*m_Context));
    m_SystemManager.addRenderSystem(std::make_unique<RenderSystem>(*m_Context));
}

void World::createWalls()
{
    /* Create the bounding box */
    b2BodyDef boundingBoxDef;
    boundingBoxDef.type = b2_staticBody;
    float xPos = (m_Context->window->getSize().x / 2.f) / utils::PIXELS_PER_METERS;
    float yPos = 0.5f;
    boundingBoxDef.position.Set(xPos, yPos);

    auto entity = m_Context->registry->create();
    m_Context->registry->emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);

    // Map b2Bodies from the world with entities
    m_Context->bodies[entity] = m_Context->b2_World->CreateBody(&boundingBoxDef);

    b2PolygonShape boxShape;
    // Top b2d Wall
    boxShape.SetAsBox(m_Context->window->getSize().x / utils::PIXELS_PER_METERS, 0.5f, b2Vec2(0.f, 0.f), 0.f);
    auto fixture = m_Context->bodies[entity]->CreateFixture(&boxShape, 1.0); //Top

    //Top sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                                 static_cast<float>(1.f * utils::PIXELS_PER_METERS));

        auto *shape = new sf::RectangleShape(size);
        utils::centerOrigin(*shape);
        shape->setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        shape->setPosition(xPos * utils::PIXELS_PER_METERS, yPos * utils::PIXELS_PER_METERS);

        fixture->SetUserData(shape);
    }

    // Bottom b2d Wall
    yPos = (m_Context->window->getSize().y) / utils::PIXELS_PER_METERS - 1.f;
    boxShape.SetAsBox((m_Context->window->getSize().x) / utils::PIXELS_PER_METERS, 0.5f, b2Vec2(0.f, yPos), 0.f);
    fixture = m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f); //Bottom

    //Bottom sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                            static_cast<float>(1.f * utils::PIXELS_PER_METERS));
        auto shape = new sf::RectangleShape(size);
        utils::centerOrigin(*shape);
        shape->setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        shape->setPosition(xPos * utils::PIXELS_PER_METERS, yPos * utils::PIXELS_PER_METERS + 16.f);

        fixture->SetUserData(shape);
    }

    // Left b2d Wall
    xPos -= 0.5f;
    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / utils::PIXELS_PER_METERS, b2Vec2(-xPos, 0.f), 0.f);
    fixture = m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f);//Left

    //Left sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(1.f * utils::PIXELS_PER_METERS),
                                 static_cast<float>(m_Context->window->getSize().y) * 2.f);
        auto shape = new sf::RectangleShape(size);
        utils::centerOrigin(*shape);
        shape->setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        shape->setPosition(16.f, yPos * utils::PIXELS_PER_METERS);

        fixture->SetUserData(shape);
    }


    // Right b2d Wall
    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / utils::PIXELS_PER_METERS, b2Vec2(xPos, 0.f), 0.f);
    fixture = m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f);//Right

    //Right sfml rectangle
    {
        auto size = sf::Vector2f(1.f * utils::PIXELS_PER_METERS,
                                 static_cast<float>(m_Context->window->getSize().y) * 2.f);
        auto shape = new sf::RectangleShape(size);
        utils::centerOrigin(*shape);
        shape->setFillColor(sf::Color(sf::Color::Blue));
        shape->setPosition(xPos * utils::PIXELS_PER_METERS + m_Context->window->getSize().x / 2.f,
                           yPos * utils::PIXELS_PER_METERS);

        fixture->SetUserData(shape);
    }
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

            // Center origin
            auto bounds = animComp.animatedSprite.getLocalBounds();
            animComp.animatedSprite.setOrigin(std::floor(bounds.left + bounds.width / 2.f),
                                              std::floor(bounds.top + bounds.height / 2.f));
        }
    }
}

void World::createPlayer()
{
    const auto entity = m_Context->registry->create();
    auto shape = new sf::RectangleShape(sf::Vector2f(20.f, 20.f));
    utils::centerOrigin(*shape);
    shape->setFillColor(sf::Color::Transparent);
    shape->setOutlineThickness(-1);
    shape->setOutlineColor(sf::Color::Green);

    // Create the body definition
    sf::Vector2f position(static_cast<float>(m_Context->window->getSize().x) / 2.f,
                          static_cast<float>(m_Context->window->getSize().y) / 2.f);

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
