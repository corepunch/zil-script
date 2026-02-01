-- Test DEFMAC and FORM support
local test = require 'tests.unit.test_framework'
local parser = require 'zilscript.parser'
local compiler = require 'zilscript.compiler'

test.describe("DEFMAC and FORM Tests", function(t)

  -- Test 1: Parse DEFMAC
  t.it("should parse DEFMAC definition", function(assert)
    local source = [[
<DEFMAC BSET ('OBJ "ARGS" BITS)
  <FORM FSET .OBJ .BITS>>
]]
    local ast = parser.parse(source)
    assert.assert_not_nil(ast, "Should parse DEFMAC")
    assert.assert_equal(ast[1].name, "DEFMAC", "Should be DEFMAC")
    assert.assert_equal(ast[1][1].value, "BSET", "Should have name BSET")
  end)

  -- Test 2: Compile DEFMAC 
  t.it("should compile DEFMAC and store macro", function(assert)
    local source = [[
<DEFMAC BSET ('OBJ "ARGS" BITS)
  <FORM FSET .OBJ .BITS>>
]]
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    -- DEFMAC should be stored in compiler.macros, not generate code
    assert.assert_not_nil(result, "Should compile")
    -- The macro should not generate runtime code (no BSET function)
    local no_bset_func = not result.combined:match("BSET =")
    assert.assert_equal(no_bset_func, true, "DEFMAC should not generate runtime function")
  end)

  -- Test 3: Parse FORM expression
  t.it("should parse FORM expression", function(assert)
    local source = "<FORM OR .A .B>"
    local ast = parser.parse(source)
    assert.assert_not_nil(ast, "Should parse FORM")
    assert.assert_equal(ast[1].name, "FORM", "Should be FORM")
    assert.assert_equal(ast[1][1].value, "OR", "Should have OR as first arg")
  end)

  -- Test 4: Compile FORM expression
  t.it("should compile FORM expression", function(assert)
    local source = "<ROUTINE TEST () <FORM OR .A .B>>"
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    assert.assert_not_nil(result, "Should compile")
    -- FORM should generate a table/form structure
    local has_table = result.declarations:match("type=") or result.declarations:match("{")
    assert.assert_equal(has_table ~= nil, true, "FORM should generate table code")
  end)

end)

