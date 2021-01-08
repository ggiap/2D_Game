//
// Created by george on 31/7/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_C_CAMERA_HPP
#define ENTITY_COMPONENT_SYSTEM_C_CAMERA_HPP

#include <entt/entity/registry.hpp>
#include <SFML/Graphics/View.hpp>

struct C_Camera
{
    C_Camera() = default;
    C_Camera(sf::View view, entt::entity target) :
        view(view),
        defaultView(view),
        target(target)
    {

    }

    sf::View view{};
    sf::View defaultView{};
    entt::entity target{entt::null};
};

#endif //ENTITY_COMPONENT_SYSTEM_C_CAMERA_HPP
