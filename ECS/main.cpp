//
// Created by georg on 04-Jun-20.
//
#include "spdlog/spdlog.h"
#include <entt/entt.hpp>
#include "Components/C_Position.hpp"
#include "Components/C_Velocity.hpp"
#include "Components/C_Shape.hpp"
#include <SFML/Graphics.hpp>
#include "Utils/Utility.hpp"


void update(float dt, entt::registry& registry, sf::RenderTarget& window)
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
            pos.x += vel.dx * dt;
            pos.y += vel.dy * dt;
            
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
    float dt = 0.001f;

    std::srand(std::time(nullptr));
    for (auto i = 0; i < 100; ++i) 
    {
        auto entity = registry.create();
        registry.emplace<position>(entity, float(rand() % 550), float(rand() % 300));
        registry.emplace<velocity>(entity, float(rand() % 60 + 20), float(rand() % 60 + 20));
        registry.emplace<shape>(entity, sf::RectangleShape(), sf::Vector2f(10.f, 10.f));
    }

   
    sf::RenderWindow sfmlWin(sf::VideoMode(600, 360), "Entity Component System");

    while (sfmlWin.isOpen())
    {

        sf::Event e;
        while (sfmlWin.pollEvent(e))
        {

            switch (e.type) {
            case sf::Event::EventType::Closed:
                sfmlWin.close();
                break;
            }
        }

        update(dt, registry, sfmlWin);
        sfmlWin.clear(sf::Color(0, 116, 217));
        render(sfmlWin, registry);
        sfmlWin.display();
    }

    return 0;
}