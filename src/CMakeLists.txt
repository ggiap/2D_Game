add_library(SOURCE
        core/SystemManager.cpp
        core/SystemManager.hpp
        core/Game.h
        core/Game.cpp
        core/World.cpp
        core/World.h   
        core/MusicPlayer.hpp
        core/MusicPlayer.cpp
        core/SoundEffectPlayer.hpp
        core/SoundEffectPlayer.cpp
        States/State.h
        States/StateStack.h
        States/State.cpp
        States/StateStack.cpp
        States/GameState.h
        States/GameState.cpp    
        States/MenuState.hpp
        States/MenuState.cpp
        States/PauseState.hpp
        States/PauseState.cpp
        States/SplashScreenState.hpp
        States/SplashScreenState.cpp
        Utils/ResourceHolder.h
        Utils/Utility.hpp
        Utils/Utility.cpp
        Utils/Math.hpp
        Utils/Context.hpp
        Utils/SFMLDebugDraw.h
        Utils/SFMLDebugDraw.cpp 
        Utils/QueryCallback.h
        Utils/Animation.cpp
        Utils/AnimatedSprite.h
        Utils/AnimatedSprite.cpp
        Utils/Animation.h
        Utils/ContactListener.cpp
        Utils/ContactListener.hpp
        Utils/RayCastCallback.cpp
        Utils/RayCastCallback.hpp
        Utils/Timer.hpp 
        Utils/Timer.cpp
        Utils/BodyCreator.h
        Utils/FixtureUserData.hpp
        Systems/BaseSystem.hpp
        Systems/BaseSystem.cpp
        Systems/CollisionSystem.hpp
        Systems/CollisionSystem.cpp
        Systems/MoveSystem.cpp
        Systems/MoveSystem.hpp
        Systems/RenderSystem.cpp
        Systems/RenderSystem.hpp
        Systems/AnimationSystem.cpp
        Systems/AnimationSystem.hpp
        Systems/PlayerControllerSystem.hpp
        Systems/PlayerControllerSystem.cpp
        Systems/CameraSystem.cpp
        Systems/CameraSystem.hpp
        Systems/TilemapSystem.cpp
        Systems/TilemapSystem.hpp
        Systems/EnemyControllerSystem.hpp
        Systems/EnemyControllerSystem.cpp
        Components/C_Rigidbody.hpp
        Components/C_Animation.hpp
        Components/C_Tag.h
        Components/C_Raycast.hpp
        Components/C_Camera.hpp
        Components/C_Tilemap.hpp
        Tilemaps/SFMLOrthogonalLayer.hpp)


target_link_libraries(SOURCE sfml-window sfml-system sfml-audio sfml-graphics ${SOURCE})