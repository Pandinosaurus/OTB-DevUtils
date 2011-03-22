SET (CTEST_SOURCE_DIRECTORY "/home/otbtesting/OTB/trunk/OTB")
SET (CTEST_BINARY_DIRECTORY " /home/otbtesting/OTB/bin/OTB-Nightly")

SET( CTEST_CMAKE_GENERATOR  "Unix Makefiles" )
SET (CTEST_CMAKE_COMMAND "cmake" )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j5 -i -k install" )
SET (CTEST_SITE "leod.c-s.fr")
SET (CTEST_BUILD_NAME "MacOSX10.5-g++4.0.1-Release")
SET (CTEST_BUILD_CONFIGURATION "Release")
SET (CTEST_HG_COMMAND "/usr/local/bin/hg")
SET (CTEST_HG_UPDATE_OPTIONS "-C")

SET (ENV{DISPLAY} ":0")

SET (CTEST_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

OTB_DATA_USE_LARGEINPUT:BOOL=OFF
OTB_DATA_LARGEINPUT_ROOT:STRING=/Users/data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/WWW.ORFEO-TOOLBOX.ORG-CS-NIGHTLY/OTB-Data

CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable

CMAKE_OSX_ARCHITECTURES:STRING=i386
OPENTHREADS_CONFIG_HAS_BEEN_RUN_BEFORE:BOOL=ON

CMAKE_BUILD_TYPE:STRING=Release
BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=ON

OTB_USE_CURL:BOOL=ON
OTB_USE_PQXX:BOOL=OFF
ITK_USE_PATENTED:BOOL=ON
OTB_USE_PATENTED:BOOL=ON
OTB_USE_EXTERNAL_BOOST:BOOL=OFF
OTB_USE_EXTERNAL_EXPAT:BOOL=ON
OTB_USE_EXTERNAL_FLTK:BOOL=ON
OTB_USE_GETTEXT:BOOL=OFF
FLTK_DIR:PATH=$ENV{HOME}/OTB-OUTILS/fltk/binaries-macosx-shared-release-fltk-1.1.9
USE_FFTWD:BOOL=OFF
USE_FFTWF:BOOL=OFF
OTB_GL_USE_ACCEL:BOOL=ON
ITK_USE_REVIEW:BOOL=ON 
ITK_USE_OPTIMIZED_REGISTRATION_METHODS:BOOL=ON 
OTB_USE_MAPNIK:BOOL=OFF
CMAKE_INSTALL_PREFIX:STRING=$ENV{HOME}/OTB-NIGHTLY-VALIDATION/install/OTB

GDALCONFIG_EXECUTABLE:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/bin/gdal-config
GDAL_CONFIG:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/bin/gdal-config
GDAL_INCLUDE_DIR:STRING=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
GDAL_LIBRARY:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/lib/libgdal.dylib
OGR_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
GEOTIFF_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
TIFF_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
JPEG_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
JPEG_INCLUDE_DIR:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
")

SET( PULL_RESULT_FILE "${CTEST_BINARY_DIRECTORY}/pull_result.txt" )

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${PULL_RESULT_FILE}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

execute_process( COMMAND ${CTEST_HG_COMMAND} pull http://hg.orfeo-toolbox.org/OTB-Nightly
                 WORKING_DIRECTORY "${CTEST_SOURCE_DIRECTORY}"
                 OUTPUT_VARIABLE   PULL_RESULT
                 ERROR_VARIABLE    PULL_RESULT )
file(WRITE ${PULL_RESULT_FILE} ${PULL_RESULT} )

ctest_start(Continuous)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()

###########

SET (CTEST_SOURCE_DIRECTORY "/home/otbtesting/OTB/trunk/OTB")
SET (CTEST_BINARY_DIRECTORY " /home/otbtesting/OTB/bin/OTB-Nightly")


# which ctest command to use for running the dashboard
SET (CTEST_COMMAND 
  "ctest -j6 -D Nightly -A /home/otbtesting/OTB/trunk/OTB-DevUtils/Config/pc-christophe-OTB-Nightly.cmake -V"
  )

# what cmake command to use for configuring this dashboard
SET (CTEST_CMAKE_COMMAND 
  "cmake"
  )

# should ctest wipe the binary tree before running
SET (CTEST_START_WITH_EMPTY_BINARY_DIRECTORY TRUE)

# this is the initial cache to use for the binary tree, be careful to escape
# any quotes inside of this string if you use it
SET (CTEST_INITIAL_CACHE "
//Command used to build entire project from the command line.
MAKECOMMAND:STRING=/usr/bin/make -i -k -j4
//Name of the build
BUILDNAME:STRING=ArchLinux-2010.5-64bits-Release
//Name of the computer/site where compile is being run
SITE:STRING=pc-christophe
//LargeInput
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/media/TeraDisk/OTB/trunk/OTB-Data/LargeInput
//Data root
OTB_DATA_ROOT:STRING=/media/TeraDisk/OTB/trunk/OTB-Data
//Compilation options
CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable
//Set up the build options
CMAKE_BUILD_TYPE:STRING=Release
BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=ON
OTB_USE_CURL:BOOL=ON
//OTB_USE_PQXX:BOOL=ON
//OTB_USE_EXTERNAL_BOOST:BOOL=ON
//OTB_USE_EXTERNAL_EXPAT:BOOL=ON
//OTB_USE_DEPRECATED:BOOL=ON
//ITK_USE_PATENTED:BOOL=ON
//OTB_USE_PATENTED:BOOL=ON
//USE_FFTWD:BOOL=ON
//USE_FFTWF:BOOL=ON
OTB_GL_USE_ACCEL:BOOL=ON 
ITK_USE_REVIEW:BOOL=ON 
ITK_USE_OPTIMIZED_REGISTRATION_METHODS:BOOL=ON 
//OTB_USE_MAPNIK:BOOL=ON 
// Mapnik configuration
//MAPNIK_INCLUDE_DIR:STRING=/usr/include
//MAPNIK_LIBRARY:STRING=/usr/lib/libmapnik.so
")

# set any extra envionment varibles here
SET (CTEST_ENVIRONMENT
 "DISPLAY=:0"
)

