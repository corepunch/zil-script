-- Comprehensive line accuracy test
local parser = require 'zilscript.parser'
local compiler = require 'zilscript.compiler'
local sourcemap = require 'zilscript.sourcemap'

sourcemap.clear()

-- Test with a realistic ZIL file with multiple routines
local test_zil = [[
<ROUTINE LINE-2 ()
  <PRINC "This is line 2">
>

<ROUTINE LINE-5 ()
  <PRINC "This is line 5">
  <PRINC "This is line 6">
>

<ROUTINE LINE-10 ()
  <PRINC "This is line 10">
  <+ 1 2>
  <PRINC "This is line 12">
>
]]

local f = io.open("/tmp/accurate_test.zil", "w")
f:write(test_zil)
f:close()

local ast = parser.parse_file("/tmp/accurate_test.zil")
local result = compiler.compile(ast, "zil_accurate_test.lua")

-- Find where specific ZIL lines are referenced in the Lua code
print("Looking for mappings to key ZIL lines:\n")

-- Check all mappings
local zil_to_lua = {}
for lua_line = 1, 100 do
  local src = sourcemap.get_source("zil_accurate_test.lua", lua_line)
  if src then
    local zil_line = src.line
    if not zil_to_lua[zil_line] then
      zil_to_lua[zil_line] = {}
    end
    table.insert(zil_to_lua[zil_line], lua_line)
  end
end

-- Print the Lua code with annotations
local lua_lines = {}
for line in result.combined:gmatch("([^\n]*)\n?") do
  table.insert(lua_lines, line)
end

print("Generated Lua code with ZIL source annotations:")
print("=" .. string.rep("=", 70))
for i = 1, math.min(50, #lua_lines) do
  local src = sourcemap.get_source("zil_accurate_test.lua", i)
  local annotation = ""
  if src then
    annotation = string.format("  <- ZIL line %d", src.line)
  end
  print(string.format("%3d: %-50s%s", i, lua_lines[i] or "", annotation))
end
print("=" .. string.rep("=", 70))

print("\nZIL line -> Lua lines mapping:")
for zil_line = 1, 15 do
  if zil_to_lua[zil_line] then
    print(string.format("  ZIL line %2d maps to Lua lines: %s", 
      zil_line, table.concat(zil_to_lua[zil_line], ", ")))
  end
end

print("\n✅ Test completed - verify that ZIL lines map to the correct Lua lines")
print("   The PRINC calls should be on the lines they claim to be from")

-- Exit successfully
os.exit(0)
