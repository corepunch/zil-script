#!/usr/bin/env lua
-- Unit tests for new TypeScript-inspired compiler modules

local test = require 'tests.unit.test_framework'
local parser = require 'zilscript.parser'
local visitor_module = require 'zilscript.compiler.visitor'
local diagnostics_module = require 'zilscript.compiler.diagnostics'
local emitter_module = require 'zilscript.compiler.emitter'
local checker_module = require 'zilscript.compiler.checker'

-- Visitor Tests
test.describe("Visitor Module", function(t)
  t.it("should collect ROUTINE nodes", function(assert)
    local ast = parser.parse([[
      <ROUTINE FOO () <RETURN 1>>
      <ROUTINE BAR () <RETURN 2>>
    ]])
    
    local collector = visitor_module.collector(function(node)
      return node.type == "expr" and node.name == "ROUTINE"
    end)
    
    for i = 1, #ast do
      collector.walk(ast[i], {})
    end
    
    local routines = collector.get_collected()
    assert.assert_equal(#routines, 2, "Should find 2 ROUTINE nodes")
  end)

  t.it("should count nodes by type", function(assert)
    local ast = parser.parse([[<ROUTINE TEST (A B) <SET A 10> <RETURN A>>]])
    
    local counter = visitor_module.counter()
    counter.walk(ast[1], {})
    
    local counts = counter.get_counts()
    assert.assert_true(counts["ROUTINE"] >= 1, "Should count ROUTINE")
  end)
end)

-- Diagnostics Tests
test.describe("Diagnostics Module", function(t)
  t.it("should add error", function(assert)
    local diag = diagnostics_module.new()
    diag.error(1004, "Variable 'foo' undefined", {filename = "test.zil", line = 42, col = 10})
    
    assert.assert_true(diag.has_errors(), "Should have errors")
    assert.assert_equal(#diag.errors, 1, "Should have 1 error")
  end)

  t.it("should add warning", function(assert)
    local diag = diagnostics_module.new()
    diag.warning(2001, "Type mismatch", {filename = "test.zil", line = 10, col = 5})
    
    assert.assert_false(diag.has_errors(), "Should not have errors")
    assert.assert_equal(#diag.warnings, 1, "Should have 1 warning")
  end)

  t.it("should format diagnostic", function(assert)
    local diag = diagnostics_module.new()
    diag.error(1004, "Variable undefined", {filename = "test.zil", line = 5, col = 3})
    
    local formatted = diag.format_diagnostic(diag.errors[1])
    assert.assert_match(formatted, "test%.zil:5:3", "Should include location")
    assert.assert_match(formatted, "ERROR", "Should include category")
  end)
end)

-- Emitter Tests
test.describe("Emitter Module", function(t)
  t.it("should emit function", function(assert)
    local compiler = {current_source = nil, current_lua_filename = "test.lua"}
    local emitter = emitter_module.new(compiler)
    
    emitter.emit_function("my_func", {"a", "b"}, function()
      emitter.writeln_indented("return a + b")
    end)
    
    local output = emitter.get_output()
    assert.assert_match(output, "function my_func", "Should emit function")
    assert.assert_match(output, "end", "Should emit end")
  end)

  t.it("should manage indentation", function(assert)
    local compiler = {current_source = nil, current_lua_filename = "test.lua"}
    local emitter = emitter_module.new(compiler)
    
    assert.assert_equal(emitter.indent_level, 0, "Should start at 0")
    emitter.increase_indent()
    assert.assert_equal(emitter.indent_level, 1, "Should be 1")
    emitter.decrease_indent()
    assert.assert_equal(emitter.indent_level, 0, "Should be 0 again")
  end)
end)

-- Checker Tests
test.describe("Checker Module", function(t)
  t.it("should declare and lookup symbol", function(assert)
    local diag = diagnostics_module.new()
    local checker = checker_module.new(diag)
    
    local node = {type = "ident", value = "FOO"}
    checker.declare_symbol("FOO", checker_module.SymbolKind.ROUTINE, node)
    
    local symbol = checker.lookup_symbol("FOO")
    assert.assert_not_nil(symbol, "Should find symbol")
    assert.assert_equal(symbol.name, "FOO", "Should have correct name")
  end)

  t.it("should error on undefined symbol", function(assert)
    local diag = diagnostics_module.new()
    local checker = checker_module.new(diag)
    
    local node = {type = "ident", value = "UNDEFINED"}
    checker.check_defined("UNDEFINED", node)
    
    assert.assert_true(diag.has_errors(), "Should have error")
  end)

  t.it("should manage scopes", function(assert)
    local diag = diagnostics_module.new()
    local checker = checker_module.new(diag)
    
    checker.declare_symbol("GLOBAL_VAR", checker_module.SymbolKind.GLOBAL, {})
    checker.enter_scope("function")
    checker.declare_symbol("LOCAL_VAR", checker_module.SymbolKind.LOCAL, {})
    
    assert.assert_not_nil(checker.lookup_symbol("GLOBAL_VAR"), "Should find global")
    assert.assert_not_nil(checker.lookup_symbol("LOCAL_VAR"), "Should find local")
    
    checker.exit_scope()
    assert.assert_not_nil(checker.lookup_symbol("GLOBAL_VAR"), "Should still find global")
    assert.assert_nil(checker.lookup_symbol("LOCAL_VAR"), "Should not find local")
  end)
end)
