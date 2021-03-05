//
// Created by george on 4/7/20.
//

#include "AnimationSystem.hpp"
#include "../Components/C_Animation.hpp"
#include "../Utils//Context.hpp"
#include "../core/World.h"

AnimationSystem::AnimationSystem(Context& context, World *world) :
BaseSystem(context, world)
{

}

void AnimationSystem::update(sf::Time& dt)
{
    auto view = m_World->getEntityRegistry()->view<C_Animation>();

    for (auto& entity : view)
    {
        auto& animComp = m_World->getEntityRegistry()->get<C_Animation>(entity);

        animComp.animatedSprite.update(dt);
    }
}
