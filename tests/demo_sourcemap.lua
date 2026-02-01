-- Demonstration of source mapping feature
-- This shows how Lua errors are automatically translated to ZIL source locations

-- Initialize ZIL require system
require 'zil'

local runtime = require 'zil.runtime'
local sourcemap = require 'zil.sourcemap'

print("=== Source Mapping Demonstration ===\n")

-- Create environment and load bootstrap
local env = runtime.create_game_env()
runtime.load_bootstrap(env, true)

-- Create a ZIL file that will generate an error
local demo_zil = [[
<ROUTINE BROKEN-ROUTINE ()
  <PRINC "This routine will fail">
  <TELL CR CR "Attempting to use undefined variable..." CR>
  <SET X UNDEFINED-VARIABLE>
>

<ROUTINE CALLER ()
  <PRINC "Calling broken routine...">
  <BROKEN-ROUTINE>
>
]]

-- Write to temp file
local temp_zil = "/tmp/demo.zil"
local f = io.open(temp_zil, "w")
f:write(demo_zil)
f:close()

print("Created demo ZIL file:")
print(demo_zil)
print()

-- Compile it
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

local ast = parser.parse_file(temp_zil)
local lua_filename = "zil_demo.lua"
local result = compiler.compile(ast, lua_filename)

print("Compiled to Lua (first 20 lines):")
local lines = {}
for line in result.combined:gmatch("[^\n]+") do
  table.insert(lines, line)
  if #lines >= 20 then break end
end
print(table.concat(lines, "\n"))
print("...\n")

-- Load it
local ok, err = pcall(function()
  local chunk = load(result.combined, '@'..lua_filename, 't', env)
  if chunk then
    chunk()
  end
end)

if not ok then
  print("Loading failed (unexpected):", err)
  os.exit(1)
end

print("✓ Code loaded successfully\n")

-- Now call the function and expect an error
print("Calling BROKEN-ROUTINE()...")
local call_ok, call_err = pcall(function()
  return env["BROKEN_ROUTINE"]()
end)

if not call_ok then
  print("\n━━━ ERROR (Before Translation) ━━━")
  print(call_err)
  print()
  
  -- Translate it
  local translated = sourcemap.translate(tostring(call_err))
  print("━━━ ERROR (After Translation) ━━━")
  print(translated)
  print()
  
  -- Highlight the difference
  if translated ~= call_err then
    print("✅ SUCCESS! Lua file references were translated to ZIL file references!")
    print()
    if translated:match("demo%.zil") then
      print("✓ References demo.zil (ZIL source file)")
    end
    if translated:match("demo%.zil:%d+") then
      local line = translated:match("demo%.zil:(%d+)")
      print("✓ Includes line number in ZIL source: line " .. line)
    end
  else
    print("⚠️  No translation occurred (this might happen if the error doesn't reference Lua files)")
  end
else
  print("❌ Function succeeded when it should have failed!")
end

print("\n=== Demonstration Complete ===")
