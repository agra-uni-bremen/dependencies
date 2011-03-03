project(CUDD)

cmake_minimum_required(VERSION 2.8)

set(STATIC_OR_SHARED SHARED CACHE STRING "Build STATIC or SHARED libaries")


add_library(CUDD_util 
  ${STATIC_OR_SHARED}
  util/cpu_time.c
  util/strsav.c
  util/restart.c
  util/cpu_stats.c
  util/ptime.c
  util/texpand.c
  util/tmpfile.c
  util/getopt.c
  util/state.c
  util/stub.c
  util/safe_mem.c
  util/prtime.c
  util/pipefork.c
  util/datalimit.c
  util/saveimage.c
  util/pathsearch.c
)

add_library(CUDD_epd
  ${STATIC_OR_SHARED}
  epd/epd.c
)

add_library(CUDD_mtr
  ${STATIC_OR_SHARED}
  mtr/mtrGroup.c
  mtr/mtrBasic.c
)

include_directories(util)

add_library(CUDD_st
  ${STATIC_OR_SHARED} 
  st/st.c
)
target_link_libraries(CUDD_st CUDD_util)

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

include_directories(cudd)

add_library( CUDD_obj
  ${STATIC_OR_SHARED}
  obj/cuddObj.cc
)
target_link_libraries(CUDD_obj CUDD_cudd)

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

file(WRITE ${PROJECT_BINARY_DIR}/CUDDConfig.cmake 
"set(CUDD_FOUND 1)
set(CUDD_VERSION 2.4.2)
get_filename_component(CUDD_CONFIG_DIR "\${CMAKE_CURRENT_LIST_FILE}" PATH)
set(CUDD_INCLUDE_DIR \${CUDD_CONFIG_DIR}/../../include)
include("\${CUDD_CONFIG_DIR}/CUDD.cmake" )
")
file(WRITE ${PROJECT_BINARY_DIR}/CUDDConfigVersion.cmake 
"if(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 2.4.2)
	set(PACKAGE_VERSION_EXACT 1)
	set(PACKAGE_VERSION_COMPATIBLE 1)
endif(\"\${PACKAGE_FIND_VERSION}\" VERSION_EQUAL 2.4.2)
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
  CUDD_cudd
  CUDD_dddmp
  CUDD_epd
  CUDD_mtr
  CUDD_obj
  CUDD_st
  CUDD_util
  EXPORT CUDD
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
)

install(FILES
  cudd/cudd.h
  cudd/cuddInt.h
  obj/cuddObj.hh
  epd/epd.h
  dddmp/dddmp.h
  mtr/mtr.h
  obj/cuddObj.hh
  st/st.h
  util/util.h
  mnemosyne/mnemosyne.h
  
  DESTINATION include 
)
