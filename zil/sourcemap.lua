-- Source map module for mapping Lua line numbers to ZIL source locations
-- This allows converting Lua backtraces to ZIL source locations

local M = {}

-- Source map structure:
-- {
--   [lua_filename] = {
--     [lua_line_number] = { file = "zil_file.zil", line = zil_line, col = zil_col }
--   }
-- }
local source_maps = {}

-- Create or get a source map for a specific Lua file
function M.create(lua_filename)
  if not source_maps[lua_filename] then
    source_maps[lua_filename] = {}
  end
  return source_maps[lua_filename]
end

-- Add a mapping from Lua line to ZIL source location
function M.add_mapping(lua_filename, lua_line, zil_file, zil_line, zil_col)
  local map = M.create(lua_filename)
  map[lua_line] = {
    file = zil_file,
    line = zil_line,
    col = zil_col or 0
  }
end

-- Get the ZIL source location for a Lua line
function M.get_source(lua_filename, lua_line)
  local map = source_maps[lua_filename]
  if not map then
    return nil
  end
  return map[lua_line]
end

-- Clear all source maps (useful for testing)
function M.clear()
  for k in pairs(source_maps) do
    source_maps[k] = nil
  end
end

-- Translate a Lua traceback to use ZIL source locations
-- Input: standard Lua traceback string
-- Output: traceback with ZIL file:line references
function M.translate_traceback(traceback)
  if not traceback then
    return traceback
  end
  
  -- Pattern to match Lua file references in traceback
  -- Matches: zil_*.lua files or paths containing zil_*.lua
  -- We need to handle tabs/spaces before filenames in stack traces
  local result = traceback:gsub("([@%s]*)([^%s:]*zil_[^%s:]+%.lua):(%d+):", function(prefix, lua_file, lua_line)
    -- Try to find source mapping
    local source = M.get_source(lua_file, tonumber(lua_line))
    
    if source and source.file and source.line then
      -- Replace with ZIL source location, preserve prefix (spaces/tabs/@)
      return prefix .. string.format("%s:%d:", source.file, source.line)
    else
      -- Keep original if no mapping found
      return prefix .. lua_file .. ":" .. lua_line .. ":"
    end
  end)
  
  return result
end

return M
