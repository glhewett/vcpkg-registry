get_filename_component(PACKAGE_PREFIX_DIR "build/vcpkg_installed/arm64-osx/share/cjose/../../" ABSOLUTE)
#get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE)
find_path(CJOSE_INCLUDE_DIR 
          NAMES cjose/cjose.h
          PATHS "${PACKAGE_PREFIX_DIR}/include"
          NO_DEFAULT_PATH)
find_library(CJOSE_DEBUG_LIB
             NAMES cjose
             PATHS "${PACKAGE_PREFIX_DIR}/debug/lib"
             NO_DEFAULT_PATH)
find_library(CJOSE_RELEASE_LIB
             NAMES cjose
             PATHS "${PACKAGE_PREFIX_DIR}/lib"
             NO_DEFAULT_PATH)

if(${CJOSE_INCLUDE_DIR} MATCHES "NOTFOUND" OR
   ${CJOSE_RELEASE_LIB} MATCHES "NOTFOUND" OR
   ${CJOSE_DEBUG_LIB} MATCHES "NOTFOUND")
  set(CJOSE_FOUND FALSE)
else()
  add_library(cjose::cjose STATIC IMPORTED)
  set_target_properties(cjose::cjose PROPERTIES
                        IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
                        IMPORTED_LOCATION_RELEASE "${CJOSE_RELEASE_LIB}"
                        IMPORTED_LOCATION_DEBUG "${CJOSE_DEBUG_LIB}"
                        INTERFACE_INCLUDE_DIRECTORIES "${CJOSE_INCLUDE_DIR}")
  set(CJOSE_FOUND TRUE)
endif()
