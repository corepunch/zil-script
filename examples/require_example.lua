-- Example: Using require to load ZIL files
-- Demonstrates the new require system for .zil files

print("=== ZIL Require System Example ===\n")

-- Step 1: Initialize the ZIL loader
print("Step 1: Initialize ZIL loader")
require "zil"  -- This automatically sets up the loader
print("✓ ZIL loader initialized\n")

-- Step 2: Now we can require .zil files just like Lua files
print("Step 2: Load a simple ZIL file via require")
local test_require = require "tests.test-require"
print("✓ Loaded tests/test-require.zil\n")

-- Step 3: Try loading zork1 actions (if the file exists and is parseable)
print("Step 3: Attempt to load zork1.actions")
print("Note: This requires zork1/actions.zil to be present\n")

-- First, make sure the path includes the project directory
package.zilpath = package.zilpath .. ";./?.zil"

local ok, actions = pcall(require, "zork1.actions")
if ok then
	print("✓ Successfully loaded zork1/actions.zil via require!")
	print("  The file was compiled and cached automatically")
else
	print("⚠ Could not load zork1.actions: " .. tostring(actions))
	print("  (This is expected if actions.zil has dependencies)")
end

print("\n=== Summary ===")
print("The require system allows you to:")
print("  1. Call 'require \"zil\"' to initialize the loader")
print("  2. Use 'require \"module.name\"' to load .zil files")
print("  3. Files are automatically compiled from .zil to Lua")
print("  4. Compiled modules are cached by Lua's require system")
print("\nJust like moonscript!")
