//
// Created by georg on 04-Jun-20.
//
#include "spdlog/spdlog.h"
#include <entt/entt.hpp>
#include "Components/C_Position.hpp"
#include "Components/C_Velocity.hpp"
#include "Components/C_Shape.hpp"
#include "Components/C_Body.hpp"
#include <SFML/Graphics.hpp>
#include "Utils/Utility.hpp"


void update(sf::Time dt, entt::registry& registry, sf::RenderTarget& window)
{
    registry.view<position, velocity, shape>().each([&](auto& pos, auto& vel, auto& s)
        {
            if (window.getView().getSize().x - 10.f < pos.x)
            {
                vel.dx = -vel.dx;
            }
            if (window.getView().getSize().y - 10.f < pos.y)
            {
                vel.dy = -vel.dy;
            }
            if (0.0f > pos.y)
            {
                vel.dy = -vel.dy;
            }
            if (0.0f > pos.x)
            {
                vel.dx = -vel.dx;
            }
            pos.x += vel.dx * dt.asSeconds();
            pos.y += vel.dy * dt.asSeconds();
            
            s.setPosition(pos.x, pos.y);
        });
}

void render(sf::RenderWindow& win, entt::registry& registry)
{
    registry.view<shape>().each([&win](auto& entity, auto& s)
        {
            win.draw(s);
        });
}

int main()
{
    entt::registry registry;

    std::srand(std::time(nullptr));
    for (auto i = 0; i < 6000; ++i) 
    {
        auto entity = registry.create();
        registry.emplace<position>(entity, float(rand() % 550), float(rand() % 300));
        registry.emplace<velocity>(entity, float(rand() % 100 + 50), float(rand() % 100 + 50));
        registry.emplace<shape>(entity, sf::RectangleShape(), sf::Vector2f(5.f, 5.f));
        registry.emplace<Body>(entity, sf::RectangleShape(sf::Vector2f(5.f, 5.f)));
    }

   
    sf::RenderWindow sfmlWin(sf::VideoMode(1200, 660), "Entity Component System");

    sf::Time m_StatisticsUpdateTime{};
    std::size_t m_StatisticsNumFrames{};
    const sf::Time TimePerFrame = sf::seconds(1 / 60.f);
    sf::Clock clock;
    sf::Time timeSinceLastUpdate = sf::Time::Zero;
    while (sfmlWin.isOpen())
    {
        sf::Time dt = clock.restart();
        timeSinceLastUpdate += dt;
        while (timeSinceLastUpdate > TimePerFrame)
        {
            timeSinceLastUpdate -= TimePerFrame;
            sf::Event e;
            while (sfmlWin.pollEvent(e))
            {

                switch (e.type) {
                case sf::Event::EventType::Closed:
                    sfmlWin.close();
                    break;
                }
            }
        }
        m_StatisticsUpdateTime += dt;
        m_StatisticsNumFrames += std::size_t(1);
        if (m_StatisticsUpdateTime >= sf::seconds(1.0f))
        {
            spdlog::info("FPS: {}", std::to_string(m_StatisticsNumFrames));

            m_StatisticsUpdateTime -= sf::seconds(1.0f);
            m_StatisticsNumFrames = 0;
        }
        

        update(dt, registry, sfmlWin);
        sfmlWin.clear(sf::Color(0, 116, 217));
        render(sfmlWin, registry);
        sfmlWin.display();
    }

    return 0;
}