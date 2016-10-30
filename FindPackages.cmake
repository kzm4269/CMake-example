cmake_minimum_required(VERSION 3.5)

# Python
find_package(PythonLibs REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})
link_directories("${PYTHON_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${PYTHON_LIBRARIES})

# HDF5
find_package(HDF5 REQUIRED)
include_directories(${HDF5_INCLUDE_DIRS})
link_directories("${HDF5_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${LIBRARIES} ${HDF5_LIBRARIES})
foreach(library IN LISTS HDF5_LIBRARIES)
	string(REGEX REPLACE "/libhdf5\." "/libhdf5_cpp\." library "${library}")
	set(ALL_LIBRARIES ${ALL_LIBRARIES} "${library}")
endforeach()

# OpenGL
find_package(OpenGL REQUIRED)
include_directories(${OPENGL_INCLUDE_DIRS})
link_directories("${OPENCV_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${OPENGL_LIBRARIES})

# GLUT
find_package(GLUT REQUIRED)
include_directories(${GLUT_INCLUDE_DIR})
link_directories("${GLUT_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${GLUT_LIBRARIES})

# X11
find_package(X11 REQUIRED)
include_directories(${X11_INCLUDE_DIR})
link_directories("${X11_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${X11_LIBRARIES})


# conan
execute_process(COMMAND conan install "${CMAKE_SOURCE_DIR}")
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
include_directories(SYSTEM ${CONAN_INCLUDE_DIRS})

# setup
foreach(library IN LISTS ALL_LIBRARIES)
	string(REGEX REPLACE "(/[^;]*)/lib[^;]*(.so|.a)" "\\1" library "${library}")
	link_directories("${library}")
endforeach()
string(REGEX REPLACE "/[^;]*/lib([^;]*)(.so|.a)" "\\1" ALL_LIBRARIES "${ALL_LIBRARIES}")
list(REMOVE_DUPLICATES ALL_LIBRARIES)
