-- Test script to verify local variable naming conflict fix
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

-- Read and parse the test file
local file = io.open("test_local_conflict.zil", "r")
local content = file:read("*all")
file:close()

print("Parsing test file...")
local ast = parser.parse(content, "test_local_conflict.zil")

print("\nCompiling...")
local result = compiler.compile(ast)
local lua_code = result.combined

print("\n=== Generated Lua Code ===")
print(lua_code)
print("\n=== End of Generated Code ===")

-- Check for the conflict resolution
if lua_code:match("PROB_local") then
  print("\n✓ SUCCESS: Local variables are properly suffixed with _local")
else
  print("\n✗ FAILURE: Local variables are not properly suffixed")
  os.exit(1)
end

-- Check that the PROB function is defined (not PROB_local function)
if lua_code:match("^PROB = function") then
  print("✓ SUCCESS: Function PROB is defined correctly")
else
  print("✗ FAILURE: Function PROB definition is incorrect")
  os.exit(1)
end

-- Check that the PROB function is called with PROB_local as argument
if lua_code:match("PROB%(PROB_local%)") then
  print("✓ SUCCESS: PROB function is called with PROB_local parameter")
else
  print("✗ FAILURE: Function call pattern not found")
  os.exit(1)
end

print("\nAll checks passed!")
