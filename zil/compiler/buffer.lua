-- Output buffer management for efficient string concatenation
-- Inspired by TypeScript's emitter buffer system
--
-- NOTE: We use dot notation (buf.write) not colon notation (buf:write)
-- because the buffer doesn't need self-reference. In Lua:
--   obj:method() is sugar for obj.method(obj) - passes self as first arg
--   obj.method() is a plain function call - no self parameter
-- This matches TypeScript's approach of simple function calls.
local sourcemap = require 'zil.sourcemap'

local Buffer = {}

-- Create a new output buffer with line tracking and source mapping
function Buffer.new(compiler)
  local lines = {}
  local current_line = 1  -- Track current Lua line number
  
  -- Helper to record source mapping for current line
  local function recordMapping()
    if compiler.current_lua_filename and compiler.current_source then
      local src = compiler.current_source
      sourcemap.add_mapping(
        compiler.current_lua_filename,
        current_line,
        src.filename,
        src.line,
        src.col
      )
    end
  end
  
  -- Helper to count newlines and record source mapping
  local function processNewlines(text)
    for _ in text:gmatch("\n") do
      current_line = current_line + 1
      recordMapping()
    end
  end
  
  return {
    write = function(fmt, ...)
      local text = string.format(fmt, ...)
      table.insert(lines, text)
      processNewlines(text)
    end,
    writeln = function(fmt, ...)
      if fmt then
        local text = string.format(fmt, ...)
        table.insert(lines, text)
        processNewlines(text)
      end
      table.insert(lines, "\n")
      recordMapping()
      current_line = current_line + 1
    end,
    indent = function(level)
      table.insert(lines, string.rep("  ", level))
    end,
    get = function()
      return table.concat(lines)
    end,
    clear = function()
      lines = {}
      current_line = 1
    end,
    get_line = function()
      return current_line
    end
  }
end

return Buffer
