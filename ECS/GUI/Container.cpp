#include "Container.h"
#include <SFML/Graphics.hpp>

namespace GUI
{
	Container::Container() :
	m_Children(),
	m_SelectedChild(-1)
	{

	}

	void Container::pack(Component::Ptr component)
	{
		m_Children.push_back(component);

		if(!hasSelection() && component->isSelectable())
			select(m_Children.size() - 1);
	}

	bool Container::isSelectable() const
	{
		return false;
	}

	void Container::handleEvent(const sf::Event& event)
	{
		if(hasSelection() && m_Children.at(m_SelectedChild)->isActive())
		{
			m_Children.at(m_SelectedChild)->handleEvent(event);
		}
		else if(event.type == sf::Event::KeyReleased)
		{
			if(event.key.code == sf::Keyboard::W || event.key.code == sf::Keyboard::Up)
				selectPrevious();
			else if(event.key.code == sf::Keyboard::S || event.key.code == sf::Keyboard::Down)
				selectNext();
			else if(event.key.code == sf::Keyboard::Enter)
			{
				if(hasSelection())
					m_Children.at(m_SelectedChild)->activate();
			}
		}
	}

	void Container::draw(sf::RenderTarget& target, sf::RenderStates states) const
	{
		states.transform *= getTransform();

		for(const auto& component : m_Children)
			target.draw(*component, states);
	}

	bool Container::hasSelection() const
	{
		return m_SelectedChild >= 0;
	}

	void Container::select(std::size_t index)
	{
		if(m_Children.at(index)->isSelectable())
		{
			if(hasSelection())
				m_Children.at(m_SelectedChild)->deselect();

			m_Children.at(index)->select();
			m_SelectedChild = static_cast<int>(index);
		}
	}

	void Container::selectNext()
	{
		if(!hasSelection())
			return;

		int next = m_SelectedChild;
		do
			next = (next + 1) % m_Children.size();
		while(!m_Children.at(next)->isSelectable());

		select(next);
	}

	void Container::selectPrevious()
	{
		if(!hasSelection())
			return;

		int previous = m_SelectedChild;
		do
			previous = static_cast<int>(previous + m_Children.size() - 1) % m_Children.size();
		while(!m_Children.at(previous)->isSelectable());

		select(previous);
	}
}