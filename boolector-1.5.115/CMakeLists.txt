project(Boolector)

cmake_minimum_required(VERSION 2.8)

find_package( MiniSat REQUIRED )

set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

include_directories( ${MiniSat_INCLUDE_DIR} )

add_library( Boolector_libboolector SHARED
  boolector.c
  btoraig.c
  btoraigvec.c
  btorbtor.c
  btorconst.c
  btorexp.c
  btorhash.c
  btormain.c
  btormem.c
  btorrewrite.c
  btorsat.c
  btorsmt.c
  btorutil.c
  btorsmt2.c
  btorminisat.cc
)

add_definitions( -DBTOR_USE_MINISAT )

set_target_properties(Boolector_libboolector PROPERTIES OUTPUT_NAME boolector)
target_link_libraries(Boolector_libboolector ${MiniSat_LIBRARIES})

add_executable( Boolector_boolector boolectormain.c)
target_link_libraries(Boolector_boolector Boolector_libboolector)
set_target_properties(Boolector_boolector PROPERTIES OUTPUT_NAME boolector)


add_executable( Boolector_deltabtor deltabtor.c)
target_link_libraries(Boolector_deltabtor Boolector_libboolector)
set_target_properties(Boolector_deltabtor PROPERTIES OUTPUT_NAME deltabtor)

add_executable( Boolector_synthebtor synthebtor.c)
target_link_libraries(Boolector_synthebtor Boolector_libboolector)
set_target_properties(Boolector_synthebtor PROPERTIES OUTPUT_NAME synthebtor)

set(Boolector_LIBRARIES Boolector_libboolector)

configure_file(BoolectorConfig.cmake ${PROJECT_BINARY_DIR}/BoolectorConfig.cmake @ONLY)
configure_file(BoolectorConfigVersion.cmake ${PROJECT_BINARY_DIR}/BoolectorConfigVersion.cmake @ONLY)
## create libBoolector config file for internal use
file(WRITE ${PROJECT_BINARY_DIR}/Boolector.cmake 
"set(Boolector_INCLUDE_DIR 
  ${PROJECT_SOURCE_DIR}/
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
  DESTINATION include 
)
# vim: ts=2 sw=2 et
