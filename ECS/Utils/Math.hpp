#pragma once

#include <cmath>
#include <SFML/System/Vector2.hpp>

namespace math
{
    constexpr const double PI = 3.141592653589793238462643383;

    template <typename T>
    T dotProduct(const sf::Vector2<T>& v, const sf::Vector2<T>& u)
    {
        return v.x * u.x + v.y * u.y;
    }

    /*template <typename T>
    T crossProduct(const sf::Vector2<T>& v, const sf::Vector2<T>& u)
    {
        return v.x * u.y - v.y * u.x;
    }*/

    template <typename T>
    T magnitude(const sf::Vector2<T>& v)
    {
        return std::sqrt(dotProduct(v, v));
    }

    template <typename T>
    T squaredLength(const sf::Vector2<T>& v)
    {
        return dotProduct(v, v);
    }

    template <typename T>
    T distance(const sf::Vector2<T>& v, const sf::Vector2<T>& u)
    {
        return magnitude(v - u);
    }

    template <typename T>
    sf::Vector2<T> normalize(const sf::Vector2<T>& v)
    {
        assert(v != sf::Vector2<T>());
        return v / magnitude(v);
    }

    template <typename T>
    T radToDeg(T radians)
    {
        return (180 / PI) * radians;
    }

    template <typename T>
    T degToRad(T deegres)
    {
        return (PI / 180) * deegres;
    }

    template <typename T>
    T lerp(const T& v0, const T& v1, float t)
    {
        return (1 - t) * v0 + t * v1;
    }
}