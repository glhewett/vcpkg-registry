vcpkg_check_linkage(ONLY_STATIC_LIBRARY) 

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO cisco/cjose
  REF 9261231f08d2a3cbcf5d73c5f9e754a2f1c379ac # v0.6.1
  SHA512 d47e0f0b128c71b68ed7c9368ff2349b28e676b9fa4e711c5e405e8f84d07d2964f5a525a54357e1b3fcb38a4f821e7f0b6e3865c6b70c469758ce6656600757
  HEAD_REF master    
)

set_property(GLOBAL PROPERTY C_STANDARD 99)
set(CFLAGS_DEBUG "-g -O0 -DDEBUG -Wno-strict-prototypes -Wno-deprecated-declarations")
set(CFLAGS_RELEASE "-O2 -Wno-strict-prototypes -Wno-deprecated-declarations")

message(STATUS ${OPTIONS})
vcpkg_configure_make(
  SOURCE_PATH "${SOURCE_PATH}"
  NO_ADDITIONAL_PATHS
  COPY_SOURCE
  OPTIONS ${OPTIONS}
    --disable-shared
    --with-openssl="${CURRENT_INSTALLED_DIR}"
    --with-jansson="${CURRENT_INSTALLED_DIR}"
    OPTIONS_DEBUG "CFLAGS=${CFLAGS_DEBUG}"
    OPTIONS_RELEASE "CFLAGS=${CFLAGS_RELEASE}"
)

vcpkg_install_make()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/doc")

file(INSTALL "${SOURCE_PATH}/LICENSE"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/cjose"
     RENAME copyright)
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/cjoseConfig.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
