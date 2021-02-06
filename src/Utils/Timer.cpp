#include "Timer.hpp"

Timer::Timer(const sf::Time& seconds) : seconds(seconds), remainingTime(seconds)
{
	
}

void Timer::start()
{
	isActive = true;
}

void Timer::update(const sf::Time& dt)
{
	if (isActive)
	{
		remainingTime -= dt;

		if (remainingTime.asSeconds() <= 0)
			isActive = false;
	}
}

void Timer::stop()
{
	isActive = false;
}

float Timer::getRemainingTime()
{
	return remainingTime.asSeconds();
}

void Timer::setTimer(const sf::Time& amount)
{
	seconds = amount;
	remainingTime = seconds;
}

void Timer::addTime(const sf::Time& amount)
{
	remainingTime += amount;
}

void Timer::reset()
{
	remainingTime = seconds;
}

bool Timer::isRunning()
{
	return isActive;
}