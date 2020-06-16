#include "SceneNode.h"
#include "../Utils/Utility.hpp"

SceneNode::SceneNode() :
	m_Parent(nullptr),
	m_Children()
{
}

void SceneNode::attachChild(Ptr child)
{
	child->m_Parent = this;
	m_Children.push_back(std::move(child));
}

SceneNode::Ptr SceneNode::detachChild(const SceneNode& node)
{
	auto found = std::find_if(m_Children.begin(), m_Children.end(),
		[&](Ptr &p) { return p.get() == &node; });


	assert(found != m_Children.end());

	Ptr result = std::move(*found);
	result->m_Parent = nullptr;
	m_Children.erase(found);

	return result;
}

void SceneNode::update(sf::Time dt)
{
	updateCurrent(dt);
	updateChildren(dt);
}

sf::Transform SceneNode::getWorldTransform() const
{
	auto transform = sf::Transform::Identity;

	for (auto node = this; node != nullptr; node = node->m_Parent)
		transform *= node->getTransform();

	return transform;
}

sf::Vector2f SceneNode::getWorldPosition() const
{
	return getWorldTransform() * sf::Vector2f();
}

unsigned int SceneNode::getCategory() const
{
	return Category::Scene;
}

void SceneNode::updateCurrent([[maybe_unused]]sf::Time dt)
{

}

void SceneNode::updateChildren(sf::Time dt)
{
	for (auto& child : m_Children)
		child->update(dt);
}

void SceneNode::draw(sf::RenderTarget& target, sf::RenderStates states) const
{
	states.transform *= getTransform();

	drawCurrent(target, states);

	for (const auto& child : m_Children)
		child->draw(target, states);
}

void SceneNode::drawCurrent([[maybe_unused]]sf::RenderTarget& target, [[maybe_unused]]sf::RenderStates states) const
{
}
