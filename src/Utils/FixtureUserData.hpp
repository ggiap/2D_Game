#pragma once

#include <entt/entt.hpp>


namespace sf
{
	class RectangleShape;
}


struct FixtureUserData
{
	sf::RectangleShape* shape;
	entt::entity entity;
};