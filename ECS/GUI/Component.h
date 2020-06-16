#pragma once

#include <memory>
#include <SFML/Graphics/Drawable.hpp>
#include <SFML/Graphics/Transformable.hpp>
#include <SFML/System/NonCopyable.hpp>

namespace sf
{
	class Event;
}

namespace GUI
{
	class Component : public sf::NonCopyable,
					  public sf::Drawable,
	 				  public sf::Transformable
	{
	public:
		using Ptr = std::shared_ptr<Component>;

	public:
						Component();
		virtual 		~Component();
		virtual bool 	isSelectable() const = 0;
		bool 			isSelected() const;
		virtual void 	select();
		virtual void	deselect();
		virtual bool	isActive() const;
		virtual void 	activate();
		virtual void 	deactivate();
		virtual void 	handleEvent(const sf::Event& event) = 0;

	private:
		bool 			m_IsSelected;
		bool 			m_IsActive;
	};
}