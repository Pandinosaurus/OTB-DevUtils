SET (dashboard_model Nightly)
SET (CTEST_DASHBOARD_ROOT "C:/Users/jmalik/Dashboard")

SET (OTB_PROJECT Ice) # OTB / Monteverdi / Monteverdi2
SET (OTB_ARCH x86) # x86 / amd64

SET (CTEST_BUILD_CONFIGURATION RelWithDebInfo)

SET (CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/src/${OTB_PROJECT}")
SET (CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/build/${OTB_PROJECT}-vc10-${OTB_ARCH}-${CTEST_BUILD_CONFIGURATION}")

SET (CTEST_CMAKE_GENERATOR  "NMake Makefiles")
SET (CTEST_BUILD_COMMAND  "jom install")
SET (CTEST_CMAKE_COMMAND "C:/Program Files (x86)/CMake 2.8/bin/cmake.exe")
SET (CTEST_SITE "raoul.c-s.fr" )
SET (CTEST_BUILD_NAME "Win7-vc10-${OTB_ARCH}-${CTEST_BUILD_CONFIGURATION}-Static")
SET (CTEST_HG_COMMAND "C:/Program Files (x86)/Mercurial/hg.exe")
SET (CTEST_HG_UPDATE_OPTIONS "")

SET (OTB_INSTALL_PREFIX ${CTEST_DASHBOARD_ROOT}/install/${OTB_PROJECT}-vc10-${OTB_ARCH}-${CTEST_BUILD_CONFIGURATION})

SET (OTB_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

CMAKE_INSTALL_PREFIX:PATH=${OTB_INSTALL_PREFIX}

CMAKE_INCLUDE_PATH:PATH=$ENV{OSGEO4W_ROOT}/include
CMAKE_LIBRARY_PATH:PATH=$ENV{OSGEO4W_ROOT}/lib
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DIR:PATH=${CTEST_DASHBOARD_ROOT}/install/OTB-vc10-${OTB_ARCH}-${CTEST_BUILD_CONFIGURATION}/lib/cmake/OTB-4.5
")

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

ctest_start(${dashboard_model})
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${OTB_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
#ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}" TARGET PACKAGE)
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}" TARGET INSTALL)
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_submit ()
