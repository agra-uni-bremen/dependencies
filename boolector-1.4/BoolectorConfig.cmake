set(Boolector_FOUND 1)
set(Boolector_VERSION @Boolector_VERSION@)
get_filename_component(Boolector_CONFIG_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(Boolector_INCLUDE_DIR ${Boolector_CONFIG_DIR}/../../include)
include(${Boolector_CONFIG_DIR}/Boolector.cmake )

