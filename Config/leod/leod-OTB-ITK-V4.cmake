SET (ENV{DISPLAY} ":0")

SET (CTEST_SOURCE_DIRECTORY "/Users/otbval/Dashboard/nightly/OTB-ITKv4/src")
SET (CTEST_BINARY_DIRECTORY "/Users/otbval/Dashboard/nightly/OTB-ITKv4/build")

SET( CTEST_CMAKE_GENERATOR  "Unix Makefiles" )
SET (CTEST_CMAKE_COMMAND "/opt/local/bin/cmake" )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j8 -i -k" )
SET (CTEST_SITE "leod.c-s.fr")
SET (CTEST_BUILD_NAME "OTB-ITKv4_MacOSX10.8-Release")
SET (CTEST_BUILD_CONFIGURATION "Release")
SET (CTEST_HG_COMMAND "/opt/local/bin/hg")
SET (CTEST_HG_UPDATE_OPTIONS "-C")
SET (CTEST_USE_LAUNCHERS ON)


SET (CTEST_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}
CTEST_USE_LAUNCHERS:BOOL=ON

OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/Users/otbval/Data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Data/OTB-Data

CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable -fPIC
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable -fPIC -Wno-gnu -Wno-overloaded-virtual

#CMAKE_OSX_ARCHITECTURES:STRING=i386
OPENTHREADS_CONFIG_HAS_BEEN_RUN_BEFORE:BOOL=ON

CMAKE_BUILD_TYPE:STRING=Release
BUILD_TESTING:BOOL=ON
BUILD_EXAMPLES:BOOL=OFF
BUILD_APPLICATIONS:BOOL=ON
OTB_WRAP_PYTHON:BOOL=ON
OTB_WRAP_QT:BOOL=ON
#OTB_WRAP_PYQT:BOOL=ON
OTB_WRAP_JAVA:BOOL=ON

OTB_USE_CURL:BOOL=ON
OTB_USE_PQXX:BOOL=OFF
ITK_USE_PATENTED:BOOL=ON
OTB_USE_PATENTED:BOOL=ON
OTB_USE_EXTERNAL_BOOST:BOOL=ON
OTB_USE_EXTERNAL_EXPAT:BOOL=ON
OTB_USE_EXTERNAL_FLTK:BOOL=ON
OTB_USE_GETTEXT:BOOL=OFF
USE_FFTWD:BOOL=ON
USE_FFTWF:BOOL=ON
OTB_GL_USE_ACCEL:BOOL=OFF
ITK_USE_REVIEW:BOOL=ON
ITK_USE_OPTIMIZED_REGISTRATION_METHODS:BOOL=ON 
OTB_USE_MAPNIK:BOOL=OFF
CMAKE_INSTALL_PREFIX:STRING=$ENV{HOME}/Dashboard/nightly/OTB-Release/install

GDALCONFIG_EXECUTABLE:FILEPATH=/opt/local/bin/gdal-config
GDAL_CONFIG:FILEPATH=/opt/local/bin/gdal-config
GDAL_INCLUDE_DIR:STRING=/opt/local/include
GDAL_LIBRARY:FILEPATH=/opt/local/lib/libgdal.dylib

GEOTIFF_INCLUDE_DIRS:PATH=/opt/local/include
GEOTIFF_LIBRARY:FILEPATH=/opt/local/lib/libgeotiff.dylib

TIFF_INCLUDE_DIRS:PATH=/opt/local/include
TIFF_LIBRARY:FILEPATH=/opt/local/lib/libtiff.dylib

JPEG_INCLUDE_DIRS:PATH=/opt/local/include
JPEG_INCLUDE_DIR:PATH=/opt/local/include
JPEG_LIBRARY:FILEPATH=/opt/local/lib/libjpeg.dylib

EXPAT_INCLUDE_DIR:PATH=/opt/local/include
EXPAT_LIBRARY:FILEPATH=/opt/local/lib/libexpat.dylib

CURL_INCLUDE_DIR:PATH=/opt/local/include
CURL_LIBRARY:FILEPATH=/opt/local/lib/libcurl.dylib

OTB_USE_EXTERNAL_ITK:BOOL=ON
ITK_DIR:PATH=/Users/otbval/Dashboard/itkv4/build
")

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})
ctest_start(Nightly)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()

