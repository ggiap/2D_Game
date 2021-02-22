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
    m_World->getEntityRegistry()->view<C_Animation>().each([&](auto entity, auto& anim)
    {
        anim.animatedSprite.update(dt);
    });
}
