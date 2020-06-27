#pragma once

#include <SFML/Window/Keyboard.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/Graphics/Text.hpp>
#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/System/Vector2.hpp>
#include <Box2D/Box2D.h>
#include <cassert>
#include <cmath>


namespace sf
{
    class Texture;
    class Font;
    class Sprite;
    class Text;
    class RectangleShape;
}

namespace Textures
{
    enum ID
    {
        Background,
    };
}

namespace Fonts
{
    enum ID
    {
        ARJULIAN,
    };
}

namespace Category
{
    enum Type
    {
        None = 0,
        Scene = 1 << 0,
        Player = 1 << 1,
        Enemy = 1 << 2,
    };
}

template<typename Resource, typename Identifier>
class ResourceHolder;

using TextureHolder = ResourceHolder<sf::Texture, Textures::ID>;
using FontHolder = ResourceHolder<sf::Font, Fonts::ID>;

namespace sfdd
{
    const float SCALE = 32.f;
}

namespace utils
{
    template <typename T>
    void centerOrigin(T obj);
    void centerOrigin(sf::Sprite& sprite);
    void centerOrigin(sf::Text& text);
    void centerOrigin(sf::RectangleShape& rect);
    const char* getKeyName(const sf::Keyboard::Key key);

    //Converts SFML's vector to Box2D's vector and downscales it so it fits Box2D's MKS units
    template <typename T>
    b2Vec2 sfVecToB2Vec(sf::Vector2<T> vector)
    {
        return b2Vec2(vector.x / sfdd::SCALE, vector.y / sfdd::SCALE);
    }

    // Convert Box2D's vector to SFML vector [Default - scales the vector up by SCALE constants amount]
    template <typename T>
    T B2VecToSFVec(const b2Vec2 &vector, bool scaleToPixels = true)
    {
        return T(vector.x * (scaleToPixels ? sfdd::SCALE : 1.f), vector.y * (scaleToPixels ? sfdd::SCALE : 1.f));
    }

}
