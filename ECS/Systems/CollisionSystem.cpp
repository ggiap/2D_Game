#include "CollisionSystem.hpp"
#include "../Components/C_Body.hpp"

CollisionSystem::CollisionSystem(Context& context) :
    BaseSystem(context)
{
    //m_Context->registry->view()
}

void CollisionSystem::update(sf::Time dt)
{
	//auto view = m_Context->registry->view<Body>();

//	for (auto& entity : view)
//	{
//		auto& body = view.get<Body>(entity);
//        checkOutOFBorder(body);
//	}

    m_Context->world->Step(dt.asSeconds(), 8, 3);
}

void CollisionSystem::checkOutOFBorder(Body& body) const
{
    if (m_Context->window->getView().getSize().x - body.shape.getSize().x < body.position.x)
    {
        body.velocity.x = -body.velocity.x;
    }
    if (m_Context->window->getView().getSize().y - body.shape.getSize().y < body.position.y)
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
    return (m_Context->window->getView().getSize().x - body.shape.getSize().x < body.position.x) ||
           (m_Context->window->getView().getSize().y - body.shape.getSize().y < body.position.y) ||
           (0.0f > body.position.y) ||
           (0.0f > body.position.x);

}