#!/usr/bin/env lua
-- Unit tests for zil/compiler.lua

local test = require 'tests.unit.test_framework'
local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

test.describe("Compiler - Basic Compilation", function(t)
	t.it("should compile simple routine", function(assert)
		local code = [[<ROUTINE TEST () <RETURN 42>>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_type(result, "table")
		assert.assert_not_nil(result.body)
		assert.assert_not_nil(result.declarations)
		assert.assert_not_nil(result.combined)
	end)
	
	t.it("should generate function declaration", function(assert)
		local code = [[<ROUTINE HELLO () <RETURN 1>>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_match(result.body, "HELLO = function")
		assert.assert_match(result.body, "error%(1%)")
	end)
	
	t.it("should compile routine with parameters", function(assert)
		local code = [[<ROUTINE ADD (A B) <RETURN <+ .A .B>>>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_match(result.body, "ADD = function")
		assert.assert_match(result.body, "local A, B")
	end)
end)

test.describe("Compiler - Object Compilation", function(t)
	t.it("should compile simple object", function(assert)
		local code = [[<OBJECT MAILBOX (DESC "mailbox")>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_match(result.body, "MAILBOX")
	end)
	
	t.it("should compile object with properties", function(assert)
		local code = [[<OBJECT ITEM (DESC "item") (FLAGS TAKEBIT)>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_match(result.body, "ITEM")
	end)
end)

test.describe("Compiler - Constants and Globals", function(t)
	t.it("should compile CONSTANT", function(assert)
		local code = [[<CONSTANT MAX-SCORE 100>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		-- Constants generate declarations
		assert.assert_type(result.declarations, "string")
	end)
	
	t.it("should compile GLOBAL", function(assert)
		local code = [[<GLOBAL SCORE 0>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_type(result.declarations, "string")
	end)
end)

test.describe("Compiler - Control Flow", function(t)
	t.it("should compile COND statement", function(assert)
		local code = [[<ROUTINE TEST (X)
			<COND (<G? .X 0> <RETURN 1>)
			      (ELSE <RETURN 0>)>
		>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_match(result.body, "if")
	end)
	
	t.it("should compile REPEAT loop", function(assert)
		local code = [[<ROUTINE LOOP ()
			<REPEAT ()
				<RETURN>
			>
		>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_match(result.body, "repeat")
	end)
end)

test.describe("Compiler - Output Structure", function(t)
	t.it("should separate declarations and body", function(assert)
		local code = [[<GLOBAL TEST 0> <ROUTINE HELLO () <RETURN>>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result.declarations)
		assert.assert_not_nil(result.body)
		assert.assert_type(result.declarations, "string")
		assert.assert_type(result.body, "string")
	end)
	
	t.it("should provide combined output", function(assert)
		local code = [[<ROUTINE TEST () <RETURN>>]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result.combined)
		assert.assert_type(result.combined, "string")
		-- Combined should contain both declarations and body
		local combined_length = #result.combined
		local decl_length = #result.declarations
		local body_length = #result.body
		assert.assert_true(combined_length >= decl_length + body_length)
	end)
end)

test.describe("Compiler - Edge Cases", function(t)
	t.it("should handle empty AST", function(assert)
		local ast = parser.parse("")
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_type(result.body, "string")
		assert.assert_type(result.declarations, "string")
	end)
	
	t.it("should compile multiple top-level forms", function(assert)
		local code = [[
			<ROUTINE A () <RETURN 1>>
			<ROUTINE B () <RETURN 2>>
			<ROUTINE C () <RETURN 3>>
		]]
		local ast = parser.parse(code)
		local result = compiler.compile(ast)
		
		assert.assert_not_nil(result)
		assert.assert_match(result.body, "A = function")
		assert.assert_match(result.body, "B = function")
		assert.assert_match(result.body, "C = function")
	end)
end)

-- Run tests and exit with appropriate code
local success = test.summary()
os.exit(success and 0 or 1)
