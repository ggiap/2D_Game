#include "CameraSystem.hpp"
#include "../Utils/Context.hpp"
#include "../Components/C_Camera.hpp"
#include "../core/World.h"

#include <SFML/System/Time.hpp>
#include <SFML/System/Vector2.hpp>
#include <SFML/Window/Event.hpp>

CameraSystem::CameraSystem(Context &context, World* world) :
BaseSystem(context, world),
freeRoaming(false)
{ }

void CameraSystem::update(sf::Time& dt)
{
    m_World->getEntityRegistry()->view<C_Camera>().each([&](auto& entity, auto& cameraComp)
    {
        if(freeRoaming == false)
        {
            auto targetPos = utils::B2VecToSFVec<sf::Vector2f>(m_Context->enttToBody[cameraComp.target]->GetPosition());
            cameraComp.view.setCenter(targetPos);
            m_Context->window->setView(cameraComp.view);
        }
        else
        {
          cameraPanning();
        }
    });
}

void CameraSystem::handleEvents(const sf::Event& event)
{
    if( sf::Keyboard::isKeyPressed(sf::Keyboard::Up) ||
        sf::Keyboard::isKeyPressed(sf::Keyboard::Down)||
        sf::Keyboard::isKeyPressed(sf::Keyboard::Right)||
        sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
    {
        freeRoaming = true;
    }

    if (event.type == sf::Event::MouseWheelScrolled)
    {
        freeRoaming = true;
        auto zoomAmount = 1.1f;
        if (event.mouseWheelScroll.delta > 0)
            zoomViewAt({event.mouseWheelScroll.x, event.mouseWheelScroll.y}, (1.f / zoomAmount));
        else if (event.mouseWheelScroll.delta < 0)
            zoomViewAt({event.mouseWheelScroll.x, event.mouseWheelScroll.y}, zoomAmount);
    }

    if (sf::Keyboard::isKeyPressed(sf::Keyboard::I))
    {
        freeRoaming = false;
        resetView();
    }
}

void CameraSystem::cameraPanning()
{
    freeRoaming = true;

    m_World->getEntityRegistry()->view<C_Camera>().each([&](auto& entity, auto& cameraComp)
    {
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
        {
            cameraComp.view.move({0.f, -10.f});
            m_Context->window->setView(cameraComp.view);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
        {
            cameraComp.view.move({0.f, 10.f});
            m_Context->window->setView(cameraComp.view);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
        {
            cameraComp.view.move({10.f, 0.f});
            m_Context->window->setView(cameraComp.view);
        }
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
        {
            cameraComp.view.move({-10.f, 0.f});
            m_Context->window->setView(cameraComp.view);
        }
    });
}

void CameraSystem::zoomViewAt(sf::Vector2<int> pixel, float zoom)
{
    m_World->getEntityRegistry()->view<C_Camera>().each([&](auto& entity, auto& cameraComp)
    {
        const sf::Vector2f beforeCoord{ m_Context->window->mapPixelToCoords(pixel) };
        cameraComp.view.zoom(zoom);
        m_Context->window->setView(cameraComp.view);
        const sf::Vector2f afterCoord{ m_Context->window->mapPixelToCoords(pixel) };
        const sf::Vector2f offsetCoords{ beforeCoord - afterCoord };
        cameraComp.view.move(offsetCoords);
        m_Context->window->setView(cameraComp.view);
    });
}

void CameraSystem::resetView()
{
    m_World->getEntityRegistry()->view<C_Camera>().each([&](auto& entity, auto& cameraComp)
    {
        cameraComp.view = cameraComp.defaultView;
    });
}
