#include "TilemapSystem.hpp"

#include "../Utils/Context.hpp"
#include "../Utils/BodyCreator.h"
#include "../Utils/FixtureUserData.hpp"
#include "../Components/C_Tilemap.hpp"
#include "../Components/C_Rigidbody.hpp"
#include "../Components/C_Tag.h"
#include <tmxlite/Layer.hpp>
#include <tmxlite/Map.hpp>
#include "../core/World.h"

TilemapSystem::TilemapSystem(Context &context, World *world) : BaseSystem(context, world)
{
	m_World->getEntityRegistry()->view<C_Tilemap>().each([&](auto entity, auto& tilemapComp)
	{
		tmx::Map map;
		map.load(tilemapComp.m_MapPath);
		auto& layers = map.getLayers();

		size_t i = 0;
		for (const auto& l : layers)
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
					const auto& objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto& obj : objects)
					{
						auto entity = m_World->getEntityRegistry()->create();
						m_Context->enttToBody[entity] = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_staticBody);
						
						m_World->getEntityRegistry()->emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);
						
						FixtureUserData* userData = new FixtureUserData();
						userData->entity = entity;
						m_Context->enttToBody[entity]->GetFixtureList()->SetUserData(userData);
					}
				}
				else if (l->getName() == "Dynamic Object Layer")
				{
					auto objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto& obj : objects)
					{
						auto entity = m_World->getEntityRegistry()->create();
						m_Context->enttToBody[entity] = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_dynamicBody);

						m_World->getEntityRegistry()->emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);

						FixtureUserData* userData = new FixtureUserData();
						userData->entity = entity;
						m_Context->enttToBody[entity]->GetFixtureList()->SetUserData(userData);					
					}
				}

				else if (l->getName() == "Kinematic Object Layer")
				{
					auto objects = l->getLayerAs<tmx::ObjectGroup>().getObjects();
					for (const auto& obj : objects)
					{
						auto entity = m_World->getEntityRegistry()->create();
						m_Context->enttToBody[entity] = BodyCreator::createBody(*m_World->getB2World(), obj, b2BodyType::b2_kinematicBody);

						m_World->getEntityRegistry()->emplace<C_Rigidbody>(entity, m_Context->enttToBody[entity]);

						FixtureUserData* userData = new FixtureUserData();
						userData->entity = entity;
						m_Context->enttToBody[entity]->GetFixtureList()->SetUserData(userData);
						
						if (obj.getName().find("Platform") != std::string::npos)
						{
							m_World->getEntityRegistry()->emplace<C_OneWayPlatform>(entity);
							b2Filter filter;
							filter.categoryBits = BodyCategory::OneWayPlatform;
							filter.maskBits = BodyCategory::Enemy | BodyCategory::Player;
							m_Context->enttToBody[entity]->GetFixtureList()->SetFilterData(filter);
						}

						if (obj.getName().find("Spikes") != std::string::npos)
						{
							m_World->getEntityRegistry()->emplace<C_Spikes>(entity);
						}
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