#pragma once

#include <SFML/Window/Keyboard.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/Graphics/Text.hpp>
#include <SFML/Graphics/RectangleShape.hpp>
#include <SFML/System/Vector2.hpp>
#include <Box2D/Box2D.h>
#include <cassert>
#include <cmath>
#include <entt/entity/registry.hpp>

#include "../Utils/ResourceHolder.h"


// ======= FORWARD DECLARATIONS =======
namespace sf
{
    class Texture;
    class Font;
    class Sprite;
    class Text;
    class RectangleShape;
    class SoundBuffer;
}

template<typename Resource, typename Identifier>
class ResourceHolder;

class AnimatedSprite;

namespace tmx
{
    class Object;
}
// ====================================


namespace BodyCategory
{
    enum ID
    {
        Player = 0x01,
        Enemy = 0x02,
        EnemySensor = 0x04,
        Other = 0x08,
    };
}

namespace Music
{
    enum class ID
    {
        MenuTheme,
        GameTheme,
    };
}

namespace Sounds
{
    enum class ID
    {
        Jump,
        CoinPickup,
        Pause,
    };
}

namespace Textures
{
    enum class ID
    {
        CharactersSpriteSheet,
        MonochromeSpriteSheet,
        Background,
        SplashScreen,
    };
}

namespace Fonts
{
    enum class ID
    {
        ARJULIAN,
    };
}

namespace Category
{
    enum class ID
    {
        None = 0,
        Scene = 1 << 0,
        Player = 1 << 1,
        Enemy = 1 << 2,
    };
}

namespace GameObjectState
{
    enum class ID
    {
        Standing,
        Walking,
        Jumping,
    };
}

namespace Animations
{
    enum class ID
    {
        Standing,
        Walking,
        Jumping,
        EnemyMoving,
    };
}

using TextureHolder = ResourceHolder<sf::Texture, Textures::ID>;
using FontHolder = ResourceHolder<sf::Font, Fonts::ID>;
using SoundBufferHolder = ResourceHolder<sf::SoundBuffer, Sounds::ID>;

namespace utils
{
    void centerOrigin(sf::Sprite& sprite);
    void centerOrigin(sf::Text& text);
    void centerOrigin(sf::RectangleShape& rect);
    void centerOrigin(sf::Shape& rect);
    void centerOrigin(AnimatedSprite& animatedSprite);
    tmx::Object getObjectByName(entt::registry &reg, const std::string& layerName, const std::string& name);
    std::vector<tmx::Object> getObjectsByName(entt::registry &reg, const std::string& layerName, const std::string& substr);
    const char* getKeyName(const sf::Keyboard::Key key);

    // Box2D to SFML space conversion constant
    const auto PIXELS_PER_METERS = 32.f;

    //Converts SFML's vector to Box2D's vector and downscales it so it fits Box2D's MKS units
    b2Vec2 sfVecToB2Vec(const float x, const float y);
    
    template <typename T>
    b2Vec2 sfVecToB2Vec(sf::Vector2<T> vector)
    {
        return b2Vec2(vector.x / PIXELS_PER_METERS, vector.y / PIXELS_PER_METERS);
    }

    // Convert Box2D's vector to SFML vector [Default - scales the vector up by PIXELS_PER_METERS constants amount]
    template <typename T>
    T B2VecToSFVec(const b2Vec2 &vector, bool scaleToPixels = true)
    {
        return T(vector.x * (scaleToPixels ? PIXELS_PER_METERS : 1.f), vector.y * (scaleToPixels ? PIXELS_PER_METERS : 1.f));
    }
}
