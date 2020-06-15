add_library(SOURCE
            src/Entity.hpp
            src/Entity.cpp
            src/EntityManager.cpp
            src/EntityManager.hpp
            Components/C_Position.hpp
            Components/C_Velocity.hpp
            Components/C_Shape.hpp
            Systems/BaseSystem.hpp
            Systems/BaseSystem.cpp
            Utils/Utility.hpp
            )

target_link_libraries(SOURCE ${SOURCE})