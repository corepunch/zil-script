# ZIL Compiler Module

This directory contains the modularized ZIL to Lua compiler. The compiler architecture is inspired by the TypeScript compiler, featuring clean separation of concerns, visitor pattern for AST traversal, diagnostic collection, and modular code generation.

## Architecture Overview

The compiler follows a multi-phase architecture similar to TypeScript:

```
Source Code → Parser → AST → Checker → Emitter → Lua Code
                              ↓
                        Diagnostics
```

## Core Modules

### `init.lua`
Main module entry point. Coordinates all compiler components and provides the public API:
- `Compiler.compile(ast, lua_filename, options)` - Main compilation function
  - `ast` - Abstract syntax tree from parser
  - `lua_filename` - Optional output filename for source mapping
  - `options` - Optional table with:
    - `enable_semantic_check` - Boolean, enables semantic analysis (default: false)
  - Returns table with:
    - `declarations` - Function and object declarations
    - `body` - Main code body
    - `combined` - Combined output
    - `diagnostics` - Diagnostic collection with any errors/warnings
- `Compiler.iter_children(node, skip)` - AST node iteration helper

**Integration with TypeScript-inspired modules:**
The compiler now internally uses:
- `diagnostics.lua` for structured error collection
- `checker.lua` for optional semantic analysis (when `enable_semantic_check = true`)
- Maintains backward compatibility - existing code works without changes

### `buffer.lua`
Output buffer management for efficient string concatenation with source mapping support:
- `Buffer.new(compiler)` - Create a new output buffer with line tracking
- Provides `write()`, `writeln()`, `indent()`, `get()` methods

### `utils.lua`
Utility functions used throughout the compiler:
- `safeget(node, attr)` - Safe node attribute access
- `normalize_identifier(str)` - Convert ZIL identifiers to Lua-safe names
- `digits_to_letters(str)` - Convert leading digits to letters (0-9 -> a-j)
- `normalize_function_name(name)` - Convert ZIL function names to Lua
- `is_cond(n)` - Check if node is a COND expression
- `need_return(node)` - Check if node needs return wrapper
- `get_source_line(node)` - Extract source line from AST node

### `value.lua`
Value conversion functions for translating ZIL values to Lua:
- `value(node, compiler)` - Convert ZIL values to Lua representations
- `local_var_name(node, compiler)` - Convert identifiers to local variable names
- `register_local_var(arg, compiler)` - Register a variable as local

### `fields.lua`
Field writing functions for ZIL objects (ROOM, OBJECT):
- `write_field(buf, node, field_name, compiler)` - Write object field
- `write_nav(buf, node, compiler)` - Write navigation direction
- `FIELD_WRITERS` - Dispatch table for different field types

### `forms.lua`
Expression form handlers for ZIL special forms:
- `create_handlers(compiler, print_node)` - Create form handler table
- Handlers for: COND, SET, SETG, RETURN, RTRUE, RFALSE, PROG, REPEAT, AGAIN, BUZZ, SYNONYM, GLOBAL, CONSTANT, SYNTAX, LTABLE, TABLE, ITABLE, AND, OR, etc.

### `toplevel.lua`
Top-level compilation functions:
- `compile_routine(decl, body, node, compiler, print_node)` - Compile ROUTINE forms
- `compile_object(decl, body, node, compiler)` - Compile OBJECT/ROOM forms
- `write_function_header(buf, node, compiler, print_node)` - Generate function headers with parameters
- `print_syntax_object(buf, nodes, start_idx, field_name, compiler)` - Handle SYNTAX objects
- `TOP_LEVEL_COMPILERS` - Registry of top-level form compilers
- `DIRECT_STATEMENTS` - Set of forms that print directly to output

### `print_node.lua`
AST node printing logic:
- `create_print_node(compiler, form_handlers)` - Create the main print_node function that traverses AST and generates Lua code

## Advanced Modules (TypeScript-Inspired)

### `visitor.lua`
AST visitor pattern implementation (inspired by TypeScript's `forEachChild`):
- `Visitor.new(handlers, default_handler)` - Create a visitor with custom node handlers
- `visitor.visit_node(node, context)` - Visit a single AST node
- `visitor.visit_children(node, context, skip)` - Visit all children of a node
- `visitor.for_each_child(node, fn, context)` - Iterate over children with callback
- `visitor.transform(node, context)` - Transform AST by visiting and modifying nodes
- `visitor.walk(node, context)` - Depth-first tree traversal
- `Visitor.collector(predicate)` - Create a visitor that collects matching nodes
- `Visitor.counter()` - Create a visitor that counts nodes by type

**Example Usage:**
```lua
local visitor = require 'zil.compiler.visitor'

-- Collect all ROUTINE nodes
local collector = visitor.collector(function(node)
  return node.type == "expr" and node.name == "ROUTINE"
end)
collector.walk(ast, {})
local routines = collector.get_collected()
```

### `diagnostics.lua`
Structured error collection and reporting (inspired by TypeScript's diagnostic system):
- `Diagnostics.new()` - Create a diagnostic collection
- `collection.error(code, message, location, node)` - Add an error diagnostic
- `collection.warning(code, message, location, node)` - Add a warning diagnostic
- `collection.has_errors()` - Check if any errors were reported
- `collection.format_all()` - Format all diagnostics for display
- `collection.report()` - Report diagnostics to stderr
- Diagnostic categories: ERROR, WARNING, INFO, MESSAGE
- Diagnostic codes for different error types (UNKNOWN_FORM, UNDEFINED_VARIABLE, etc.)

**Example Usage:**
```lua
local diagnostics = require 'zil.compiler.diagnostics'

local diag = diagnostics.new()
diag.error(diagnostics.Code.UNDEFINED_VARIABLE, 
           "Variable 'foo' is not defined",
           {filename = "test.zil", line = 42, col = 10})

if diag.has_errors() then
  diag.report()  -- Prints: test.zil:42:10 ERROR [ZIL1004]: Variable 'foo' is not defined
end
```

### `emitter.lua`
Code generation abstraction (inspired by TypeScript's emitter):
- `Emitter.new(compiler)` - Create a code emitter
- `emitter.emit_function(name, params, body_fn)` - Emit a function definition
- `emitter.emit_block(fn)` - Emit a block with automatic indentation
- `emitter.emit_table(entries_fn)` - Emit a table constructor
- `emitter.emit_if(condition, then_fn, else_fn)` - Emit conditional statement
- Automatic indentation management
- Source location tracking for source maps

**Example Usage:**
```lua
local emitter_module = require 'zil.compiler.emitter'

local emitter = emitter_module.new(compiler)
emitter.emit_function("my_function", {"param1", "param2"}, function()
  emitter.writeln_indented("print(param1)")
  emitter.writeln_indented("return param2")
end)
local code = emitter.get_output()
```

### `checker.lua`
Semantic analysis and symbol table management (inspired by TypeScript's binder/checker):
- `Checker.new(diagnostics)` - Create a semantic checker with optional diagnostic collection
- `checker.declare_symbol(name, kind, declaration)` - Declare a new symbol
- `checker.lookup_symbol(name)` - Look up a symbol by name
- `checker.enter_scope(kind)` - Enter a new lexical scope
- `checker.exit_scope()` - Exit current scope
- `checker.check_defined(name, node)` - Verify a symbol is defined
- `checker.check_ast(ast)` - Perform semantic analysis on entire AST
- Symbol kinds: ROUTINE, GLOBAL, CONSTANT, LOCAL, PARAMETER, OBJECT, ROOM
- Automatic scope tracking and symbol resolution

**Example Usage:**
```lua
local checker_module = require 'zil.compiler.checker'
local diagnostics = require 'zil.compiler.diagnostics'

local diag = diagnostics.new()
local checker = checker_module.new(diag)

-- Check AST for semantic errors
checker.check_ast(ast)

if diag.has_errors() then
  diag.report()
end
```

## Usage

### Basic Usage (Backward Compatible)

The module can be required as before:

```lua
local compiler = require 'zil.compiler'
local result = compiler.compile(ast, "output.lua")
```

The result is a table with four fields:
- `declarations` - Function and object declarations
- `body` - Main code body
- `combined` - Combined output (declarations + body)
- `diagnostics` - Diagnostic collection with errors/warnings (NEW)

### Advanced Usage with TypeScript-Inspired Features

Enable semantic checking:

```lua
local compiler = require 'zil.compiler'
local result = compiler.compile(ast, "output.lua", {
  enable_semantic_check = true  -- Enables semantic analysis
})

-- Check for semantic errors
if result.diagnostics.has_errors() then
  print("Compilation errors found:")
  result.diagnostics.report()
end

-- Access diagnostics directly
local diag = result.diagnostics
print(diag.summary())  -- "2 errors, 1 warning"
```

### Migration Path

**Old code (still works):**
```lua
local result = compiler.compile(ast)
-- Uses: result.declarations, result.body, result.combined
```

**New code (with diagnostics):**
```lua
local result = compiler.compile(ast, "output.lua")
-- Uses: result.diagnostics for error handling
```

**Advanced (with semantic checking):**
```lua
local result = compiler.compile(ast, "output.lua", {enable_semantic_check = true})
-- Uses: result.diagnostics for semantic errors
```

## Design Principles

Inspired by the TypeScript compiler architecture, the ZIL compiler follows these principles:

1. **Separation of Concerns**: Each module handles a specific aspect of compilation
   - Parser generates AST
   - Visitor traverses AST
   - Checker performs semantic analysis
   - Emitter generates code
   - Diagnostics collect and report errors

2. **Clear Dependencies**: Modules depend on each other in a clear hierarchy:
   - `init.lua` orchestrates all other modules
   - `buffer.lua` is self-contained with only sourcemap dependency
   - `utils.lua` has no internal dependencies
   - `value.lua` depends on `utils.lua`
   - `fields.lua` depends on `utils.lua`
   - `forms.lua` depends on `utils.lua`
   - `toplevel.lua` depends on `utils.lua` and `fields.lua`
   - `print_node.lua` depends on `utils.lua`
   - `visitor.lua` is self-contained (no internal dependencies)
   - `diagnostics.lua` is self-contained (no internal dependencies)
   - `emitter.lua` depends on `buffer.lua`
   - `checker.lua` depends on `diagnostics.lua` and `visitor.lua`

3. **Visitor Pattern**: Clean AST traversal using the visitor pattern
   - Separates tree traversal from node processing
   - Extensible through custom handlers
   - Supports transformation and collection operations

4. **Diagnostic Collection**: Errors don't halt compilation immediately
   - Multiple errors can be collected and reported together
   - Structured error messages with codes and source locations
   - Categorized by severity (ERROR, WARNING, INFO)

5. **Lazy Evaluation**: Following TypeScript's approach
   - Checker only resolves what's needed
   - Emitter generates code on-demand
   - Efficient for large codebases

6. **Backward Compatibility**: The module maintains the same public API as the original monolithic compiler

7. **Testability**: Each module can be tested independently

## Comparison with TypeScript Compiler

| Feature | TypeScript | ZIL Compiler |
|---------|-----------|--------------|
| **Scanner** | `scanner.ts` | Built into `parser.lua` |
| **Parser** | `parser.ts` | `parser.lua` |
| **AST Nodes** | `Node` hierarchy | Table-based with type field |
| **Binder** | `binder.ts` | `checker.lua` (symbol table) |
| **Checker** | `checker.ts` | `checker.lua` (semantic analysis) |
| **Emitter** | `emitter.ts` | `emitter.lua` + `print_node.lua` |
| **Diagnostics** | Built-in system | `diagnostics.lua` |
| **Visitor Pattern** | `forEachChild` | `visitor.lua` |
| **Source Maps** | Full support | `sourcemap.lua` + `buffer.lua` |
| **Symbol Table** | Global + scoped | `checker.lua` scopes |

## Migration Path

The new modules are optional and don't break existing code:

1. **Current code** continues to work with `init.lua` API
2. **New projects** can use visitor, diagnostics, emitter, and checker modules
3. **Gradual migration** possible by adopting modules one at a time

## Future Enhancements

Potential improvements inspired by TypeScript:

1. **Transformer Pipeline**: Add AST transformation passes before emission
2. **Module System**: Better support for ZIL includes and dependencies
3. **Incremental Compilation**: Cache compilation results for faster rebuilds
4. **Language Server Protocol**: Enable IDE integration
5. **Control Flow Analysis**: Track variable initialization and usage
6. **Type Inference**: Optional type checking for ZIL code
