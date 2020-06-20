#include "CollisionSystem.hpp"
#include "../Components/C_Body.hpp"


CollisionSystem::CollisionSystem(entt::registry& reg, sf::RenderWindow& win) :
    BaseSystem(reg, win)
{

}

void CollisionSystem::update(sf::Time dt)
{
	auto view = registry->view();

	for (auto& entity : view)
	{
		auto& body = view.get<Body>(entity);
        checkOutOFBorder(body);
	}
}

void CollisionSystem::checkOutOFBorder(Body& body)
{
    if (window->getView().getSize().x - 10.f < body.position.x)
    {
        body.velocity.x = -body.velocity.x;
    }
    if (window->getView().getSize().y - 10.f < body.position.y)
    {
        body.velocity.y = -body.velocity.y;
    }
    if (0.0f > body.position.y)
    {
        body.velocity.y = -body.velocity.y;
    }
    if (0.0f > body.position.x)
    {
        body.velocity.x = -body.velocity.x;
    }
}