#!/usr/bin/env lua5.4
-- Real-world demonstration of source mapping with a complete example
-- This shows how developers benefit from seeing ZIL source locations instead of Lua

print("=== Real-World Source Mapping Example ===\n")
print("This demonstrates how error messages now reference ZIL files instead of Lua files.\n")

-- Initialize ZIL require system
require 'zil'

local runtime = require 'zil.runtime'

-- Create a realistic ZIL program with a bug
local example_zil = [[
<ROUTINE CALCULATE-DAMAGE (WEAPON ARMOR)
  <COND
    (<EQUAL? .WEAPON "SWORD">
      <RETURN </ <+ 10 <GET-WEAPON-BONUS .WEAPON>> .ARMOR>>
    )
    (<EQUAL? .WEAPON "AXE">
      <RETURN </ <+ 15 <GET-WEAPON-BONUS .WEAPON>> .ARMOR>>
    )
    (ELSE
      <RETURN 0>
    )
  >
>

<ROUTINE GET-WEAPON-BONUS (WEAPON)
  ; Bug: This routine tries to access an undefined variable
  <RETURN <+ 5 UNDEFINED-BONUS-TABLE>>
>

<ROUTINE MAIN ()
  <TELL "Starting combat simulation..." CR>
  <PRINC <CALCULATE-DAMAGE "SWORD" 2>>
  <TELL " damage dealt." CR>
>
]]

-- Save to a file that simulates a real project
local filename = "/tmp/combat_system.zil"
local f = io.open(filename, "w")
f:write(example_zil)
f:close()

print("📄 Created ZIL source file: combat_system.zil")
print()
print("ZIL Code Preview:")
print("─────────────────────────────────────────")
for i, line in ipairs({
  "1:  <ROUTINE CALCULATE-DAMAGE (WEAPON ARMOR)",
  "2:    <COND",
  "3:      (<EQUAL? .WEAPON \"SWORD\">",
  "...",
  "15: <ROUTINE GET-WEAPON-BONUS (WEAPON)",
  "16:   ; Bug: This routine tries to access an undefined variable",
  "17:   <RETURN <+ 5 UNDEFINED-BONUS-TABLE>>",
  "18: >",
}) do
  print("   " .. line)
end
print("─────────────────────────────────────────")
print()

-- Compile it
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

print("🔧 Compiling ZIL to Lua...")
local ast = parser.parse_file(filename)
local result = compiler.compile(ast, "zil_combat_system.lua")
print("✓ Compilation successful")
print()

-- Create environment and load bootstrap
local env = runtime.create_game_env()
runtime.load_bootstrap(env, true)

-- Load the compiled code
print("⚙️  Loading compiled code...")
local chunk = load(result.combined, '@zil_combat_system.lua', 't', env)
if chunk then
  local ok, err = pcall(chunk)
  if ok then
    print("✓ Code loaded successfully")
  else
    print("✗ Loading failed:", err)
    os.exit(1)
  end
end
print()

-- Run it and trigger the error
print("🎮 Running MAIN()...")
print()
print("─── Program Output ───")
local ok, err = pcall(function()
  env.MAIN()
end)

if not ok then
  print()
  print("─── Error Occurred ───")
  print()
  
  -- The error has already been translated by the runtime
  local sourcemap = require 'zil.sourcemap'
  local translated = sourcemap.translate(tostring(err))
  
  print("💥 ERROR MESSAGE:")
  print()
  print(translated)
  print()
  
  -- Highlight the benefit
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("✅ NOTICE: The error references 'combat_system.zil'")
  print("   (the ZIL source file you wrote)")
  print()
  print("   NOT 'zil_combat_system.lua'")
  print("   (the generated Lua file)")
  print()
  print("   This makes debugging much easier!")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
else
  print()
  print("✗ Expected an error but program succeeded")
end

print()
print("=== End of Demonstration ===")
