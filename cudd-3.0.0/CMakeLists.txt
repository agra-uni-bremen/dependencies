cmake_minimum_required(VERSION 2.8)

project(CUDD C)
enable_language(CXX OPTIONAL)

set(CUDD_VERSION 3.0.0)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()

set(STATIC_OR_SHARED SHARED CACHE STRING "Build STATIC or SHARED libaries")

include(CheckTypeSize)

check_type_size("long"  SIZEOF_LONG)
check_type_size("void*" SIZEOF_VOID_P)

add_definitions(
  -DSIZEOF_LONG=${SIZEOF_LONG}
  -DSIZEOF_VOID_P=${SIZEOF_VOID_P}
)

if(UNIX) 
  add_definitions(-DHAVE_IEEE_754 -DBSD)
endif()


add_library(CUDD_util 
  ${STATIC_OR_SHARED}
  util/cpu_stats.c
  util/cpu_time.c
  util/datalimit.c
  util/pathsearch.c
  util/pipefork.c
  util/prtime.c
  #util/ptime.c
  util/safe_mem.c
  util/strsav.c
  #util/stub.c
  util/texpand.c
  util/cstringstream.c
  util/ucbqsort.c
)
list(APPEND CUDD_LIBS CUDD_util)

add_library(CUDD_epd
  ${STATIC_OR_SHARED}
  epd/epd.c
)
list(APPEND CUDD_LIBS CUDD_epd)

add_library(CUDD_mtr
  ${STATIC_OR_SHARED}
  mtr/mtrGroup.c
  mtr/mtrBasic.c
)
target_link_libraries( CUDD_mtr m )
list(APPEND CUDD_LIBS CUDD_mtr)

include_directories(util)

add_library(CUDD_st
  ${STATIC_OR_SHARED} 
  st/st.c
)
target_link_libraries(CUDD_st CUDD_util)
list(APPEND CUDD_LIBS CUDD_st)

include_directories(mtr epd st)

add_library(CUDD_cudd
  ${STATIC_OR_SHARED}
  cudd/cuddAddFind.c
  cudd/cuddLinear.c
  cudd/cuddApa.c
  cudd/cuddGenetic.c
  cudd/cuddZddFuncs.c
  cudd/cuddCof.c
  cudd/cuddAddNeg.c
  cudd/cuddMatMult.c
  cudd/cuddAddIte.c
  cudd/cuddAddInv.c
  cudd/cuddAndAbs.c
  cudd/cuddSubsetSP.c
  cudd/cuddCheck.c
  cudd/cuddClip.c
  cudd/cuddBddIte.c
  cudd/cuddWindow.c
  cudd/cuddPriority.c
  cudd/cuddCache.c
  cudd/cuddAddAbs.c
  cudd/cuddLevelQ.c
  cudd/cuddExport.c
  cudd/cuddTable.c
  cudd/cuddInit.c
  cudd/cuddZddGroup.c
  cudd/cuddLiteral.c
  cudd/cuddSolve.c
  cudd/cuddRef.c
  cudd/cuddBddCorr.c
  cudd/cuddZddPort.c
  cudd/cuddZddReord.c
  cudd/cuddZddIsop.c
  cudd/cuddRead.c
  cudd/cuddZddSymm.c
  cudd/cuddExact.c
  cudd/cuddSplit.c
  cudd/cuddGroup.c
  cudd/cuddUtil.c
  cudd/cuddSubsetHB.c
  cudd/cuddZddLin.c
  cudd/cuddSymmetry.c
  cudd/cuddAPI.c
  cudd/testcudd.c
  cudd/cuddZddMisc.c
  cudd/cuddHarwell.c
  cudd/cuddGenCof.c
  cudd/cuddDecomp.c
  cudd/cuddLCache.c
  cudd/cuddZddSetop.c
  cudd/cuddBddAbs.c
  cudd/cuddApprox.c
  cudd/cuddAddApply.c
  cudd/cuddCompose.c
  cudd/cuddZddCount.c
  cudd/cuddSat.c
  cudd/cuddAnneal.c
  cudd/cuddSign.c
  cudd/cuddReorder.c
  cudd/cuddBridge.c
  cudd/cuddAddWalsh.c
  cudd/cuddInteract.c
  cudd/cuddEssent.c
  cudd/cuddZddUtil.c
)
target_link_libraries(CUDD_cudd CUDD_st CUDD_mtr CUDD_epd)
list(APPEND CUDD_LIBS CUDD_cudd)

include_directories(cudd)

if( CMAKE_CXX_COMPILER_WORKS )
  add_library( CUDD_obj
    ${STATIC_OR_SHARED}
    cplusplus/cuddObj.cc
  )
  target_link_libraries(CUDD_obj CUDD_cudd)
  list(APPEND CUDD_LIBS CUDD_obj)
endif()

add_library(CUDD_dddmp
  ${STATIC_OR_SHARED}

  dddmp/dddmpStoreBdd.c
  dddmp/dddmpStoreAdd.c
  dddmp/dddmpStoreCnf.c
  dddmp/dddmpLoad.c
  dddmp/dddmpLoadCnf.c
  dddmp/dddmpNodeBdd.c
  dddmp/dddmpNodeAdd.c
  dddmp/dddmpNodeCnf.c
  dddmp/dddmpStoreMisc.c
  dddmp/dddmpUtil.c
  dddmp/dddmpBinary.c
  dddmp/dddmpConvert.c
  dddmp/dddmpDbg.c

)
target_link_libraries(CUDD_dddmp CUDD_cudd)
list(APPEND CUDD_LIBS CUDD_dddmp)

############################################################
# Test Binaries
############################################################

include(CTest)

if( BUILD_TESTING )

add_executable( testcudd cudd/testcudd.c ) 
target_link_libraries(testcudd CUDD_cudd m)
add_test(testcudd testcudd ${CMAKE_CURRENT_SOURCE_DIR}/cudd/r7x8.1.mat)


add_executable( testmtr mtr/testmtr.c ) 
target_link_libraries(testmtr CUDD_mtr CUDD_util)
add_test(testmtr testmtr ${CMAKE_CURRENT_SOURCE_DIR}/mtr/test.groups)

add_executable( testdddmp dddmp/testdddmp.c ) 
target_link_libraries(testdddmp CUDD_dddmp m)
#add_test(testdddmp testdddmp )

endif()
############################################################
# Compiler Flags
############################################################

if( CMAKE_COMPILER_IS_GNUCC ) 
  set_property(TARGET
    ${CUDD_LIBS}
    APPEND PROPERTY COMPILE_FLAGS "-malign-double")
endif()

file(WRITE ${PROJECT_BINARY_DIR}/CUDDConfig.cmake 
"set(CUDD_FOUND 1)
set(CUDD_VERSION ${CUDD_VERSION})
get_filename_component(CUDD_CONFIG_DIR "\${CMAKE_CURRENT_LIST_FILE}" PATH)
set(CUDD_INCLUDE_DIR \${CUDD_CONFIG_DIR}/../../include)
include("\${CUDD_CONFIG_DIR}/CUDD.cmake" )
")
file(WRITE ${PROJECT_BINARY_DIR}/CUDDConfigVersion.cmake 
"if(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL ${CUDD_VERSION})
	set(PACKAGE_VERSION_EXACT 1)
	set(PACKAGE_VERSION_COMPATIBLE 1)
endif(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL ${CUDD_VERSION})
")
## create libCUDD config file for internal use
file(WRITE ${PROJECT_BINARY_DIR}/CUDD.cmake 
"set(CUDD_INCLUDE_DIR 
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
  ${PROJECT_BINARY_DIR}/CUDDConfig.cmake
  ${PROJECT_BINARY_DIR}/CUDDConfigVersion.cmake
  DESTINATION share/CUDD)
install(EXPORT CUDD DESTINATION share/CUDD)

install(TARGETS 
  ${CUDD_LIBS}
  EXPORT CUDD
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
)

install(FILES
  cudd/cudd.h
  cudd/cuddInt.h
  cplusplus/cuddObj.hh
  epd/epd.h
  dddmp/dddmp.h
  mtr/mtr.h
  cplusplus/cuddObj.hh
  st/st.h
  util/util.h
  #mnemosyne/mnemosyne.h
  
  DESTINATION include 
)
