local helpers = require 'personal.luasnip-helper-funcs'
local get_visual = helpers.get_visual

local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {
  -- New Project
  s(
    { trig = 'new', snippetType = 'autosnippet' },
    fmta(
      [[
      cmake_minimum_required(VERSION 3.15...3.30)
      project(
      <>
      VERSION <>
      DESCRIPTION "<>"
      LANGUAGES <>)
      ]],
      { i(1), i(2, '1.0'), i(3), i(4, 'CXX') }
    ),
    { condition = line_begin }
  ),

  -- Default build type
  s(
    { trig = 'dbuild', snippetType = 'autosnippet' },
    fmt(
      [[
      # Default Build type if not specified (set to "Release")
      set(default_build_type "<>")
      if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
        message(
          STATUS
          "Setting build type to '${default_build_type}' as none was specified.")
        set(CMAKE_BUILD_TYPE
          "${default_build_type}"
          CACHE STRING "Choose the type of build." FORCE)
        # Set the possible values of build type for cmake-gui
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
                                               "MinSizeRel" "RelWithDebInfo")
      endif()
  ]],
      {
        i(1, 'Release'),
      }
    ),
    { condition = line_begin }
  ),
  -- Message Status
  s(
    { trig = 'pps', snippetType = 'autosnippet' },
    fmta([[message(STATUS "<>")]], {
      i(1),
    }),
    { condition = line_begin }
  ),

  -- Message Fatal Error
  s(
    { trig = 'ppe', snippetType = 'autosnippet' },
    fmta([[message(FATAL_ERROR "<>")]], {
      i(1),
    }),
    { condition = line_begin }
  ),
  -- IF STATEMENT
  s(
    { trig = 'iff', snippetType = 'autosnippet' },
    fmta(
      [[
      if(<>)
        <>
      endif()
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- In source build prohibit
  s(
    { trig = 'noinsb', snippetType = 'autosnippet' },
    t {
      'if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})',
      '\tmessage(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. ")',
      'endif()',
    },
    { condition = line_begin }
  ),

  -- find_package
  s(
    { trig = 'pack', snippetType = 'autosnippet' },
    fmta([[find_package(<>)]], {
      i(1),
    }),
    { condition = line_begin }
  ),

  -- add subdirectory
  s(
    { trig = 'adsub', snippetType = 'autosnippet' },
    fmta([[add_subdirectory(<>)]], {
      i(1),
    }),
    { condition = line_begin }
  ),
  -- add executable
  s(
    { trig = 'adex', snippetType = 'autosnippet' },
    fmta([[add_executable(<>)]], {
      i(1),
    }),
    { condition = line_begin }
  ),

  -- add executable
  s(
    { trig = 'adlib', snippetType = 'autosnippet' },
    fmta([[add_library(<>)]], {
      i(1),
    }),
    { condition = line_begin }
  ),

  -- link_target_libraries
  s(
    { trig = 'llib', snippetType = 'autosnippet' },
    fmta([[target_link_libraries(<>)]], {
      i(1),
    }),
    { condition = line_begin }
  ),

  -- link_target_include
  s(
    { trig = 'lincl', snippetType = 'autosnippet' },
    fmta([[target_include_directories(<> <> "<>")]], {
      i(1),
      i(2, 'PUBLIC'),
      i(3, '${CMAKE_CURRENT_SOURCE_DIR}/include'),
    }),
    { condition = line_begin }
  ),
}
