#[===================================================================[
   NIH dep: libsnark

   Libsnark is header-only, thus is an INTERFACE lib in CMake.
   TODO: move the library definition into Libsnark repo and add
   proper targets and export/install
#]===================================================================]
add_library(libsnark STATIC IMPORTED GLOBAL)
add_library(libff STATIC IMPORTED GLOBAL)

message(STATUS "libsnark cmake")
#message(STATUS "libsnark CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
ExternalProject_Add( libsnark_src
    PREFIX ${nih_cache_path}
    GIT_REPOSITORY https://github.com/pantyukhov/libsnark.git
    GIT_TAG        master
    GIT_SUBMODULES_RECURSE true
    GIT_PROGRESS true
    CMAKE_ARGS
        -DCURVE=ALT_BN128
        -USE_LINKED_LIBRARIES=
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_CONFIGURE ON
)


ExternalProject_Get_Property (libsnark_src BINARY_DIR)
ExternalProject_Get_Property (libsnark_src SOURCE_DIR)

file (MAKE_DIRECTORY ${SOURCE_DIR}/include)
file (MAKE_DIRECTORY ${BINARY_DIR}/include)

set (libsnark_src_BINARY_DIR "${BINARY_DIR}")
add_dependencies (libsnark libsnark_src)


set_target_properties (libsnark PROPERTIES
        IMPORTED_LOCATION_DEBUG
        "/usr/local/libsnark.a"
        IMPORTED_LOCATION_RELEASE
        "/usr/local/lib/libsnark.a"
        INTERFACE_INCLUDE_DIRECTORIES
        "/usr/local/include/"
)
#
set_target_properties (libff PROPERTIES
        IMPORTED_LOCATION_DEBUG
        "/usr/local/libff.a"
        IMPORTED_LOCATION_RELEASE
        "/usr/local/lib/libff.a"
        INTERFACE_INCLUDE_DIRECTORIES
        "/usr/local/include/"
)

target_link_libraries (ripple_libs INTERFACE libsnark)
target_link_libraries(ripple_libs INTERFACE libff)
target_link_libraries(libsnark INTERFACE libff)
#target_link_libraries (libsnark INTERFACE libff)
#add_library (NIH::libsnark ALIAS libsnark)
