#ifndef C_SHAPE
#define C_SHAPE

#include <SFML/Graphics.hpp>

struct shape : public sf::Drawable, public sf::Transformable
{
    shape() = default;
    shape(const sf::RectangleShape& rect, const sf::Vector2f& s) : rectangle(rect), size(s) 
    {
        rectangle.setSize(size);
        rectangle.setOutlineColor(sf::Color::White);
    }

    sf::RectangleShape rectangle;
    sf::Vector2f size;

private:
    void draw(sf::RenderTarget& target, sf::RenderStates states) const
    {
        states.transform *= getTransform();

        target.draw(rectangle, states);
    }
};

#endif