cmake_minimum_required(VERSION 2.8.9)
project (log4cxx)

find_path(APR_INCLUDE_DIR
  NAMES apr.h
)

find_library(APR_LIBRARIES
  NAMES libapr-1
)

find_path(APRUTIL_INCLUDE_DIR
  NAMES apu.h
)

find_library(APRUTIL_LIBRARIES
  NAMES libaprutil-1
)

configure_file(src/main/include/log4cxx/log4cxx.hw
              ${PROJECT_BINARY_DIR}/include/log4cxx/log4cxx.h COPYONLY)

configure_file(src/main/include/log4cxx/private/log4cxx_private.hw
              ${PROJECT_BINARY_DIR}/include/log4cxx/private/log4cxx_private.h COPYONLY)

set(LOG4CXX_INCLUDE_DIRECTORIES
  ${PROJECT_BINARY_DIR}/include
  src/main/include
  ${APR_INCLUDE_DIR}/include
  ${APRUTIL_INCLUDE_DIR}/include
  )

file(GLOB_RECURSE LOG4CXX_SRC
  "${PROJECT_SOURCE_DIR}/src/main/cpp/*.cpp"
)

add_library(log4cxx SHARED ${LOG4CXX_SRC})
target_include_directories(log4cxx PUBLIC ${LOG4CXX_INCLUDE_DIRECTORIES})
SET_TARGET_PROPERTIES(log4cxx PROPERTIES COMPILE_DEFINITIONS "_USRDLL;DLL_EXPORTS;LOG4CXX;WIN32")

target_link_libraries(log4cxx
  ${APRUTIL_LIBRARIES}
  ${APR_LIBRARIES}
  odbc32
  )

install(TARGETS log4cxx
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        )

INSTALL(DIRECTORY src/main/include/ DESTINATION include)
INSTALL(DIRECTORY ${PROJECT_BINARY_DIR}/include/ DESTINATION include)
