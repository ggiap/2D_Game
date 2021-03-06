cmake_minimum_required(VERSION 3.16)

project("2D_Game" CXX)

set(CMAKE_MODULE_PATH
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
         ${CMAKE_MODULE_PATH})

# Download automatically, you can also just copy the conan.cmake file
if(NOT EXISTS "${CMAKE_MODULE_PATH}/conan.cmake")
    message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
            "${CMAKE_MODULE_PATH}/conan.cmake")
endif()

include(${CMAKE_MODULE_PATH}/conan.cmake)

conan_cmake_run(REQUIRES
        box2d/2.3.2.ef96a4f@conan/stable
        entt/3.4.0
        spdlog/1.5.0
        IMPORTS "bin, *.dll -> ./bin"
        IMPORTS "lib, *.dylib* -> ./bin"
        BASIC_SETUP
        BUILD missing)

# Link this 'library' to use the standard warnings
add_library(project_warnings INTERFACE)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)

set(CMAKE_CXX_STANDARD 17)
# Don't add this line if you will try_compile with boost.
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add MSVC compiler options
if (MSVC)
    if (NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        # remove default warning level from CMAKE_CXX_FLAGS
        string (REGEX REPLACE "/W[0-4]" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
        add_compile_options(/W0 /WX "/permissive-") #/Za produces an error
    endif()
else()
    target_compile_options(project_warnings
            INTERFACE -Wall
            #-Werror # treat all warnings as errors
            -Wextra # reasonable and standard
            -Wshadow # warn the user if a variable
            # declaration shadows one from a
            # parent context
            -Wnon-virtual-dtor # warn the user if a class
            # with virtual functions
            # has a non-virtual
            # destructor. This helps
            # catch hard to track down
            # memory errors
            #-Wold-style-cast # warn for c-style casts
            -Wcast-align # warn for potential performance
            # problem casts
            -Wunused # warn on anything being unused
            -Woverloaded-virtual # warn if you overload
            # (not override) a
            # virtual function
            -Wpedantic # warn if non-standard C++ is used
            -Wconversion # warn on type conversions that
            # may lose data
            #-Wsign-conversion # warn on sign conversions
            -Wnull-dereference # warn if a null
            # dereference is detected
            -Wdouble-promotion # warn if float is
            # implicit promoted to
            # double
            -Wformat=2 # warn on security issues around
            # functions that format output (ie
            # printf)
            )

    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        target_compile_options(project_warnings
                INTERFACE -Wmisleading-indentation # warn if
                # identation
                # implies blocks
                # where blocks do
                # not exist
                -Wduplicated-cond # warn if if / else chain
                # has duplicated
                # conditions
                -Wduplicated-branches # warn if if / else
                # branches have
                # duplicated code
                -Wlogical-op # warn about logical
                # operations being used where
                # bitwise were probably wanted
                #-Wuseless-cast # warn if you perform a cast
                # to the same type
                )
        target_link_libraries(project_options INTERFACE stdc++fs)
    else()
        if(LIBCPP)
            target_compile_options(project_options INTERFACE -stdlib=libc++)
        else()
            target_link_libraries(project_options INTERFACE stdc++fs)
        endif()
    endif()
endif (MSVC)

set(BUILD_SHARED_LIBS false)
include_directories(${CMAKE_SOURCE_DIR} src)
include_directories(${CMAKE_SOURCE_DIR} src/core)
include_directories(${CMAKE_SOURCE_DIR} src/Components)
include_directories(${CMAKE_SOURCE_DIR} src/Systems)
include_directories(${CMAKE_SOURCE_DIR} src/States)
include_directories(${CMAKE_SOURCE_DIR} src/utils)
include_directories(${CMAKE_SOURCE_DIR} extlib/tmxlite/tmxlite/include)
include_directories(${CMAKE_SOURCE_DIR} extlib/sfml/include)
add_subdirectory(extlib/tmxlite/tmxlite)
add_subdirectory(extlib/sfml)
add_subdirectory(src)

add_executable(${CMAKE_PROJECT_NAME} src/main.cpp)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE project_options project_warnings SOURCE ${CONAN_LIBS} sfml-window sfml-system sfml-audio sfml-graphics tmxlite)

add_custom_command(
        TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/src/res
        ${CMAKE_CURRENT_BINARY_DIR}/res)

add_custom_command(
    TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/extlib/sfml/extlibs/bin/x64/openal32.dll
    ${CMAKE_CURRENT_BINARY_DIR}/bin)
