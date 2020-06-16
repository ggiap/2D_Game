#pragma once
#include <memory>
#include <vector>
#include <algorithm>
#include <cassert>

#include <SFML/System/NonCopyable.hpp>
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/Drawable.hpp>
#include <SFML/Graphics/Transformable.hpp>

class SceneNode : public sf::Transformable, public sf::Drawable, private sf::NonCopyable
{
public:
	using Ptr = std::unique_ptr<SceneNode>;

public:
	SceneNode();

	void attachChild(Ptr child);
	Ptr detachChild(const SceneNode &node);

	void update(sf::Time dt);

	sf::Transform getWorldTransform() const;
	sf::Vector2f getWorldPosition() const;

	virtual unsigned int getCategory() const;

private:
	virtual void updateCurrent(sf::Time dt);
	void updateChildren(sf::Time dt);

	virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const override;
	virtual void drawCurrent(sf::RenderTarget& target, sf::RenderStates states) const;

private:
	SceneNode* m_Parent;
	std::vector<Ptr> m_Children;
};

