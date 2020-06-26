#include "World.h"

#include "../Components/C_Body.hpp"
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
	for (auto i = 0; i < 100; ++i)
	{
		const auto entity = m_Context->registry->create();
		sf::Vector2f position(static_cast<float>(rand() % 1150), static_cast<float>(rand() % 750));
		sf::Vector2f velocity(static_cast<float>(rand() % 200 - 50), static_cast<float>(rand() % 200 - 50));
		m_Context->registry->emplace<Body>(entity, sf::RectangleShape(sf::Vector2f(20.f, 20.f)));

        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position = utils::sfVecToB2Vec(position);
        //bodyDef.fixedRotation = true;
        b2Body* body = m_Context->world->CreateBody(&bodyDef);
        b2PolygonShape bShape;
        b2Vec2 size = utils::sfVecToB2Vec(sf::Vector2<float>(10.6f, 10.6f));
        bShape.SetAsBox(size.x, size.y);
        b2FixtureDef fixture;
        fixture.shape = &bShape;
        fixture.density = 1.f;
        fixture.friction = 1.f;
        body->CreateFixture(&fixture);
        bodies[entity] = body;

        m_Context->registry->emplace<C_Rigidbody>(entity, body);
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
    float xPos = (m_Context->window->getSize().x) / 2.f / sfdd::SCALE;
    float yPos = (m_Context->window->getSize().y) / sfdd::SCALE;
    boundingBoxDef.position.Set(xPos, yPos);

    b2Body* boundingBoxBody = m_Context->world->CreateBody(&boundingBoxDef);

    b2PolygonShape boxShape;
    boxShape.SetAsBox((m_Context->window->getSize().x) / sfdd::SCALE, 0.5f,
            b2Vec2(0.f, 0.f), 0.f);
    boundingBoxBody->CreateFixture(&boxShape, 1.0); //Top

    {
        const auto entity = m_Context->registry->create();
        auto size = sf::Vector2f(m_Context->window->getSize().x, 12.5f);
        sf::RectangleShape rect(size);
        //rect.setRotation(90);
        printf("%f %f %f\n", size.x, size.y, rect.getRotation());

        //Add body to entity-bodies map
        bodies[entity] = boundingBoxBody;
        m_Context->registry->emplace<Body>(entity, rect);
        m_Context->registry->emplace<C_Rigidbody>(entity, boundingBoxBody);
    }

    yPos = (m_Context->window->getSize().y) / sfdd::SCALE - 1.f;
    boxShape.SetAsBox((m_Context->window->getSize().x) / sfdd::SCALE, 0.5f,
            b2Vec2(0.f, yPos), 0.f);
    boundingBoxBody->CreateFixture(&boxShape, 1.f); //Bottom

    {
        const auto entity = m_Context->registry->create();
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x),
                m_Context->window->getSize().y);
        sf::RectangleShape rect(size);
        rect.setRotation(90);
        printf("%f %f %f\n", size.x, size.y, rect.getRotation());

        //Add body to entity-bodies map
        bodies[entity] = boundingBoxBody;
        m_Context->registry->emplace<Body>(entity, sf::RectangleShape(sf::Vector2f()));
        m_Context->registry->emplace<C_Rigidbody>(entity, boundingBoxBody);
    }

    xPos -= 0.5f;
    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / sfdd::SCALE,
            b2Vec2(-xPos, 0.f), 0.f);
    boundingBoxBody->CreateFixture(&boxShape, 1.f);//Left

    {
        const auto entity = m_Context->registry->create();
        auto size = sf::Vector2f(-0.5f, m_Context->window->getSize().y);
        sf::RectangleShape rect(size);
        rect.setRotation(90);
        rect.setPosition(utils::B2VecToSFVec<sf::Vector2f>(boundingBoxBody->GetPosition()));
        printf("%f %f %f\n", size.x, size.y, rect.getRotation());

        //Add body to entity-bodies map
        bodies[entity] = boundingBoxBody;
        m_Context->registry->emplace<Body>(entity, rect);
        m_Context->registry->emplace<C_Rigidbody>(entity, boundingBoxBody);
    }

    boxShape.SetAsBox(0.5f, (m_Context->window->getSize().y) / sfdd::SCALE,
            b2Vec2(xPos, 0.f), 0.f);
    boundingBoxBody->CreateFixture(&boxShape, 1.f);//Right

    {
        const auto entity = m_Context->registry->create();
        auto size = sf::Vector2f(static_cast<float>(m_Context->window->getSize().x), 0.5f * sfdd::SCALE);
        sf::RectangleShape rect(size);
        rect.setRotation(90);
        rect.setPosition(utils::B2VecToSFVec<sf::Vector2f>(boundingBoxBody->GetPosition()));
        printf("%f %f %f %f %f\n", size.x, size.y, rect.getRotation(), rect.getPosition().x, rect.getPosition().y);

        //Add body to entity-bodies map
        bodies[entity] = boundingBoxBody;

        m_Context->registry->emplace<Body>(entity, rect);
        m_Context->registry->emplace<C_Rigidbody>(entity, boundingBoxBody);
    }
}
