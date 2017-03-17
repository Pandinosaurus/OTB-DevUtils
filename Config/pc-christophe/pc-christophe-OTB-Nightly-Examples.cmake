# Client maintainer: manuel.grizonnet@cnes.fr
set(dashboard_model Nightly)
set(CTEST_DASHBOARD_ROOT "/home/otbtesting/")
set(CTEST_SITE "pc-christophe.cst.cnes.fr")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "Fedora22-64bits-${CTEST_BUILD_CONFIGURATION}")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_FLAGS "-j2 -k" )
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_TEST_TIMEOUT 500)
set(CTEST_DASHBOARD_TRACK Examples)

set(INSTALLROOT "${CTEST_DASHBOARD_ROOT}/install")

string(TOLOWER ${dashboard_model} lcdashboard_model)

set(dashboard_root_name "tests")
set(dashboard_update_dir "${CTEST_DASHBOARD_ROOT}sources/orfeo/trunk/OTB-Nightly")
set(dashboard_source_name "sources/orfeo/trunk/OTB-Nightly/Examples")
set(dashboard_binary_name "build/orfeo/trunk/build-examples")

#set(dashboard_fresh_source_checkout OFF)
set(dashboard_git_url "https://git@git.orfeo-toolbox.org/git/otb.git")

macro(dashboard_hook_init)
set(dashboard_cache "

CMAKE_C_FLAGS:STRING=-Wall -Wextra -fopenmp
CMAKE_CXX_FLAGS:STRING=-Wall -Wno-cpp -Wextra -Wno-deprecated-declarations -fopenmp --std=c++11

BUILD_TESTING:BOOL=ON
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/media/TeraDisk2/LargeInput
OTB_DATA_ROOT:STRING=${CTEST_DASHBOARD_ROOT}sources/orfeo/OTB-Data
OTB_DIR:PATH=${CTEST_DASHBOARD_ROOT}build/orfeo/trunk/OTB-Nightly/${CTEST_BUILD_CONFIGURATION}

")
endmacro()

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
