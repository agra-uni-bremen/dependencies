project(Boolector)

cmake_minimum_required(VERSION 2.8)

find_package( PicoSAT REQUIRED )
#find_package( PrecoSat )

include_directories( ${PicoSAT_INCLUDE_DIR} )

add_library( Boolector_libboolector
  boolector.c
  btoraig.c
  btoraigvec.c
  btorbtor.c
  btorconst.c
  btorexp.c
  btorhash.c
  btormain.c
  btormem.c
  btorrand.c
  btorrewrite.c
  btorsat.c
  btorsmt.c
  btorutil.c
  btorpreco.cc
)
set_target_properties(Boolector_libboolector PROPERTIES OUTPUT_NAME boolector)
target_link_libraries(Boolector_libboolector PicoSAT_libpicosat)

add_executable( Boolector_boolector
  boolectormain.c
)
target_link_libraries(Boolector_boolector Boolector_libboolector)

add_executable( Boolector_deltabtor
  deltabtor.c
)
target_link_libraries(Boolector_deltabtor Boolector_libboolector)

add_executable( Boolector_synthebtor 
  synthebtor.c
)
target_link_libraries(Boolector_synthebtor Boolector_libboolector)

file(WRITE ${PROJECT_BINARY_DIR}/BoolectorConfig.cmake 
"set(Boolector_FOUND 1)
set(Boolector_VERSION 1.4.1)
get_filename_component(Boolector_CONFIG_DIR "\${CMAKE_CURRENT_LIST_FILE}" PATH)
set(Boolector_INCLUDE_DIR \${Boolector_CONFIG_DIR}/../../include)
include("\${Boolector_CONFIG_DIR}/Boolector.cmake" )
")
file(WRITE ${PROJECT_BINARY_DIR}/BoolectorConfigVersion.cmake 
"if("\${PACKAGE_FIND_VERSION}" VERSION_EQUAL 1.4.1)
set(PACKAGE_VERSION_EXACT 1)
set(PACKAGE_VERSION_COMPATIBLE 1)
endif(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 1.4.1)
")
## create libBoolector config file for internal use
file(WRITE ${PROJECT_BINARY_DIR}/Boolector.cmake 
"set(Boolector_INCLUDE_DIR 
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
  ${PROJECT_BINARY_DIR}/BoolectorConfig.cmake
  ${PROJECT_BINARY_DIR}/BoolectorConfigVersion.cmake
  DESTINATION share/Boolector)
install(EXPORT Boolector DESTINATION share/Boolector)
install(TARGETS 
  Boolector_libboolector
  Boolector_boolector
  Boolector_deltabtor
  Boolector_synthebtor
  EXPORT Boolector
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(FILES
  boolector.h
  btordefs.h
  DESTINATION include 
)
# vim: ts=2 sw=2 et
