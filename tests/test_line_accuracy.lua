-- Test to verify line number accuracy
local parser = require 'zilscript.parser'
local compiler = require 'zilscript.compiler'
local sourcemap = require 'zilscript.sourcemap'

-- Clear previous mappings
sourcemap.clear()

-- Simple ZIL code with known line numbers
local test_zil = [[
<ROUTINE TEST-LINE-1 ()
  <PRINC "Line 2">
  <PRINC "Line 3">
  <PRINC "Line 4">
>
]]

-- Write to temp file
local f = io.open("/tmp/test_lines.zil", "w")
f:write(test_zil)
f:close()

-- Compile it
local ast = parser.parse_file("/tmp/test_lines.zil")
local result = compiler.compile(ast, "zil_test_lines.lua")

print("Generated Lua code:")
local lua_lines = {}
for line in result.combined:gmatch("[^\n]*\n?") do
  if line ~= "" then
    table.insert(lua_lines, line)
  end
end

for i, line in ipairs(lua_lines) do
  print(string.format("%3d: %s", i, line))
end

print("\n\nSource mappings:")
for lua_line = 1, #lua_lines do
  local src = sourcemap.get_source("zil_test_lines.lua", lua_line)
  if src then
    print(string.format("Lua line %d -> ZIL %s:%d", lua_line, src.file, src.line))
  end
end

print("\n\nExpected mappings (approximate):")
print("The PRINC calls on ZIL lines 2, 3, 4 should map to their corresponding Lua lines")
print("If we see Lua line X mapping to ZIL line Y+1, we have an off-by-one error")

-- Exit successfully
os.exit(0)
