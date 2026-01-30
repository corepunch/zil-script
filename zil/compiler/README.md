# ZIL Compiler Module

This directory contains the modularized ZIL to Lua compiler. The compiler has been split into separate files for better organization and maintainability.

## Module Structure

### `init.lua`
Main module entry point. Coordinates all compiler components and provides the public API:
- `Compiler.compile(ast, lua_filename)` - Main compilation function
- `Compiler.iter_children(node, skip)` - AST node iteration helper

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

## Usage

The module can be required as before:

```lua
local compiler = require 'zil.compiler'
local result = compiler.compile(ast, "output.lua")
```

The result is a table with three fields:
- `declarations` - Function and object declarations
- `body` - Main code body
- `combined` - Combined output (declarations + body)

## Design Principles

1. **Separation of Concerns**: Each module handles a specific aspect of compilation
2. **Clear Dependencies**: Modules depend on each other in a clear hierarchy:
   - `init.lua` orchestrates all other modules
   - `buffer.lua` is self-contained with only sourcemap dependency
   - `utils.lua` has no internal dependencies
   - `value.lua` depends on `utils.lua`
   - `fields.lua` depends on `utils.lua`
   - `forms.lua` depends on `utils.lua`
   - `toplevel.lua` depends on `utils.lua` and `fields.lua`
   - `print_node.lua` depends on `utils.lua`
3. **Backward Compatibility**: The module maintains the same public API as the original monolithic compiler
4. **Testability**: Each module can be tested independently
