project(Lingeling)

cmake_minimum_required(VERSION 2.8)

set(STATIC_OR_SHARED SHARED CACHE STRING "Build STATIC or SHARED libaries")

file(READ ${CMAKE_CURRENT_SOURCE_DIR}/VERSION Lingeling_VERSION)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_library(lingeling_libLingeling
  ${STATIC_OR_SHARED}
  lglib.c
)

set_target_properties(lingeling_libLingeling PROPERTIES OUTPUT_NAME lingeling)

set(Lingeling_CXXFLAGS "-DNLGLOG -DNDEBUG -DNCHKSOL -DNLGLPICOSAT")
add_executable(lingeling_lingeling
  lglib.c
  lglbnr.c
  lglmain.c
)
SET_TARGET_PROPERTIES(lingeling_lingeling PROPERTIES
  OUTPUT_NAME lingeling
)

file(WRITE ${PROJECT_BINARY_DIR}/LingelingConfig.cmake 
"set(Lingeling_FOUND 1)
set(Lingeling_VERSION 587-9c0f11d-110302)
get_filename_component(Lingeling_CONFIG_DIR "\${CMAKE_CURRENT_LIST_FILE}" PATH)
set(PicoSAT_INCLUDE_DIR \${Lingeling_CONFIG_DIR}/../../include)
include("\${Lingeling_CONFIG_DIR}/Lingeling.cmake" )
")
file(WRITE ${PROJECT_BINARY_DIR}/LingelingConfigVersion.cmake 
"if(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 587-9c0f11d-110302)
set(PACKAGE_VERSION_EXACT 1)
set(PACKAGE_VERSION_COMPATIBLE 1)
endif(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 587-9c0f11d-110302)
")
## create libLingeling config file for internal use
file(WRITE ${PROJECT_BINARY_DIR}/Lingeling.cmake 
"set(Lingeling_INCLUDE_DIR 
  ${PROJECT_SOURCE_DIR}/cudd
  ${PROJECT_SOURCE_DIR}/dddmp
  ${PROJECT_SOURCE_DIR}/epd
  ${PROJECT_SOURCE_DIR}/mtr
  ${PROJECT_SOURCE_DIR}/obj
  ${PROJECT_SOURCE_DIR}/st
  ${PROJECT_SOURCE_DIR}/util
)
")
## export target with install
INSTALL( FILES
  ${PROJECT_BINARY_DIR}/LingelingConfig.cmake
  ${PROJECT_BINARY_DIR}/LingelingConfigVersion.cmake
  DESTINATION share/Lingeling)
install(EXPORT Lingeling DESTINATION share/Lingeling)

install(TARGETS 
  lingeling_libLingeling
  EXPORT Lingeling
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
)

install(FILES
  lglib.h
  DESTINATION include 
)
