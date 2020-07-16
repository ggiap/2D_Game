#include "World.h"

#include "../Components/C_Shape.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_PlayerInput.hpp"
#include "../Components/C_Animation.hpp"
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

    std::srand(std::time(nullptr));
    const auto entity = m_Context->registry->create();
    sf::RectangleShape rect(sf::Vector2f(20.f, 20.f));
    utils::centerOrigin(rect);
    rect.setFillColor(sf::Color::Transparent);
    rect.setOutlineThickness(-1);
    rect.setOutlineColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
    m_Context->registry->emplace<BodyShape>(entity, rect);

    // Create the body definition
    sf::Vector2f position(static_cast<float>(m_Context->window->getSize().x) / 2.f,
                          static_cast<float>(m_Context->window->getSize().y) / 2.f);
    auto bodySize = m_Context->registry->view<BodyShape>().get(entity);
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = utils::sfVecToB2Vec(position);
    //bodyDef.fixedRotation = true;

    // Fixture shape
    b2PolygonShape bShape;
    b2Vec2 size = utils::sfVecToB2Vec(bodySize.shape.getSize() / 2.f);
    bShape.SetAsBox(size.x, size.y);

    // Fixture definition
    b2FixtureDef fixture;
    fixture.shape = &bShape;
    fixture.density = 1.f;
    fixture.friction = 1.f;
    fixture.restitution = 0.f;

    // Create and register the body in the world
    m_Context->bodies[entity] = m_Context->b2_World->CreateBody(&bodyDef);
    m_Context->bodies[entity]->CreateFixture(&fixture);

    m_Context->registry->emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);
    m_Context->registry->emplace<C_PlayerInput>(entity);
    m_Context->registry->emplace<C_Animation>(entity);

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
    float xPos = (m_Context->window->getSize().x / 2.f) / utils::SCALE;
    float yPos = 0.5f;
    boundingBoxDef.position.Set(xPos, yPos);

    const auto entity = m_Context->registry->create();
    m_Context->registry->emplace<C_Rigidbody>(entity, m_Context->bodies[entity]);

    // Keep track of b2Bodies of the world
    m_Context->bodies[entity] = m_Context->b2_World->CreateBody(&boundingBoxDef);


    b2PolygonShape boxShape;
    boxShape.SetAsBox(m_Context->window->getSize().x / utils::SCALE, 0.5f,b2Vec2(0.f, 0.f), 0.f);
    m_Context->bodies[entity]->CreateFixture(&boxShape, 1.0); //Top

    //Top sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                                 static_cast<float>(1.f * utils::SCALE));
        sf::RectangleShape rect(size);
        utils::centerOrigin(rect);
        rect.setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        rect.setPosition(xPos * utils::SCALE, yPos * utils::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    yPos = (m_Context->window->getSize().y) / utils::SCALE - 1.f;
    boxShape.SetAsBox((m_Context->window->getSize().x) / utils::SCALE, 0.5f, b2Vec2(0.f, yPos), 0.f);
    m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f); //Bottom

    //Bottom sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                                 static_cast<float>(1.f * utils::SCALE));
        sf::RectangleShape rect(size);
        utils::centerOrigin(rect);
        rect.setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        rect.setPosition(xPos * utils::SCALE, yPos * utils::SCALE + 16.f);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    xPos -= 0.5f;
    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / utils::SCALE, b2Vec2(-xPos, 0.f), 0.f);
    m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f);//Left

    //Left sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(1.f * utils::SCALE),
                                 static_cast<float>(m_Context->window->getSize().y) * 2.f);
        sf::RectangleShape rect(size);
        utils::centerOrigin(rect);
        rect.setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        rect.setPosition(16.f, yPos * utils::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / utils::SCALE, b2Vec2(xPos, 0.f), 0.f);
    m_Context->bodies[entity]->CreateFixture(&boxShape, 1.f);//Right

    //Right sfml rectangle
    {
        auto size = sf::Vector2f(1.f * utils::SCALE,
                                static_cast<float>(m_Context->window->getSize().y) * 2.f);
        sf::RectangleShape rect(size);
        utils::centerOrigin(rect);
        rect.setFillColor(sf::Color(rand() % 255, rand() % 255, rand() % 255));
        rect.setPosition(xPos * utils::SCALE + m_Context->window->getSize().x / 2.f, yPos * utils::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
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

    auto view = m_Context->registry->view<C_Animation>();

    for (auto &entity : view)
    {
        if(m_Context->registry->has<C_PlayerInput>(entity))
        {
            auto &animComp = m_Context->registry->get<C_Animation>(entity);
            animComp.animatedSprite.addAnimation(Animations::Standing, standing);
            animComp.animatedSprite.addAnimation(Animations::Walking, walking);
            animComp.animatedSprite.play(Animations::Standing);

            // Center origin
            auto bounds = animComp.animatedSprite.getLocalBounds();
            animComp.animatedSprite.setOrigin(std::floor(bounds.left + bounds.width / 2.f),
                                              std::floor(bounds.top + bounds.height / 2.f));
        }
    }
}
