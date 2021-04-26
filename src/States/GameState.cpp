#include "GameState.h"
#include "StateStack.h"
#include "../Utils/QueryCallback.h"
#include "../Components/C_Rigidbody.hpp"
#include "../core/MusicPlayer.hpp"
#include "../core/SoundEffectPlayer.hpp"

#include <SFML/Window/Event.hpp>

GameState::GameState(StateStack& stack, Context& context) :
	State(stack, context),
	m_World(context)
{
    auto m_B2World = m_World.getB2World();

    /* Mouse Joint */
    mouseJoint = nullptr;
    b2BodyDef bodyDef;
    ground = m_B2World->CreateBody(&bodyDef);

    youLoseLabel.setString("YOU LOSE");
    youLoseLabel.setCharacterSize(60u);
    youLoseLabel.setFont(m_Context.fonts->get(Fonts::ID::ARJULIAN));
    youLoseLabel.setOutlineThickness(3.f);
    youLoseLabel.setOutlineColor(sf::Color::Black);
    utils::centerOrigin(youLoseLabel);

    victoryLabel.setString("VICTORY");
    victoryLabel.setCharacterSize(60u);
    victoryLabel.setFont(m_Context.fonts->get(Fonts::ID::ARJULIAN));
    victoryLabel.setOutlineThickness(3.f);
    victoryLabel.setOutlineColor(sf::Color::Black);
    utils::centerOrigin(victoryLabel);

    m_Context.music->play(Music::ID::GameTheme);
}

void GameState::draw()
{
	m_World.draw();

    if (m_World.getRemainingTime() <= 0 || m_World.GameOver())
        m_Context.window->draw(youLoseLabel);
    if (m_World.getNumberOfEnemies() == 0)
        m_Context.window->draw(victoryLabel);
}

bool GameState::update(const sf::Time dt)
{
    if (m_World.getNumberOfEnemies() == 0)
    {
        victoryLabel.setPosition(m_Context.window->getView().getCenter());
        victoryLabel.setScale(m_Context.window->getView().getSize().x / m_Context.window->getDefaultView().getSize().x,
                              m_Context.window->getView().getSize().y / m_Context.window->getDefaultView().getSize().y);

        return false;
    }
    if (m_World.getRemainingTime() <= 0 || m_World.GameOver())
    {
        /*requestStackPop();
        requestStackPush(States::Game);*/

        youLoseLabel.setPosition(m_Context.window->getView().getCenter());
        youLoseLabel.setScale(m_Context.window->getView().getSize().x / m_Context.window->getDefaultView().getSize().x,
                              m_Context.window->getView().getSize().y / m_Context.window->getDefaultView().getSize().y);

        return false;
    }

	m_World.update(dt);   

	return true;
}

bool GameState::handleEvent(const sf::Event& event)
{
    m_World.handleEvents(event);

    if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::P && m_World.getNumberOfEnemies() != 0)
    {
        m_World.spawnEnemy();
    }

    if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::R)
    {
        requestStackPop();
        requestStackPush(States::ID::Game);
    }

    if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Num1)
    {
        m_World.sfmlDebugging() = !m_World.sfmlDebugging();
    }

    if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Num2)
    {
        m_World.b2dDebugging() = !m_World.b2dDebugging();
    }

    if (((event.type == sf::Event::KeyPressed && (event.key.code == sf::Keyboard::BackSpace || event.key.code == sf::Keyboard::Escape))) &&
        (m_World.getRemainingTime() <= 0 || m_World.getNumberOfEnemies() == 0))
    {
        requestStackPop();
        requestStackPush(States::ID::Menu);
        m_Context.isPaused = false;
    }
    else if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Escape)
    {
        m_Context.sounds->play(Sounds::ID::Pause);
        requestStackPush(States::ID::Pause);
        m_Context.isPaused = true;
    } 

    auto m_B2World = m_World.getB2World();

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
        m_B2World->QueryAABB(&callback, aabb);

        if (callback.m_fixture)
        {
            b2Body* body = callback.m_fixture->GetBody();
            b2MouseJointDef md;
            md.bodyA = ground; //If bounding box body is used instead, the dynamic bodies can be dragged over the bounding box and we don't want that
            md.bodyB = body;
            md.target = mousePos;
            md.maxForce = 1000.0f * body->GetMass();
            mouseJoint = (b2MouseJoint*)m_B2World->CreateJoint(&md);
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
        m_B2World->DestroyJoint(mouseJoint);
        mouseJoint = nullptr;
    }

	return true;
}
