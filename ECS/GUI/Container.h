#pragma once

#include <memory>
#include <vector>
#include "Component.h"

namespace GUI
{
	class Container : public Component
	{
	public:
		using Ptr = std::shared_ptr<Container>;

	public:
		Container();

		void pack(Component::Ptr component);

		virtual bool isSelectable() const;
		virtual void handleEvent(const sf::Event& event);

	private:
		virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const;

		bool	hasSelection() const;
		void	select(std::size_t index);
		void	selectNext();
		void	selectPrevious();

	private:
		std::vector<Component::Ptr> m_Children;
		int m_SelectedChild;
	};
}