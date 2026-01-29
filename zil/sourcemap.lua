-- Source map module for mapping Lua line numbers to ZIL source locations
-- This allows converting Lua backtraces to ZIL source locations

local SourceMap = {}

-- Source map structure:
-- {
--   [filename] = {
--     [line_number] = { file = "zil_file.zil", line = zil_line, col = zil_col }
--   }
-- }
local source_maps = {}

-- Create or get a source map for a specific Lua file
function SourceMap.create(filename)
  if not source_maps[filename] then
    source_maps[filename] = {}
  end
  return source_maps[filename]
end

-- Add a mapping from Lua line to ZIL source location
function SourceMap.add_mapping(filename, line, zil_file, zil_line, zil_col)
  local map = SourceMap.create(filename)
  map[line] = {
    file = zil_file,
    line = zil_line,
    col = zil_col or 0
  }
end

-- Get the ZIL source location for a Lua line
function SourceMap.get_source(filename, line)
  local map = source_maps[filename]
  if not map then
    return nil
  end
  return map[line]
end

-- Clear all source maps (useful for testing)
function SourceMap.clear()
  for k in pairs(source_maps) do
    source_maps[k] = nil
  end
end

-- Translate a Lua traceback to use ZIL source locations
-- Input: standard Lua traceback string
-- Output: traceback with ZIL file:line references
function SourceMap.translate(stack)
  if not stack then
    return stack
  end
  
  -- remove all [C]: in function 'pcall' with any trailing spaces/newlines
  stack = stack:gsub("%[C%]: in function '[^']+'\n?%s*", "")
  stack = stack:gsub("\t", "  ") -- replace tabs with spaces for consistency

  -- Pattern to match Lua file references in stack
  -- Matches: zil_*.lua files or paths containing zil_*.lua
  -- We need to handle tabs/spaces before filenames in stack traces
  local result = stack:gsub("([@%s]*)([^%s:]*zil_[^%s:]+%.lua):(%d+):", function(prefix, file, line)
    -- Try to find source mapping
    local source = SourceMap.get_source(file, tonumber(line))
    
    if source and source.file and source.line then
      -- Replace with ZIL source location, preserve prefix (spaces/tabs/@)
      return prefix .. string.format("%s:%d:", source.file, source.line)
    else
      -- Keep original if no mapping found
      return prefix .. file .. ":" .. line .. ":"
    end
  end)
  
  return result
end

return SourceMap
