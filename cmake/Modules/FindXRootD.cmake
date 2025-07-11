# Try to find XROOTD
# Once done, this will define
#
# XROOTD_FOUND       - system has XRootD
# XROOTD_INCLUDE_DIR - the XRootD include directory
# XROOTD_LIB_DIR     - the XRootD library directory
# XROOTD_PRIVATE_INDCLUDE_DIR - the XRootD private include directory
#
# XROOTD_DIR may be defined as a hint for where to look

find_program(XROOTD_CONFIG xrootd-config
  HINTS
  /usr/bin
  /usr/local/bin
  /opt/homebrew/bin
)

if (XROOTD_CONFIG)
  execute_process(COMMAND ${XROOTD_CONFIG} --version OUTPUT_VARIABLE XROOTD_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "XROOTD_VERSION:" ${XROOTD_VERSION})
else()
  message(STATUS "XROOTD: Could not determin the XRootD version")
  set(XROOTD_VERSION 0)
endif()

find_path (XROOTD_INCLUDE_DIR XrdPosix/XrdPosix.hh
  HINTS
  $PWD/xrootd/src/include/
  ${XROOTD_DIR}
  $ENV{XROOTD_DIR}
  /usr
  /opt/xrootd/
  /usr/local
  /opt/homebrew/xrootd
  PATH_SUFFIXES include/xrootd
  PATHS /opt/xrootd /usr/local/xrootd /opt/homebrew
)

if (XROOTD_INCLUDE_DIR)
   message(STATUS "XROOTD_INCLUDE_DIR:" ${XROOTD_INCLUDE_DIR})
   SET(XROOTD_FOUND TRUE)
endif()

find_library (XROOTD_XrdPosix_LIBRARY
  NAME XrdPosix
  HINTS
  $PWD/xrootd/src/include/
  ${XROOTD_DIR}
  $ENV{XROOTD_DIR}
  /usr
  /opt/xrootd/
  /usr/local
  /opt/homebrew
  PATH_SUFFIXES lib/xrootd
  PATHS /opt/xrootd /usr/local/xrootd /opt/homebrew
)

if (XROOTD_XrdPosix_LIBRARY)
   message(STATUS "XROOTD_XrdPosix_LIBRARY:" ${XROOTD_XrdPosix_LIBRARY})
endif()

find_library (XROOTD_XrdPosixPreload_LIBRARY
  NAME XrdPosixPreload
  HINTS
  $PWD/xrootd/
  ${XROOTD_DIR}
  $ENV{XROOTD_DIR}
  /usr
  /opt/xrootd/
  /usr/local
  /opt/brew/xrootd
  PATH_SUFFIXES include/xrootd
  PATHS /opt/xrootd /usr/local/xrootd /opt/brew/xrootd
)
if (XROOTD_XrdPosixPreload_LIBRARY)
   message(STATUS "XROOTD_XrdPosixPreload_LIBRARY:" ${XROOTD_XrdPosixPreload_LIBRARY})
endif()


GET_FILENAME_COMPONENT( XROOTD_LIB_DIR ${XROOTD_XrdPosix_LIBRARY} PATH )

mark_as_advanced (XROOTD_FOUND XROOTD_INCLUDE_DIR XROOTD_LIBRARY XROOTD_LIB_DIR)

set (XROOTD_FOUND ${XROOTD_FOUND})
set (XROOTD_LIBRARIES ${XROOTD_LIBRARY})
set (XROOTD_INCLUDE_DIRS ${XROOTD_INCLUDE_DIR})
set (XROOTD_LIB_DIR ${XROOTD_LIB_DIR})

add_library (XROOTD UNKNOWN IMPORTED)
