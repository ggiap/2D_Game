#include "World.h"

#include "../Components/C_Shape.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Systems/CollisionSystem.hpp"
#include "../Systems/MoveSystem.hpp"
#include "../Systems/RenderSystem.hpp"

#include <Box2D/Box2D.h>

World::World(Context& context) :
	m_Window(context.window),
	m_WorldView(context.window->getDefaultView()),
	m_WorldBounds(0, 0, m_WorldView.getSize().x, 600),
	m_Context(&context),
	em(context.registry),
	bodies()
{
	loadTextures();
	buildScene();
}

void World::update(const sf::Time dt)
{
	em.update(dt);
}

void World::draw()
{
	em.draw();
}

void World::loadTextures()
{
	
}

void World::buildScene()
{
    createWalls();

	std::srand(std::time(nullptr));
	for (auto i = 0; i < 1000; ++i)
	{
		const auto entity = m_Context->registry->create();
		m_Context->registry->emplace<BodyShape>(entity, sf::RectangleShape(sf::Vector2f(20.f, 20.f)));

		// Create the body definition
        sf::Vector2f position(static_cast<float>(rand() % 1100), static_cast<float>(rand() % 700));
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
        bodies[entity] = m_Context->b2_World->CreateBody(&bodyDef);
        bodies[entity]->CreateFixture(&fixture);

        m_Context->registry->emplace<C_Rigidbody>(entity, bodies[entity]);
	}

	em.addSystem(std::make_unique<MoveSystem>(*m_Context));
	em.addSystem(std::make_unique<CollisionSystem>(*m_Context));
	em.addRenderSystem(std::make_unique<RenderSystem>(*m_Context));
}

void World::createWalls()
{
    /* Create the bounding box */
    b2BodyDef boundingBoxDef;
    boundingBoxDef.type = b2_staticBody;
    float xPos = (m_Context->window->getSize().x / 2.f) / sfdd::SCALE;
    float yPos = 0.5f;
    boundingBoxDef.position.Set(xPos, yPos);

    const auto entity = m_Context->registry->create();
    m_Context->registry->emplace<C_Rigidbody>(entity, bodies[entity]);

    // Keep track of b2Bodies of the world
    bodies[entity] = m_Context->b2_World->CreateBody(&boundingBoxDef);


    b2PolygonShape boxShape;
    boxShape.SetAsBox(m_Context->window->getSize().x / sfdd::SCALE, 0.5f,b2Vec2(0.f, 0.f), 0.f);
    bodies[entity]->CreateFixture(&boxShape, 1.0); //Top

    //Top sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                                 static_cast<float>(1.f * sfdd::SCALE));
        sf::RectangleShape rect(size);
        rect.setPosition(xPos * sfdd::SCALE, yPos * sfdd::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    yPos = (m_Context->window->getSize().y) / sfdd::SCALE - 1.f;
    boxShape.SetAsBox((m_Context->window->getSize().x) / sfdd::SCALE, 0.5f, b2Vec2(0.f, yPos), 0.f);
    bodies[entity]->CreateFixture(&boxShape, 1.f); //Bottom

    //Bottom sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                                 static_cast<float>(1.f * sfdd::SCALE));
        sf::RectangleShape rect(size);
        rect.setPosition(xPos * sfdd::SCALE, yPos * sfdd::SCALE + 16.f);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    xPos -= 0.5f;
    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / sfdd::SCALE, b2Vec2(-xPos, 0.f), 0.f);
    bodies[entity]->CreateFixture(&boxShape, 1.f);//Left

    //Left sfml rectangle
    {
        auto size = sf::Vector2f(static_cast<float>(1.f * sfdd::SCALE),
                                 static_cast<float>(m_Context->window->getSize().y) * 2.f);
        sf::RectangleShape rect(size);
        rect.setPosition(16.f, yPos * sfdd::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }

    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / sfdd::SCALE, b2Vec2(xPos, 0.f), 0.f);
    bodies[entity]->CreateFixture(&boxShape, 1.f);//Right

    //Right sfml rectangle
    {
        auto size = sf::Vector2f(1.f * sfdd::SCALE,
                                static_cast<float>(m_Context->window->getSize().y) * 2.f);
        sf::RectangleShape rect(size);
        rect.setPosition(xPos * sfdd::SCALE + m_Context->window->getSize().x / 2.f, yPos * sfdd::SCALE);

        auto entity = m_Context->registry->create();
        m_Context->registry->emplace<BodyShape>(entity, rect);
    }
}
