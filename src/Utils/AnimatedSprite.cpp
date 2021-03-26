#include "AnimatedSprite.h"

#include <utility>
#include <spdlog/spdlog.h>

AnimatedSprite::AnimatedSprite(sf::Time frameTime, bool paused, bool looped) :
animations(),m_animation(nullptr), m_frameTime(frameTime),
m_currentFrame(0), m_isPaused(paused), m_isLooped(looped),
m_Sprite()
{

}

void AnimatedSprite::setAnimation(const Animations::ID id)
{
    m_animation = animations[id];
    m_Sprite.setTexture(*m_animation->getSpriteSheet());
    m_currentFrame = 0;
    setFrame(m_currentFrame);
}

void AnimatedSprite::setFrameTime(sf::Time time)
{
	m_frameTime = time;
}
void AnimatedSprite::addAnimation(Animations::ID id, Animation *animation)
{
    animations[id] = animation;
}

void AnimatedSprite::play()
{
	m_isPaused = false;
}

void AnimatedSprite::play(const Animations::ID id)
{
	if (getAnimation() != animations[id])
    {
        setAnimation(id);
    }
	play();
}

void AnimatedSprite::pause()
{
	m_isPaused = true;
}

void AnimatedSprite::stop()
{
	m_isPaused = true;
	m_currentFrame = 0;
	setFrame(m_currentFrame);
}

void AnimatedSprite::setLooped(bool looped)
{
	m_isLooped = looped;
}

void AnimatedSprite::setColor(const sf::Color& color)
{
	m_Sprite.setColor(color);
}

const Animation* AnimatedSprite::getAnimation() const
{
	return m_animation;
}

sf::FloatRect AnimatedSprite::getLocalBounds() const
{
	return m_Sprite.getLocalBounds();
}

sf::FloatRect AnimatedSprite::getGlobalBounds() const
{
	return m_Sprite.getGlobalBounds();
}

bool AnimatedSprite::isLooped() const
{
	return m_isLooped;
}

bool AnimatedSprite::isPlaying() const
{
	return !m_isPaused;
}

sf::Time AnimatedSprite::getFrameTime() const
{
	return m_frameTime;
}

void AnimatedSprite::setFrame(std::size_t newFrame, bool resetTime)
{
	if (m_animation)
	{
		sf::IntRect rect = m_animation->getFrame(newFrame);
		m_Sprite.setTextureRect(rect);
	}

	if (resetTime)
		m_currentTime = sf::Time::Zero;
}

void AnimatedSprite::update(sf::Time deltaTime)
{
	// if not paused and we have a valid animation
	if (!m_isPaused && m_animation)
	{
		// add delta time
		m_currentTime += deltaTime;

		// if current time is bigger then the frame time advance one frame
		if (m_currentTime >= m_frameTime)
		{
			// reset time, but keep the remainder
			m_currentTime = sf::microseconds(m_currentTime.asMicroseconds() % m_frameTime.asMicroseconds());

			// get next Frame index
			if (m_currentFrame + 1 < m_animation->getSize())
				m_currentFrame++;
			else
			{
				// animation has ended
				m_currentFrame = 0; // reset to start

				if (!m_isLooped)
				{
					m_isPaused = true;
				}

			}

			// set the current frame, not reseting the time
			setFrame(m_currentFrame, false);
		}
	}
}

void AnimatedSprite::draw(sf::RenderTarget& target, sf::RenderStates states) const
{
	if (m_animation)
	{
		states.transform *= getTransform();
		target.draw(m_Sprite, states);
	}
}