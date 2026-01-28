-- Test source mapping functionality
local sourcemap = require 'zil.sourcemap'

print("Testing source mapping module...")

-- Test 1: Basic mapping
sourcemap.clear()
sourcemap.add_mapping("zil_test.lua", 10, "test.zil", 5, 10)
local src = sourcemap.get_source("zil_test.lua", 10)
assert(src ~= nil, "Should find source mapping")
assert(src.file == "test.zil", "Should map to correct file")
assert(src.line == 5, "Should map to correct line")
print("✓ Test 1: Basic mapping works")

-- Test 2: No mapping found
local src2 = sourcemap.get_source("zil_test.lua", 999)
assert(src2 == nil, "Should return nil for unmapped line")
print("✓ Test 2: Returns nil for unmapped lines")

-- Test 3: Traceback translation
sourcemap.clear()
sourcemap.add_mapping("zil_action.lua", 235, "action.zil", 123, 0)
local traceback = "zil_action.lua:235: no such variable whatever"
local translated = sourcemap.translate_traceback(traceback)
assert(translated:match("action%.zil:123:"), "Should translate to ZIL source")
print("✓ Test 3: Traceback translation works")
print("  Original:   " .. traceback)
print("  Translated: " .. translated)

-- Test 4: Multiple mappings in traceback
sourcemap.clear()
sourcemap.add_mapping("zil_action.lua", 100, "action.zil", 50, 0)
sourcemap.add_mapping("zil_parser.lua", 200, "parser.zil", 75, 0)
local complex_traceback = [[stack traceback:
	zil_action.lua:100: in function 'foo'
	zil_parser.lua:200: in main chunk]]
local translated2 = sourcemap.translate_traceback(complex_traceback)
assert(translated2:match("action%.zil:50:"), "Should translate first file")
assert(translated2:match("parser%.zil:75:"), "Should translate second file")
print("✓ Test 4: Multiple translations work")

-- Test 5: Preserve unmapped references
local traceback3 = "zil_unknown.lua:999: some error"
local translated3 = sourcemap.translate_traceback(traceback3)
assert(translated3:match("zil_unknown%.lua:999:"), "Should preserve unmapped references")
print("✓ Test 5: Preserves unmapped references")

print("\n✅ All source mapping tests passed!")
