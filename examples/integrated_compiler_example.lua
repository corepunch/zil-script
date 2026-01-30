-- Example: Using the Integrated TypeScript-Inspired Compiler
-- This demonstrates how the compiler now uses diagnostics and optional semantic checking

local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

print("=== Example 1: Basic Compilation (Backward Compatible) ===\n")

local code1 = [[
  <ROUTINE HELLO (NAME)
    <TELL "Hello, " .NAME "!" CR>>
]]

local ast1 = parser.parse(code1)
local result1 = compiler.compile(ast1)

print("Compilation result:")
print("  Has declarations:", result1.declarations ~= nil)
print("  Has body:", result1.body ~= nil)
print("  Has diagnostics:", result1.diagnostics ~= nil)
print("  Diagnostic summary:", result1.diagnostics.summary())

print("\n=== Example 2: Compilation with Errors ===\n")

-- Code with unknown form - will generate diagnostic error
local code2 = [[
  <ROUTINE TEST ()>
  <UNKNOWN-FORM X>
]]

local ast2 = parser.parse(code2)
local result2 = compiler.compile(ast2, "test.lua")

print("Compilation with errors:")
print("  Has errors:", result2.diagnostics.has_errors())
print("  Diagnostic summary:", result2.diagnostics.summary())
print("\nFormatted diagnostics:")
print(result2.diagnostics.format_all())

print("\n=== Example 3: Semantic Checking ===\n")

-- Code with undefined variable
local code3 = [[
  <ROUTINE FOO ()
    <RETURN X>>
  
  <ROUTINE BAR ()
    <SETG Y 10>>
]]

local ast3 = parser.parse(code3)
local result3 = compiler.compile(ast3, "semantic.lua", {
  enable_semantic_check = true
})

print("Semantic checking enabled:")
print("  Has errors:", result3.diagnostics.has_errors())
print("  Diagnostic summary:", result3.diagnostics.summary())

if result3.diagnostics.has_errors() then
  print("\nSemantic errors found:")
  result3.diagnostics.report()
end

print("\n=== Example 4: Valid Code with Semantic Checking ===\n")

-- Valid code
local code4 = [[
  <GLOBAL X 0>
  <GLOBAL Y 0>
  
  <ROUTINE FOO ()
    <RETURN .X>>
  
  <ROUTINE BAR ()
    <SETG Y 10>>
]]

local ast4 = parser.parse(code4)
local result4 = compiler.compile(ast4, "valid.lua", {
  enable_semantic_check = true
})

print("Valid code with semantic checking:")
print("  Has errors:", result4.diagnostics.has_errors())
print("  Diagnostic summary:", result4.diagnostics.summary())
print("  Compilation successful!")

print("\n=== Summary ===\n")
print("The compiler now uses TypeScript-inspired modules internally:")
print("  ✓ Diagnostics collection for better error reporting")
print("  ✓ Optional semantic checking with checker module")
print("  ✓ Backward compatible - existing code works unchanged")
print("  ✓ New features available through options parameter")
