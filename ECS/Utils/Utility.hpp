#ifndef UTILITY
#define UTILITY

#include <SFML/System/Vector2.hpp>
#include <cassert>

namespace utils
{
	constexpr const double PI = 3.141592653589793238462643383;

	template <typename T>
	T dotProduct(const sf::Vector2<T>& v1, const sf::Vector2<T>& v2)
	{
		return v1.x * v2.x + v1.y * v2.y;
	}

	template <typename T>
	T crossProduct(const sf::Vector2<T>& v1, const sf::Vector2<T>& v2)
	{
		return v1.x * v2.y - v1.y * v2.x;
	}

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
}

#endif // UTILITY
