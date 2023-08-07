
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


#
target_link_libraries(ripple_libs INTERFACE libgmpxx.a libgmp.a libff libsnark)
#target_link_libraries (libsnark INTERFACE libff)
##add_library (NIH::libsnark ALIAS libsnark)
