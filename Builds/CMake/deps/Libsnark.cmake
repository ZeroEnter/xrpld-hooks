
add_library(libsnark STATIC IMPORTED GLOBAL)
add_library(libff STATIC IMPORTED GLOBAL)


set_target_properties (libsnark PROPERTIES
        IMPORTED_LOCATION_DEBUG
        "/usr/local/libsnark.a"
        IMPORTED_LOCATION_RELEASE
        "/usr/local/lib/libsnark.a"
        INTERFACE_INCLUDE_DIRECTORIES
        "/usr/local/include/"
)
##
set_target_properties (libff PROPERTIES
        IMPORTED_LOCATION_DEBUG
        "/usr/local/libff.a"
        IMPORTED_LOCATION_RELEASE
        "/usr/local/lib/libff.a"
        INTERFACE_INCLUDE_DIRECTORIES
        "/usr/local/include/"
)


# GMP
find_path(GMP_INCLUDE_DIR NAMES gmp.h)
find_library(GMP_LIBRARY gmp)
if(GMP_LIBRARY MATCHES ${CMAKE_SHARED_LIBRARY_SUFFIX})
    set(gmp_library_type SHARED)
else()
    set(gmp_library_type STATIC)
endif()
message(STATUS "GMP: ${GMP_LIBRARY}, ${GMP_INCLUDE_DIR}")
add_library(GMP::gmp ${gmp_library_type} IMPORTED)
set_target_properties(
        GMP::gmp PROPERTIES
        IMPORTED_LOCATION ${GMP_LIBRARY}
        INTERFACE_INCLUDE_DIRECTORIES ${GMP_INCLUDE_DIR}
)

add_definitions(
  -DNO_PROCPS
)

#
target_link_libraries(ripple_libs INTERFACE libgmp.so libgmpxx.a libgmp.a libff libsnark)
#target_link_libraries (libsnark INTERFACE libff)
##add_library (NIH::libsnark ALIAS libsnark)
