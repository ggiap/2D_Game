include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS SUFFIX)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            endif()
        endif()
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAME ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS${SUFFIX}}")
            endif()
        endforeach()
    endif()
endmacro()


#################
###  BOX2D
#################
set(CONAN_BOX2D_ROOT "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d")
set(CONAN_INCLUDE_DIRS_BOX2D "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/include")
set(CONAN_LIB_DIRS_BOX2D "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/lib")
set(CONAN_BIN_DIRS_BOX2D )
set(CONAN_RES_DIRS_BOX2D )
set(CONAN_SRC_DIRS_BOX2D )
set(CONAN_BUILD_DIRS_BOX2D "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/")
set(CONAN_FRAMEWORK_DIRS_BOX2D )
set(CONAN_LIBS_BOX2D Box2D)
set(CONAN_PKG_LIBS_BOX2D Box2D)
set(CONAN_SYSTEM_LIBS_BOX2D )
set(CONAN_FRAMEWORKS_BOX2D )
set(CONAN_FRAMEWORKS_FOUND_BOX2D "")  # Will be filled later
set(CONAN_DEFINES_BOX2D )
set(CONAN_BUILD_MODULES_PATHS_BOX2D )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BOX2D )

set(CONAN_C_FLAGS_BOX2D "")
set(CONAN_CXX_FLAGS_BOX2D "")
set(CONAN_SHARED_LINKER_FLAGS_BOX2D "")
set(CONAN_EXE_LINKER_FLAGS_BOX2D "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BOX2D_LIST "")
set(CONAN_CXX_FLAGS_BOX2D_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BOX2D_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BOX2D_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BOX2D "${CONAN_FRAMEWORKS_BOX2D}" "_BOX2D")
# Append to aggregated values variable
set(CONAN_LIBS_BOX2D ${CONAN_PKG_LIBS_BOX2D} ${CONAN_SYSTEM_LIBS_BOX2D} ${CONAN_FRAMEWORKS_FOUND_BOX2D})


#################
###  SFML
#################
set(CONAN_SFML_ROOT "/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf")
set(CONAN_INCLUDE_DIRS_SFML "/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/include")
set(CONAN_LIB_DIRS_SFML "/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/lib")
set(CONAN_BIN_DIRS_SFML )
set(CONAN_RES_DIRS_SFML )
set(CONAN_SRC_DIRS_SFML )
set(CONAN_BUILD_DIRS_SFML "/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/")
set(CONAN_FRAMEWORK_DIRS_SFML )
set(CONAN_LIBS_SFML sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_PKG_LIBS_SFML sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_SYSTEM_LIBS_SFML pthread udev)
set(CONAN_FRAMEWORKS_SFML )
set(CONAN_FRAMEWORKS_FOUND_SFML "")  # Will be filled later
set(CONAN_DEFINES_SFML "-DSFML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_SFML )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SFML "SFML_STATIC")

set(CONAN_C_FLAGS_SFML "")
set(CONAN_CXX_FLAGS_SFML "")
set(CONAN_SHARED_LINKER_FLAGS_SFML "")
set(CONAN_EXE_LINKER_FLAGS_SFML "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SFML_LIST "")
set(CONAN_CXX_FLAGS_SFML_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SFML_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SFML_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SFML "${CONAN_FRAMEWORKS_SFML}" "_SFML")
# Append to aggregated values variable
set(CONAN_LIBS_SFML ${CONAN_PKG_LIBS_SFML} ${CONAN_SYSTEM_LIBS_SFML} ${CONAN_FRAMEWORKS_FOUND_SFML})


#################
###  ENTT
#################
set(CONAN_ENTT_ROOT "/home/george/.conan/data/entt/3.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_ENTT "/home/george/.conan/data/entt/3.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_ENTT )
set(CONAN_BIN_DIRS_ENTT )
set(CONAN_RES_DIRS_ENTT )
set(CONAN_SRC_DIRS_ENTT )
set(CONAN_BUILD_DIRS_ENTT "/home/george/.conan/data/entt/3.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_ENTT )
set(CONAN_LIBS_ENTT )
set(CONAN_PKG_LIBS_ENTT )
set(CONAN_SYSTEM_LIBS_ENTT )
set(CONAN_FRAMEWORKS_ENTT )
set(CONAN_FRAMEWORKS_FOUND_ENTT "")  # Will be filled later
set(CONAN_DEFINES_ENTT )
set(CONAN_BUILD_MODULES_PATHS_ENTT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ENTT )

set(CONAN_C_FLAGS_ENTT "")
set(CONAN_CXX_FLAGS_ENTT "")
set(CONAN_SHARED_LINKER_FLAGS_ENTT "")
set(CONAN_EXE_LINKER_FLAGS_ENTT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ENTT_LIST "")
set(CONAN_CXX_FLAGS_ENTT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ENTT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ENTT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ENTT "${CONAN_FRAMEWORKS_ENTT}" "_ENTT")
# Append to aggregated values variable
set(CONAN_LIBS_ENTT ${CONAN_PKG_LIBS_ENTT} ${CONAN_SYSTEM_LIBS_ENTT} ${CONAN_FRAMEWORKS_FOUND_ENTT})


#################
###  SPDLOG
#################
set(CONAN_SPDLOG_ROOT "/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3")
set(CONAN_INCLUDE_DIRS_SPDLOG "/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/include")
set(CONAN_LIB_DIRS_SPDLOG "/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/lib")
set(CONAN_BIN_DIRS_SPDLOG )
set(CONAN_RES_DIRS_SPDLOG )
set(CONAN_SRC_DIRS_SPDLOG )
set(CONAN_BUILD_DIRS_SPDLOG "/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/")
set(CONAN_FRAMEWORK_DIRS_SPDLOG )
set(CONAN_LIBS_SPDLOG spdlog)
set(CONAN_PKG_LIBS_SPDLOG spdlog)
set(CONAN_SYSTEM_LIBS_SPDLOG pthread)
set(CONAN_FRAMEWORKS_SPDLOG )
set(CONAN_FRAMEWORKS_FOUND_SPDLOG "")  # Will be filled later
set(CONAN_DEFINES_SPDLOG "-DSPDLOG_COMPILED_LIB"
			"-DSPDLOG_FMT_EXTERNAL")
set(CONAN_BUILD_MODULES_PATHS_SPDLOG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SPDLOG "SPDLOG_COMPILED_LIB"
			"SPDLOG_FMT_EXTERNAL")

set(CONAN_C_FLAGS_SPDLOG "")
set(CONAN_CXX_FLAGS_SPDLOG "")
set(CONAN_SHARED_LINKER_FLAGS_SPDLOG "")
set(CONAN_EXE_LINKER_FLAGS_SPDLOG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SPDLOG_LIST "")
set(CONAN_CXX_FLAGS_SPDLOG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SPDLOG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SPDLOG "${CONAN_FRAMEWORKS_SPDLOG}" "_SPDLOG")
# Append to aggregated values variable
set(CONAN_LIBS_SPDLOG ${CONAN_PKG_LIBS_SPDLOG} ${CONAN_SYSTEM_LIBS_SPDLOG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG})


#################
###  FREETYPE
#################
set(CONAN_FREETYPE_ROOT "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610")
set(CONAN_INCLUDE_DIRS_FREETYPE "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/include"
			"/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/include/freetype2")
set(CONAN_LIB_DIRS_FREETYPE "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/lib")
set(CONAN_BIN_DIRS_FREETYPE "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/bin")
set(CONAN_RES_DIRS_FREETYPE )
set(CONAN_SRC_DIRS_FREETYPE )
set(CONAN_BUILD_DIRS_FREETYPE "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/")
set(CONAN_FRAMEWORK_DIRS_FREETYPE )
set(CONAN_LIBS_FREETYPE freetype)
set(CONAN_PKG_LIBS_FREETYPE freetype)
set(CONAN_SYSTEM_LIBS_FREETYPE m)
set(CONAN_FRAMEWORKS_FREETYPE )
set(CONAN_FRAMEWORKS_FOUND_FREETYPE "")  # Will be filled later
set(CONAN_DEFINES_FREETYPE )
set(CONAN_BUILD_MODULES_PATHS_FREETYPE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FREETYPE )

set(CONAN_C_FLAGS_FREETYPE "")
set(CONAN_CXX_FLAGS_FREETYPE "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FREETYPE_LIST "")
set(CONAN_CXX_FLAGS_FREETYPE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FREETYPE "${CONAN_FRAMEWORKS_FREETYPE}" "_FREETYPE")
# Append to aggregated values variable
set(CONAN_LIBS_FREETYPE ${CONAN_PKG_LIBS_FREETYPE} ${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE})


#################
###  STB
#################
set(CONAN_STB_ROOT "/home/george/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_STB "/home/george/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_STB )
set(CONAN_BIN_DIRS_STB )
set(CONAN_RES_DIRS_STB )
set(CONAN_SRC_DIRS_STB )
set(CONAN_BUILD_DIRS_STB "/home/george/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_STB )
set(CONAN_LIBS_STB )
set(CONAN_PKG_LIBS_STB )
set(CONAN_SYSTEM_LIBS_STB )
set(CONAN_FRAMEWORKS_STB )
set(CONAN_FRAMEWORKS_FOUND_STB "")  # Will be filled later
set(CONAN_DEFINES_STB "-DSTB_TEXTEDIT_KEYTYPE=unsigned")
set(CONAN_BUILD_MODULES_PATHS_STB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_STB "STB_TEXTEDIT_KEYTYPE=unsigned")

set(CONAN_C_FLAGS_STB "")
set(CONAN_CXX_FLAGS_STB "")
set(CONAN_SHARED_LINKER_FLAGS_STB "")
set(CONAN_EXE_LINKER_FLAGS_STB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_STB_LIST "")
set(CONAN_CXX_FLAGS_STB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_STB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_STB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_STB "${CONAN_FRAMEWORKS_STB}" "_STB")
# Append to aggregated values variable
set(CONAN_LIBS_STB ${CONAN_PKG_LIBS_STB} ${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB})


#################
###  OPENAL
#################
set(CONAN_OPENAL_ROOT "/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8")
set(CONAN_INCLUDE_DIRS_OPENAL "/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/include"
			"/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/include/AL")
set(CONAN_LIB_DIRS_OPENAL "/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/lib")
set(CONAN_BIN_DIRS_OPENAL )
set(CONAN_RES_DIRS_OPENAL )
set(CONAN_SRC_DIRS_OPENAL )
set(CONAN_BUILD_DIRS_OPENAL "/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/")
set(CONAN_FRAMEWORK_DIRS_OPENAL )
set(CONAN_LIBS_OPENAL openal)
set(CONAN_PKG_LIBS_OPENAL openal)
set(CONAN_SYSTEM_LIBS_OPENAL dl m)
set(CONAN_FRAMEWORKS_OPENAL )
set(CONAN_FRAMEWORKS_FOUND_OPENAL "")  # Will be filled later
set(CONAN_DEFINES_OPENAL "-DAL_LIBTYPE_STATIC")
set(CONAN_BUILD_MODULES_PATHS_OPENAL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENAL "AL_LIBTYPE_STATIC")

set(CONAN_C_FLAGS_OPENAL "")
set(CONAN_CXX_FLAGS_OPENAL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENAL_LIST "")
set(CONAN_CXX_FLAGS_OPENAL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENAL "${CONAN_FRAMEWORKS_OPENAL}" "_OPENAL")
# Append to aggregated values variable
set(CONAN_LIBS_OPENAL ${CONAN_PKG_LIBS_OPENAL} ${CONAN_SYSTEM_LIBS_OPENAL} ${CONAN_FRAMEWORKS_FOUND_OPENAL})


#################
###  FLAC
#################
set(CONAN_FLAC_ROOT "/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1")
set(CONAN_INCLUDE_DIRS_FLAC "/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/include")
set(CONAN_LIB_DIRS_FLAC "/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/lib")
set(CONAN_BIN_DIRS_FLAC "/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/bin")
set(CONAN_RES_DIRS_FLAC )
set(CONAN_SRC_DIRS_FLAC )
set(CONAN_BUILD_DIRS_FLAC "/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/")
set(CONAN_FRAMEWORK_DIRS_FLAC )
set(CONAN_LIBS_FLAC FLAC++ FLAC)
set(CONAN_PKG_LIBS_FLAC FLAC++ FLAC)
set(CONAN_SYSTEM_LIBS_FLAC m)
set(CONAN_FRAMEWORKS_FLAC )
set(CONAN_FRAMEWORKS_FOUND_FLAC "")  # Will be filled later
set(CONAN_DEFINES_FLAC "-DFLAC__NO_DLL")
set(CONAN_BUILD_MODULES_PATHS_FLAC )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FLAC "FLAC__NO_DLL")

set(CONAN_C_FLAGS_FLAC "")
set(CONAN_CXX_FLAGS_FLAC "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC "")
set(CONAN_EXE_LINKER_FLAGS_FLAC "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FLAC_LIST "")
set(CONAN_CXX_FLAGS_FLAC_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FLAC_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FLAC "${CONAN_FRAMEWORKS_FLAC}" "_FLAC")
# Append to aggregated values variable
set(CONAN_LIBS_FLAC ${CONAN_PKG_LIBS_FLAC} ${CONAN_SYSTEM_LIBS_FLAC} ${CONAN_FRAMEWORKS_FOUND_FLAC})


#################
###  VORBIS
#################
set(CONAN_VORBIS_ROOT "/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da")
set(CONAN_INCLUDE_DIRS_VORBIS "/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/include")
set(CONAN_LIB_DIRS_VORBIS "/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/lib")
set(CONAN_BIN_DIRS_VORBIS )
set(CONAN_RES_DIRS_VORBIS )
set(CONAN_SRC_DIRS_VORBIS )
set(CONAN_BUILD_DIRS_VORBIS "/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/")
set(CONAN_FRAMEWORK_DIRS_VORBIS )
set(CONAN_LIBS_VORBIS vorbisfile vorbisenc vorbis)
set(CONAN_PKG_LIBS_VORBIS vorbisfile vorbisenc vorbis)
set(CONAN_SYSTEM_LIBS_VORBIS m)
set(CONAN_FRAMEWORKS_VORBIS )
set(CONAN_FRAMEWORKS_FOUND_VORBIS "")  # Will be filled later
set(CONAN_DEFINES_VORBIS )
set(CONAN_BUILD_MODULES_PATHS_VORBIS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VORBIS )

set(CONAN_C_FLAGS_VORBIS "")
set(CONAN_CXX_FLAGS_VORBIS "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VORBIS_LIST "")
set(CONAN_CXX_FLAGS_VORBIS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VORBIS "${CONAN_FRAMEWORKS_VORBIS}" "_VORBIS")
# Append to aggregated values variable
set(CONAN_LIBS_VORBIS ${CONAN_PKG_LIBS_VORBIS} ${CONAN_SYSTEM_LIBS_VORBIS} ${CONAN_FRAMEWORKS_FOUND_VORBIS})


#################
###  LIBXRANDR
#################
set(CONAN_LIBXRANDR_ROOT "/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e")
set(CONAN_INCLUDE_DIRS_LIBXRANDR "/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/include")
set(CONAN_LIB_DIRS_LIBXRANDR "/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/lib")
set(CONAN_BIN_DIRS_LIBXRANDR )
set(CONAN_RES_DIRS_LIBXRANDR )
set(CONAN_SRC_DIRS_LIBXRANDR )
set(CONAN_BUILD_DIRS_LIBXRANDR "/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/"
			"/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXRANDR )
set(CONAN_LIBS_LIBXRANDR Xrandr)
set(CONAN_PKG_LIBS_LIBXRANDR Xrandr)
set(CONAN_SYSTEM_LIBS_LIBXRANDR )
set(CONAN_FRAMEWORKS_LIBXRANDR )
set(CONAN_FRAMEWORKS_FOUND_LIBXRANDR "")  # Will be filled later
set(CONAN_DEFINES_LIBXRANDR )
set(CONAN_BUILD_MODULES_PATHS_LIBXRANDR )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXRANDR )

set(CONAN_C_FLAGS_LIBXRANDR "")
set(CONAN_CXX_FLAGS_LIBXRANDR "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXRANDR "")
set(CONAN_EXE_LINKER_FLAGS_LIBXRANDR "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXRANDR_LIST "")
set(CONAN_CXX_FLAGS_LIBXRANDR_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXRANDR_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXRANDR "${CONAN_FRAMEWORKS_LIBXRANDR}" "_LIBXRANDR")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXRANDR ${CONAN_PKG_LIBS_LIBXRANDR} ${CONAN_SYSTEM_LIBS_LIBXRANDR} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR})


#################
###  OPENGL
#################
set(CONAN_OPENGL_ROOT "/home/george/.conan/data/opengl/virtual/bincrafters/stable/package/25315d66e1f567146d60eadc7d8fc22e5398fdaf")
set(CONAN_INCLUDE_DIRS_OPENGL )
set(CONAN_LIB_DIRS_OPENGL )
set(CONAN_BIN_DIRS_OPENGL )
set(CONAN_RES_DIRS_OPENGL )
set(CONAN_SRC_DIRS_OPENGL )
set(CONAN_BUILD_DIRS_OPENGL "/home/george/.conan/data/opengl/virtual/bincrafters/stable/package/25315d66e1f567146d60eadc7d8fc22e5398fdaf/")
set(CONAN_FRAMEWORK_DIRS_OPENGL )
set(CONAN_LIBS_OPENGL )
set(CONAN_PKG_LIBS_OPENGL )
set(CONAN_SYSTEM_LIBS_OPENGL GL)
set(CONAN_FRAMEWORKS_OPENGL )
set(CONAN_FRAMEWORKS_FOUND_OPENGL "")  # Will be filled later
set(CONAN_DEFINES_OPENGL )
set(CONAN_BUILD_MODULES_PATHS_OPENGL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENGL )

set(CONAN_C_FLAGS_OPENGL "")
set(CONAN_CXX_FLAGS_OPENGL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENGL_LIST "")
set(CONAN_CXX_FLAGS_OPENGL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENGL "${CONAN_FRAMEWORKS_OPENGL}" "_OPENGL")
# Append to aggregated values variable
set(CONAN_LIBS_OPENGL ${CONAN_PKG_LIBS_OPENGL} ${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL})


#################
###  FMT
#################
set(CONAN_FMT_ROOT "/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d")
set(CONAN_INCLUDE_DIRS_FMT "/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/include")
set(CONAN_LIB_DIRS_FMT "/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/lib")
set(CONAN_BIN_DIRS_FMT )
set(CONAN_RES_DIRS_FMT )
set(CONAN_SRC_DIRS_FMT )
set(CONAN_BUILD_DIRS_FMT "/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/")
set(CONAN_FRAMEWORK_DIRS_FMT )
set(CONAN_LIBS_FMT fmt)
set(CONAN_PKG_LIBS_FMT fmt)
set(CONAN_SYSTEM_LIBS_FMT )
set(CONAN_FRAMEWORKS_FMT )
set(CONAN_FRAMEWORKS_FOUND_FMT "")  # Will be filled later
set(CONAN_DEFINES_FMT )
set(CONAN_BUILD_MODULES_PATHS_FMT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FMT )

set(CONAN_C_FLAGS_FMT "")
set(CONAN_CXX_FLAGS_FMT "")
set(CONAN_SHARED_LINKER_FLAGS_FMT "")
set(CONAN_EXE_LINKER_FLAGS_FMT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FMT_LIST "")
set(CONAN_CXX_FLAGS_FMT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FMT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FMT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FMT "${CONAN_FRAMEWORKS_FMT}" "_FMT")
# Append to aggregated values variable
set(CONAN_LIBS_FMT ${CONAN_PKG_LIBS_FMT} ${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT})


#################
###  LIBPNG
#################
set(CONAN_LIBPNG_ROOT "/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c")
set(CONAN_INCLUDE_DIRS_LIBPNG "/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/include")
set(CONAN_LIB_DIRS_LIBPNG "/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/lib")
set(CONAN_BIN_DIRS_LIBPNG "/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/bin")
set(CONAN_RES_DIRS_LIBPNG )
set(CONAN_SRC_DIRS_LIBPNG )
set(CONAN_BUILD_DIRS_LIBPNG "/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/")
set(CONAN_FRAMEWORK_DIRS_LIBPNG )
set(CONAN_LIBS_LIBPNG png16)
set(CONAN_PKG_LIBS_LIBPNG png16)
set(CONAN_SYSTEM_LIBS_LIBPNG m)
set(CONAN_FRAMEWORKS_LIBPNG )
set(CONAN_FRAMEWORKS_FOUND_LIBPNG "")  # Will be filled later
set(CONAN_DEFINES_LIBPNG )
set(CONAN_BUILD_MODULES_PATHS_LIBPNG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBPNG )

set(CONAN_C_FLAGS_LIBPNG "")
set(CONAN_CXX_FLAGS_LIBPNG "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBPNG_LIST "")
set(CONAN_CXX_FLAGS_LIBPNG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBPNG "${CONAN_FRAMEWORKS_LIBPNG}" "_LIBPNG")
# Append to aggregated values variable
set(CONAN_LIBS_LIBPNG ${CONAN_PKG_LIBS_LIBPNG} ${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG})


#################
###  BZIP2
#################
set(CONAN_BZIP2_ROOT "/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567")
set(CONAN_INCLUDE_DIRS_BZIP2 "/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/include")
set(CONAN_LIB_DIRS_BZIP2 "/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/lib")
set(CONAN_BIN_DIRS_BZIP2 "/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/bin")
set(CONAN_RES_DIRS_BZIP2 )
set(CONAN_SRC_DIRS_BZIP2 )
set(CONAN_BUILD_DIRS_BZIP2 "/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/")
set(CONAN_FRAMEWORK_DIRS_BZIP2 )
set(CONAN_LIBS_BZIP2 bz2)
set(CONAN_PKG_LIBS_BZIP2 bz2)
set(CONAN_SYSTEM_LIBS_BZIP2 )
set(CONAN_FRAMEWORKS_BZIP2 )
set(CONAN_FRAMEWORKS_FOUND_BZIP2 "")  # Will be filled later
set(CONAN_DEFINES_BZIP2 )
set(CONAN_BUILD_MODULES_PATHS_BZIP2 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BZIP2 )

set(CONAN_C_FLAGS_BZIP2 "")
set(CONAN_CXX_FLAGS_BZIP2 "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2 "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BZIP2_LIST "")
set(CONAN_CXX_FLAGS_BZIP2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BZIP2 "${CONAN_FRAMEWORKS_BZIP2}" "_BZIP2")
# Append to aggregated values variable
set(CONAN_LIBS_BZIP2 ${CONAN_PKG_LIBS_BZIP2} ${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2})


#################
###  LIBALSA
#################
set(CONAN_LIBALSA_ROOT "/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3")
set(CONAN_INCLUDE_DIRS_LIBALSA "/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/include")
set(CONAN_LIB_DIRS_LIBALSA "/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/lib")
set(CONAN_BIN_DIRS_LIBALSA "/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/bin")
set(CONAN_RES_DIRS_LIBALSA )
set(CONAN_SRC_DIRS_LIBALSA )
set(CONAN_BUILD_DIRS_LIBALSA "/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/")
set(CONAN_FRAMEWORK_DIRS_LIBALSA )
set(CONAN_LIBS_LIBALSA asound)
set(CONAN_PKG_LIBS_LIBALSA asound)
set(CONAN_SYSTEM_LIBS_LIBALSA dl m rt pthread)
set(CONAN_FRAMEWORKS_LIBALSA )
set(CONAN_FRAMEWORKS_FOUND_LIBALSA "")  # Will be filled later
set(CONAN_DEFINES_LIBALSA )
set(CONAN_BUILD_MODULES_PATHS_LIBALSA )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBALSA )

set(CONAN_C_FLAGS_LIBALSA "")
set(CONAN_CXX_FLAGS_LIBALSA "")
set(CONAN_SHARED_LINKER_FLAGS_LIBALSA "")
set(CONAN_EXE_LINKER_FLAGS_LIBALSA "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBALSA_LIST "")
set(CONAN_CXX_FLAGS_LIBALSA_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBALSA_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBALSA "${CONAN_FRAMEWORKS_LIBALSA}" "_LIBALSA")
# Append to aggregated values variable
set(CONAN_LIBS_LIBALSA ${CONAN_PKG_LIBS_LIBALSA} ${CONAN_SYSTEM_LIBS_LIBALSA} ${CONAN_FRAMEWORKS_FOUND_LIBALSA})


#################
###  OGG
#################
set(CONAN_OGG_ROOT "/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1")
set(CONAN_INCLUDE_DIRS_OGG "/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/include")
set(CONAN_LIB_DIRS_OGG "/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/lib")
set(CONAN_BIN_DIRS_OGG )
set(CONAN_RES_DIRS_OGG )
set(CONAN_SRC_DIRS_OGG )
set(CONAN_BUILD_DIRS_OGG "/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/")
set(CONAN_FRAMEWORK_DIRS_OGG )
set(CONAN_LIBS_OGG ogg)
set(CONAN_PKG_LIBS_OGG ogg)
set(CONAN_SYSTEM_LIBS_OGG )
set(CONAN_FRAMEWORKS_OGG )
set(CONAN_FRAMEWORKS_FOUND_OGG "")  # Will be filled later
set(CONAN_DEFINES_OGG )
set(CONAN_BUILD_MODULES_PATHS_OGG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OGG )

set(CONAN_C_FLAGS_OGG "")
set(CONAN_CXX_FLAGS_OGG "")
set(CONAN_SHARED_LINKER_FLAGS_OGG "")
set(CONAN_EXE_LINKER_FLAGS_OGG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OGG_LIST "")
set(CONAN_CXX_FLAGS_OGG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OGG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OGG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OGG "${CONAN_FRAMEWORKS_OGG}" "_OGG")
# Append to aggregated values variable
set(CONAN_LIBS_OGG ${CONAN_PKG_LIBS_OGG} ${CONAN_SYSTEM_LIBS_OGG} ${CONAN_FRAMEWORKS_FOUND_OGG})


#################
###  LIBXRENDER
#################
set(CONAN_LIBXRENDER_ROOT "/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7")
set(CONAN_INCLUDE_DIRS_LIBXRENDER "/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/include")
set(CONAN_LIB_DIRS_LIBXRENDER "/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib")
set(CONAN_BIN_DIRS_LIBXRENDER )
set(CONAN_RES_DIRS_LIBXRENDER )
set(CONAN_SRC_DIRS_LIBXRENDER )
set(CONAN_BUILD_DIRS_LIBXRENDER "/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/"
			"/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXRENDER )
set(CONAN_LIBS_LIBXRENDER Xrender)
set(CONAN_PKG_LIBS_LIBXRENDER Xrender)
set(CONAN_SYSTEM_LIBS_LIBXRENDER )
set(CONAN_FRAMEWORKS_LIBXRENDER )
set(CONAN_FRAMEWORKS_FOUND_LIBXRENDER "")  # Will be filled later
set(CONAN_DEFINES_LIBXRENDER )
set(CONAN_BUILD_MODULES_PATHS_LIBXRENDER )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXRENDER )

set(CONAN_C_FLAGS_LIBXRENDER "")
set(CONAN_CXX_FLAGS_LIBXRENDER "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXRENDER "")
set(CONAN_EXE_LINKER_FLAGS_LIBXRENDER "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXRENDER_LIST "")
set(CONAN_CXX_FLAGS_LIBXRENDER_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXRENDER_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXRENDER "${CONAN_FRAMEWORKS_LIBXRENDER}" "_LIBXRENDER")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXRENDER ${CONAN_PKG_LIBS_LIBXRENDER} ${CONAN_SYSTEM_LIBS_LIBXRENDER} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER})


#################
###  LIBXEXT
#################
set(CONAN_LIBXEXT_ROOT "/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7")
set(CONAN_INCLUDE_DIRS_LIBXEXT "/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/include")
set(CONAN_LIB_DIRS_LIBXEXT "/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib")
set(CONAN_BIN_DIRS_LIBXEXT )
set(CONAN_RES_DIRS_LIBXEXT )
set(CONAN_SRC_DIRS_LIBXEXT )
set(CONAN_BUILD_DIRS_LIBXEXT "/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/"
			"/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXEXT )
set(CONAN_LIBS_LIBXEXT Xext)
set(CONAN_PKG_LIBS_LIBXEXT Xext)
set(CONAN_SYSTEM_LIBS_LIBXEXT dl)
set(CONAN_FRAMEWORKS_LIBXEXT )
set(CONAN_FRAMEWORKS_FOUND_LIBXEXT "")  # Will be filled later
set(CONAN_DEFINES_LIBXEXT )
set(CONAN_BUILD_MODULES_PATHS_LIBXEXT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXEXT )

set(CONAN_C_FLAGS_LIBXEXT "")
set(CONAN_CXX_FLAGS_LIBXEXT "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXEXT "")
set(CONAN_EXE_LINKER_FLAGS_LIBXEXT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXEXT_LIST "")
set(CONAN_CXX_FLAGS_LIBXEXT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXEXT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXEXT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXEXT "${CONAN_FRAMEWORKS_LIBXEXT}" "_LIBXEXT")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXEXT ${CONAN_PKG_LIBS_LIBXEXT} ${CONAN_SYSTEM_LIBS_LIBXEXT} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT "/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1")
set(CONAN_INCLUDE_DIRS_ZLIB "/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/include")
set(CONAN_LIB_DIRS_ZLIB "/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/lib")
set(CONAN_BIN_DIRS_ZLIB )
set(CONAN_RES_DIRS_ZLIB )
set(CONAN_SRC_DIRS_ZLIB )
set(CONAN_BUILD_DIRS_ZLIB "/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/")
set(CONAN_FRAMEWORK_DIRS_ZLIB )
set(CONAN_LIBS_ZLIB z)
set(CONAN_PKG_LIBS_ZLIB z)
set(CONAN_SYSTEM_LIBS_ZLIB )
set(CONAN_FRAMEWORKS_ZLIB )
set(CONAN_FRAMEWORKS_FOUND_ZLIB "")  # Will be filled later
set(CONAN_DEFINES_ZLIB )
set(CONAN_BUILD_MODULES_PATHS_ZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB )

set(CONAN_C_FLAGS_ZLIB "")
set(CONAN_CXX_FLAGS_ZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB "${CONAN_FRAMEWORKS_ZLIB}" "_ZLIB")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB ${CONAN_PKG_LIBS_ZLIB} ${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB})


#################
###  LIBX11
#################
set(CONAN_LIBX11_ROOT "/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d")
set(CONAN_INCLUDE_DIRS_LIBX11 "/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/include")
set(CONAN_LIB_DIRS_LIBX11 "/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/lib")
set(CONAN_BIN_DIRS_LIBX11 )
set(CONAN_RES_DIRS_LIBX11 )
set(CONAN_SRC_DIRS_LIBX11 )
set(CONAN_BUILD_DIRS_LIBX11 "/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/"
			"/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBX11 )
set(CONAN_LIBS_LIBX11 X11)
set(CONAN_PKG_LIBS_LIBX11 X11)
set(CONAN_SYSTEM_LIBS_LIBX11 dl)
set(CONAN_FRAMEWORKS_LIBX11 )
set(CONAN_FRAMEWORKS_FOUND_LIBX11 "")  # Will be filled later
set(CONAN_DEFINES_LIBX11 )
set(CONAN_BUILD_MODULES_PATHS_LIBX11 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBX11 )

set(CONAN_C_FLAGS_LIBX11 "")
set(CONAN_CXX_FLAGS_LIBX11 "")
set(CONAN_SHARED_LINKER_FLAGS_LIBX11 "")
set(CONAN_EXE_LINKER_FLAGS_LIBX11 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBX11_LIST "")
set(CONAN_CXX_FLAGS_LIBX11_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBX11_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBX11_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBX11 "${CONAN_FRAMEWORKS_LIBX11}" "_LIBX11")
# Append to aggregated values variable
set(CONAN_LIBS_LIBX11 ${CONAN_PKG_LIBS_LIBX11} ${CONAN_SYSTEM_LIBS_LIBX11} ${CONAN_FRAMEWORKS_FOUND_LIBX11})


#################
###  XTRANS
#################
set(CONAN_XTRANS_ROOT "/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XTRANS "/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_XTRANS )
set(CONAN_BIN_DIRS_XTRANS )
set(CONAN_RES_DIRS_XTRANS )
set(CONAN_SRC_DIRS_XTRANS )
set(CONAN_BUILD_DIRS_XTRANS "/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_XTRANS )
set(CONAN_LIBS_XTRANS )
set(CONAN_PKG_LIBS_XTRANS )
set(CONAN_SYSTEM_LIBS_XTRANS )
set(CONAN_FRAMEWORKS_XTRANS )
set(CONAN_FRAMEWORKS_FOUND_XTRANS "")  # Will be filled later
set(CONAN_DEFINES_XTRANS )
set(CONAN_BUILD_MODULES_PATHS_XTRANS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XTRANS )

set(CONAN_C_FLAGS_XTRANS "")
set(CONAN_CXX_FLAGS_XTRANS "")
set(CONAN_SHARED_LINKER_FLAGS_XTRANS "")
set(CONAN_EXE_LINKER_FLAGS_XTRANS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XTRANS_LIST "")
set(CONAN_CXX_FLAGS_XTRANS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XTRANS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XTRANS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XTRANS "${CONAN_FRAMEWORKS_XTRANS}" "_XTRANS")
# Append to aggregated values variable
set(CONAN_LIBS_XTRANS ${CONAN_PKG_LIBS_XTRANS} ${CONAN_SYSTEM_LIBS_XTRANS} ${CONAN_FRAMEWORKS_FOUND_XTRANS})


#################
###  LIBXCB
#################
set(CONAN_LIBXCB_ROOT "/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e")
set(CONAN_INCLUDE_DIRS_LIBXCB "/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/include")
set(CONAN_LIB_DIRS_LIBXCB "/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/lib")
set(CONAN_BIN_DIRS_LIBXCB )
set(CONAN_RES_DIRS_LIBXCB )
set(CONAN_SRC_DIRS_LIBXCB )
set(CONAN_BUILD_DIRS_LIBXCB "/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/"
			"/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXCB )
set(CONAN_LIBS_LIBXCB xcb)
set(CONAN_PKG_LIBS_LIBXCB xcb)
set(CONAN_SYSTEM_LIBS_LIBXCB )
set(CONAN_FRAMEWORKS_LIBXCB )
set(CONAN_FRAMEWORKS_FOUND_LIBXCB "")  # Will be filled later
set(CONAN_DEFINES_LIBXCB )
set(CONAN_BUILD_MODULES_PATHS_LIBXCB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXCB )

set(CONAN_C_FLAGS_LIBXCB "")
set(CONAN_CXX_FLAGS_LIBXCB "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXCB "")
set(CONAN_EXE_LINKER_FLAGS_LIBXCB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXCB_LIST "")
set(CONAN_CXX_FLAGS_LIBXCB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXCB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXCB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXCB "${CONAN_FRAMEWORKS_LIBXCB}" "_LIBXCB")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXCB ${CONAN_PKG_LIBS_LIBXCB} ${CONAN_SYSTEM_LIBS_LIBXCB} ${CONAN_FRAMEWORKS_FOUND_LIBXCB})


#################
###  XCB-PROTO
#################
set(CONAN_XCB-PROTO_ROOT "/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XCB-PROTO )
set(CONAN_LIB_DIRS_XCB-PROTO "/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib")
set(CONAN_BIN_DIRS_XCB-PROTO )
set(CONAN_RES_DIRS_XCB-PROTO )
set(CONAN_SRC_DIRS_XCB-PROTO )
set(CONAN_BUILD_DIRS_XCB-PROTO "/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_XCB-PROTO )
set(CONAN_LIBS_XCB-PROTO )
set(CONAN_PKG_LIBS_XCB-PROTO )
set(CONAN_SYSTEM_LIBS_XCB-PROTO )
set(CONAN_FRAMEWORKS_XCB-PROTO )
set(CONAN_FRAMEWORKS_FOUND_XCB-PROTO "")  # Will be filled later
set(CONAN_DEFINES_XCB-PROTO )
set(CONAN_BUILD_MODULES_PATHS_XCB-PROTO )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XCB-PROTO )

set(CONAN_C_FLAGS_XCB-PROTO "")
set(CONAN_CXX_FLAGS_XCB-PROTO "")
set(CONAN_SHARED_LINKER_FLAGS_XCB-PROTO "")
set(CONAN_EXE_LINKER_FLAGS_XCB-PROTO "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XCB-PROTO_LIST "")
set(CONAN_CXX_FLAGS_XCB-PROTO_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XCB-PROTO_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XCB-PROTO "${CONAN_FRAMEWORKS_XCB-PROTO}" "_XCB-PROTO")
# Append to aggregated values variable
set(CONAN_LIBS_XCB-PROTO ${CONAN_PKG_LIBS_XCB-PROTO} ${CONAN_SYSTEM_LIBS_XCB-PROTO} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO})


#################
###  UTIL-MACROS
#################
set(CONAN_UTIL-MACROS_ROOT "/home/george/.conan/data/util-macros/1.19.2/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_UTIL-MACROS )
set(CONAN_LIB_DIRS_UTIL-MACROS )
set(CONAN_BIN_DIRS_UTIL-MACROS )
set(CONAN_RES_DIRS_UTIL-MACROS )
set(CONAN_SRC_DIRS_UTIL-MACROS )
set(CONAN_BUILD_DIRS_UTIL-MACROS "/home/george/.conan/data/util-macros/1.19.2/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/util-macros/1.19.2/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_UTIL-MACROS )
set(CONAN_LIBS_UTIL-MACROS )
set(CONAN_PKG_LIBS_UTIL-MACROS )
set(CONAN_SYSTEM_LIBS_UTIL-MACROS )
set(CONAN_FRAMEWORKS_UTIL-MACROS )
set(CONAN_FRAMEWORKS_FOUND_UTIL-MACROS "")  # Will be filled later
set(CONAN_DEFINES_UTIL-MACROS )
set(CONAN_BUILD_MODULES_PATHS_UTIL-MACROS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_UTIL-MACROS )

set(CONAN_C_FLAGS_UTIL-MACROS "")
set(CONAN_CXX_FLAGS_UTIL-MACROS "")
set(CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS "")
set(CONAN_EXE_LINKER_FLAGS_UTIL-MACROS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_UTIL-MACROS_LIST "")
set(CONAN_CXX_FLAGS_UTIL-MACROS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_UTIL-MACROS "${CONAN_FRAMEWORKS_UTIL-MACROS}" "_UTIL-MACROS")
# Append to aggregated values variable
set(CONAN_LIBS_UTIL-MACROS ${CONAN_PKG_LIBS_UTIL-MACROS} ${CONAN_SYSTEM_LIBS_UTIL-MACROS} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS})


#################
###  LIBXAU
#################
set(CONAN_LIBXAU_ROOT "/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49")
set(CONAN_INCLUDE_DIRS_LIBXAU "/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/include")
set(CONAN_LIB_DIRS_LIBXAU "/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/lib")
set(CONAN_BIN_DIRS_LIBXAU )
set(CONAN_RES_DIRS_LIBXAU )
set(CONAN_SRC_DIRS_LIBXAU )
set(CONAN_BUILD_DIRS_LIBXAU "/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/"
			"/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXAU )
set(CONAN_LIBS_LIBXAU Xau)
set(CONAN_PKG_LIBS_LIBXAU Xau)
set(CONAN_SYSTEM_LIBS_LIBXAU )
set(CONAN_FRAMEWORKS_LIBXAU )
set(CONAN_FRAMEWORKS_FOUND_LIBXAU "")  # Will be filled later
set(CONAN_DEFINES_LIBXAU )
set(CONAN_BUILD_MODULES_PATHS_LIBXAU )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXAU )

set(CONAN_C_FLAGS_LIBXAU "")
set(CONAN_CXX_FLAGS_LIBXAU "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXAU "")
set(CONAN_EXE_LINKER_FLAGS_LIBXAU "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXAU_LIST "")
set(CONAN_CXX_FLAGS_LIBXAU_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXAU_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXAU_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXAU "${CONAN_FRAMEWORKS_LIBXAU}" "_LIBXAU")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXAU ${CONAN_PKG_LIBS_LIBXAU} ${CONAN_SYSTEM_LIBS_LIBXAU} ${CONAN_FRAMEWORKS_FOUND_LIBXAU})


#################
###  LIBPTHREAD-STUBS
#################
set(CONAN_LIBPTHREAD-STUBS_ROOT "/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS )
set(CONAN_LIB_DIRS_LIBPTHREAD-STUBS "/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib")
set(CONAN_BIN_DIRS_LIBPTHREAD-STUBS )
set(CONAN_RES_DIRS_LIBPTHREAD-STUBS )
set(CONAN_SRC_DIRS_LIBPTHREAD-STUBS )
set(CONAN_BUILD_DIRS_LIBPTHREAD-STUBS "/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBPTHREAD-STUBS )
set(CONAN_LIBS_LIBPTHREAD-STUBS )
set(CONAN_PKG_LIBS_LIBPTHREAD-STUBS )
set(CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS )
set(CONAN_FRAMEWORKS_LIBPTHREAD-STUBS )
set(CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS "")  # Will be filled later
set(CONAN_DEFINES_LIBPTHREAD-STUBS )
set(CONAN_BUILD_MODULES_PATHS_LIBPTHREAD-STUBS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS )

set(CONAN_C_FLAGS_LIBPTHREAD-STUBS "")
set(CONAN_CXX_FLAGS_LIBPTHREAD-STUBS "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS "")
set(CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBPTHREAD-STUBS_LIST "")
set(CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS "${CONAN_FRAMEWORKS_LIBPTHREAD-STUBS}" "_LIBPTHREAD-STUBS")
# Append to aggregated values variable
set(CONAN_LIBS_LIBPTHREAD-STUBS ${CONAN_PKG_LIBS_LIBPTHREAD-STUBS} ${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS})


#################
###  LIBXDMCP
#################
set(CONAN_LIBXDMCP_ROOT "/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06")
set(CONAN_INCLUDE_DIRS_LIBXDMCP "/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/include")
set(CONAN_LIB_DIRS_LIBXDMCP "/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/lib")
set(CONAN_BIN_DIRS_LIBXDMCP )
set(CONAN_RES_DIRS_LIBXDMCP )
set(CONAN_SRC_DIRS_LIBXDMCP )
set(CONAN_BUILD_DIRS_LIBXDMCP "/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/"
			"/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_LIBXDMCP )
set(CONAN_LIBS_LIBXDMCP Xdmcp)
set(CONAN_PKG_LIBS_LIBXDMCP Xdmcp)
set(CONAN_SYSTEM_LIBS_LIBXDMCP )
set(CONAN_FRAMEWORKS_LIBXDMCP )
set(CONAN_FRAMEWORKS_FOUND_LIBXDMCP "")  # Will be filled later
set(CONAN_DEFINES_LIBXDMCP )
set(CONAN_BUILD_MODULES_PATHS_LIBXDMCP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBXDMCP )

set(CONAN_C_FLAGS_LIBXDMCP "")
set(CONAN_CXX_FLAGS_LIBXDMCP "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXDMCP "")
set(CONAN_EXE_LINKER_FLAGS_LIBXDMCP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBXDMCP_LIST "")
set(CONAN_CXX_FLAGS_LIBXDMCP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBXDMCP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBXDMCP "${CONAN_FRAMEWORKS_LIBXDMCP}" "_LIBXDMCP")
# Append to aggregated values variable
set(CONAN_LIBS_LIBXDMCP ${CONAN_PKG_LIBS_LIBXDMCP} ${CONAN_SYSTEM_LIBS_LIBXDMCP} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP})


#################
###  XORGPROTO
#################
set(CONAN_XORGPROTO_ROOT "/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XORGPROTO "/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_XORGPROTO )
set(CONAN_BIN_DIRS_XORGPROTO )
set(CONAN_RES_DIRS_XORGPROTO )
set(CONAN_SRC_DIRS_XORGPROTO )
set(CONAN_BUILD_DIRS_XORGPROTO "/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_XORGPROTO )
set(CONAN_LIBS_XORGPROTO )
set(CONAN_PKG_LIBS_XORGPROTO )
set(CONAN_SYSTEM_LIBS_XORGPROTO )
set(CONAN_FRAMEWORKS_XORGPROTO )
set(CONAN_FRAMEWORKS_FOUND_XORGPROTO "")  # Will be filled later
set(CONAN_DEFINES_XORGPROTO )
set(CONAN_BUILD_MODULES_PATHS_XORGPROTO )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XORGPROTO )

set(CONAN_C_FLAGS_XORGPROTO "")
set(CONAN_CXX_FLAGS_XORGPROTO "")
set(CONAN_SHARED_LINKER_FLAGS_XORGPROTO "")
set(CONAN_EXE_LINKER_FLAGS_XORGPROTO "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XORGPROTO_LIST "")
set(CONAN_CXX_FLAGS_XORGPROTO_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XORGPROTO_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XORGPROTO_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XORGPROTO "${CONAN_FRAMEWORKS_XORGPROTO}" "_XORGPROTO")
# Append to aggregated values variable
set(CONAN_LIBS_XORGPROTO ${CONAN_PKG_LIBS_XORGPROTO} ${CONAN_SYSTEM_LIBS_XORGPROTO} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO})


#################
###  XPROTO
#################
set(CONAN_XPROTO_ROOT "/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XPROTO "/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_XPROTO "/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib")
set(CONAN_BIN_DIRS_XPROTO )
set(CONAN_RES_DIRS_XPROTO )
set(CONAN_SRC_DIRS_XPROTO )
set(CONAN_BUILD_DIRS_XPROTO "/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig")
set(CONAN_FRAMEWORK_DIRS_XPROTO )
set(CONAN_LIBS_XPROTO )
set(CONAN_PKG_LIBS_XPROTO )
set(CONAN_SYSTEM_LIBS_XPROTO )
set(CONAN_FRAMEWORKS_XPROTO )
set(CONAN_FRAMEWORKS_FOUND_XPROTO "")  # Will be filled later
set(CONAN_DEFINES_XPROTO )
set(CONAN_BUILD_MODULES_PATHS_XPROTO )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XPROTO )

set(CONAN_C_FLAGS_XPROTO "")
set(CONAN_CXX_FLAGS_XPROTO "")
set(CONAN_SHARED_LINKER_FLAGS_XPROTO "")
set(CONAN_EXE_LINKER_FLAGS_XPROTO "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XPROTO_LIST "")
set(CONAN_CXX_FLAGS_XPROTO_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XPROTO_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XPROTO_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XPROTO "${CONAN_FRAMEWORKS_XPROTO}" "_XPROTO")
# Append to aggregated values variable
set(CONAN_LIBS_XPROTO ${CONAN_PKG_LIBS_XPROTO} ${CONAN_SYSTEM_LIBS_XPROTO} ${CONAN_FRAMEWORKS_FOUND_XPROTO})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "x86_64")
set(CONAN_SETTINGS_ARCH_BUILD "x86_64")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "gcc")
set(CONAN_SETTINGS_COMPILER_LIBCXX "libstdc++11")
set(CONAN_SETTINGS_COMPILER_VERSION "10")
set(CONAN_SETTINGS_OS "Linux")
set(CONAN_SETTINGS_OS_BUILD "Linux")

set(CONAN_DEPENDENCIES box2d sfml entt spdlog freetype stb openal flac vorbis libxrandr opengl fmt libpng bzip2 libalsa ogg libxrender libxext zlib libx11 xtrans libxcb xcb-proto util-macros libxau libpthread-stubs libxdmcp xorgproto xproto)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/include"
			"/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/include"
			"/home/george/.conan/data/entt/3.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/include"
			"/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/include"
			"/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/include/freetype2"
			"/home/george/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/include"
			"/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/include/AL"
			"/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/include"
			"/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/include"
			"/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/include"
			"/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/include"
			"/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/include"
			"/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/include"
			"/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/include"
			"/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/include"
			"/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/include"
			"/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/include"
			"/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/include"
			"/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/include"
			"/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/include"
			"/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/include"
			"/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/include"
			"/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/lib"
			"/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/lib"
			"/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/lib"
			"/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/lib"
			"/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/lib"
			"/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/lib"
			"/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/lib"
			"/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/lib"
			"/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/lib"
			"/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/lib"
			"/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/lib"
			"/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/lib"
			"/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/lib"
			"/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib"
			"/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib"
			"/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/lib"
			"/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/lib"
			"/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/lib"
			"/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib"
			"/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/lib"
			"/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib"
			"/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/lib"
			"/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/bin"
			"/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/bin"
			"/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/bin"
			"/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/bin"
			"/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS  ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS Box2D sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s spdlog freetype openal FLAC++ FLAC vorbisfile vorbisenc vorbis Xrandr fmt png16 bz2 asound ogg Xrender Xext z X11 xcb Xau Xdmcp ${CONAN_LIBS})
set(CONAN_PKG_LIBS Box2D sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s spdlog freetype openal FLAC++ FLAC vorbisfile vorbisenc vorbis Xrandr fmt png16 bz2 asound ogg Xrender Xext z X11 xcb Xau Xdmcp ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS udev GL m rt pthread dl ${CONAN_SYSTEM_LIBS})
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES "-DFLAC__NO_DLL"
			"-DAL_LIBTYPE_STATIC"
			"-DSTB_TEXTEDIT_KEYTYPE=unsigned"
			"-DSPDLOG_COMPILED_LIB"
			"-DSPDLOG_FMT_EXTERNAL"
			"-DSFML_STATIC" ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS  ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "/home/george/.conan/data/box2d/2.3.2.ef96a4f/conan/stable/package/b173bbda18164d49a449ffadc1c9e817f49e819d/"
			"/home/george/.conan/data/sfml/2.5.1/bincrafters/stable/package/07c6bf58ef02efd27126ab466d38142c5354facf/"
			"/home/george/.conan/data/entt/3.4.0/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/spdlog/1.5.0/_/_/package/5ec35c7aba5410ef8b762c324eb39c457e8e6fe3/"
			"/home/george/.conan/data/freetype/2.10.1/_/_/package/af0209aed453aaecfeb6401e9ac3621766498610/"
			"/home/george/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/openal/1.19.1/_/_/package/b971b2aa3a64ea42480c2195c692f93bbf878fc8/"
			"/home/george/.conan/data/flac/1.3.3/_/_/package/f73e61b9ac5c8f3043ccfbe374875bbd9a7376b1/"
			"/home/george/.conan/data/vorbis/1.3.6/_/_/package/6e4bc3ab815736fa7c637f569f101e1193ddb5da/"
			"/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/"
			"/home/george/.conan/data/libxrandr/1.5.2/bincrafters/stable/package/112184a69692d70ffc11ef980f23dcd6f668826e/lib/pkgconfig"
			"/home/george/.conan/data/opengl/virtual/bincrafters/stable/package/25315d66e1f567146d60eadc7d8fc22e5398fdaf/"
			"/home/george/.conan/data/fmt/6.1.2/_/_/package/b173bbda18164d49a449ffadc1c9e817f49e819d/"
			"/home/george/.conan/data/libpng/1.6.37/_/_/package/d8b88b49d6e7691941997f64ad700b4308d0ed8c/"
			"/home/george/.conan/data/bzip2/1.0.8/_/_/package/91a8b22c2c5a149bc617cfc06cdd21bf23b12567/"
			"/home/george/.conan/data/libalsa/1.1.9/_/_/package/51e96d1346424f5ef647616231906873cd225eb3/"
			"/home/george/.conan/data/ogg/1.3.4/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/"
			"/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/"
			"/home/george/.conan/data/libxrender/0.9.10/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib/pkgconfig"
			"/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/"
			"/home/george/.conan/data/libxext/1.3.4/bincrafters/stable/package/ff5fc0ec6a8b391a9f2e7beb212072ac4a9ec2a7/lib/pkgconfig"
			"/home/george/.conan/data/zlib/1.2.11/_/_/package/19729b9559f3ae196cad45cb2b97468ccb75dcd1/"
			"/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/"
			"/home/george/.conan/data/libx11/1.6.8/bincrafters/stable/package/bc544775aa5fddf6d7575a80ae53ca5af9e8b12d/lib/pkgconfig"
			"/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xtrans/1.4.0/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig"
			"/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/"
			"/home/george/.conan/data/libxcb/1.13.1/bincrafters/stable/package/43727058fb43b11ad21351fbc04f89a2c057b90e/lib/pkgconfig"
			"/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xcb-proto/1.13/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig"
			"/home/george/.conan/data/util-macros/1.19.2/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/util-macros/1.19.2/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig"
			"/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/"
			"/home/george/.conan/data/libxau/1.0.9/bincrafters/stable/package/d31d575170e7c3452326b68c3e39de5d8e9dfa49/lib/pkgconfig"
			"/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/libpthread-stubs/0.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig"
			"/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/"
			"/home/george/.conan/data/libxdmcp/1.1.3/bincrafters/stable/package/c78e38be3b4a9dcf2f91a8fd4409d2114ca88f06/lib/pkgconfig"
			"/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xorgproto/2019.1/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/share/pkgconfig"
			"/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/george/.conan/data/xproto/7.0.31/bincrafters/stable/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/pkgconfig" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}" "")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS ${CONAN_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    set(_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BOX2D} ${CONAN_FRAMEWORKS_FOUND_BOX2D} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOX2D_DEPENDENCIES "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOX2D}" "${CONAN_LIB_DIRS_BOX2D}"
                                  CONAN_PACKAGE_TARGETS_BOX2D "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES}"
                                  "" box2d)
    set(_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BOX2D_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BOX2D_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOX2D_DEBUG}" "${CONAN_LIB_DIRS_BOX2D_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BOX2D_DEBUG "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_DEBUG}"
                                  "debug" box2d)
    set(_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BOX2D_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BOX2D_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOX2D_RELEASE}" "${CONAN_LIB_DIRS_BOX2D_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BOX2D_RELEASE "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELEASE}"
                                  "release" box2d)
    set(_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BOX2D_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BOX2D_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOX2D_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BOX2D_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BOX2D_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" box2d)
    set(_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BOX2D_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BOX2D_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOX2D_MINSIZEREL}" "${CONAN_LIB_DIRS_BOX2D_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BOX2D_MINSIZEREL "${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" box2d)

    add_library(CONAN_PKG::box2d INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::box2d PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BOX2D} ${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOX2D_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BOX2D_RELEASE} ${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOX2D_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BOX2D_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOX2D_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BOX2D_MINSIZEREL} ${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOX2D_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BOX2D_DEBUG} ${_CONAN_PKG_LIBS_BOX2D_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOX2D_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOX2D_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::box2d PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BOX2D}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BOX2D_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BOX2D_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BOX2D_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BOX2D_DEBUG}>)
    set_property(TARGET CONAN_PKG::box2d PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BOX2D}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BOX2D_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BOX2D_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BOX2D_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BOX2D_DEBUG}>)
    set_property(TARGET CONAN_PKG::box2d PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BOX2D_LIST} ${CONAN_CXX_FLAGS_BOX2D_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BOX2D_RELEASE_LIST} ${CONAN_CXX_FLAGS_BOX2D_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BOX2D_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BOX2D_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BOX2D_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BOX2D_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BOX2D_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BOX2D_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES "${CONAN_SYSTEM_LIBS_SFML} ${CONAN_FRAMEWORKS_FOUND_SFML} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::libx11 CONAN_PKG::libxrandr CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML}" "${CONAN_LIB_DIRS_SFML}"
                                  CONAN_PACKAGE_TARGETS_SFML "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}"
                                  "" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_SFML_DEBUG} ${CONAN_FRAMEWORKS_FOUND_SFML_DEBUG} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::libx11 CONAN_PKG::libxrandr CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_DEBUG}" "${CONAN_LIB_DIRS_SFML_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_SFML_DEBUG "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}"
                                  "debug" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_SFML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SFML_RELEASE} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::libx11 CONAN_PKG::libxrandr CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_RELEASE}" "${CONAN_LIB_DIRS_SFML_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_SFML_RELEASE "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}"
                                  "release" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_SFML_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_SFML_RELWITHDEBINFO} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::libx11 CONAN_PKG::libxrandr CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_SFML_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_SFML_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_SFML_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_SFML_MINSIZEREL} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::libx11 CONAN_PKG::libxrandr CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_MINSIZEREL}" "${CONAN_LIB_DIRS_SFML_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_SFML_MINSIZEREL "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" sfml)

    add_library(CONAN_PKG::sfml INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_SFML} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_SFML_RELEASE} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_SFML_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_SFML_MINSIZEREL} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_SFML_DEBUG} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_SFML}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_SFML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_SFML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_SFML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_SFML_DEBUG}>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_SFML}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_SFML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_SFML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_SFML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_SFML_DEBUG}>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_SFML_LIST} ${CONAN_CXX_FLAGS_SFML_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_SFML_RELEASE_LIST} ${CONAN_CXX_FLAGS_SFML_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_SFML_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_SFML_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_SFML_DEBUG_LIST}  ${CONAN_CXX_FLAGS_SFML_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ENTT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ENTT} ${CONAN_FRAMEWORKS_FOUND_ENTT} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ENTT_DEPENDENCIES "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ENTT}" "${CONAN_LIB_DIRS_ENTT}"
                                  CONAN_PACKAGE_TARGETS_ENTT "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES}"
                                  "" entt)
    set(_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ENTT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ENTT_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ENTT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ENTT_DEBUG}" "${CONAN_LIB_DIRS_ENTT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ENTT_DEBUG "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_DEBUG}"
                                  "debug" entt)
    set(_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ENTT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ENTT_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ENTT_RELEASE}" "${CONAN_LIB_DIRS_ENTT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ENTT_RELEASE "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELEASE}"
                                  "release" entt)
    set(_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ENTT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ENTT_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ENTT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ENTT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ENTT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" entt)
    set(_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ENTT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ENTT_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ENTT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ENTT_MINSIZEREL}" "${CONAN_LIB_DIRS_ENTT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ENTT_MINSIZEREL "${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" entt)

    add_library(CONAN_PKG::entt INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::entt PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ENTT} ${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ENTT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ENTT_RELEASE} ${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ENTT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ENTT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ENTT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ENTT_MINSIZEREL} ${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ENTT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ENTT_DEBUG} ${_CONAN_PKG_LIBS_ENTT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ENTT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ENTT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::entt PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ENTT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ENTT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ENTT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ENTT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ENTT_DEBUG}>)
    set_property(TARGET CONAN_PKG::entt PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ENTT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ENTT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ENTT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ENTT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ENTT_DEBUG}>)
    set_property(TARGET CONAN_PKG::entt PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ENTT_LIST} ${CONAN_CXX_FLAGS_ENTT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ENTT_RELEASE_LIST} ${CONAN_CXX_FLAGS_ENTT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ENTT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ENTT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ENTT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ENTT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ENTT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ENTT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_SPDLOG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG}" "${CONAN_LIB_DIRS_SPDLOG}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}"
                                  "" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_SPDLOG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_DEBUG} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_DEBUG}" "${CONAN_LIB_DIRS_SPDLOG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_DEBUG "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}"
                                  "debug" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_SPDLOG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_RELEASE} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_RELEASE}" "${CONAN_LIB_DIRS_SPDLOG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_RELEASE "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}"
                                  "release" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_SPDLOG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_RELWITHDEBINFO} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_SPDLOG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" spdlog)
    set(_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_SPDLOG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_SPDLOG_MINSIZEREL} CONAN_PKG::fmt")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SPDLOG_MINSIZEREL}" "${CONAN_LIB_DIRS_SPDLOG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_SPDLOG_MINSIZEREL "${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" spdlog)

    add_library(CONAN_PKG::spdlog INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_SPDLOG} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_SPDLOG_RELEASE} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_SPDLOG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_SPDLOG_MINSIZEREL} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_SPDLOG_DEBUG} ${_CONAN_PKG_LIBS_SPDLOG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SPDLOG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_SPDLOG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_SPDLOG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_SPDLOG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_SPDLOG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_SPDLOG_DEBUG}>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_SPDLOG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_SPDLOG_DEBUG}>)
    set_property(TARGET CONAN_PKG::spdlog PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_SPDLOG_LIST} ${CONAN_CXX_FLAGS_SPDLOG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_SPDLOG_RELEASE_LIST} ${CONAN_CXX_FLAGS_SPDLOG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_SPDLOG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_SPDLOG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_SPDLOG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_SPDLOG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_SPDLOG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_SPDLOG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE}" "${CONAN_LIB_DIRS_FREETYPE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}"
                                  "" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FREETYPE_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_DEBUG} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_DEBUG}" "${CONAN_LIB_DIRS_FREETYPE_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}"
                                  "debug" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FREETYPE_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELEASE}" "${CONAN_LIB_DIRS_FREETYPE_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}"
                                  "release" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FREETYPE_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELWITHDEBINFO} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FREETYPE_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FREETYPE_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_MINSIZEREL} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_MINSIZEREL}" "${CONAN_LIB_DIRS_FREETYPE_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" freetype)

    add_library(CONAN_PKG::freetype INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FREETYPE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FREETYPE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FREETYPE_RELEASE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FREETYPE_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FREETYPE_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FREETYPE_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FREETYPE_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB}" "${CONAN_LIB_DIRS_STB}"
                                  CONAN_PACKAGE_TARGETS_STB "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}"
                                  "" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_STB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_STB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_DEBUG}" "${CONAN_LIB_DIRS_STB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_STB_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}"
                                  "debug" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_STB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_STB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELEASE}" "${CONAN_LIB_DIRS_STB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_STB_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}"
                                  "release" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_STB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_STB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_STB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_STB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_STB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_MINSIZEREL}" "${CONAN_LIB_DIRS_STB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_STB_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" stb)

    add_library(CONAN_PKG::stb INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_STB} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_STB_RELEASE} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_STB_MINSIZEREL} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_STB_DEBUG} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_STB_LIST} ${CONAN_CXX_FLAGS_STB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_STB_RELEASE_LIST} ${CONAN_CXX_FLAGS_STB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_STB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_STB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_STB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_STB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_STB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENAL} ${CONAN_FRAMEWORKS_FOUND_OPENAL} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL}" "${CONAN_LIB_DIRS_OPENAL}"
                                  CONAN_PACKAGE_TARGETS_OPENAL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}"
                                  "" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENAL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENAL_DEBUG} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_DEBUG}" "${CONAN_LIB_DIRS_OPENAL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_DEBUG "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}"
                                  "debug" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENAL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENAL_RELEASE} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_RELEASE}" "${CONAN_LIB_DIRS_OPENAL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_RELEASE "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}"
                                  "release" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENAL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENAL_RELWITHDEBINFO} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENAL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENAL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENAL_MINSIZEREL} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENAL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openal)

    add_library(CONAN_PKG::openal INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENAL} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENAL_RELEASE} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENAL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENAL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENAL_DEBUG} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENAL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENAL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENAL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENAL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENAL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENAL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENAL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENAL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENAL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENAL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENAL_LIST} ${CONAN_CXX_FLAGS_OPENAL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENAL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENAL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENAL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENAL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENAL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENAL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FLAC} ${CONAN_FRAMEWORKS_FOUND_FLAC} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC}" "${CONAN_LIB_DIRS_FLAC}"
                                  CONAN_PACKAGE_TARGETS_FLAC "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}"
                                  "" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FLAC_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FLAC_DEBUG} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_DEBUG}" "${CONAN_LIB_DIRS_FLAC_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FLAC_DEBUG "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}"
                                  "debug" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FLAC_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FLAC_RELEASE} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_RELEASE}" "${CONAN_LIB_DIRS_FLAC_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FLAC_RELEASE "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}"
                                  "release" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FLAC_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FLAC_RELWITHDEBINFO} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FLAC_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FLAC_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FLAC_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FLAC_MINSIZEREL} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_MINSIZEREL}" "${CONAN_LIB_DIRS_FLAC_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FLAC_MINSIZEREL "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" flac)

    add_library(CONAN_PKG::flac INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FLAC} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FLAC_RELEASE} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FLAC_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FLAC_MINSIZEREL} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FLAC_DEBUG} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FLAC}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FLAC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FLAC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FLAC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FLAC_DEBUG}>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FLAC}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FLAC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FLAC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FLAC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FLAC_DEBUG}>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FLAC_LIST} ${CONAN_CXX_FLAGS_FLAC_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FLAC_RELEASE_LIST} ${CONAN_CXX_FLAGS_FLAC_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FLAC_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FLAC_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FLAC_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FLAC_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_VORBIS} ${CONAN_FRAMEWORKS_FOUND_VORBIS} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS}" "${CONAN_LIB_DIRS_VORBIS}"
                                  CONAN_PACKAGE_TARGETS_VORBIS "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}"
                                  "" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_VORBIS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_VORBIS_DEBUG} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_DEBUG}" "${CONAN_LIB_DIRS_VORBIS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_DEBUG "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}"
                                  "debug" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_VORBIS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VORBIS_RELEASE} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_RELEASE}" "${CONAN_LIB_DIRS_VORBIS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_RELEASE "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}"
                                  "release" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VORBIS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_VORBIS_RELWITHDEBINFO} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VORBIS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_VORBIS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_VORBIS_MINSIZEREL} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_MINSIZEREL}" "${CONAN_LIB_DIRS_VORBIS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_MINSIZEREL "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" vorbis)

    add_library(CONAN_PKG::vorbis INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VORBIS} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VORBIS_RELEASE} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VORBIS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VORBIS_MINSIZEREL} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VORBIS_DEBUG} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VORBIS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VORBIS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VORBIS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VORBIS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VORBIS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VORBIS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VORBIS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VORBIS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VORBIS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VORBIS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VORBIS_LIST} ${CONAN_CXX_FLAGS_VORBIS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VORBIS_RELEASE_LIST} ${CONAN_CXX_FLAGS_VORBIS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VORBIS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VORBIS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VORBIS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VORBIS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXRANDR} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR} CONAN_PKG::libxrender CONAN_PKG::libxext")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRANDR}" "${CONAN_LIB_DIRS_LIBXRANDR}"
                                  CONAN_PACKAGE_TARGETS_LIBXRANDR "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES}"
                                  "" libxrandr)
    set(_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXRANDR_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR_DEBUG} CONAN_PKG::libxrender CONAN_PKG::libxext")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRANDR_DEBUG}" "${CONAN_LIB_DIRS_LIBXRANDR_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXRANDR_DEBUG "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_DEBUG}"
                                  "debug" libxrandr)
    set(_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXRANDR_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR_RELEASE} CONAN_PKG::libxrender CONAN_PKG::libxext")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRANDR_RELEASE}" "${CONAN_LIB_DIRS_LIBXRANDR_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXRANDR_RELEASE "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELEASE}"
                                  "release" libxrandr)
    set(_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXRANDR_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR_RELWITHDEBINFO} CONAN_PKG::libxrender CONAN_PKG::libxext")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRANDR_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXRANDR_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXRANDR_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxrandr)
    set(_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXRANDR_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXRANDR_MINSIZEREL} CONAN_PKG::libxrender CONAN_PKG::libxext")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRANDR_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXRANDR_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXRANDR_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxrandr)

    add_library(CONAN_PKG::libxrandr INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxrandr PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXRANDR} ${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRANDR_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXRANDR_RELEASE} ${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRANDR_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXRANDR_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRANDR_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXRANDR_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRANDR_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXRANDR_DEBUG} ${_CONAN_PKG_LIBS_LIBXRANDR_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRANDR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRANDR_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxrandr PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXRANDR}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXRANDR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXRANDR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXRANDR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXRANDR_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxrandr PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXRANDR}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXRANDR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXRANDR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXRANDR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXRANDR_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxrandr PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXRANDR_LIST} ${CONAN_CXX_FLAGS_LIBXRANDR_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXRANDR_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXRANDR_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXRANDR_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXRANDR_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXRANDR_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXRANDR_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXRANDR_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXRANDR_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL}" "${CONAN_LIB_DIRS_OPENGL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}"
                                  "" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENGL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENGL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_DEBUG}" "${CONAN_LIB_DIRS_OPENGL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}"
                                  "debug" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENGL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELEASE}" "${CONAN_LIB_DIRS_OPENGL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}"
                                  "release" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENGL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENGL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENGL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENGL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENGL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opengl)

    add_library(CONAN_PKG::opengl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENGL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENGL_RELEASE} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENGL_DEBUG} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENGL_LIST} ${CONAN_CXX_FLAGS_OPENGL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENGL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENGL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENGL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENGL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENGL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT}" "${CONAN_LIB_DIRS_FMT}"
                                  CONAN_PACKAGE_TARGETS_FMT "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}"
                                  "" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FMT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FMT_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_DEBUG}" "${CONAN_LIB_DIRS_FMT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FMT_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}"
                                  "debug" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FMT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FMT_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELEASE}" "${CONAN_LIB_DIRS_FMT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}"
                                  "release" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FMT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FMT_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FMT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FMT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FMT_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_MINSIZEREL}" "${CONAN_LIB_DIRS_FMT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" fmt)

    add_library(CONAN_PKG::fmt INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FMT} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FMT_RELEASE} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FMT_DEBUG} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FMT_LIST} ${CONAN_CXX_FLAGS_FMT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FMT_RELEASE_LIST} ${CONAN_CXX_FLAGS_FMT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FMT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FMT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FMT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FMT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG}" "${CONAN_LIB_DIRS_LIBPNG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}"
                                  "" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBPNG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_DEBUG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_DEBUG}" "${CONAN_LIB_DIRS_LIBPNG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}"
                                  "debug" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBPNG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELEASE}" "${CONAN_LIB_DIRS_LIBPNG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}"
                                  "release" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBPNG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELWITHDEBINFO} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBPNG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBPNG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_MINSIZEREL} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBPNG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libpng)

    add_library(CONAN_PKG::libpng INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBPNG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBPNG_LIST} ${CONAN_CXX_FLAGS_LIBPNG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBPNG_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBPNG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBPNG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBPNG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBPNG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2}" "${CONAN_LIB_DIRS_BZIP2}"
                                  CONAN_PACKAGE_TARGETS_BZIP2 "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}"
                                  "" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BZIP2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BZIP2_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_DEBUG}" "${CONAN_LIB_DIRS_BZIP2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}"
                                  "debug" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BZIP2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELEASE}" "${CONAN_LIB_DIRS_BZIP2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}"
                                  "release" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BZIP2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BZIP2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BZIP2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BZIP2_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_MINSIZEREL}" "${CONAN_LIB_DIRS_BZIP2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" bzip2)

    add_library(CONAN_PKG::bzip2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BZIP2} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BZIP2_RELEASE} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BZIP2_DEBUG} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BZIP2_LIST} ${CONAN_CXX_FLAGS_BZIP2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BZIP2_RELEASE_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BZIP2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BZIP2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BZIP2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BZIP2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBALSA} ${CONAN_FRAMEWORKS_FOUND_LIBALSA} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA}" "${CONAN_LIB_DIRS_LIBALSA}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}"
                                  "" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBALSA_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_DEBUG}" "${CONAN_LIB_DIRS_LIBALSA_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_DEBUG "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}"
                                  "debug" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBALSA_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_RELEASE}" "${CONAN_LIB_DIRS_LIBALSA_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_RELEASE "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}"
                                  "release" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBALSA_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBALSA_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBALSA_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBALSA_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_MINSIZEREL "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libalsa)

    add_library(CONAN_PKG::libalsa INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBALSA} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBALSA_RELEASE} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBALSA_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBALSA_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBALSA_DEBUG} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBALSA}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBALSA_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBALSA_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBALSA_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBALSA_DEBUG}>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBALSA}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_DEBUG}>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBALSA_LIST} ${CONAN_CXX_FLAGS_LIBALSA_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBALSA_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBALSA_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBALSA_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBALSA_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBALSA_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OGG} ${CONAN_FRAMEWORKS_FOUND_OGG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG}" "${CONAN_LIB_DIRS_OGG}"
                                  CONAN_PACKAGE_TARGETS_OGG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}"
                                  "" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OGG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OGG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_DEBUG}" "${CONAN_LIB_DIRS_OGG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OGG_DEBUG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}"
                                  "debug" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OGG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OGG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_RELEASE}" "${CONAN_LIB_DIRS_OGG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OGG_RELEASE "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}"
                                  "release" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OGG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OGG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OGG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OGG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OGG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OGG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_MINSIZEREL}" "${CONAN_LIB_DIRS_OGG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OGG_MINSIZEREL "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" ogg)

    add_library(CONAN_PKG::ogg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OGG} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OGG_RELEASE} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OGG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OGG_MINSIZEREL} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OGG_DEBUG} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OGG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OGG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OGG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OGG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OGG_DEBUG}>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OGG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OGG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OGG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OGG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OGG_DEBUG}>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OGG_LIST} ${CONAN_CXX_FLAGS_OGG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OGG_RELEASE_LIST} ${CONAN_CXX_FLAGS_OGG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OGG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OGG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OGG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OGG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXRENDER} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRENDER}" "${CONAN_LIB_DIRS_LIBXRENDER}"
                                  CONAN_PACKAGE_TARGETS_LIBXRENDER "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES}"
                                  "" libxrender)
    set(_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXRENDER_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER_DEBUG} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRENDER_DEBUG}" "${CONAN_LIB_DIRS_LIBXRENDER_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXRENDER_DEBUG "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_DEBUG}"
                                  "debug" libxrender)
    set(_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXRENDER_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER_RELEASE} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRENDER_RELEASE}" "${CONAN_LIB_DIRS_LIBXRENDER_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXRENDER_RELEASE "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELEASE}"
                                  "release" libxrender)
    set(_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXRENDER_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER_RELWITHDEBINFO} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRENDER_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXRENDER_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXRENDER_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxrender)
    set(_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXRENDER_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXRENDER_MINSIZEREL} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXRENDER_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXRENDER_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXRENDER_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxrender)

    add_library(CONAN_PKG::libxrender INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxrender PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXRENDER} ${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRENDER_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXRENDER_RELEASE} ${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRENDER_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXRENDER_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRENDER_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXRENDER_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRENDER_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXRENDER_DEBUG} ${_CONAN_PKG_LIBS_LIBXRENDER_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXRENDER_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXRENDER_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxrender PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXRENDER}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXRENDER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXRENDER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXRENDER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXRENDER_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxrender PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXRENDER}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXRENDER_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXRENDER_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXRENDER_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXRENDER_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxrender PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXRENDER_LIST} ${CONAN_CXX_FLAGS_LIBXRENDER_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXRENDER_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXRENDER_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXRENDER_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXRENDER_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXRENDER_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXRENDER_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXRENDER_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXRENDER_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXEXT} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXEXT}" "${CONAN_LIB_DIRS_LIBXEXT}"
                                  CONAN_PACKAGE_TARGETS_LIBXEXT "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES}"
                                  "" libxext)
    set(_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXEXT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT_DEBUG} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXEXT_DEBUG}" "${CONAN_LIB_DIRS_LIBXEXT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXEXT_DEBUG "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_DEBUG}"
                                  "debug" libxext)
    set(_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXEXT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT_RELEASE} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXEXT_RELEASE}" "${CONAN_LIB_DIRS_LIBXEXT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXEXT_RELEASE "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELEASE}"
                                  "release" libxext)
    set(_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXEXT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT_RELWITHDEBINFO} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXEXT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXEXT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXEXT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxext)
    set(_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXEXT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXEXT_MINSIZEREL} CONAN_PKG::libx11")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXEXT_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXEXT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXEXT_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxext)

    add_library(CONAN_PKG::libxext INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxext PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXEXT} ${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXEXT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXEXT_RELEASE} ${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXEXT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXEXT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXEXT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXEXT_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXEXT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXEXT_DEBUG} ${_CONAN_PKG_LIBS_LIBXEXT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXEXT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXEXT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxext PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXEXT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXEXT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXEXT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXEXT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXEXT_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxext PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXEXT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXEXT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXEXT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXEXT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXEXT_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxext PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXEXT_LIST} ${CONAN_CXX_FLAGS_LIBXEXT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXEXT_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXEXT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXEXT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXEXT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXEXT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXEXT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXEXT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXEXT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB}" "${CONAN_LIB_DIRS_ZLIB}"
                                  CONAN_PACKAGE_TARGETS_ZLIB "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}"
                                  "" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_DEBUG}" "${CONAN_LIB_DIRS_ZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}"
                                  "debug" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELEASE}" "${CONAN_LIB_DIRS_ZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}"
                                  "release" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_ZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zlib)

    add_library(CONAN_PKG::zlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZLIB} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZLIB_RELEASE} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZLIB_DEBUG} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZLIB_LIST} ${CONAN_CXX_FLAGS_ZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZLIB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBX11} ${CONAN_FRAMEWORKS_FOUND_LIBX11} CONAN_PKG::xorgproto CONAN_PKG::xtrans CONAN_PKG::libxcb")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBX11_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBX11}" "${CONAN_LIB_DIRS_LIBX11}"
                                  CONAN_PACKAGE_TARGETS_LIBX11 "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES}"
                                  "" libx11)
    set(_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBX11_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBX11_DEBUG} CONAN_PKG::xorgproto CONAN_PKG::xtrans CONAN_PKG::libxcb")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBX11_DEBUG}" "${CONAN_LIB_DIRS_LIBX11_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBX11_DEBUG "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_DEBUG}"
                                  "debug" libx11)
    set(_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBX11_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBX11_RELEASE} CONAN_PKG::xorgproto CONAN_PKG::xtrans CONAN_PKG::libxcb")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBX11_RELEASE}" "${CONAN_LIB_DIRS_LIBX11_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBX11_RELEASE "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELEASE}"
                                  "release" libx11)
    set(_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBX11_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBX11_RELWITHDEBINFO} CONAN_PKG::xorgproto CONAN_PKG::xtrans CONAN_PKG::libxcb")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBX11_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBX11_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBX11_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libx11)
    set(_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBX11_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBX11_MINSIZEREL} CONAN_PKG::xorgproto CONAN_PKG::xtrans CONAN_PKG::libxcb")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBX11_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBX11_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBX11_MINSIZEREL "${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libx11)

    add_library(CONAN_PKG::libx11 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libx11 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBX11} ${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBX11_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBX11_RELEASE} ${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBX11_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBX11_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBX11_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBX11_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBX11_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBX11_DEBUG} ${_CONAN_PKG_LIBS_LIBX11_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBX11_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBX11_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libx11 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBX11}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBX11_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBX11_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBX11_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBX11_DEBUG}>)
    set_property(TARGET CONAN_PKG::libx11 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBX11}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBX11_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBX11_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBX11_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBX11_DEBUG}>)
    set_property(TARGET CONAN_PKG::libx11 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBX11_LIST} ${CONAN_CXX_FLAGS_LIBX11_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBX11_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBX11_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBX11_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBX11_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBX11_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBX11_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBX11_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBX11_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XTRANS} ${CONAN_FRAMEWORKS_FOUND_XTRANS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XTRANS_DEPENDENCIES "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XTRANS}" "${CONAN_LIB_DIRS_XTRANS}"
                                  CONAN_PACKAGE_TARGETS_XTRANS "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES}"
                                  "" xtrans)
    set(_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XTRANS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XTRANS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XTRANS_DEBUG}" "${CONAN_LIB_DIRS_XTRANS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XTRANS_DEBUG "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_DEBUG}"
                                  "debug" xtrans)
    set(_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XTRANS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XTRANS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XTRANS_RELEASE}" "${CONAN_LIB_DIRS_XTRANS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XTRANS_RELEASE "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELEASE}"
                                  "release" xtrans)
    set(_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XTRANS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XTRANS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XTRANS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XTRANS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XTRANS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xtrans)
    set(_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XTRANS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XTRANS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XTRANS_MINSIZEREL}" "${CONAN_LIB_DIRS_XTRANS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XTRANS_MINSIZEREL "${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xtrans)

    add_library(CONAN_PKG::xtrans INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xtrans PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XTRANS} ${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XTRANS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XTRANS_RELEASE} ${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XTRANS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XTRANS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XTRANS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XTRANS_MINSIZEREL} ${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XTRANS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XTRANS_DEBUG} ${_CONAN_PKG_LIBS_XTRANS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XTRANS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XTRANS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xtrans PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XTRANS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XTRANS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XTRANS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XTRANS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XTRANS_DEBUG}>)
    set_property(TARGET CONAN_PKG::xtrans PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XTRANS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XTRANS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XTRANS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XTRANS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XTRANS_DEBUG}>)
    set_property(TARGET CONAN_PKG::xtrans PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XTRANS_LIST} ${CONAN_CXX_FLAGS_XTRANS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XTRANS_RELEASE_LIST} ${CONAN_CXX_FLAGS_XTRANS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XTRANS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XTRANS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XTRANS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XTRANS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XTRANS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XTRANS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXCB} ${CONAN_FRAMEWORKS_FOUND_LIBXCB} CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXCB}" "${CONAN_LIB_DIRS_LIBXCB}"
                                  CONAN_PACKAGE_TARGETS_LIBXCB "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES}"
                                  "" libxcb)
    set(_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXCB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXCB_DEBUG} CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXCB_DEBUG}" "${CONAN_LIB_DIRS_LIBXCB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXCB_DEBUG "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_DEBUG}"
                                  "debug" libxcb)
    set(_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXCB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXCB_RELEASE} CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXCB_RELEASE}" "${CONAN_LIB_DIRS_LIBXCB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXCB_RELEASE "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELEASE}"
                                  "release" libxcb)
    set(_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXCB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXCB_RELWITHDEBINFO} CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXCB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXCB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXCB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxcb)
    set(_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXCB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXCB_MINSIZEREL} CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXCB_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXCB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXCB_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxcb)

    add_library(CONAN_PKG::libxcb INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxcb PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXCB} ${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXCB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXCB_RELEASE} ${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXCB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXCB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXCB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXCB_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXCB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXCB_DEBUG} ${_CONAN_PKG_LIBS_LIBXCB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXCB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXCB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxcb PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXCB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXCB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXCB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXCB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXCB_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxcb PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXCB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXCB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXCB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXCB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXCB_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxcb PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXCB_LIST} ${CONAN_CXX_FLAGS_LIBXCB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXCB_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXCB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXCB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXCB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXCB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXCB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXCB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXCB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XCB-PROTO} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XCB-PROTO}" "${CONAN_LIB_DIRS_XCB-PROTO}"
                                  CONAN_PACKAGE_TARGETS_XCB-PROTO "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES}"
                                  "" xcb-proto)
    set(_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XCB-PROTO_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XCB-PROTO_DEBUG}" "${CONAN_LIB_DIRS_XCB-PROTO_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XCB-PROTO_DEBUG "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_DEBUG}"
                                  "debug" xcb-proto)
    set(_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XCB-PROTO_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XCB-PROTO_RELEASE}" "${CONAN_LIB_DIRS_XCB-PROTO_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XCB-PROTO_RELEASE "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELEASE}"
                                  "release" xcb-proto)
    set(_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XCB-PROTO_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XCB-PROTO_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XCB-PROTO_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XCB-PROTO_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xcb-proto)
    set(_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XCB-PROTO_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XCB-PROTO_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XCB-PROTO_MINSIZEREL}" "${CONAN_LIB_DIRS_XCB-PROTO_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XCB-PROTO_MINSIZEREL "${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xcb-proto)

    add_library(CONAN_PKG::xcb-proto INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xcb-proto PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XCB-PROTO} ${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XCB-PROTO_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XCB-PROTO_RELEASE} ${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XCB-PROTO_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XCB-PROTO_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XCB-PROTO_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XCB-PROTO_MINSIZEREL} ${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XCB-PROTO_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XCB-PROTO_DEBUG} ${_CONAN_PKG_LIBS_XCB-PROTO_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XCB-PROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XCB-PROTO_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xcb-proto PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XCB-PROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XCB-PROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XCB-PROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XCB-PROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XCB-PROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xcb-proto PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XCB-PROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XCB-PROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XCB-PROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XCB-PROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XCB-PROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xcb-proto PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XCB-PROTO_LIST} ${CONAN_CXX_FLAGS_XCB-PROTO_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XCB-PROTO_RELEASE_LIST} ${CONAN_CXX_FLAGS_XCB-PROTO_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XCB-PROTO_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XCB-PROTO_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XCB-PROTO_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XCB-PROTO_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XCB-PROTO_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XCB-PROTO_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_UTIL-MACROS} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTIL-MACROS}" "${CONAN_LIB_DIRS_UTIL-MACROS}"
                                  CONAN_PACKAGE_TARGETS_UTIL-MACROS "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES}"
                                  "" util-macros)
    set(_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_UTIL-MACROS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTIL-MACROS_DEBUG}" "${CONAN_LIB_DIRS_UTIL-MACROS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_UTIL-MACROS_DEBUG "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_DEBUG}"
                                  "debug" util-macros)
    set(_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_UTIL-MACROS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTIL-MACROS_RELEASE}" "${CONAN_LIB_DIRS_UTIL-MACROS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_UTIL-MACROS_RELEASE "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELEASE}"
                                  "release" util-macros)
    set(_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_UTIL-MACROS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTIL-MACROS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_UTIL-MACROS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_UTIL-MACROS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" util-macros)
    set(_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_UTIL-MACROS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_UTIL-MACROS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTIL-MACROS_MINSIZEREL}" "${CONAN_LIB_DIRS_UTIL-MACROS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_UTIL-MACROS_MINSIZEREL "${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" util-macros)

    add_library(CONAN_PKG::util-macros INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::util-macros PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_UTIL-MACROS} ${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_UTIL-MACROS_RELEASE} ${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_UTIL-MACROS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_UTIL-MACROS_MINSIZEREL} ${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_UTIL-MACROS_DEBUG} ${_CONAN_PKG_LIBS_UTIL-MACROS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTIL-MACROS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTIL-MACROS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::util-macros PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_UTIL-MACROS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_UTIL-MACROS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_UTIL-MACROS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_UTIL-MACROS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_UTIL-MACROS_DEBUG}>)
    set_property(TARGET CONAN_PKG::util-macros PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_UTIL-MACROS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_UTIL-MACROS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_UTIL-MACROS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_UTIL-MACROS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_UTIL-MACROS_DEBUG}>)
    set_property(TARGET CONAN_PKG::util-macros PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_UTIL-MACROS_LIST} ${CONAN_CXX_FLAGS_UTIL-MACROS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_UTIL-MACROS_RELEASE_LIST} ${CONAN_CXX_FLAGS_UTIL-MACROS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_UTIL-MACROS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_UTIL-MACROS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_UTIL-MACROS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_UTIL-MACROS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_UTIL-MACROS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_UTIL-MACROS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXAU} ${CONAN_FRAMEWORKS_FOUND_LIBXAU} CONAN_PKG::xorgproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXAU}" "${CONAN_LIB_DIRS_LIBXAU}"
                                  CONAN_PACKAGE_TARGETS_LIBXAU "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES}"
                                  "" libxau)
    set(_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXAU_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXAU_DEBUG} CONAN_PKG::xorgproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXAU_DEBUG}" "${CONAN_LIB_DIRS_LIBXAU_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXAU_DEBUG "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_DEBUG}"
                                  "debug" libxau)
    set(_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXAU_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXAU_RELEASE} CONAN_PKG::xorgproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXAU_RELEASE}" "${CONAN_LIB_DIRS_LIBXAU_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXAU_RELEASE "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELEASE}"
                                  "release" libxau)
    set(_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXAU_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXAU_RELWITHDEBINFO} CONAN_PKG::xorgproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXAU_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXAU_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXAU_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxau)
    set(_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXAU_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXAU_MINSIZEREL} CONAN_PKG::xorgproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXAU_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXAU_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXAU_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxau)

    add_library(CONAN_PKG::libxau INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxau PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXAU} ${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXAU_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXAU_RELEASE} ${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXAU_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXAU_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXAU_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXAU_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXAU_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXAU_DEBUG} ${_CONAN_PKG_LIBS_LIBXAU_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXAU_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXAU_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxau PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXAU}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXAU_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXAU_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXAU_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXAU_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxau PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXAU}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXAU_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXAU_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXAU_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXAU_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxau PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXAU_LIST} ${CONAN_CXX_FLAGS_LIBXAU_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXAU_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXAU_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXAU_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXAU_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXAU_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXAU_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXAU_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXAU_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPTHREAD-STUBS}" "${CONAN_LIB_DIRS_LIBPTHREAD-STUBS}"
                                  CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES}"
                                  "" libpthread-stubs)
    set(_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEBUG}" "${CONAN_LIB_DIRS_LIBPTHREAD-STUBS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_DEBUG "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_DEBUG}"
                                  "debug" libpthread-stubs)
    set(_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPTHREAD-STUBS_RELEASE}" "${CONAN_LIB_DIRS_LIBPTHREAD-STUBS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_RELEASE "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELEASE}"
                                  "release" libpthread-stubs)
    set(_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPTHREAD-STUBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBPTHREAD-STUBS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libpthread-stubs)
    set(_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBPTHREAD-STUBS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBPTHREAD-STUBS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPTHREAD-STUBS_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBPTHREAD-STUBS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libpthread-stubs)

    add_library(CONAN_PKG::libpthread-stubs INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libpthread-stubs PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS} ${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_RELEASE} ${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBPTHREAD-STUBS_DEBUG} ${_CONAN_PKG_LIBS_LIBPTHREAD-STUBS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPTHREAD-STUBS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPTHREAD-STUBS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libpthread-stubs PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBPTHREAD-STUBS_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpthread-stubs PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBPTHREAD-STUBS_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpthread-stubs PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBPTHREAD-STUBS_LIST} ${CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBPTHREAD-STUBS_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBPTHREAD-STUBS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBPTHREAD-STUBS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBPTHREAD-STUBS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBPTHREAD-STUBS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBXDMCP} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP} CONAN_PKG::xproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXDMCP}" "${CONAN_LIB_DIRS_LIBXDMCP}"
                                  CONAN_PACKAGE_TARGETS_LIBXDMCP "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES}"
                                  "" libxdmcp)
    set(_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBXDMCP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP_DEBUG} CONAN_PKG::xproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXDMCP_DEBUG}" "${CONAN_LIB_DIRS_LIBXDMCP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBXDMCP_DEBUG "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_DEBUG}"
                                  "debug" libxdmcp)
    set(_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBXDMCP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP_RELEASE} CONAN_PKG::xproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXDMCP_RELEASE}" "${CONAN_LIB_DIRS_LIBXDMCP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBXDMCP_RELEASE "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELEASE}"
                                  "release" libxdmcp)
    set(_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBXDMCP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP_RELWITHDEBINFO} CONAN_PKG::xproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXDMCP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBXDMCP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBXDMCP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libxdmcp)
    set(_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBXDMCP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBXDMCP_MINSIZEREL} CONAN_PKG::xproto")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBXDMCP_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBXDMCP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBXDMCP_MINSIZEREL "${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libxdmcp)

    add_library(CONAN_PKG::libxdmcp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libxdmcp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBXDMCP} ${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXDMCP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBXDMCP_RELEASE} ${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXDMCP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBXDMCP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXDMCP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBXDMCP_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXDMCP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBXDMCP_DEBUG} ${_CONAN_PKG_LIBS_LIBXDMCP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBXDMCP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBXDMCP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libxdmcp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBXDMCP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBXDMCP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBXDMCP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBXDMCP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBXDMCP_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxdmcp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBXDMCP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBXDMCP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBXDMCP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBXDMCP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBXDMCP_DEBUG}>)
    set_property(TARGET CONAN_PKG::libxdmcp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBXDMCP_LIST} ${CONAN_CXX_FLAGS_LIBXDMCP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBXDMCP_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBXDMCP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBXDMCP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBXDMCP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBXDMCP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBXDMCP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBXDMCP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBXDMCP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XORGPROTO} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORGPROTO}" "${CONAN_LIB_DIRS_XORGPROTO}"
                                  CONAN_PACKAGE_TARGETS_XORGPROTO "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES}"
                                  "" xorgproto)
    set(_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XORGPROTO_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORGPROTO_DEBUG}" "${CONAN_LIB_DIRS_XORGPROTO_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XORGPROTO_DEBUG "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_DEBUG}"
                                  "debug" xorgproto)
    set(_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XORGPROTO_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORGPROTO_RELEASE}" "${CONAN_LIB_DIRS_XORGPROTO_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XORGPROTO_RELEASE "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELEASE}"
                                  "release" xorgproto)
    set(_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XORGPROTO_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORGPROTO_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XORGPROTO_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XORGPROTO_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xorgproto)
    set(_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XORGPROTO_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XORGPROTO_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORGPROTO_MINSIZEREL}" "${CONAN_LIB_DIRS_XORGPROTO_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XORGPROTO_MINSIZEREL "${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xorgproto)

    add_library(CONAN_PKG::xorgproto INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xorgproto PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XORGPROTO} ${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORGPROTO_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XORGPROTO_RELEASE} ${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORGPROTO_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XORGPROTO_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORGPROTO_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XORGPROTO_MINSIZEREL} ${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORGPROTO_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XORGPROTO_DEBUG} ${_CONAN_PKG_LIBS_XORGPROTO_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORGPROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORGPROTO_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xorgproto PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XORGPROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XORGPROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XORGPROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XORGPROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XORGPROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorgproto PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XORGPROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XORGPROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XORGPROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XORGPROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XORGPROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorgproto PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XORGPROTO_LIST} ${CONAN_CXX_FLAGS_XORGPROTO_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XORGPROTO_RELEASE_LIST} ${CONAN_CXX_FLAGS_XORGPROTO_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XORGPROTO_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XORGPROTO_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XORGPROTO_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XORGPROTO_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XORGPROTO_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XORGPROTO_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XPROTO} ${CONAN_FRAMEWORKS_FOUND_XPROTO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XPROTO_DEPENDENCIES "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XPROTO}" "${CONAN_LIB_DIRS_XPROTO}"
                                  CONAN_PACKAGE_TARGETS_XPROTO "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES}"
                                  "" xproto)
    set(_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XPROTO_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XPROTO_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XPROTO_DEBUG}" "${CONAN_LIB_DIRS_XPROTO_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XPROTO_DEBUG "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_DEBUG}"
                                  "debug" xproto)
    set(_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XPROTO_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XPROTO_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XPROTO_RELEASE}" "${CONAN_LIB_DIRS_XPROTO_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XPROTO_RELEASE "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELEASE}"
                                  "release" xproto)
    set(_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XPROTO_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XPROTO_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XPROTO_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XPROTO_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XPROTO_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xproto)
    set(_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XPROTO_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XPROTO_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XPROTO_MINSIZEREL}" "${CONAN_LIB_DIRS_XPROTO_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XPROTO_MINSIZEREL "${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xproto)

    add_library(CONAN_PKG::xproto INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xproto PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XPROTO} ${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XPROTO_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XPROTO_RELEASE} ${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XPROTO_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XPROTO_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XPROTO_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XPROTO_MINSIZEREL} ${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XPROTO_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XPROTO_DEBUG} ${_CONAN_PKG_LIBS_XPROTO_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XPROTO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XPROTO_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xproto PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XPROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XPROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XPROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XPROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XPROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xproto PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XPROTO}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XPROTO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XPROTO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XPROTO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XPROTO_DEBUG}>)
    set_property(TARGET CONAN_PKG::xproto PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XPROTO_LIST} ${CONAN_CXX_FLAGS_XPROTO_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XPROTO_RELEASE_LIST} ${CONAN_CXX_FLAGS_XPROTO_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XPROTO_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XPROTO_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XPROTO_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XPROTO_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XPROTO_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XPROTO_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::box2d CONAN_PKG::sfml CONAN_PKG::entt CONAN_PKG::spdlog CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::vorbis CONAN_PKG::libxrandr CONAN_PKG::opengl CONAN_PKG::fmt CONAN_PKG::libpng CONAN_PKG::bzip2 CONAN_PKG::libalsa CONAN_PKG::ogg CONAN_PKG::libxrender CONAN_PKG::libxext CONAN_PKG::zlib CONAN_PKG::libx11 CONAN_PKG::xtrans CONAN_PKG::libxcb CONAN_PKG::xcb-proto CONAN_PKG::util-macros CONAN_PKG::libxau CONAN_PKG::libpthread-stubs CONAN_PKG::libxdmcp CONAN_PKG::xorgproto CONAN_PKG::xproto)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()


macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()


macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()


macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        conan_get_policy(CMP0091 policy_0091)
        if(policy_0091 STREQUAL "NEW")
            if(CONAN_LINK_RUNTIME MATCHES "MTd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
            elseif(CONAN_LINK_RUNTIME MATCHES "MDd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
            elseif(CONAN_LINK_RUNTIME MATCHES "MT")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
            elseif(CONAN_LINK_RUNTIME MATCHES "MD")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
            endif()
        else()
            foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                         CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                         CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
                if(DEFINED ${flag})
                    string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
            foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
                if(DEFINED ${flag})
                    string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
        endif()
    endif()
endmacro()


macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()


function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


function(conan_get_policy policy_id policy)
    if(POLICY "${policy_id}")
        cmake_policy(GET "${policy_id}" _policy)
        set(${policy} "${_policy}" PARENT_SCOPE)
    else()
        set(${policy} "" PARENT_SCOPE)
    endif()
endfunction()


function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
            set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    # Add all dependencies to all targets
    string(REPLACE " " ";" deps_list "${deps}")
    foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
        set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
    endforeach()

    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()


macro(conan_set_std)
    conan_message(STATUS "Conan: Adjusting language standard")
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
        if(CONAN_STD_CXX_FLAG)
            conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
            set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
        endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()


macro(conan_set_rpath)
    conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        set(CMAKE_SKIP_RPATH 1)  # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
                                 # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()


macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()


macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()


macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()


macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: \n"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}\n"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}\n"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])"
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})

function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    # MATCHALL will match all, including the last one, which is the full_settings one
    string(REGEX MATCH "full_settings.*" _FULL_SETTINGS_MATCHED ${CONANINFO})
    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()


function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL CONAN_COMPILER_VERSION)
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL CONAN_COMPILER_VERSION)
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "intel")
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 19.1)
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
               conan_error_compiler_version()
            endif()
        else()
            if(NOT ${VERSION_MAJOR} VERSION_EQUAL ${CONAN_COMPILER_VERSION})
               conan_error_compiler_version()
            endif()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()


function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()


macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()


macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()


macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()


macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

set(CONAN_USER_FREETYPE_LIBTOOL_VERSION "23.0.17")