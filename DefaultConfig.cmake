cmake_minimum_required(VERSION 3.5)

# build type
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	message(STATUS "Setting build type to 'MinSizeRel' as none was specified.")
	set(CMAKE_BUILD_TYPE MinSizeRel CACHE STRING "Choose the type of build." FORCE)
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()
string(TOUPPER "${CMAKE_BUILD_TYPE}" U_CMAKE_BUILD_TYPE)

# cflags
set(CMAKE_CXX_STANDARD 11)
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
	if(NOT "${U_CMAKE_BUILD_TYPE}" MATCHES DEBUG)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden")
		
		include(CheckCXXCompilerFlag)
		CHECK_CXX_COMPILER_FLAG("-flto" HAS_LTO_FLAG)
		if(HAS_LTO_FLAG)
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -flto")
		endif()
	endif()
endif()

