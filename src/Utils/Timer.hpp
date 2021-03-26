#pragma once

#include <SFML/System/Time.hpp>

class Timer
{
public:
	Timer() = default;
	Timer(const sf::Time& seconds);

	void start();
	void update(const sf::Time &dt);
	void stop();
	float getRemainingTime();
	void setTimer(const sf::Time &amount);
	void addTime(const sf::Time &amount);
	void reset();
	bool isRunning();

private:
	bool isActive{ false };
	sf::Time seconds{};
	sf::Time remainingTime{};
};