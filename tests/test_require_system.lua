-- Test for ZIL require system
-- Tests that require "zil" enables loading .zil files

print("=== Testing ZIL Require System ===\n")

-- Test 1: Basic require of zil module
print("Test 1: Loading zil module...")
local zil = require "zil"
assert(zil, "Failed to load zil module")
assert(type(zil.insert_loader) == "function", "zil.insert_loader should be a function")
assert(type(zil.zil_loader) == "function", "zil.zil_loader should be a function")
print("✓ Successfully loaded zil module\n")

-- Test 2: Check that package.zilpath was created
print("Test 2: Checking package.zilpath...")
assert(package.zilpath, "package.zilpath should be created")
print("✓ package.zilpath exists: " .. package.zilpath .. "\n")

-- Test 3: Check that loader was inserted
print("Test 3: Checking loader was inserted...")
local loaders = package.loaders or package.searchers
local found = false
for _, loader in ipairs(loaders) do
	if loader == zil.zil_loader then
		found = true
		break
	end
end
assert(found, "zil_loader should be in package.loaders/searchers")
print("✓ Loader was inserted successfully\n")

-- Test 4: Test loading a .zil file via require
print("Test 4: Loading test-require.zil via require...")
-- First, ensure tests directory is in the path
local original_path = package.path
package.path = package.path .. ";./tests/?.lua"
package.zilpath = package.zilpath .. ";./tests/?.zil"

-- Now require should work
local success, test_module = pcall(require, "test-require")
if not success then
	print("Error loading test-require: " .. tostring(test_module))
	error("Failed to load test-require.zil")
end
print("✓ Successfully loaded test-require.zil via require\n")

-- Test 5: Test utility functions
print("Test 5: Testing zil.to_lua...")
local simple_code = '<ROUTINE FOO () <RETURN 1>>'
local lua_code, result = zil.to_lua(simple_code)
assert(lua_code, "to_lua should return code")
assert(type(lua_code) == "string", "to_lua should return a string")
print("✓ zil.to_lua works correctly\n")

-- Test 6: Test loadstring
print("Test 6: Testing zil.loadstring...")
local test_code = '<ROUTINE BAR () <RETURN 99>>'
local chunk, err = zil.loadstring(test_code)
assert(chunk, "loadstring should return a chunk: " .. tostring(err))
print("✓ zil.loadstring works correctly\n")

-- Test 7: Test remove_loader
print("Test 7: Testing remove_loader...")
local removed = zil.remove_loader()
assert(removed, "remove_loader should return true")
local found_after = false
for _, loader in ipairs(loaders) do
	if loader == zil.zil_loader then
		found_after = true
		break
	end
end
assert(not found_after, "Loader should be removed")
print("✓ remove_loader works correctly\n")

-- Test 8: Re-insert loader
print("Test 8: Re-inserting loader...")
local inserted = zil.insert_loader()
assert(inserted, "insert_loader should return true")
local found_again = false
for _, loader in ipairs(loaders) do
	if loader == zil.zil_loader then
		found_again = true
		break
	end
end
assert(found_again, "Loader should be re-inserted")
print("✓ Loader re-inserted successfully\n")

-- Test 9: Verify require "zil" doesn't insert loader multiple times
print("Test 9: Testing that require 'zil' is idempotent...")
local count_before = 0
for _, loader in ipairs(loaders) do
	if loader == zil.zil_loader then
		count_before = count_before + 1
	end
end
require "zil"  -- Call again
local count_after = 0
for _, loader in ipairs(loaders) do
	if loader == zil.zil_loader then
		count_after = count_after + 1
	end
end
assert(count_before == count_after, "Loader should not be inserted multiple times")
print("✓ Loader count unchanged after second require 'zil'\n")

-- Clean up
package.path = original_path

print("=== All Tests Passed! ===")
