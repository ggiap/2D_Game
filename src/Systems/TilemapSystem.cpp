#include "TilemapSystem.hpp"

#include "../Utils/Context.hpp"
#include "../Utils/BodyCreator.h"
#include "../Components/C_Tilemap.hpp"
#include <tmxlite/Layer.hpp>
#include <tmxlite/Map.hpp>
#include "../core/World.h"

TilemapSystem::TilemapSystem(Context &context, World *world) : BaseSystem(context, world)
{
	m_World->getEntityRegistry()->view<C_Tilemap>().each([&](auto entity, auto &tilemapComp)
	{
		tmx::Map map;
		map.load(tilemapComp.m_MapPath);
		auto &layers = map.getLayers();

		size_t i = 0;
		for (const auto &l : layers)
		{
			if (l->getType() == tmx::Layer::Type::Tile)
			{
				tilemapComp.m_TileLayers.push_back(std::make_unique<MapLayer>(map, i));
				++i;
			}
			else if (l->getType() == tmx::Layer::Type::Object)
			{
				auto objLayer = l->template getLayerAs<tmx::ObjectGroup>();
				tilemapComp.m_ObjectLayers.push_back(std::make_unique<tmx::ObjectGroup>(objLayer));
				if (l->getName() == "Static Object Layer")
				{
					const auto &objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto &obj : objects)
					{
						auto *body = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_staticBody);
					}
				}
				else if (l->getName() == "Dynamic Object Layer")
				{
					auto objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto &obj : objects)
					{
						auto *body = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_dynamicBody);
					}
				}

				else if (l->getName() == "Kinematic Object Layer")
				{
					auto objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto &obj : objects)
					{
						auto *body = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_kinematicBody);
					}
				}
			}
		}
	});
}

void TilemapSystem::update(sf::Time &dt)
{
	m_World->getEntityRegistry()->view<C_Tilemap>().each([&](auto entity, auto &tilemapComp)
    {
     	for(const auto &l : tilemapComp.m_TileLayers)
            l->update(dt);
    });
}