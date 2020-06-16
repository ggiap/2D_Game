#pragma once
#include <algorithm>
#include <memory>
#include <array>
#include <SFML/Graphics/RenderWindow.hpp>
#include "../Utils/ResourceHolder.h"
#include "../Utils/Utility.hpp"
#include "../core/SceneNode.h"

class World
{
public:
	explicit World(sf::RenderWindow &window);

	void update(sf::Time dt);
	void draw();

private:
	void loadTextures();
	void buildScene();

private:
	typedef enum
	{
		Foreground,
		Background,
		Objects,
		LayerCount
	}layer;

private:
	sf::RenderWindow& m_Window;
	sf::View m_WorldView;
	sf::FloatRect m_WorldBounds;
	sf::Vector2f m_spawnPosition;
	TextureHolder m_Textures;
	FontHolder m_Fonts;
	SceneNode m_SceneGraph;
	std::array<SceneNode*, LayerCount> m_SceneLayers;
};

