project(MiniSat)

cmake_minimum_required(VERSION 2.8)

set(STATIC_OR_SHARED SHARED CACHE STRING "Build STATIC or SHARED libaries")


file(GLOB UTILS_SRCS minisat/utils/*.cc)
file(GLOB MTL_HDRS minisat/mtl/*.h)
file(GLOB CORE_HDRS minisat/core/*.h)
file(GLOB SIMP_HDRS minisat/simp/*.h)
file(GLOB UTILS_HDRS minisat/utils/*.h)

include_directories(${PROJECT_SOURCE_DIR})
message(STATUS ${PROJECT_SOURCE_DIR}})

set(MiniSat_CXXFLAGS "-D __STDC_LIMIT_MACROS -D __STDC_FORMAT_MACROS")

add_definitions( ${MiniSat_CXXFLAGS} )

add_library(MiniSat_libMiniSat  
  ${STATIC_OR_SHARED}
  minisat/core/Solver.cc 
  minisat/simp/SimpSolver.cc 
  ${UTILS_SRCS}
)

find_library(LIBZ z)

SET_TARGET_PROPERTIES( MiniSat_libMiniSat PROPERTIES
  VERSION 2.1.0
  SOVERSION 2.1.0
  OUTPUT_NAME minisat_core
)

add_executable(MiniSat_core
  ${UTILS_SRCS}
  minisat/core/Solver.cc
  minisat/core/Main.cc
)
target_link_libraries(MiniSat_core ${LIBZ})

SET_TARGET_PROPERTIES( MiniSat_core PROPERTIES
  OUTPUT_NAME minisat_core
)

add_executable(MiniSat_simp
  ${UTILS_SRCS}
  minisat/core/Solver.cc
  minisat/simp/SimpSolver.cc
  minisat/simp/Main.cc
)
target_link_libraries(MiniSat_simp ${LIBZ})

SET_TARGET_PROPERTIES( MiniSat_simp PROPERTIES
  OUTPUT_NAME minisat
)

file(WRITE ${PROJECT_BINARY_DIR}/MiniSatConfig.cmake 
"set(MiniSat_FOUND 1)
set(MiniSat_VERSION 2.2.0)
get_filename_component(MiniSat_CONFIG_DIR "\${CMAKE_CURRENT_LIST_FILE}" PATH)
set(MiniSat_INCLUDE_DIR \${MiniSat_CONFIG_DIR}/../../include)
set(MiniSat_CXXFLAGS \"${MiniSat_CXXFLAGS}\")
include("\${MiniSat_CONFIG_DIR}/MiniSat.cmake" )
")
file(WRITE ${PROJECT_BINARY_DIR}/MiniSatConfigVersion.cmake 
"if(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 2.2.0)
set(PACKAGE_VERSION_EXACT 1)
set(PACKAGE_VERSION_COMPATIBLE 1)
endif(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 2.2.0)
")
## create libMiniSat config file for internal use
file(WRITE ${PROJECT_BINARY_DIR}/MiniSat.cmake 
"set(MiniSat_INCLUDE_DIR 
  ${PROJECT_SOURCE_DIR}
)
")
## export target with install
INSTALL( FILES
  ${PROJECT_BINARY_DIR}/MiniSatConfig.cmake
  ${PROJECT_BINARY_DIR}/MiniSatConfigVersion.cmake
  DESTINATION share/MiniSat)
install(EXPORT MiniSat DESTINATION share/MiniSat)

install(TARGETS 
  MiniSat_libMiniSat
  MiniSat_core
  MiniSat_simp
  EXPORT MiniSat
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

install(FILES ${MTL_HDRS} DESTINATION include/minisat/mtl)
install(FILES ${CORE_HDRS} DESTINATION include/minisat/core)
install(FILES ${SIMP_HDRS} DESTINATION include/minisat/simp)
install(FILES ${UTILS_HDRS} DESTINATION include/minisat/utils)
