//
// Created by george on 4/7/20.
//

#include "AnimationSystem.hpp"
#include "../Components/C_Animation.hpp"
#include "../Utils//Context.hpp"

AnimationSystem::AnimationSystem(Context& context) :
BaseSystem(context)
{

}

void AnimationSystem::update(sf::Time& dt)
{
    m_Context->registry->view<C_Animation>().each([&](auto entity, auto& anim)
    {
        anim.animatedSprite.update(dt);
    });
}
