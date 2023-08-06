#[===================================================================[
   NIH dep: libsnark

   Libsnark is header-only, thus is an INTERFACE lib in CMake.
   TODO: move the library definition into Libsnark repo and add
   proper targets and export/install
#]===================================================================]
add_library(libsnark SHARED IMPORTED GLOBAL)

set(
    CURVE
    "ALT_BN128"
    CACHE
    STRING
    "Default curve: one of ALT_BN128, BN128, EDWARDS, MNT4, MNT6"
)
#if(CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
#    # Common compilation flags and warning configuration
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20 -Wall -Wextra -Wfatal-errors -pthread")
#
#    if("${MULTICORE}")
#        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
#    endif()
#
#    # Default optimizations flags (to override, use -DOPT_FLAGS=...)
#    if("${OPT_FLAGS}" STREQUAL "")
#        set(OPT_FLAGS "-ggdb3 -O2 -march=native -mtune=native")
#    endif()
#endif()
set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wfatal-errors"
)
if("${MULTICORE}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
endif()

# Default optimizations flags (to override, use -DOPT_FLAGS=...)
if("${OPT_FLAGS}" STREQUAL "")
    set(OPT_FLAGS "-ggdb3 -O2 -march=native -mtune=native")
endif()
add_definitions(-DCURVE_${CURVE})

if(${CURVE} STREQUAL "BN128")
    add_definitions(-DBN_SUPPORT_SNARK=1)
endif()

if("${VERBOSE}")
    add_definitions(-DVERBOSE=1)
endif()

if("${MULTICORE}")
    add_definitions(-DMULTICORE=1)
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OPT_FLAGS}")

include(FindPkgConfig)
if("${WITH_PROCPS}")
    pkg_check_modules(PROCPS REQUIRED libprocps)
else()
    add_definitions(-DNO_PROCPS)
endif()

set(CMAKE_CXX_STANDARD 11)

message(STATUS "start building libsnark")
#message(STATUS "libsnark CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
ExternalProject_Add( libsnark_src
    PREFIX ${nih_cache_path}
    GIT_REPOSITORY https://github.com/pantyukhov/libsnark.git
    GIT_TAG        master
#    UPDATE_COMMAND git submodule init && git submodule update
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_CONFIGURE ON
)


ExternalProject_Get_Property (libsnark_src BINARY_DIR)
ExternalProject_Get_Property (libsnark_src SOURCE_DIR)

set (libsnark_src_BINARY_DIR "${BINARY_DIR}")
add_dependencies (libsnark libsnark_src)

#execute_process(
#        COMMAND
#        mkdir -p "${libsnark_src_BINARY_DIR}/include/api"
#)
message(STATUS "${libsnark_src_BINARY_DIR}")
set_target_properties (libsnark PROPERTIES
        IMPORTED_LOCATION_DEBUG
        "${libsnark_src_BINARY_DIR}/lib/libsnark.a"
        IMPORTED_LOCATION_RELEASE
        "${libsnark_src_BINARY_DIR}/lib/libsnark.a"
        INTERFACE_INCLUDE_DIRECTORIES
        "${libsnark_src_BINARY_DIR}/include/"
        )
target_link_libraries (ripple_libs INTERFACE archive_lib)
#add_library (NIH::libsnark ALIAS libsnark)

message(STATUS "libsnark was built")
