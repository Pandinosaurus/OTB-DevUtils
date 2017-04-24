#Contact: Pierre Lassalle <lassallepierre34@gmail.com>

# otb_fetch_module(otbGRM
# 	"GRM OTB Application for region merging segmentation of very high resolution satellite scenes."
# 	GIT_REPOSITORY http://tully.ups-tlse.fr/lassallep/grm/
# 	GIT_TAG master
# 	)

set(dashboard_module "otbGRM")
# set(dashboard_module_url "http://tully.ups-tlse.fr/lassallep/grm.git")

set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "${dashboard_module}-MacOSX10.10-${CTEST_BUILD_CONFIGURATION}")
set(dashboard_no_install 1)
include(${CTEST_SCRIPT_DIRECTORY}/leod_common.cmake)

set(dashboard_model "Nightly")
set(dashboard_source_name "nightly/OTB-${CTEST_BUILD_CONFIGURATION}/src")
set(dashboard_binary_name "nightly/OTB-${CTEST_BUILD_CONFIGURATION}/build-${dashboard_module}")

set(dashboard_cache "
CMAKE_PREFIX_PATH:PATH=/opt/local
CMAKE_C_FLAGS:STRING= -fPIC -Wall
CMAKE_CXX_FLAGS:STRING= -fPIC -Wall  -Wno-\\\\#warnings

OPENTHREADS_CONFIG_HAS_BEEN_RUN_BEFORE:BOOL=ON

BUILD_SHARED_LIBS:BOOL=ON
BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=OFF

OTB_WRAP_PYTHON:BOOL=ON
OTB_WRAP_JAVA:BOOL=OFF
OTB_WRAP_QT:BOOL=OFF

OTB_DATA_USE_LARGEINPUT:BOOL=OFF
OTB_DATA_ROOT:STRING=$ENV{HOME}/Data/OTB-Data
OTB_BUILD_DEFAULT_MODULES:BOOL=OFF
Module_${dashboard_module}:BOOL=ON

PYTHON_EXECUTABLE:FILEPATH=/opt/local/bin/python2.7
PYTHON_INCLUDE_DIR:PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Headers
PYTHON_LIBRARY:FILEPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python

ITK_DIR:PATH=${CTEST_DASHBOARD_ROOT}/itkv4/install/lib/cmake/ITK-4.9

GDAL_CONFIG:PATH=/opt/local/bin/gdal-config
GDAL_CONFIG_CHECKING:BOOL=ON
GDAL_INCLUDE_DIR:PATH=/opt/local/include
GDAL_LIBRARY:PATH=/opt/local/lib/libgdal.dylib

OSSIM_INCLUDE_DIR:PATH=${CTEST_DASHBOARD_ROOT}/ossim/install-1.8.20-3/include
OSSIM_LIBRARY:FILEPATH=${CTEST_DASHBOARD_ROOT}/ossim/install-1.8.20-3/lib/libossim.dylib
")

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
