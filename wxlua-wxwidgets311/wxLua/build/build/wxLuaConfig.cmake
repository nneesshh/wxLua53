# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget LuaLib wxLuaLib wxLuaDebugLib wxLuaDebuggerLib wxLuaBindLib)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Create imported target LuaLib
add_library(LuaLib STATIC IMPORTED)

# Create imported target wxLuaLib
add_library(wxLuaLib STATIC IMPORTED)

# Create imported target wxLuaDebugLib
add_library(wxLuaDebugLib STATIC IMPORTED)

# Create imported target wxLuaDebuggerLib
add_library(wxLuaDebuggerLib STATIC IMPORTED)

# Create imported target wxLuaBindLib
add_library(wxLuaBindLib STATIC IMPORTED)

# Import target "LuaLib" for configuration "Debug"
set_property(TARGET LuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(LuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Debug/wxlua_lua52-wx31mswud-2.8.12.3.lib"
  )

# Import target "wxLuaLib" for configuration "Debug"
set_property(TARGET wxLuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(wxLuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C;CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "LuaLib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31ud_xml.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31ud_net.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31ud.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxpngd.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxtiffd.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxjpegd.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxzlibd.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxregexud.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxexpatd.lib;opengl32;glu32;winmm;comctl32;rpcrt4;wsock32"
  IMPORTED_LOCATION_DEBUG "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Debug/wxlua-wx31mswud-2.8.12.3.lib"
  )

# Import target "wxLuaDebugLib" for configuration "Debug"
set_property(TARGET wxLuaDebugLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(wxLuaDebugLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "wxLuaLib"
  IMPORTED_LOCATION_DEBUG "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Debug/wxlua_debug-wx31mswud-2.8.12.3.lib"
  )

# Import target "wxLuaDebuggerLib" for configuration "Debug"
set_property(TARGET wxLuaDebuggerLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(wxLuaDebuggerLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "wxLuaBindLib;wxLuaDebugLib"
  IMPORTED_LOCATION_DEBUG "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Debug/wxlua_debugger-wx31mswud-2.8.12.3.lib"
  )

# Import target "wxLuaBindLib" for configuration "Debug"
set_property(TARGET wxLuaBindLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(wxLuaBindLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "wxLuaLib"
  IMPORTED_LOCATION_DEBUG "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Debug/wxlua_bind-wx31mswud-2.8.12.3.lib"
  )

# Import target "LuaLib" for configuration "Release"
set_property(TARGET LuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(LuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Release/wxlua_lua52-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaLib" for configuration "Release"
set_property(TARGET wxLuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wxLuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "LuaLib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_xml.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_net.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxpng.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxtiff.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxjpeg.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxzlib.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxregexu.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxexpat.lib;opengl32;glu32;winmm;comctl32;rpcrt4;wsock32"
  IMPORTED_LOCATION_RELEASE "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Release/wxlua-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebugLib" for configuration "Release"
set_property(TARGET wxLuaDebugLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wxLuaDebugLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "wxLuaLib"
  IMPORTED_LOCATION_RELEASE "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Release/wxlua_debug-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebuggerLib" for configuration "Release"
set_property(TARGET wxLuaDebuggerLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wxLuaDebuggerLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "wxLuaBindLib;wxLuaDebugLib"
  IMPORTED_LOCATION_RELEASE "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Release/wxlua_debugger-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaBindLib" for configuration "Release"
set_property(TARGET wxLuaBindLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(wxLuaBindLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "wxLuaLib"
  IMPORTED_LOCATION_RELEASE "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/Release/wxlua_bind-wx31mswu-2.8.12.3.lib"
  )

# Import target "LuaLib" for configuration "MinSizeRel"
set_property(TARGET LuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(LuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "C"
  IMPORTED_LOCATION_MINSIZEREL "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/MinSizeRel/wxlua_lua52-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaLib" for configuration "MinSizeRel"
set_property(TARGET wxLuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(wxLuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "C;CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "LuaLib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_xml.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_net.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxpng.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxtiff.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxjpeg.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxzlib.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxregexu.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxexpat.lib;opengl32;glu32;winmm;comctl32;rpcrt4;wsock32"
  IMPORTED_LOCATION_MINSIZEREL "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/MinSizeRel/wxlua-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebugLib" for configuration "MinSizeRel"
set_property(TARGET wxLuaDebugLib APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(wxLuaDebugLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "wxLuaLib"
  IMPORTED_LOCATION_MINSIZEREL "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/MinSizeRel/wxlua_debug-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebuggerLib" for configuration "MinSizeRel"
set_property(TARGET wxLuaDebuggerLib APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(wxLuaDebuggerLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "wxLuaBindLib;wxLuaDebugLib"
  IMPORTED_LOCATION_MINSIZEREL "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/MinSizeRel/wxlua_debugger-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaBindLib" for configuration "MinSizeRel"
set_property(TARGET wxLuaBindLib APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(wxLuaBindLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_MINSIZEREL "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_MINSIZEREL "wxLuaLib"
  IMPORTED_LOCATION_MINSIZEREL "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/MinSizeRel/wxlua_bind-wx31mswu-2.8.12.3.lib"
  )

# Import target "LuaLib" for configuration "RelWithDebInfo"
set_property(TARGET LuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(LuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C"
  IMPORTED_LOCATION_RELWITHDEBINFO "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/RelWithDebInfo/wxlua_lua52-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaLib" for configuration "RelWithDebInfo"
set_property(TARGET wxLuaLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(wxLuaLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "C;CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELWITHDEBINFO "LuaLib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_xml.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u_net.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxbase31u.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxpng.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxtiff.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxjpeg.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxzlib.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxregexu.lib;D:/zbs/wxWidgets-3.1.1/lib/vc_lib/wxexpat.lib;opengl32;glu32;winmm;comctl32;rpcrt4;wsock32"
  IMPORTED_LOCATION_RELWITHDEBINFO "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/RelWithDebInfo/wxlua-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebugLib" for configuration "RelWithDebInfo"
set_property(TARGET wxLuaDebugLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(wxLuaDebugLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELWITHDEBINFO "wxLuaLib"
  IMPORTED_LOCATION_RELWITHDEBINFO "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/RelWithDebInfo/wxlua_debug-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaDebuggerLib" for configuration "RelWithDebInfo"
set_property(TARGET wxLuaDebuggerLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(wxLuaDebuggerLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELWITHDEBINFO "wxLuaBindLib;wxLuaDebugLib"
  IMPORTED_LOCATION_RELWITHDEBINFO "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/RelWithDebInfo/wxlua_debugger-wx31mswu-2.8.12.3.lib"
  )

# Import target "wxLuaBindLib" for configuration "RelWithDebInfo"
set_property(TARGET wxLuaBindLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(wxLuaBindLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELWITHDEBINFO "wxLuaLib"
  IMPORTED_LOCATION_RELWITHDEBINFO "D:/zbs/wxlua-wxwidgets311/wxLua/build/lib/RelWithDebInfo/wxlua_bind-wx31mswu-2.8.12.3.lib"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)