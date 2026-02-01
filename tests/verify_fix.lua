-- Verification test for the off-by-one fix
-- This test demonstrates that line numbers are now accurate

-- Initialize ZIL require system
require 'zil'

local parser = require 'zil.parser'
local compiler = require 'zil.compiler'
local sourcemap = require 'zil.sourcemap'
local runtime = require 'zil.runtime'

print("=== Verification of Off-By-One Fix ===\n")

sourcemap.clear()

-- Create a ZIL file similar to what would be in actions.zil
local test_zil = [[
<ROUTINE EXAMPLE-ROUTINE ()
  <PRINC "Line 2">
  <PRINC "Line 3">
  <PRINC "Line 4">
  <RANDOM 100>
  <PRINC "Line 6">
>
]]

local f = io.open("/tmp/verify_fix.zil", "w")
f:write(test_zil)
f:close()

-- Compile it
local ast = parser.parse_file("/tmp/verify_fix.zil")
local result = compiler.compile(ast, "zil_verify_fix.lua")

print("ZIL Source (with line numbers):")
print("─────────────────────────────────")
local zil_lines = {}
for line in test_zil:gmatch("[^\n]+") do
  table.insert(zil_lines, line)
end
for i, line in ipairs(zil_lines) do
  print(string.format("%d: %s", i, line))
end
print("─────────────────────────────────\n")

-- Create environment
local env = runtime.create_game_env()
runtime.load_bootstrap(env, true)

-- Load the code
local chunk = load(result.combined, '@zil_verify_fix.lua', 't', env)
if chunk then pcall(chunk) end

print("Now testing error at ZIL line 5 (RANDOM call):\n")

-- Trigger an error on the RANDOM line
local ok, err = pcall(function()
  env.EXAMPLE_ROUTINE()
end)

if not ok then
  local translated = sourcemap.translate(tostring(err))
  print("Error traceback:")
  print(translated)
  print()
  
  -- Check if the error points to the correct line
  if translated:match("/tmp/verify_fix%.zil:5") then
    print("✅ PASS: Error correctly points to ZIL line 5 (where RANDOM is)")
    print("   The off-by-one bug has been FIXED!")
  elseif translated:match("/tmp/verify_fix%.zil:6") then
    print("❌ FAIL: Error points to ZIL line 6 instead of 5")
    print("   This would indicate an off-by-one error")
  elseif translated:match("/tmp/verify_fix%.zil:4") then
    print("❌ FAIL: Error points to ZIL line 4 instead of 5")
    print("   This would indicate an off-by-negative-one error")
  else
    print("⚠️  Line number not found in expected range")
  end
end

print("\n=== Verification Complete ===")
