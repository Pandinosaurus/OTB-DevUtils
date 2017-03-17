# Client maintainer: julien.malik@c-s.fr
set(dashboard_model Nightly)
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CONFIGURATION_TYPE Release)
set(CTEST_BUILD_NAME "MacOSX10.10-SuperBuild")
set(dashboard_no_install 1)
set(CTEST_BUILD_FLAGS "-j4 -k" )

set(CTEST_TEST_ARGS PARALLEL_LEVEL 3)
include(${CTEST_SCRIPT_DIRECTORY}/leod_common.cmake)

set(dashboard_source_name "nightly/OTB-${CTEST_BUILD_CONFIGURATION}/src/SuperBuild")
set(dashboard_binary_name "nightly/OTB-SuperBuild/build")
set(dashboard_update_dir ${CTEST_DASHBOARD_ROOT}/nightly/OTB-${CTEST_BUILD_CONFIGURATION}/src)

set(OTB_INSTALL_PREFIX ${CTEST_DASHBOARD_ROOT}/nightly/OTB-SuperBuild/install)

list(APPEND CTEST_TEST_ARGS
  BUILD ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build
)

#OTB_ADDITIONAL_CACHE:STRING='-DOTB_SHOW_ALL_MSG_DEBUG:BOOL=ON'

macro(dashboard_hook_init)
set(dashboard_cache "
CMAKE_INSTALL_PREFIX:PATH=${OTB_INSTALL_PREFIX}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}
CMAKE_VERBOSE_MAKEFILE:BOOL=OFF
CMAKE_CXX_FLAGS:STRING='-std=c++11'
BUILD_TESTING:BOOL=ON
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=$ENV{HOME}/Data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Data/OTB-Data
DOWNLOAD_LOCATION:PATH=/media/otbnas/otb/DataForTests/SuperBuild-archives

ENABLE_MONTEVERDI:BOOL=ON

OTB_USE_OPENGL:BOOL=ON
OTB_USE_GLEW:BOOL=ON
OTB_USE_QWT:BOOL=ON
OTB_USE_SHARK:BOOL=ON

USE_SYSTEM_SWIG:BOOL=ON
USE_SYSTEM_PCRE:BOOL=ON

GENERATE_PACKAGE:BOOL=OFF
OTB_WRAP_PYTHON:BOOL=ON
OTB_WRAP_JAVA:BOOL=OFF

")
endmacro()

#OTB_ADDITIONAL_CACHE:STRING='-DOTB_SHOW_ALL_MSG_DEBUG:BOOL=ON'

macro(dashboard_hook_test)
  set(ENV{LD_LIBRARY_PATH} ${OTB_INSTALL_PREFIX}/lib)
endmacro()

list(APPEND CTEST_NOTES_FILES
  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/CMakeCache.txt
  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/otbConfigure.h
)

execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${OTB_INSTALL_PREFIX})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX}/lib)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX}/bin)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX}/include)


include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
