#include "Component.h"

namespace GUI
{
	Component::Component() :
	m_IsSelected(false),
	m_IsActive(false)
	{

	}

	Component::~Component()
	{

	}

	bool Component::isSelected() const
	{
		return m_IsSelected;
	}

	void Component::select()
	{
		m_IsSelected = true;
	}

	void Component::deselect()
	{
		m_IsSelected = false;
	}

	bool Component::isActive() const
	{
		return m_IsActive;
	}

	void Component::activate()
	{
		m_IsActive = true;
	}

	void Component::deactivate()
	{
		m_IsActive = false;
	}
}