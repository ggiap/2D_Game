#pragma once
#include <chrono>

class Timer
{
public:
	using clock_t = std::chrono::high_resolution_clock;

	Timer() = default;

	void start()
	{
		start_time = clock_t::now();
	}

	auto elapsedMilliseconds() const
	{
		return std::chrono::duration_cast<std::chrono::milliseconds>(clock_t::now() - start_time).count();
	}

	auto elapsedSeconds() const
	{
		return std::chrono::duration_cast<std::chrono::seconds>(clock_t::now() - start_time).count();
	}

	void reset()
	{
		start_time = clock_t::now();
	}

private:
	clock_t::time_point start_time{};
};
