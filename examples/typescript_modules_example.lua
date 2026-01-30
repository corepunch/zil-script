-- Example: Using TypeScript-Inspired Compiler Modules
-- This example demonstrates how to use the new visitor, diagnostics, emitter, and checker modules

local parser = require 'zil.parser'
local visitor = require 'zil.compiler.visitor'
local diagnostics = require 'zil.compiler.diagnostics'
local emitter_module = require 'zil.compiler.emitter'
local checker = require 'zil.compiler.checker'

print("=== Example 1: Using the Visitor Pattern ===\n")

-- Parse some ZIL code
local ast = parser.parse([[
  <ROUTINE HELLO (NAME)
    <TELL "Hello, " .NAME "!" CR>>
  
  <ROUTINE MAIN ()
    <HELLO "World">>
]])

-- Example 1a: Count all nodes by type
print("1a. Counting nodes by type:")
local counter = visitor.counter()
for i = 1, #ast do
  counter.walk(ast[i], {})
end

local counts = counter.get_counts()
for node_type, count in pairs(counts) do
  print(string.format("  %s: %d", node_type, count))
end

-- Example 1b: Collect all ROUTINE declarations
print("\n1b. Finding all ROUTINE declarations:")
local routine_collector = visitor.collector(function(node)
  return node.type == "expr" and node.name == "ROUTINE"
end)

for i = 1, #ast do
  routine_collector.walk(ast[i], {})
end

local routines = routine_collector.get_collected()
print(string.format("  Found %d routines:", #routines))
for i, routine in ipairs(routines) do
  if routine[1] and routine[1].value then
    print(string.format("    - %s", routine[1].value))
  end
end

print("\n=== Example 2: Using the Diagnostics System ===\n")

-- Create a diagnostic collection
local diag = diagnostics.new()

-- Add some diagnostics
diag.error(
  diagnostics.Code.UNDEFINED_VARIABLE,
  "Variable 'FOO' is not defined",
  {filename = "example.zil", line = 10, col = 5}
)

diag.warning(
  diagnostics.Code.TYPE_MISMATCH,
  "Possible type mismatch in comparison",
  {filename = "example.zil", line = 15, col = 10}
)

diag.info(
  1000,
  "Consider using a more descriptive variable name",
  {filename = "example.zil", line = 3, col = 8}
)

-- Display diagnostics
print("Diagnostics collected:")
print(diag.format_all())

print("\nSummary: " .. diag.summary())

-- Check if there are errors
if diag.has_errors() then
  print("⚠ Compilation would fail due to errors")
else
  print("✓ No errors, safe to proceed")
end

print("\n=== Example 3: Using the Emitter ===\n")

-- Create a compiler context (minimal for this example)
local mock_compiler = {
  current_source = nil,
  current_lua_filename = "example.lua"
}

local emit = emitter_module.new(mock_compiler)

-- Emit a function
print("3a. Emitting a simple function:")
emit.emit_function("greet", {"name"}, function()
  emit.writeln_indented('print("Hello, " .. name)')
end)

print(emit.get_output())

-- Clear and emit a table
emit.clear()
print("3b. Emitting a table:")
emit.emit_table(function()
  emit.writeln_indented("x = 10,")
  emit.writeln_indented("y = 20,")
  emit.writeln_indented('name = "test"')
end)

print(emit.get_output())

-- Clear and emit an if statement
emit.clear()
print("\n3c. Emitting an if statement:")
emit.emit_if(
  function() emit.write("x > 5") end,
  function() emit.writeln_indented('print("x is large")') end,
  function() emit.writeln_indented('print("x is small")') end
)

print(emit.get_output())

print("\n=== Example 4: Using the Semantic Checker ===\n")

-- Parse a program with some issues
local program = parser.parse([[
  <ROUTINE FOO ()
    <SETG X 10>
    <RETURN X>>
  
  <ROUTINE BAR ()
    <FOO>
    <RETURN Y>>
  
  <GLOBAL X 0>
]])

-- Create checker with diagnostics
local check_diag = diagnostics.new()
local semantic_checker = checker.new(check_diag)

-- Check the AST
print("4a. Performing semantic analysis...")
semantic_checker.check_ast(program)

-- Report any issues found
if check_diag.has_errors() then
  print("\nSemantic errors found:")
  check_diag.report()
else
  print("\n✓ No semantic errors found")
end

-- Display symbol table
print("\n4b. Symbol table:")
local symbols = semantic_checker.get_all_symbols()
for _, symbol in ipairs(symbols) do
  print(string.format("  %s (%s)", symbol.name, symbol.kind))
end

print("\n=== Example 5: Custom Visitor Handler ===\n")

-- Create a visitor that finds all function calls
local call_finder = visitor.new({
  expr = function(node, visitor_obj, context)
    -- Skip special forms that we know are not function calls
    local special_forms = {
      ROUTINE = true, GLOBAL = true, CONSTANT = true,
      SETG = true, SET = true, RETURN = true
    }
    
    if not special_forms[node.name] and node.name ~= "" then
      print(string.format("  Function call: %s", node.name))
    end
    
    -- Continue visiting children
    visitor_obj.visit_children(node, context, 0)
  end
})

print("Finding all function calls:")
for i = 1, #program do
  call_finder.walk(program[i], {})
end

print("\n=== Summary ===\n")
print("The new TypeScript-inspired modules provide:")
print("  ✓ Visitor pattern for flexible AST traversal")
print("  ✓ Diagnostic system for collecting and reporting errors")
print("  ✓ Emitter for structured code generation")
print("  ✓ Semantic checker with symbol table and scope tracking")
print("\nThese modules are optional and backward-compatible!")
