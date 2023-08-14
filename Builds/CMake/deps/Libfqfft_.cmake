#[===================================================================[
   NIH dep: libfqfft

   libfqfft is header-only, thus is an INTERFACE lib in CMake.
   TODO: move the library definition into libfqfft repo and add
   proper targets and export/install
#]===================================================================]
add_library(libfqfft SHARED IMPORTED GLOBAL)

message(STATUS "start building libfqfft")
ExternalProject_Add( libfqfft_src
    PREFIX ${nih_cache_path}
    GIT_REPOSITORY https://github.com/scipr-lab/libfqfft
    GIT_TAG        415d38df733b264d1ada69e1f6edc2f809c9b502
#    UPDATE_COMMAND git submodule init && git submodule update
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_CONFIGURE ON
)


ExternalProject_Get_Property (libfqfft_src BINARY_DIR)
ExternalProject_Get_Property (libfqfft_src SOURCE_DIR)

set (libfqfft_src_BINARY_DIR "${BINARY_DIR}")
add_dependencies (libfqfft libfqfft_src)

#execute_process(
#        COMMAND
#        mkdir -p "${libfqfft_src_BINARY_DIR}/include/api"
#)
#set_target_properties (libfqfft PROPERTIES
#        IMPORTED_LOCATION_DEBUG
#        "${libfqfft_src_BINARY_DIR}/lib/libfqfft.a"
#        IMPORTED_LOCATION_RELEASE
#        "${libfqfft_src_BINARY_DIR}/lib/libfqfft.a"
#        INTERFACE_INCLUDE_DIRECTORIES
#        "${libfqfft_src_BINARY_DIR}/include/"
#        )
#target_link_libraries (ripple_libs INTERFACE libfqfft)
#add_library (NIH::libfqfft ALIAS libfqfft)

message(STATUS "libfqfft was built")
