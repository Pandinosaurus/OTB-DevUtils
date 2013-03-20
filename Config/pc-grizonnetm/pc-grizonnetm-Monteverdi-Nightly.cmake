SET (CTEST_SOURCE_DIRECTORY "/mnt/dd-2/OTB/trunk/Monteverdi-Nightly/")
SET (CTEST_BINARY_DIRECTORY "/mnt/dd-2/OTB/Monteverdi-Binary-Nightly/")


# which ctest command to use for running the dashboard
SET (CTEST_COMMAND 
  "ctest -j6 -D Nightly -A /mnt/dd-2/OTB/trunk/OTB-DevUtils/Config/pc-grizonnetm-Monteverdi-Nightly.cmake -V"
  )

# what cmake command to use for configuring this dashboard
SET (CTEST_CMAKE_COMMAND 
  "cmake"
  )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j8 -i -k")
# should ctest wipe the binary tree before running
SET (CTEST_START_WITH_EMPTY_BINARY_DIRECTORY TRUE)
SET (CTEST_USE_LAUNCHERS ON)

# this is the initial cache to use for the binary tree, be careful to escape
# any quotes inside of this string if you use it
SET (CTEST_INITIAL_CACHE "
// Use Launchers for CDash reporting
CTEST_USE_LAUNCHERS:BOOL=ON
//Name of the build
BUILDNAME:STRING=Ubuntu10.4-64bits-Release
//Name of the computer/site where compile is being run
SITE:STRING=pc-grizonnetm
//Data root
OTB_DATA_ROOT:STRING=/mnt/dd-2/OTB/trunk/OTB-Data
//LargeInput
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=/media/TeraDisk2/LargeInput
//Compilation options
CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable
//Set up the build options
CMAKE_BUILD_TYPE:STRING=Release
OTB_DIR:STRING=/mnt/dd-2/OTB/OTB-Binary-Nightly
BUILD_TESTING:BOOL=ON
//CPack configuration
OTB_USE_CPACK:BOOL=ON
CMAKE_INSTALL_PREFIX:STRING=/home/otbtesting/OTB/tmp
CPACK_BINARY_DEB:BOOL=ON
CPACK_DEBIAN_PACKAGE_ARCHITECTURE:STRING=amd64
")

# set any extra envionment varibles here
#SET (CTEST_ENVIRONMENT
# "DISPLAY=:0"
#)
