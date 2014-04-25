#set (ENV{DISPLAY} ":0.0")
# Avoid non-ascii characters in tool output.
#set(ENV{LC_ALL} C)

set (CTEST_BUILD_CONFIGURATION "Debug")

set (DASHBOARD_DIR "$ENV{HOME}/OTB")

set (CTEST_SOURCE_DIRECTORY "${DASHBOARD_DIR}/trunk/Ice")
set (CTEST_BINARY_DIRECTORY "${DASHBOARD_DIR}/bin/Ice-Nightly")
set (CTEST_CMAKE_GENERATOR  "Unix Makefiles")
set (CTEST_CMAKE_COMMAND "cmake" )
set (CTEST_BUILD_COMMAND "/usr/bin/make -j4 -i -k install" )
set (CTEST_SITE "pc-christophe.cst.cnes.fr" )
set (CTEST_BUILD_NAME "Fedora20-64bits-${CTEST_BUILD_CONFIGURATION}")
set (CTEST_HG_COMMAND "/usr/bin/hg")
set (CTEST_HG_UPDATE_OPTIONS "-C")

set(INSTALLROOT "/home/otbtesting/install")
set (ICE_INSTALL_PREFIX "${INSTALLROOT}/Ice-${CTEST_BUILD_CONFIGURATION}")

set (CTEST_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

CMAKE_C_FLAGS:STRING=-Wall
CMAKE_CXX_FLAGS:STRING=-Wall

CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
GLFW_INCLUDE_DIR:PATH=/usr/include/GLFW
OTB_DIR:PATH=/home/otbtesting/install/OTB-InternalITK-Release

##internal ITK is used in OTB-Nightly unlike the clang Nightly build
##link failing due to that. see dashboard build
##http://dash.orfeo-toolbox.org/viewBuildError.php?buildid=143734
##ITK_DIR:PATH=${DASHBOARD_DIR}/bin/ITKv4-upstream-Release
BUILD_ICE_APPLICATION:BOOL=ON
CMAKE_INSTALL_PREFIX:STRING=${ICE_INSTALL_PREFIX}
")

set (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

execute_process (COMMAND ${CTEST_CMAKE_COMMAND} -E remove_directory ${ICE_INSTALL_PREFIX})
execute_process (COMMAND ${CTEST_CMAKE_COMMAND} -E make_directory ${ICE_INSTALL_PREFIX})
ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})

ctest_start (Nightly)
ctest_update (SOURCE "${CTEST_SOURCE_DIRECTORY}")
file (WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files (${CTEST_BINARY_DIRECTORY})
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()
