//
// Created by george on 3/8/20.
//

#ifndef ENTITY_COMPONENT_SYSTEM_CAMERASYSTEM_HPP
#define ENTITY_COMPONENT_SYSTEM_CAMERASYSTEM_HPP

#include "BaseSystem.hpp"

namespace sf
{
    class View;
    template<typename T>
    class Vector2;
}
struct C_Camera;

class CameraSystem : public BaseSystem
{
public:
    CameraSystem() = default;
    explicit CameraSystem(Context& context, World* world);

    void update(sf::Time& dt) override;
    void handleEvents(const sf::Event& event) override;

private:
    void cameraPanning();
    void zoomViewAt(sf::Vector2<int> pixel, float zoom);
    void resetView();

    bool freeRoaming{false};
};


#endif //ENTITY_COMPONENT_SYSTEM_CAMERASYSTEM_HPP
