#pragma once
#include <unordered_map>
#include <SFML/Graphics/RenderTarget.hpp>
#include <SFML/System/Time.hpp>
#include <SFML/Graphics/Drawable.hpp>
#include <SFML/Graphics/Transformable.hpp>
#include <SFML/Graphics/Sprite.hpp>
#include <SFML/System/Vector2.hpp>

#include "Animation.h"
#include "../Utils/Utility.hpp"

class AnimatedSprite : public sf::Drawable, public sf::Transformable
{
public:
	explicit AnimatedSprite(sf::Time frameTime = sf::seconds(0.2f), bool paused = false, bool looped = true);

	void update(sf::Time deltaTime);
	void setAnimation(const Animations::ID id);
	void setFrameTime(sf::Time time);
	void addAnimation(Animations::ID id, Animation* animation);
	void play();
	void play(const Animations::ID id);
	void pause();
	void stop();
	void setLooped(bool looped);
	void setColor(const sf::Color& color);
	const Animation* getAnimation() const;
	sf::FloatRect getLocalBounds() const;
	sf::FloatRect getGlobalBounds() const;
	bool isLooped() const;
	bool isPlaying() const;
	sf::Time getFrameTime() const;
	void setFrame(std::size_t newFrame, bool resetTime = true);

private:
    std::unordered_map<Animations::ID, Animation*> animations;
	const Animation* m_animation;
	sf::Time m_frameTime;
	sf::Time m_currentTime;
	std::size_t m_currentFrame;
	bool m_isPaused;
	bool m_isLooped;
	sf::Sprite m_Sprite;

	void draw(sf::RenderTarget& target, sf::RenderStates states) const override;
};