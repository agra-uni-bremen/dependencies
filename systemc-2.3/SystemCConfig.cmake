get_filename_component(SystemC_DIR ${CMAKE_CURRENT_LIST_FILE} PATH)
set(SystemC_INCLUDE_DIRS ${SystemC_DIR}/include )
set(SystemC_INCLUDE_DIR  ${SystemC_INCLUDE_DIRS} )
set(SystemC_LIBRARIES    ${SystemC_DIR}/lib-ARCH/libsystemc.a )
