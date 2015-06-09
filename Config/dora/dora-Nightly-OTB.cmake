# Client maintainer: julien.malik@c-s.fr
set(dashboard_model Nightly)
set(CTEST_DASHBOARD_ROOT "/home/otbval/Dashboard")
set(CTEST_SITE "dora.c-s.fr")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "Ubuntu12.04-64bits-${CTEST_BUILD_CONFIGURATION}")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_COMMAND "/usr/bin/make -j8 -i -k install" )
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_TEST_TIMEOUT 500)

set(CTEST_HG_COMMAND "/usr/bin/hg")
set(CTEST_HG_UPDATE_OPTIONS "-C")

string(TOLOWER ${dashboard_model} lcdashboard_model)

set(dashboard_root_name "tests")
set(dashboard_source_name "${lcdashboard_model}/OTB-${CTEST_BUILD_CONFIGURATION}/src")
set(dashboard_binary_name "${lcdashboard_model}/OTB-${CTEST_BUILD_CONFIGURATION}/build")

set(OTB_INSTALL_PREFIX ${CTEST_DASHBOARD_ROOT}/${lcdashboard_model}/OTB-${CTEST_BUILD_CONFIGURATION}/install)

#set(dashboard_fresh_source_checkout OFF)
set(dashboard_hg_url "http://hg.orfeo-toolbox.org/OTB-Nightly")
set(dashboard_hg_branch "default")

set(ENV{DISPLAY} ":0.0")
# disable GDAL OpenJpeg plugin for now due to symbol confusion (OTB-297)
#set(ENV{LD_LIBRARY_PATH} "/home/otbval/Tools/OpenJpeg/install/lib:$ENV{LD_LIBRARY_PATH}")
#set(ENV{GDAL_DRIVER_PATH} "/home/otbval/Tools/gdal_plugin")

macro(dashboard_hook_init)
  set(dashboard_cache "${dashboard_cache}

CMAKE_INSTALL_PREFIX:PATH=${OTB_INSTALL_PREFIX}

CMAKE_C_FLAGS:STRING=-fPIC -Wall -Wshadow -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING=-fPIC -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable

BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=ON

OTB_WRAP_PYTHON:BOOL=ON
OTB_WRAP_JAVA:BOOL=ON
OTB_WRAP_QT:BOOL=ON

OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=$ENV{HOME}/Data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Data/OTB-Data

ITK_DIR:PATH=/home/otbval/Tools/ITK-4.7.1/install/lib/cmake/ITK-4.7

OTB_USE_CURL:BOOL=ON
OTB_USE_LIBKML:BOOL=ON
OTB_USE_LIBSVM:BOOL=ON
OTB_USE_MUPARSER:BOOL=ON
OTB_USE_MUPARSERX:BOOL=ON
OTB_USE_OPENCV:BOOL=ON
OTB_USE_OPENJPEG:BOOL=ON
OTB_USE_QT4:BOOL=ON

MUPARSERX_LIBRARY:PATH=/home/otbval/Tools/muparserx/install/lib/libmuparserx.so
MUPARSERX_INCLUDE_DIR:PATH=/home/otbval/Tools/muparserx/install/include

# use custom libkml install because official package has undefined symbols
LIBKML_INCLUDE_DIR:PATH=/home/otbval/Tools/libkml/install/include
LIBKML_BASE_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmlbase.so
LIBKML_CONVENIENCE_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmlconvenience.so
LIBKML_DOM_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmldom.so
LIBKML_ENGINE_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmlengine.so
LIBKML_MINIZIP_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libminizip.so
LIBKML_REGIONATOR_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmlregionator.so
LIBKML_XSD_LIBRARY:FILEPATH=/home/otbval/Tools/libkml/install/lib/libkmlxsd.so

OpenJPEG_DIR:PATH=/home/otbval/Tools/OpenJpeg_2.1/install/lib/openjpeg-2.1
    ")
endmacro()

execute_process(COMMAND ${CTEST_CMAKE_COMMAND} -E remove_directory ${OTB_INSTALL_PREFIX})
execute_process(COMMAND ${CTEST_CMAKE_COMMAND} -E make_directory ${OTB_INSTALL_PREFIX})

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
