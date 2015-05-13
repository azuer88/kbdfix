cmake_minimum_required (VERSION 2.6)
project (kbdfix)
# The version number.
set (kbdfix_VERSION_MAJOR 0)
set (kbdfix_VERSION_MINOR 1)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file (
    "${PROJECT_SOURCE_DIR}/src/kbdfixConfig.h.in"
    "${PROJECT_BINARY_DIR}/kbdfixConfig.h"
    )

# add the binary tree to the search path for include files
# so that we will find kbdfixConfig.h
include_directories("${PROJECT_BINARY_DIR}")


set(RC_LOCAL ${PROJECT_BINARY_DIR}/rc.local)
set(99_KBDFIX ${PROJECT_SOURCE_DIR}/scripts/99-kbdfix)
add_custom_target(generate
    COMMAND     head "/etc/rc.local" -n -1 > "${RC_LOCAL}"
    COMMAND     echo "/usr/sbin/kbdfix\\nexit 0" >> "${RC_LOCAL}"
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
    COMMENT     "Generate rc.local"
    VERBATIM
  )

#add_custom_target(rc.local 
#    #add_custom_command(
#    #OUTPUT  rc.local
#    COMMAND head /etc/rc.local -n -1 > rc.local 
#    COMMAND echo -e "/usr/bin/kbdfix\nexit 0" >> rc.local
#    BYPRODUCTS rc.local
#    COMMENT "create rc.local"
#    )

# add the executable 
add_executable(kbdfix src/kbdfix.c)

add_dependencies(kbdfix generate)

# add the install targets
install(TARGETS kbdfix DESTINATION /usr/sbin
    PERMISSIONS WORLD_EXECUTE 
    OWNER_EXECUTE OWNER_READ OWNER_WRITE
    GROUP_EXECUTE GROUP_READ GROUP_WRITE)

install(PROGRAMS ${RC_LOCAL} DESTINATION /etc
    PERMISSIONS WORLD_EXECUTE
    OWNER_EXECUTE OWNER_READ OWNER_WRITE
    GROUP_EXECUTE GROUP_READ GROUP_WRITE)
install(PROGRAMS ${99_KBDFIX} DESTINATION /etc/pm/sleep.d
    PERMISSIONS WORLD_EXECUTE
    OWNER_EXECUTE OWNER_READ OWNER_WRITE
    GROUP_EXECUTE GROUP_READ GROUP_WRITE)
