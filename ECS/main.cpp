//
// Created by georg on 04-Jun-20.
//
#include "spdlog/spdlog.h"

int main()
{
    spdlog::info("Hello, {}!", "World");
    fmt::print("Hello, from {}\n", "{fmt}");

    return 0;
}