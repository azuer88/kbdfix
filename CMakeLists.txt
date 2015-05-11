cmake_minimum_required (VERSION 2.6)
project (kbdfix)
# The version number.
set (kbdfix_VERSION_MAJOR 0)
set (kbdfix_VERSION_MINOR 1)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file (
    "${PROJECT_SOURCE_DIR}/kbdfixConfig.h.in"
    "${PROJECT_BINARY_DIR}/kbdfixConfig.h"
    )

# add the binary tree to the search path for include files
# so that we will find kbdfixConfig.h
include_directories("${PROJECT_BINARY_DIR}")


# add the executable 
add_executable(kbdfix kbdfix.c)

# add the install targets
install(TARGETS kbdfix DESTINATION /usr/sbin
    PERMISSIONS SETUID WORLD_EXECUTE 
    OWNER_EXECUTE OWNER_READ OWNER_WRITE
    GROUP_EXECUTE GROUP_READ GROUP_WRITE)
#install(SCRIPT ${CMAKE_SOURCE_DIR}/PostInstall.cmake)
add_custom_command(TARGET kbdfix POST_BUILD
    COMMAND ${PROJECT_SOURCE_DIR}/PostInstall.sh
    )
