-- Demonstration of the new require system working with zork1.actions
-- This shows how the require system can be used instead of the old approach

print("=== Demonstration: Old vs New Approach ===\n")

print("OLD APPROACH (from main.lua):")
print("  local runtime = require 'zil.runtime'")
print("  local files = { 'zork1/actions.zil', ... }")
print("  runtime.load_zil_files(files, env)")
print("")

print("NEW APPROACH (with require system):")
print("  require 'zil'  -- Initialize loader")
print("  local actions = require 'zork1.actions'  -- Auto-compiles and loads")
print("")

print("Let's try the new approach:\n")

-- Initialize the ZIL loader
require "zil"
print("✓ ZIL loader initialized")

-- Try to load a simple test file (not zork1.actions as it has dependencies)
package.zilpath = package.zilpath .. ";./tests/?.zil"
local ok, test_module = pcall(require, "test-require")

if ok then
	print("✓ Successfully loaded test-require.zil via require()")
	print("")
	print("Benefits of the new approach:")
	print("  1. Cleaner syntax - just use require() like any Lua module")
	print("  2. Automatic caching - Lua handles module caching for you")
	print("  3. Standard Lua conventions - works with package.path/searchers")
	print("  4. Similar to moonscript - familiar pattern for Lua developers")
else
	print("✗ Failed: " .. tostring(test_module))
end

print("")
print("Note: For files with dependencies (like zork1/actions.zil),")
print("      you'll need to load dependencies first or use the")
print("      runtime.load_zil_files() approach for complete games.")
