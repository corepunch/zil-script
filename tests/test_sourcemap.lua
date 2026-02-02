-- Test source mapping functionality
local test = require 'tests.test_framework'
local sourcemap = require 'zilscript.sourcemap'

test.describe("Source Mapping", function(t)
  t.it("should find basic mapping", function(assert)
    sourcemap.clear()
    sourcemap.add_mapping("zil_test.lua", 10, "test.zil", 5, 10)
    local src = sourcemap.get_source("zil_test.lua", 10)
    assert.assert_not_nil(src, "Should find source mapping")
    assert.assert_equal(src.file, "test.zil", "Should map to correct file")
    assert.assert_equal(src.line, 5, "Should map to correct line")
  end)
  
  t.it("should return nil for unmapped line", function(assert)
    local src2 = sourcemap.get_source("zil_test.lua", 999)
    assert.assert_nil(src2, "Should return nil for unmapped line")
  end)
  
  t.it("should translate traceback", function(assert)
    sourcemap.clear()
    sourcemap.add_mapping("zil_action.lua", 235, "action.zil", 123, 0)
    local traceback = "zil_action.lua:235: no such variable whatever"
    local translated = sourcemap.translate(traceback)
    assert.assert_match(translated, "action%.zil:123:", "Should translate to ZIL source")
  end)
  
  t.it("should handle multiple mappings in traceback", function(assert)
    sourcemap.clear()
    sourcemap.add_mapping("zil_action.lua", 100, "action.zil", 50, 0)
    sourcemap.add_mapping("zil_parser.lua", 200, "parser.zil", 75, 0)
    local complex_traceback = [[stack traceback:
	zil_action.lua:100: in function 'foo'
	zil_parser.lua:200: in main chunk]]
    local translated2 = sourcemap.translate(complex_traceback)
    assert.assert_match(translated2, "action%.zil:50:", "Should translate first file")
    assert.assert_match(translated2, "parser%.zil:75:", "Should translate second file")
  end)
  
  t.it("should preserve unmapped references", function(assert)
    local traceback3 = "zil_unknown.lua:999: some error"
    local translated3 = sourcemap.translate(traceback3)
    assert.assert_match(translated3, "zil_unknown%.lua:999:", "Should preserve unmapped references")
  end)
end)

-- Run tests and exit with appropriate code
local success = test.summary()
os.exit(success and 0 or 1)
