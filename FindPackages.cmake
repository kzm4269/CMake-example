cmake_minimum_required(VERSION 3.6)

# Python
find_package(PythonLibs REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})
link_directories("${PYTHON_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${PYTHON_LIBRARIES})
message("PYTHON_INCLUDE_DIRS: ${PYTHON_INCLUDE_DIRS}")
message("PYTHON_LIBRARY_DIRS: ${PYTHON_LIBRARY_DIRS}")
message("PYTHON_LIBRARIES: ${PYTHON_LIBRARIES}")

# HDF5
find_package(HDF5 REQUIRED)
include_directories(${HDF5_INCLUDE_DIRS})
link_directories("${HDF5_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${LIBRARIES} ${HDF5_LIBRARIES})
message("HDF5_INCLUDE_DIRS: ${HDF5_INCLUDE_DIRS}")
message("HDF5_LIBRARY_DIRS: ${HDF5_LIBRARY_DIRS}")
message("HDF5_LIBRARIES: ${HDF5_LIBRARIES}")

# OpenGL
find_package(OpenGL REQUIRED)
include_directories(${OPENGL_INCLUDE_DIRS})
link_directories("${OPENGL_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${OPENGL_LIBRARIES})
message("OPENGL_INCLUDE_DIRS: ${OPENGL_INCLUDE_DIRS}")
message("OPENGL_LIBRARY_DIRS: ${OPENGL_LIBRARY_DIRS}")
message("OPENGL_LIBRARIES: ${OPENGL_LIBRARIES}")

# GLUT
find_package(GLUT REQUIRED)
include_directories(${GLUT_INCLUDE_DIR})
link_directories("${GLUT_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${GLUT_LIBRARIES})
message("GLUT_INCLUDE_DIRS: ${GLUT_INCLUDE_DIRS}")
message("GLUT_LIBRARY_DIRS: ${GLUT_LIBRARY_DIRS}")
message("GLUT_LIBRARIES: ${GLUT_LIBRARIES}")

# X11
find_package(X11 REQUIRED)
include_directories(${X11_INCLUDE_DIR})
link_directories("${X11_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${X11_LIBRARIES})
message("X11_INCLUDE_DIRS: ${X11_INCLUDE_DIRS}")
message("X11_LIBRARY_DIRS: ${X11_LIBRARY_DIRS}")
message("X11_LIBRARIES: ${X11_LIBRARIES}")


# OpenCV
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories("${OpenCV_LIBRARY_DIRS}")
set(ALL_LIBRARIES ${ALL_LIBRARIES} ${OpenCV_LIBRARIES})
message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}")
message("OpenCV_LIBRARY_DIRS: ${OpenCV_LIBRARY_DIRS}")
message("OpenCV_LIBRARIES: ${OpenCV_LIBRARIES}")


# conan
execute_process(COMMAND conan install "${CMAKE_SOURCE_DIR}")
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
include_directories(SYSTEM ${CONAN_INCLUDE_DIRS})
message("CONAN_INCLUDE_DIRS: ${CONAN_INCLUDE_DIRS}")

# setup
foreach(library IN LISTS ALL_LIBRARIES)
	string(REGEX REPLACE "(/[^;]*)/lib[^;]*(.so|.a)" "\\1" library "${library}")
	link_directories("${library}")
endforeach()
string(REGEX REPLACE "/[^;]*/lib([^;]*)(.so|.a)" "\\1" ALL_LIBRARIES "${ALL_LIBRARIES}")
list(REMOVE_DUPLICATES ALL_LIBRARIES)
