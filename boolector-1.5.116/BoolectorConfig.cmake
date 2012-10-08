set(Boolector_FOUND 1)
set(Boolector_VERSION @Boolector_VERSION@)
get_filename_component(Boolector_CONFIG_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(Boolector_INCLUDE_DIR ${Boolector_CONFIG_DIR}/../../include)
set(Boolector_INCLUDE_DIRS ${Boolector_INCLUDE_DIR})
set(Boolector_LIBRARIES @Boolector_LIBRARIES@)
include(${Boolector_CONFIG_DIR}/Boolector.cmake )

