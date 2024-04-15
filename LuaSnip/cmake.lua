local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- New Project
    s({trig = "new", snippetType="autosnippet"},
      fmta(
      [[
      cmake_minimum_required(VERSION 3.15)
      project(<>)
      ]],
        { i(1) }
      ),
      {condition = line_begin}
    ),

    -- Default build type
    s({trig = "dbuild", snippetType="autosnippet"},
    fmt(
      [[
      if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE {})
      endif()
      ]],
      { 
        i(1, "Release")
      }
    ),
    {condition = line_begin}
  ),
    -- Message Status
    s({trig = "pps", snippetType="autosnippet"},
    fmta(
      [[message(STATUS "<>")]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),

    -- Message Fatal Error
    s({trig = "ppe", snippetType="autosnippet"},
    fmta(
      [[message(FATAL_ERROR "<>")]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),
    -- IF STATEMENT
  s({trig = "iff", snippetType="autosnippet"},
    fmta(
      [[
      if(<>)
        <>
      endif()
      ]],
      { 
        i(1),
        d(2, get_visual)
      }
    ),
    {condition = line_begin}
  ),
  -- In source build prohibit
  s({trig = "noinsb", snippetType="autosnippet"},
    t({
      "if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})",
      "\tmessage(FATAL_ERROR \"In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. \")",
      "endif()"
      }
    ),
    { condition = line_begin }
  ),

  -- find_package
  s({trig = "pack", snippetType="autosnippet"},
    fmta(
      [[find_package(<>)]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),

  -- add subdirectory
  s({trig = "addsub", snippetType="autosnippet"},
    fmta(
      [[add_subdirectory(<>)]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),
  -- add executable
  s({trig = "addex", snippetType="autosnippet"},
    fmta(
      [[add_executable(<>)]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),

  -- add executable
  s({trig = "addlib", snippetType="autosnippet"},
    fmta(
      [[add_library(<>)]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),

   -- link_target_libraries
  s({trig = "llib", snippetType="autosnippet"},
    fmta(
      [[target_link_libraries(<>)]],
      { 
        i(1)
      }
    ),
    { condition = line_begin }
  ),

  -- link_target_include
  s({trig = "lincl", snippetType="autosnippet"},
    fmta(
      [[target_include_directories(<> <> "<>")]],
      { 
        i(1),
        i(2, "PUBLIC"),
        i(3, "${CMAKE_CURRENT_SOURCE_DIR}/include")
      }
    ),
    { condition = line_begin }
  ),
  }
