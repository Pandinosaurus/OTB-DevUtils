set(CTEST_DASHBOARD_ROOT "/home/otbval/Dashboard")
set(CTEST_SITE "hulk.c-s.fr")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "Ubuntu14.04-64bits-Modular")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_COMMAND "/usr/bin/make -j9 -i -k" )
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_TEST_TIMEOUT 500)

set(CTEST_SOURCE_DIRECTORY  "${CTEST_DASHBOARD_ROOT}/src/Modularity/OTB_Modular")
set(CTEST_BINARY_DIRECTORY  "${CTEST_DASHBOARD_ROOT}/build/Modularity/OTB_Modular")
set(CTEST_INSTALL_DIRECTORY "${CTEST_DASHBOARD_ROOT}/install/Modularity/OTB_Modular")

set(CTEST_HG_COMMAND          "/usr/bin/hg")
set(CTEST_HG_UPDATE_OPTIONS   "-C")

set(CTEST_NIGHTLY_START_TIME "20:00:00 CEST")
set(CTEST_DROP_METHOD "http")
set(CTEST_DROP_SITE "dash.orfeo-toolbox.org")
set(CTEST_DROP_LOCATION "/submit.php?project=OTB")
set(CTEST_DROP_SITE_CDASH TRUE)

set(CTEST_USE_LAUNCHERS TRUE)

set(OTB_INITIAL_CACHE "
CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DATA_ROOT:PATH=${CTEST_DASHBOARD_ROOT}/src/OTB-Data
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}
MAXIMUM_NUMBER_OF_HEADERS=1
ITK_DIR=${CTEST_DASHBOARD_ROOT}/build/ITKv4-upstream-RelWithDebInfo
OTB_WRAP_PYTHON:BOOL=ON
OTB_WRAP_JAVA:BOOL=ON
MUPARSERX_LIBRARY:PATH=${CTEST_DASHBOARD_ROOT}/install/muparserx/lib/libmuparserx.so
MUPARSERX_INCLUDE_DIR:PATH=${CTEST_DASHBOARD_ROOT}/install/muparserx/include
MAPNIK_INCLUDE_DIR:PATH=${CTEST_DASHBOARD_ROOT}/install/mapnik-2.0.0/include
MAPNIK_LIBRARY:PATH=${CTEST_DASHBOARD_ROOT}/install/mapnik-2.0.0/lib/libmapnik2.so
")

set (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

if(EXISTS "${CTEST_DASHBOARD_ROOT}/src/Modularity/output_modularization.log")
list(APPEND CTEST_NOTES_FILES "${CTEST_DASHBOARD_ROOT}/src/Modularity/output_modularization.log")
endif()

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})
ctest_empty_binary_directory (${CTEST_INSTALL_DIRECTORY})

ctest_start(Experimental)

file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${OTB_INITIAL_CACHE})
ctest_configure()
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
ctest_build()
ctest_test(${CTEST_TEST_ARGS})
ctest_submit()

