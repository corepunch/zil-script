# ZIL Compiler

This directory contains the ZIL to Lua compiler. It transforms ZIL source code (the Zork Implementation Language) into executable Lua code.

## How It Works

The compiler takes an Abstract Syntax Tree (AST) from the parser and generates Lua code in three simple steps:

```
┌─────────────┐       ┌──────────────┐       ┌─────────────┐
│  ZIL AST    │  -->  │   Compiler   │  -->  │  Lua Code   │
│  (Input)    │       │  (Transform) │       │  (Output)   │
└─────────────┘       └──────────────┘       └─────────────┘
                             │
                             ├─> Declarations (functions, objects)
                             ├─> Body (main code)
                             └─> Diagnostics (errors, warnings)
```

### Compilation Flow

1. **Input**: AST nodes representing ZIL code (ROUTINE, OBJECT, COND, SET, etc.)
2. **Process**: Walk the AST tree, transforming each node to Lua using specialized handlers
3. **Output**: Lua code split into declarations and body sections, plus any diagnostics


## Core Components

The compiler is built from several focused modules, each with a clear responsibility:

### The Main Pipeline

**`init.lua`** - The Orchestrator
- Entry point: `Compiler.compile(ast, lua_filename, options)`
- Coordinates all compilation steps
- Manages two output buffers: declarations (functions/objects) and body (main code)
- Returns compiled code plus diagnostics

**`print_node.lua`** - The AST Walker
- Recursively traverses the AST tree
- Dispatches to specialized handlers based on node type
- Core function that drives the entire compilation process

**`buffer.lua`** - The Output Manager
- Handles string concatenation efficiently
- Tracks indentation for clean Lua output
- Integrates with source mapping for error messages

### The Transformation Modules

**`value.lua`** - Value Converter
- Converts ZIL values to Lua equivalents
- Handles identifiers, strings, numbers, property references
- Examples:
  - `.VARNAME` → `m_varname` (local variables)
  - `"text"` → `"text"` (strings)
  - `<PROP X>` → `obj.X` (property access)

**`forms.lua`** - Expression Handlers
- Contains handlers for ZIL special forms (COND, SET, PROG, REPEAT, etc.)
- Each handler knows how to emit the right Lua code for its form
- Example: `COND` becomes `if-elseif-else` chain

**`toplevel.lua`** - Top-Level Compilers
- Compiles ROUTINE (functions), OBJECT, and ROOM declarations
- Manages function parameters and local variables
- Wraps routines in error handling (pcall)

**`fields.lua`** - Object Property Writers
- Writes properties for OBJECT and ROOM definitions
- Dispatch table for different field types (FLAGS, DESC, ACTION, etc.)

**`utils.lua`** - Shared Utilities
- Identifier normalization (ZIL names → Lua-safe names)
- Operator mapping
- Common node inspection functions

### Advanced Features (Optional)

**`checker.lua`** - Semantic Analysis
- Symbol table management
- Scope tracking
- Undefined variable detection
- Enable with `enable_semantic_check = true` option

**`diagnostics.lua`** - Error Collection
- Structured error and warning collection
- Source location tracking
- Formatted error reporting

**`visitor.lua`** - AST Visitor Pattern
- Generic tree traversal utilities
- Collect/transform/analyze AST nodes
- Used by checker and other analysis tools

**`emitter.lua`** - Code Generation Helpers
- High-level code emission abstractions
- Automatic indentation
- Used internally for cleaner code generation

## How Modules Work Together

Here's what happens when you compile a ZIL ROUTINE:

```
1. init.lua receives AST node: {type="expr", name="ROUTINE", ...}
2. print_node.lua sees it's a ROUTINE
3. Dispatches to toplevel.compile_routine()
4. toplevel.compile_routine():
   - Parses function parameters using utils.lua
   - Registers local variables
   - Creates function header
   - Calls print_node.lua recursively for function body
5. Inside function body, print_node.lua encounters SET, COND, etc:
   - Dispatches to forms.lua handlers
   - Each handler uses value.lua to convert values
   - Emits Lua code to buffer.lua
6. buffer.lua accumulates all output
7. init.lua returns complete Lua function
```

## Usage

### Basic Usage

```lua
local compiler = require 'zil.compiler'

-- ast is from the parser
local result = compiler.compile(ast, "output.lua")

-- Access the generated code
print(result.declarations)  -- Functions and object declarations
print(result.body)          -- Main execution code
print(result.combined)      -- Both combined
```

### With Semantic Checking

```lua
local result = compiler.compile(ast, "output.lua", {
  enable_semantic_check = true
})

-- Check for errors
if result.diagnostics.has_errors() then
  result.diagnostics.report()  -- Prints errors to stderr
end
```

### Result Structure

```lua
{
  declarations = "function my_routine(...)\n  ...\nend",
  body = "MY_OBJECT { NAME = ..., DESC = ... }",
  combined = declarations .. "\n" .. body,
  diagnostics = {
    errors = {...},
    warnings = {...},
    has_errors = function() ... end,
    report = function() ... end
  }
}
```

## Examples

### Example 1: Simple ROUTINE Compilation

**Input ZIL:**
```zil
<ROUTINE HELLO (NAME)
  <TELL "Hello, " .NAME "!">>
```

**AST (simplified):**
```lua
{type="expr", name="ROUTINE", value={
  {type="ident", name="HELLO"},
  {type="expr", value={{type="ident", name="NAME"}}},
  {type="expr", name="TELL", value={
    {type="string", value="Hello, "},
    {type="ident", name=".NAME"},
    {type="string", value="!"}
  }}
}}
```

**Output Lua:**
```lua
function HELLO(NAME)
  local m_name = NAME
  TELL("Hello, ", m_name, "!")
end
```

### Example 2: Object with Properties

**Input ZIL:**
```zil
<OBJECT LAMP
  (IN ROOM)
  (DESC "lamp")
  (FLAGS LIGHT)>
```

**Output Lua:**
```lua
LAMP = {
  IN = ROOM,
  DESC = "lamp",
  FLAGS = {LIGHT}
}
```

### Example 3: COND Expression

**Input ZIL:**
```zil
<COND (<FSET? OBJ LIGHT> <TELL "It's glowing">)
      (<FSET? OBJ DARK> <TELL "It's dark">)
      (ELSE <TELL "It's normal">)>
```

**Output Lua:**
```lua
if FSET_P(OBJ, LIGHT) then
  TELL("It's glowing")
elseif FSET_P(OBJ, DARK) then
  TELL("It's dark")
else
  TELL("It's normal")
end
```

## Module API Reference

### init.lua

```lua
Compiler.compile(ast, lua_filename, options)
```
- **ast**: AST from parser (required)
- **lua_filename**: Output filename for source maps (optional)
- **options**: Configuration table (optional)
  - `enable_semantic_check`: Enable semantic analysis (default: false)
- **Returns**: {declarations, body, combined, diagnostics}

### buffer.lua

```lua
Buffer.new(compiler)         -- Create new buffer
buffer:write(str)            -- Write string
buffer:writeln(str)          -- Write string + newline
buffer:indent()              -- Increase indentation
buffer:dedent()              -- Decrease indentation
buffer:get()                 -- Get accumulated output
```

### utils.lua

```lua
normalize_identifier(str)    -- "MY-VAR" -> "MY_VAR"
normalize_function_name(str) -- "FSET?" -> "FSET_P"
digits_to_letters(str)       -- "9LIVES" -> "jLIVES"
is_cond(node)               -- Check if COND expression
need_return(node)           -- Check if needs return
```

### value.lua

```lua
value(node, compiler)        -- Convert ZIL value to Lua
local_var_name(node, comp)   -- Get local variable name
register_local_var(arg, c)   -- Register local variable
```

### Advanced Modules

**visitor.lua** - AST traversal
```lua
Visitor.new(handlers, default)
visitor:walk(node, context)
Visitor.collector(predicate)
```

**diagnostics.lua** - Error reporting
```lua
Diagnostics.new()
diag:error(code, msg, loc, node)
diag:warning(code, msg, loc, node)
diag:has_errors()
diag:report()
```

**checker.lua** - Semantic analysis
```lua
Checker.new(diagnostics)
checker:check_ast(ast)
checker:enter_scope(kind)
checker:exit_scope()
```

## Design Principles

The compiler follows these key principles:

1. **Modularity**: Each file has one clear responsibility
2. **Separation of Concerns**: Parsing, checking, and code generation are separate
3. **Extensibility**: Easy to add new ZIL forms or features
4. **Error Recovery**: Collect multiple errors before failing
5. **Source Mapping**: Maintain connection to original ZIL source for debugging

## Module Dependencies

```
init.lua (orchestrator)
  ├── buffer.lua (output)
  ├── print_node.lua (AST walker)
  │   ├── forms.lua (expression handlers)
  │   ├── toplevel.lua (top-level compilers)
  │   │   └── fields.lua (object properties)
  │   └── value.lua (value conversion)
  │       └── utils.lua (utilities)
  ├── checker.lua (optional semantic analysis)
  │   ├── diagnostics.lua
  │   └── visitor.lua
  └── diagnostics.lua (error collection)
```

## Contributing

When adding new ZIL forms:

1. Add handler to `forms.lua` for expressions
2. Add compiler to `toplevel.lua` for top-level forms
3. Update `value.lua` if new value types are needed
4. Add tests in `tests/compiler/`

The modular design makes it easy to extend without touching unrelated code.
