set(CUDD_VERSION 3.0.0)
get_filename_component(CUDD_DIR ${CMAKE_CURRENT_LIST_FILE} PATH)
set(CUDD_INCLUDE_DIRS ${CUDD_DIR}/include )
set(CUDD_INCLUDE_DIR  ${CUDD_INCLUDE_DIRS} )
set(CUDD_LIBRARIES    ${CUDD_DIR}/lib/libcudd.a )
