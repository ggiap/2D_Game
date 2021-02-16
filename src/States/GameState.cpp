#include "GameState.h"
#include "StateStack.h"
#include "../Utils/QueryCallback.h"
#include <SFML/Window/Event.hpp>
#include "../Components/C_Rigidbody.hpp"

GameState::GameState(StateStack& stack, Context& context) :
	State(stack, context),
	m_World(context)
{
    /* Mouse Joint */
    mouseJoint = nullptr;
    b2BodyDef bodyDef;
    ground = m_Context.b2_World->CreateBody(&bodyDef);
}

void GameState::draw()
{
	m_World.draw();
}

bool GameState::update(const sf::Time dt)
{
	m_World.update(dt);

	return true;
}

bool GameState::handleEvent(const sf::Event& event)
{
    m_World.handleEvents(event);

    if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Escape)
        requestStackPush(States::Pause);

    // Following three events are copied almost completely from http://code.google.com/p/box2d/source/browse/trunk/Box2D/Testbed/Framework/Test.cpp
    // Copyright (c) 2011 Erin Catto http://box2d.org
    if (event.type == sf::Event::MouseButtonPressed && event.mouseButton.button == sf::Mouse::Left && mouseJoint == nullptr)
    {
        b2Vec2 mousePos = utils::sfVecToB2Vec(m_Context.window->mapPixelToCoords(sf::Mouse::getPosition(*m_Context.window)));

        // Make a small box.
        b2AABB aabb;
        b2Vec2 d;
        d.Set(0.001f, 0.001f);
        aabb.lowerBound = mousePos + d;
        aabb.upperBound = mousePos - d;

        // Query the world for overlapping shapes.
        QueryCallback callback(mousePos);
        m_Context.b2_World->QueryAABB(&callback, aabb);

        if (callback.m_fixture)
        {
            b2Body* body = callback.m_fixture->GetBody();
            b2MouseJointDef md;
            md.bodyA = ground; //If bounding box body is used instead, the dynamic bodies can be dragged over the bounding box and we don't want that
            md.bodyB = body;
            md.target = mousePos;
            md.maxForce = 1000.0f * body->GetMass();
            mouseJoint = (b2MouseJoint*)m_Context.b2_World->CreateJoint(&md);
            body->SetAwake(true);
            body->SetBullet(true);
        }
    }
    else if (event.type == sf::Event::MouseMoved && mouseJoint != nullptr)
    {
        b2Vec2 mousePos = utils::sfVecToB2Vec(m_Context.window->mapPixelToCoords(sf::Mouse::getPosition(*m_Context.window)));
        mouseJoint->SetTarget(mousePos);
    }
    else if (event.type == sf::Event::MouseButtonReleased && event.mouseButton.button == sf::Mouse::Left && mouseJoint != nullptr)
    {
        mouseJoint->GetBodyB()->SetBullet(false);
        m_Context.b2_World->DestroyJoint(mouseJoint);
        mouseJoint = nullptr;
    }

	return true;
}
