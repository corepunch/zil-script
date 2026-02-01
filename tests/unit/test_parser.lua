#!/usr/bin/env lua
-- Unit tests for zil/parser.lua

local test = require 'tests.unit.test_framework'
local parser = require 'zilscript.parser'

test.describe("Parser - Basic Types", function(t)
	t.it("should parse numbers", function(assert)
		local ast = parser.parse("42")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "number")
		assert.assert_equal(ast[1].value, 42)
	end)
	
	t.it("should parse negative numbers", function(assert)
		local ast = parser.parse("-123")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "number")
		assert.assert_equal(ast[1].value, -123)
	end)
	
	t.it("should parse strings", function(assert)
		local ast = parser.parse('"hello world"')
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "string")
		assert.assert_equal(ast[1].value, "hello world")
	end)
	
	t.it("should parse identifiers", function(assert)
		local ast = parser.parse("FOOBAR")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "ident")
		assert.assert_equal(ast[1].value, "FOOBAR")
	end)
	
	t.it("should parse symbols", function(assert)
		local ast = parser.parse(",TEST")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "symbol")
		assert.assert_equal(ast[1].value, ",TEST")
	end)
end)

test.describe("Parser - Lists and Expressions", function(t)
	t.it("should parse empty expression", function(assert)
		local ast = parser.parse("<>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "expr")
	end)
	
	t.it("should parse simple expression", function(assert)
		local ast = parser.parse("<ADD 2 3>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "expr")
		assert.assert_equal(#ast[1], 2)
	end)
	
	t.it("should parse list with parens", function(assert)
		local ast = parser.parse("(1 2 3)")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "list")
		assert.assert_equal(#ast[1], 3)
	end)
	
	t.it("should parse expressions", function(assert)
		local ast = parser.parse("<ROUTINE TEST ()>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		local node = ast[1]
		assert.assert_equal(node.type, "expr")
		assert.assert_equal(node.name, "ROUTINE")
	end)
	
	t.it("should parse nested lists", function(assert)
		local ast = parser.parse("<A <B C> D>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		local node = ast[1]
		assert.assert_equal(node.type, "expr")
		assert.assert_equal(node.name, "A")
		assert.assert_equal(#node, 2)
		assert.assert_equal(node[1].type, "expr")
	end)
end)

test.describe("Parser - Special Forms", function(t)
	t.it("should handle comments", function(assert)
		local ast = parser.parse("<A> ; comment\n<B>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 2)
		assert.assert_equal(ast[1].name, "A")
		assert.assert_equal(ast[2].name, "B")
	end)
	
	t.it("should parse placeholders", function(assert)
		local ast = parser.parse("'ITEM")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].type, "placeholder")
	end)
	
	t.it("should parse multiple top-level forms", function(assert)
		local ast = parser.parse("<FORM1> <FORM2> <FORM3>")
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 3)
	end)
end)

test.describe("Parser - Complex Examples", function(t)
	t.it("should parse ROUTINE definition", function(assert)
		local code = [[<ROUTINE HELLO ()
			<TELL "Hello, world!">
		>]]
		local ast = parser.parse(code)
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		local routine = ast[1]
		assert.assert_equal(routine.type, "expr")
		assert.assert_equal(routine.name, "ROUTINE")
	end)
	
	t.it("should parse OBJECT definition", function(assert)
		local code = [[<OBJECT MAILBOX
			(DESC "mailbox")
			(FLAGS NDESCBIT CONTBIT)
		>]]
		local ast = parser.parse(code)
		assert.assert_not_nil(ast)
		assert.assert_equal(#ast, 1)
		assert.assert_equal(ast[1].name, "OBJECT")
	end)
end)

test.describe("Parser - View Function", function(t)
	t.it("should return string representation", function(assert)
		local ast = parser.parse("<TEST 123>")
		local view = parser.view(ast)
		assert.assert_type(view, "string")
		assert.assert_match(view, "TEST")
		assert.assert_match(view, "123")
	end)
end)

-- Run tests and exit with appropriate code
local success = test.summary()
os.exit(success and 0 or 1)
