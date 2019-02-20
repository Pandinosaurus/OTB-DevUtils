set (ENV{DISPLAY} ":0.0")
set (ENV{LANG} "C")

set (CTEST_BUILD_CONFIGURATION "Debug")
# set (CTEST_BUILD_CONFIGURATION "RelWithDebInfo")
# set (CTEST_BUILD_CONFIGURATION "Release")

set( CTEST_BUILD_SUFFIX "" )
# set( CTEST_BUILD_SUFFIX "-gcc" )
# set( CTEST_BUILD_SUFFIX "-clang" )

set (CTEST_SOURCE_DIRECTORY "$ENV{HOME}/dev/source/otb")
set (CTEST_BINARY_DIRECTORY "$ENV{HOME}/dev/build/otb-${CTEST_BUILD_CONFIGURATION}${CTEST_BUILD_SUFFIX}")

set (CTEST_CMAKE_GENERATOR  "Unix Makefiles" )
set (CTEST_CMAKE_COMMAND "cmake" )
set (CTEST_BUILD_COMMAND "/usr/bin/make -j4 -k install" )
# set (CTEST_BUILD_COMMAND "/usr/bin/make install" )
set (CTEST_SITE "po9573lx.c-s.fr" )
set (CTEST_BUILD_NAME "Ubuntu-14.04_x86_64_${CTEST_BUILD_CONFIGURATION}${CTEST_BUILD_SUFFIX}-$ENV{USER}")
# set (CTEST_GIT_COMMAND "/usr/bin/git")
# set (CTEST_GIT_UPDATE_OPTIONS "")
set (CTEST_USE_LAUNCHERS ON)

set (OTB_INSTALL_PREFIX "$ENV{HOME}/dev/install/otb-${CTEST_BUILD_CONFIGURATION}${CTEST_BUILD_SUFFIX}")

set (OTB_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

OTB_DATA_USE_LARGEINPUT:BOOL=OFF
OTB_DATA_LARGEINPUT_ROOT:STRING=/media/otbnas/otb/OTB-LargeInput/
OTB_DATA_ROOT:STRING=$ENV{HOME}/dev/source/otb/Data

CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}

CMAKE_C_FLAGS:STRING+= -Wall -Wextra -Wshadow
CMAKE_CXX_FLAGS:STRING+= -Wall -Wextra -Wshadow

# CMAKE_C_COMPILER=/usr/bin/gcc-5
# CMAKE_CXX_COMPILER=/usr/bin/g++-5
# CMAKE_C_COMPILER=/usr/bin/clang
# CMAKE_CXX_COMPILER=/usr/bin/clang++

# Instrumentation
# CMAKE_C_FLAGS_RELWITHDEBINFO:STRING+= -fsanitize=address,undefined -fno-omit-frame-pointer
# CMAKE_CXX_FLAGS_RELWITHDEBINFO:STRING+=  -fsanitize=address,undefined -fno-omit-frame-pointer


BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=OFF
#OTB-5# BUILD_APPLICATIONS:BOOL=ON

OTB_USE_6S:BOOL=ON
OTB_USE_CURL:BOOL=ON
OTB_USE_LIBKML:BOOL=ON
OTB_USE_LIBSVM:BOOL=ON
#
# OTB_USE_MAPNIK:BOOL=OFF
OTB_USE_MUPARSER:BOOL=ON
OTB_USE_MUPARSERX:BOOL=ON
OTB_USE_OPENCV:BOOL=ON
OTB_USE_OPENJPEG:BOOL=OFF
OTB_USE_QT:BOOL=ON
OTB_USE_SHARK:BOOL=OFF
#
# Ice
OTB_USE_OPENGL:BOOL=ON
OTB_USE_GLEW:BOOL=ON
OTB_USE_GLUT:BOOL=ON
#
# Monteverdi
OTB_USE_QWT:BOOL=ON
# Module_OTBQGIS:BOOL=OFF
# OTBQGIS_IS_TEST:BOOL=ON
#
# Wrappers
OTB_WRAP_PYTHON:BOOL=ON

ITK_DIR:PATH=$ENV{HOME}/ssd/dev/build/ITK-4.13-Debug/
# ITK_DIR:PATH=$ENV{HOME}/dev/install/ITK-4.13-Debug/lib/cmake/ITK-4.13
# ITK_DIR:PATH=$ENV{HOME}/dev/install/ITK-4.13-Debug_static/lib/cmake/ITK-4.13
# ITK_DIR:PATH=/mnt/ssd/home/salbert/dev/install/ITK-4.13-Debug/lib/cmake/ITK-4.13

# MAPNIK_INCLUDE_DIR:PATH=/ORFEO/otbval/OTB-OUTILS/mapnik/install/include
# MAPNIK_LIBRARY:FILEPATH=/ORFEO/otbval/OTB-OUTILS/mapnik/install/lib/libmapnik.so

CMAKE_INSTALL_PREFIX:STRING=${OTB_INSTALL_PREFIX}

## OTB-5

# MUPARSERX_LIBRARY:PATH=$ENV{HOME}/local/lib/libmuparserx.so
# MUPARSERX_INCLUDE_DIR:PATH=$ENV{HOME}/local/include

# use custom libkml install because official package has undefined symbols
# LIBKML_INCLUDE_DIR:PATH=$ENV{HOME}/Tools/libkml/install/include
# LIBKML_BASE_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmlbase.so
# LIBKML_CONVENIENCE_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmlconvenience.so
# LIBKML_DOM_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmldom.so
# LIBKML_ENGINE_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmlengine.so
# LIBKML_MINIZIP_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libminizip.so
# LIBKML_REGIONATOR_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmlregionator.so
# LIBKML_XSD_LIBRARY:FILEPATH=$ENV{HOME}/Tools/libkml/install/lib/libkmlxsd.so

# OpenJPEG_DIR:PATH=$ENV{HOME}/local/lib/openjpeg-2.1

# OSSIM_INCLUDE_DIR:STRING=$ENV{HOME}/local/include
# OSSIM_LIBRARY:FILEPATH=$ENV{HOME}/local/lib/libossim.so

# GDAL_INCLUDE_DIR:STRING=$ENV{HOME}/local/include
# GDAL_LIBRARY:FILEPATH=$ENV{HOME}/local/lib/libgdal.so

# Ice
# GLFW_INCLUDE_DIR=$ENV{HOME}/local/include
# GLFW_LIBRARY=$ENV{HOME}/local/lib/libglfw.so

# QWT
# QWT_INCLUDE_DIR=$ENV{HOME}/local/include/qwt-6.1.3
# QWT_LIBRARY=$ENV{HOME}/local/lib/qwt-6.1.3/libqwt.so
# QWT_INCLUDE_DIR=/usr/include/qwt
# QWT_LIBRARY=$ENV/usr/lib/libqwt-qt5.so

# Monteverdi
OTB_I18N_MERGE_TS:BOOL=OFF
")

set (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

execute_process(COMMAND ${CTEST_CMAKE_COMMAND} -E remove_directory ${OTB_INSTALL_PREFIX})
execute_process(COMMAND ${CTEST_CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX})
ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})

ctest_start(Experimental)
# ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${OTB_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()
