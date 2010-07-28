SET (CTEST_SOURCE_DIRECTORY "$ENV{HOME}/WWW.ORFEO-TOOLBOX.ORG-CS-NIGHTLY/OTB-Wrapping")
SET (CTEST_BINARY_DIRECTORY "$ENV{HOME}/OTB-NIGHTLY-VALIDATION/build/OTB-Wrapping")

SET( CTEST_CMAKE_GENERATOR  "Unix Makefiles" )
SET (CTEST_CMAKE_COMMAND "cmake" )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j8 -i -k install" )
SET (CTEST_SITE "leod.c-s.fr")
SET (CTEST_BUILD_NAME "MacOSX10.5-g++4.0.1-Release")
SET (CTEST_BUILD_CONFIGURATION "Release")
SET (CTEST_HG_COMMAND "/usr/local/bin/hg")
SET (CTEST_HG_UPDATE_OPTIONS "-C")

SET (CTEST_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/Users/data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/WWW.ORFEO-TOOLBOX.ORG-CS-NIGHTLY/OTB-Data

CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable
CMAKE_OSX_ARCHITECTURES:STRING=i386
CMAKE_BUILD_TYPE:STRING=Release

OTB_DIR:STRING=$ENV{HOME}/OTB-NIGHTLY-VALIDATION/build/OTB
BUILD_TESTING:BOOL=ON

CMAKE_INSTALL_PREFIX:STRING=$ENV{HOME}/OTB-NIGHTLY-VALIDATION/install/OTB-Wrapping

GDALCONFIG_EXECUTABLE:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/bin/gdal-config
GDAL_CONFIG:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx2/bin/gdal-config
GDAL_INCLUDE_DIR:STRING=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
GDAL_LIBRARY:FILEPATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/lib/libgdal.dylib
OGR_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/install-macosx/include
GEOTIFF_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/gdal-1.6.1/frmts/gtiff/libgeotiff
TIFF_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/gdal-1.6.1/frmts/gtiff/libtiff
JPEG_INCLUDE_DIRS:PATH=$ENV{HOME}/OTB-OUTILS/gdal/gdal-1.6.1/frmts/jpeg/libjpeg
JPEG_INCLUDE_DIR:PATH=$ENV{HOME}/OTB-OUTILS/gdal/gdal-1.6.1/frmts/jpeg/libjpeg

SWIG_DIR:PATH=$ENV{HOME}/OTB-OUTILS/swig/install-macosx
SWIG_EXECUTABLE:FILEPATH=$ENV{HOME}/OTB-OUTILS/swig/install-macosx/bin/swig
CableSwig_DIR:PATH=$ENV{HOME}/OTB-OUTILS/cableswig/binaries-macosx-release-cableswig-3.16.0
WRAP_ITK_PYTHON:BOOL=ON
WRAP_ITK_JAVA:BOOL=ON

")

SET( PULL_RESULT_FILE "${CTEST_BINARY_DIRECTORY}/pull_result.txt" )

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${PULL_RESULT_FILE}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})

execute_process( COMMAND ${CTEST_HG_COMMAND} pull http://hg.orfeo-toolbox.org/OTB-Wrapping
                 WORKING_DIRECTORY "${CTEST_SOURCE_DIRECTORY}"
                 OUTPUT_VARIABLE   PULL_RESULT
                 ERROR_VARIABLE    PULL_RESULT )
file(WRITE ${PULL_RESULT_FILE} ${PULL_RESULT} )

ctest_start(Nightly)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()

