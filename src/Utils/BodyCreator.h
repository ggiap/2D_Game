/*********************************************************************
Matt Marchant 2013 - 2016
SFML Tiled Map Loader - https://github.com/bjorn/tiled/wiki/TMX-Map-Format
http://trederia.blogspot.com/2013/05/tiled-map-loader-for-sfml.html

Some of the hull decimation code is a based on an ActionScript class
by Antoan Angelov. See:
http://www.emanueleferonato.com/2011/09/12/create-non-convex-complex-shapes-with-box2d/

Zlib License:

This software is provided 'as-is', without any express or
implied warranty. In no event will the authors be held
liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute
it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented;
you must not claim that you wrote the original software.
If you use this software in a product, an acknowledgment
in the product documentation would be appreciated but
is not required.

2. Altered source versions must be plainly marked as such,
and must not be misrepresented as being the original software.

3. This notice may not be removed or altered from any
source distribution.
*********************************************************************/

/*********************************************************************
 *************************** CAUTION *********************************

 ******* This is an altered version of the original software *********

*********************************************************************/

#ifndef TMXTEST_BODYCREATOR_H
#define TMXTEST_BODYCREATOR_H

#include <vector>
#include <memory>
#include <SFML/System/Vector2.hpp>
#include <Box2D/Box2D.h>
#include <tmxlite/Object.hpp>
#include "../Utils/Utility.hpp"


struct BodyCreator
{
	static float getWinding(const sf::Vector2f &p1, const sf::Vector2f &p2, const sf::Vector2f &p3)
	{
		return p1.x * p2.y + p2.x * p3.y + p3.x * p1.y - p1.y * p2.x - p2.y * p3.x - p3.y * p1.x;
	}

	static void createFixture(const std::vector<sf::Vector2<float>> &points, b2Body *body)
	{
		bool clockwise = (getWinding(points[0], points[1], points[2]) > 0.f);
		size_t s = points.size();
		std::unique_ptr<b2Vec2[]> vertices(new b2Vec2[s]);
		for (auto i = 0u; i < s; i++)
		{
			//reverse direction if verts wound clockwise
			int index = (clockwise) ? (s - 1) - i : i;
			vertices[i] = utils::sfVecToB2Vec(points[index]);
		}

		b2PolygonShape ps;
		ps.Set(vertices.get(), points.size());
		b2FixtureDef f;
		f.density = 1.f;
		f.shape = &ps;

		body->CreateFixture(&f);
	}

	static b2Body *createBody(b2World &world, const tmx::Object &object, b2BodyType bodyType)
	{
		tmx::Object::Shape objShape = object.getShape();
		auto halfObjSize = utils::sfVecToB2Vec(object.getAABB().width / 2.f , object.getAABB().height /2.f);
		auto objPos = utils::sfVecToB2Vec(object.getPosition().x, object.getPosition().y) + halfObjSize;
		auto objSize = utils::sfVecToB2Vec(object.getAABB().width, object.getAABB().height);

		std::vector<sf::Vector2f> shape{};
		for (const auto &point : object.getPoints())
		{
			shape.emplace_back(point.x, point.y);
		}
		auto pointsCount = object.getPoints().size();

		b2BodyDef bodyDef;
		bodyDef.type = bodyType;
		bodyDef.position.Set(objPos.x, objPos.y);
		b2Body *retBody = nullptr;
		b2FixtureDef fixtureDef;
		fixtureDef.density = 1.f;
		fixtureDef.filter.categoryBits = BodyCategory::Other;

		if (objShape == tmx::Object::Shape::Polyline)
		{
			retBody = world.CreateBody(&bodyDef);

			if (pointsCount < 3)
			{
				b2EdgeShape edgeShape;

				edgeShape.Set(utils::sfVecToB2Vec(shape[0].x, shape[0].y), utils::sfVecToB2Vec(shape[1].x, shape[1].y));

				fixtureDef.shape = &edgeShape;
				retBody->CreateFixture(&fixtureDef);
			}
			else
			{
				std::unique_ptr<b2Vec2[]> vertices(new b2Vec2[pointsCount]);
				for (auto i = 0u; i < pointsCount; i++)
					vertices[i] = utils::sfVecToB2Vec(shape[i].x, shape[i].y);

				b2ChainShape chainShape;
				chainShape.CreateChain(vertices.get(), pointsCount);

				fixtureDef.shape = &chainShape;

				retBody->CreateFixture(&fixtureDef);
			}
		}
		else if (objShape == tmx::Object::Shape::Ellipse)
		{
			b2CircleShape c;
			c.m_radius = objSize.x / 2.f;

			fixtureDef.restitution = .9f;

			fixtureDef.shape = &c;

			retBody = world.CreateBody(&bodyDef);
			retBody->CreateFixture(&fixtureDef);
		}
		else if (objShape == tmx::Object::Shape::Rectangle)
		{
			b2PolygonShape ps;
			ps.SetAsBox(objSize.x / 2.f, objSize.y / 2.f);
			fixtureDef.shape = &ps;

			retBody = world.CreateBody(&bodyDef);
			retBody->CreateFixture(&fixtureDef);
		}
		else //simple convex polygon
		{
			retBody = world.CreateBody(&bodyDef);

			createFixture(shape, retBody);
		}

		return retBody;
	}
};

#endif //TMXTEST_BODYCREATOR_H
