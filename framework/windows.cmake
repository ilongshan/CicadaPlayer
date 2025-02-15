
message("TOPDIR is ${TOPDIR}")

set(WINDOWS_INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR}/../external/install)

message("WINDOWS_INSTALL_DIR is ${WINDOWS_INSTALL_DIR}")

if (${CMAKE_SIZEOF_VOID_P} MATCHES 4)
    set(ARCH i686)
else ()
    set(ARCH x86_64)
endif ()

set(SDL_DIR "$ENV{HOME}/Downloads/SDL2-2.0.10")
if (MSVC)
  set(COMMON_LIB_DIR ${COMMON_LIB_DIR}
          ${WINDOWS_INSTALL_DIR}/ffmpeg/win32/${ARCH}/bin)
  set(COMMON_INC_DIR ${COMMON_INC_DIR}
          ${WINDOWS_INSTALL_DIR}/ffmpeg/win32/${ARCH}/include
          ${PROJECT_SOURCE_DIR}
          ${CMAKE_CURRENT_LIST_DIR}/../external/boost)
  find_package(curl REQUIRED)
  link_libraries(CURL::libcurl)
          #find_package(FFMPEG REQUIRED)
  link_libraries(${FFMPEG_LIBRARIES})
  find_package(sdl2 REQUIRED)
  link_libraries(SDL2::SDL2)
  find_package(pthread REQUIRED)
  link_libraries(${PThreads4W_LIBRARY})
  find_package(OpenSSL REQUIRED)
  link_libraries(OpenSSL::SSL OpenSSL::Crypto)
  find_package(LibXml2 REQUIRED)
  link_libraries(${LIBXML2_LIBRARIES})
  include_directories(${LIBXML2_INCLUDE_DIR})
else ()
  set(COMMON_LIB_DIR ${COMMON_LIB_DIR}
        ${WINDOWS_INSTALL_DIR}/curl/win32/${ARCH}/lib
        ${WINDOWS_INSTALL_DIR}/librtmp/win32/${ARCH}/lib
        ${WINDOWS_INSTALL_DIR}/openssl/win32/${ARCH}/lib
        ${WINDOWS_INSTALL_DIR}/ffmpeg/win32/${ARCH}/lib
        #        ${WINDOWS_INSTALL_DIR}/pthread/win32/${ARCH}/lib
        ${WINDOWS_INSTALL_DIR}/fdk-aac/win32/${ARCH}/lib
        ${SDL_DIR}/${ARCH}-w64-mingw32/lib
        )
  set(FFMPEG_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../external/external/ffmpeg/)
  set(COMMON_INC_DIR ${COMMON_INC_DIR}
        ${WINDOWS_INSTALL_DIR}/curl/win32/${ARCH}/include
        ${WINDOWS_INSTALL_DIR}/librtmp/win32/${ARCH}/include
        ${WINDOWS_INSTALL_DIR}/openssl/win32/${ARCH}/include
        ${WINDOWS_INSTALL_DIR}/ffmpeg/win32/${ARCH}/include
        ${PROJECT_SOURCE_DIR}
        ${FFMPEG_SOURCE_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/../external/boost
        ${SDL_DIR}/${ARCH}-w64-mingw32/include)
endif ()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBUILDING_LIBCURL")
link_libraries(ws2_32)

set(TARGET_LIBRARY_TYPE STATIC)

set(ENABLE_GLRENDER OFF)
set(ENABLE_SDL ON)
set(BUILD_TEST OFF)
add_definitions(-D __STDC_FORMAT_MACROS)
