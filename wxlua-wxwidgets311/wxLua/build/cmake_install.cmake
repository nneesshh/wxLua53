# Install script for directory: D:/zbs/wxlua-wxwidgets311/wxLua

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/wxLua")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/wxlua/wxLuaConfig.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/wxlua/wxLuaConfig.cmake"
         "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/wxlua/wxLuaConfig-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/wxlua/wxLuaConfig.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig-debug.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig-minsizerel.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig-relwithdebinfo.cmake")
  endif()
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/build/CMakeFiles/Export/share/wxlua/wxLuaConfig-release.cmake")
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/luaproxydll/lua52.dll"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/luaproxydll/lua5.2.dll"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/doc/wxLua" TYPE DIRECTORY FILES "D:/zbs/wxlua-wxwidgets311/wxLua/docs/" FILES_MATCHING REGEX "/[^/]*\\.txt$" REGEX "/[^/]*\\.html$" REGEX "/cvs$" EXCLUDE REGEX "/\\.svn$" EXCLUDE REGEX "/doxygen$" EXCLUDE)
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/samples" TYPE DIRECTORY FILES "D:/zbs/wxlua-wxwidgets311/wxLua/samples/" REGEX "/cvs$" EXCLUDE REGEX "/\\.svn$" EXCLUDE)
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/wxlua/wxbind/include" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxadv_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxadv_wxladv.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxaui_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxbase_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxbinddefs.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxcore_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxcore_wxlcore.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxgl_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxhtml_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxhtml_wxlhtml.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxmedia_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxnet_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxpropgrid_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxrichtext_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxstc_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxwebview_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxxml_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxbind/include/wxxrc_bind.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/wxlua/bindings" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/bindings/wxwidgets/wx_datatypes.lua")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/wxlua/lua" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/lua-5.2/src/lauxlib.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/lua-5.2/src/luaconf.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/lua-5.2/src/lua.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/lua-5.2/src/lualib.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/wxlua" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/atomic.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/sharedptr.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlbind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlcallb.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlconsole.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxldefs.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxllua.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlobject.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlstate.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlua.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlua_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/wxlversion.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/wxlua/debug" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debug/wxldebug.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debug/wxlstack.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debug/wxluadebugdefs.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/wxlua/debugger" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debugger/wxldserv.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debugger/wxldtarg.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debugger/wxlsock.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debugger/wxluadebugger_bind.h"
    "D:/zbs/wxlua-wxwidgets311/wxLua/modules/wxlua/debugger/wxluadebuggerdefs.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/apps/wxluacan" TYPE FILE FILES "D:/zbs/wxlua-wxwidgets311/wxLua/apps/wxluacan/scripts/incircles.lua")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/apps/wxluafreeze" TYPE FILE FILES
    "D:/zbs/wxlua-wxwidgets311/wxLua/apps/wxluafreeze/readme.txt"
    "D:/zbs/wxlua-wxwidgets311/wxLua/apps/wxluafreeze/wxluafreeze.lua"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("D:/zbs/wxlua-wxwidgets311/wxLua/build/modules/cmake_install.cmake")
  include("D:/zbs/wxlua-wxwidgets311/wxLua/build/apps/cmake_install.cmake")
  include("D:/zbs/wxlua-wxwidgets311/wxLua/build/bindings/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "D:/zbs/wxlua-wxwidgets311/wxLua/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
