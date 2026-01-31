-- Test DEFMAC macro expansion
local test = require 'tests.unit.test_framework'
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

test.describe("DEFMAC Macro Expansion", function(t)

  -- Test 1: Simple macro expansion
  t.it("should expand simple BSET macro", function(assert)
    local source = [[
<DEFMAC BSET ('OBJ "ARGS" BITS)
  <FORM FSET .OBJ .BITS>>

<ROUTINE TEST-MACRO ()
  <BSET MY-OBJECT FLAG1 FLAG2>>
]]
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    assert.assert_not_nil(result, "Should compile")
    -- The macro should expand to FSET call
    local has_fset = result.declarations:match("FSET") ~= nil
    assert.assert_equal(has_fset, true, "Should expand to FSET")
    local has_obj = result.declarations:match("MY_OBJECT") or result.declarations:match("MYOBJECT")
    assert.assert_equal(has_obj ~= nil, true, "Should include MY-OBJECT")
  end)

  -- Test 2: Macro with single parameter
  t.it("should expand macro with one parameter", function(assert)
    local source = [[
<DEFMAC RFATAL ()
  '<PROG () <RETURN 42>>>

<ROUTINE TEST-RFATAL ()
  <RFATAL>>
]]
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    assert.assert_not_nil(result, "Should compile")
    -- Should expand to PROG form
    local has_expansion = result.declarations:match("function%(%)") or result.declarations:match("PROG")
    assert.assert_equal(has_expansion ~= nil, true, "Should expand macro body")
  end)

  -- Test 3: Macro parameter substitution
  t.it("should substitute macro parameters", function(assert)
    local source = [[
<DEFMAC DOUBLE ('X)
  <FORM + .X .X>>

<ROUTINE TEST-DOUBLE ()
  <DOUBLE 5>>
]]
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    assert.assert_not_nil(result, "Should compile")
    -- Should expand to addition
    local has_add = result.declarations:match("ADD") or result.declarations:match("%+")
    assert.assert_equal(has_add ~= nil, true, "Should expand to addition")
  end)

  -- Test 4: Macro without FORM (quoted body)
  t.it("should handle quoted macro body", function(assert)
    local source = [[
<DEFMAC SIMPLE ()
  '<RETURN T>>

<ROUTINE TEST-SIMPLE ()
  <SIMPLE>>
]]
    local ast = parser.parse(source)
    local result = compiler.compile(ast, "test.lua")
    
    assert.assert_not_nil(result, "Should compile")
    local has_return = result.declarations:match("return") ~= nil
    assert.assert_equal(has_return, true, "Should have return statement")
  end)

end)
