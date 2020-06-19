#pragma once

#include <SFML/Window/Keyboard.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/Graphics/Text.hpp>
#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/System/Vector2.hpp>
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
    typedef enum
    {

    }ID;
}

namespace Fonts
{
    typedef enum
    {
        ARJULIAN,
    }ID;
}

namespace Category
{
    typedef enum
    {
        None = 0,
        Scene = 1 << 0,
        Player = 1 << 1,
        Enemy = 1 << 2,
    }type;
}

template<typename Resource, typename Identifier>
class ResourceHolder;

using TextureHolder = ResourceHolder<sf::Texture, Textures::ID>;
using FontHolder = ResourceHolder<sf::Font, Fonts::ID>;

namespace utils
{
    template <typename T>
    void centerOrigin(T obj);
    void centerOrigin(sf::Sprite& sprite);
    void centerOrigin(sf::Text& text);
    void centerOrigin(sf::RectangleShape& rect);
    const char* getKeyName(const sf::Keyboard::Key key);
}
