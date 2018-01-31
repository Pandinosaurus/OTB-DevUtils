set(dashboard_model Nightly)
set(CTEST_DASHBOARD_ROOT "$ENV{HOME}/dashboard")
set(CTEST_SITE "arcee.c-s.fr")
set(CTEST_BUILD_CONFIGURATION Debug)
set(CTEST_BUILD_NAME "Debian-gcc-6.2.1-x86_64-SuperBuild-Debug")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_FLAGS "-k" )
set(CTEST_TEST_ARGS PARALLEL_LEVEL 3)
set(CTEST_TEST_TIMEOUT 1500)

set(dashboard_source_name "otb/src/SuperBuild")
set(dashboard_binary_name "otb/build")
set(dashboard_update_dir ${CTEST_DASHBOARD_ROOT}/otb/src)

set(CTEST_INSTALL_DIRECTORY ${CTEST_DASHBOARD_ROOT}/otb/install)

#set(CTEST_DASHBOARD_TRACK "LatestRelease")
#set(dashboard_git_branch "release-5.10")

list(APPEND CTEST_TEST_ARGS
  BUILD ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build
)

macro(dashboard_hook_init)
set(dashboard_cache "
CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
CMAKE_CXX_FLAGS:STRING=-Wshift-negative-value -Wshift-overflow -Wtautological-compare -Wnull-dereference -Wduplicated-cond -Wmisleading-indentation -Wlogical-op -Wframe-address -Wno-deprecated-declarations
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}
OTB_DATA_ROOT:PATH=/home/otbval/dashboard/data/otb-data
DOWNLOAD_LOCATION:PATH=/media/otbnas/otb/DataForTests/SuperBuild-archives
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/media/otbnas/otb/OTB-LargeInput
CMAKE_VERBOSE_MAKEFILE:BOOL=OFF

BUILD_TESTING:BOOL=ON

USE_SYSTEM_FREETYPE:BOOL=OFF
QT4_SB_ENABLE_GTK:BOOL=OFF

USE_SYSTEM_SWIG:BOOL=ON
USE_SYSTEM_PCRE:BOOL=ON
OTB_WRAP_PYTHON:BOOL=ON

OTB_USE_OPENGL:BOOL=ON
OTB_USE_GLEW:BOOL=ON
OTB_USE_QWT:BOOL=ON
OTB_USE_SHARK:BOOL=ON

OTB_WRAP_JAVA:BOOL=OFF

GENERATE_PACKAGE:BOOL=OFF

OTB_ADDITIONAL_CACHE:STRING='-DModule_Mosaic:BOOL=ON;-DModule_SertitObject:BOOL=ON;-DModule_otbGRM:BOOL=ON'
")
endmacro()


macro(dashboard_hook_test)
  set(ENV{LD_LIBRARY_PATH} ${CTEST_INSTALL_DIRECTORY}/lib)
endmacro()

list(APPEND CTEST_NOTES_FILES
  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/CMakeCache.txt
)

#  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/otbConfigure.h

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
