#[===================================================================[
   NIH dep: libsnark

   Libsnark is header-only, thus is an INTERFACE lib in CMake.
   TODO: move the library definition into Libsnark repo and add
   proper targets and export/install
#]===================================================================]
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
