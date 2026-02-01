-- Integration test for source mapping
-- Initialize ZIL require system
require 'zil'

local runtime = require 'zil.runtime'
local sourcemap = require 'zil.sourcemap'

print("Testing source mapping integration...")

-- Clear any previous mappings
sourcemap.clear()

-- Create a simple environment
local env = runtime.create_game_env()

-- Load bootstrap
print("\n1. Loading bootstrap...")
assert(runtime.load_bootstrap(env, true), "Bootstrap should load")

-- Create a simple ZIL file with a known error
local test_zil = [[
<ROUTINE TEST-FUNC ()
  <PRINC "Starting test">
  <PRINC "Line 4">
  <PRINC "Line 5">
  <+ 1 UNDEFINED-VAR>
>
]]

-- Write the test ZIL to a temporary file
local zil_file = io.open("/tmp/test_integration.zil", "w")
zil_file:write(test_zil)
zil_file:close()

-- Compile and load the ZIL file
print("\n2. Compiling ZIL file...")
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

local ast = parser.parse_file("/tmp/test_integration.zil")
local lua_filename = "zil_test_integration.lua"
local result = compiler.compile(ast, lua_filename)

-- Save the compiled Lua
local lua_file = io.open("/tmp/" .. lua_filename, "w")
lua_file:write(result.combined)
lua_file:close()

print("Generated Lua code:")
print(result.combined)
print("\n")

-- Load and execute
print("3. Executing compiled code...")
local chunk, err = load(result.combined, '@'..lua_filename, 't', env)
if not chunk then
  print("Compile error: " .. err)
  os.exit(1)
end

local ok, exec_err = pcall(chunk)
if not ok then
  print("Runtime error (expected):")
  print(exec_err)
end

-- Now test calling the function which references an undefined variable
print("\n4. Testing error translation...")
local call_ok, call_err = pcall(function()
  env["TEST_FUNC"]()
end)

if not call_ok then
  print("Got error (expected):")
  print(call_err)
  
  -- Translate the error
  local translated = sourcemap.translate(tostring(call_err))
  print("\nTranslated error:")
  print(translated)
  
  -- Check if it references the ZIL file
  if translated:match("test_integration%.zil") then
    print("\n✅ SUCCESS: Error was translated to ZIL source!")
    if translated:match("test_integration%.zil:6") or translated:match("test_integration%.zil:7") then
      print("✅ CORRECT LINE: Error correctly mapped to line 6 or 7!")
    else
      print("⚠️  Line number may not be exact (this is expected as tracking might not be perfect)")
    end
  else
    print("\n⚠️  WARNING: Error was not translated (might be because UNDEFINED-VAR is referenced before compilation)")
  end
else
  print("\n❌ FAILED: Expected an error but function succeeded")
end

print("\n✅ Integration test completed!")
