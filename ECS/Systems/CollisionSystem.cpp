#include "CollisionSystem.hpp"
#include "../Components/C_Body.hpp"

CollisionSystem::CollisionSystem(entt::registry& reg, sf::RenderWindow& win) :
    BaseSystem(reg, win)
{

}

void CollisionSystem::update(sf::Time dt)
{
	auto view = registry->view<Body>();

	for (auto& entity : view)
	{
		auto& body = view.get<Body>(entity);
        checkOutOFBorder(body);
	}
}

void CollisionSystem::checkOutOFBorder(Body& body) const
{
    if (window->getView().getSize().x - body.shape.getSize().x < body.position.x)
    {
        body.velocity.x = -body.velocity.x;
    }
    if (window->getView().getSize().y - body.shape.getSize().y < body.position.y)
    {
        body.velocity.y = -body.velocity.y;
    }
    if (0.0f + body.shape.getSize().x > body.position.y)
    {
        body.velocity.y = -body.velocity.y;
    }
    if (0.0f + body.shape.getSize().y > body.position.x)
    {
        body.velocity.x = -body.velocity.x;
    }
}

bool CollisionSystem::checkOutOFBorder2(Body& body) const
{
    return (window->getView().getSize().x - body.shape.getSize().x < body.position.x) ||
           (window->getView().getSize().y - body.shape.getSize().y < body.position.y) ||
           (0.0f > body.position.y) ||
           (0.0f > body.position.x);

}