<img width="1536" height="472" alt="63a454c1-f42a-4a1b-889c-1933c12541af" src="https://github.com/user-attachments/assets/b9441696-75e3-4312-80e4-a417d77f8ec1" />


A Lua-based compiler and runtime for the Zork Implementation Language (ZIL).

## Overview

This project provides a runtime environment for executing ZIL programs, including the classic Zork adventure games.

## Features

- **ZIL to Lua Compilation**: Compiles ZIL source code to Lua for execution
- **Require System**: Load .zil files using Lua's `require()` function, just like moonscript
- **Source Mapping**: Error messages automatically reference ZIL source files instead of generated Lua files (see [SOURCE_MAPPING.md](SOURCE_MAPPING.md))
- **Interactive Gameplay**: Full support for classic text adventure games
- **Comprehensive Testing**: Unit and integration tests for all components

## Requirements

- Lua 5.4 or compatible version

## Running the Game

To run the game in interactive mode:

```bash
lua main.lua
```

This will compile the ZIL files specified in `main.lua` and start the interactive game.

## Testing

The project includes comprehensive testing at multiple levels: unit tests (134+), integration tests, game walkthroughs, and **pure ZIL tests**.

### Quick Start

```bash
make test              # Run all tests (unit + integration)
make test-unit         # Run unit tests only
make test-integration  # Run integration tests only
make test-pure-zil     # Run pure ZIL tests (new!)
```

### Test Categories

- **Unit Tests**: Parser (60 tests), Compiler (44 tests), Runtime (25 tests), Source Mapping (5 tests)
- **Integration Tests**: Zork1 game tests, parser/runtime tests, horror game tests
- **Parser/Runtime Tests**: Directions, containers, light, take, pronouns
- **Pure ZIL Tests**: Self-contained tests written entirely in ZIL using ASSERT function

### Writing Pure ZIL Tests (New!)

You can now write tests entirely in ZIL without Lua wrappers:

```zil
<ROUTINE TEST-MY-FEATURE ()
    <TELL "Testing..." CR>
    <ASSERT T "This passes">
    <ASSERT <==? 5 5> "Numbers match">
    <ASSERT <FSET? ,APPLE ,TAKEBIT> "Apple is takeable">
    <TELL "All tests completed!" CR>>

<ROUTINE GO () <TEST-MY-FEATURE>>
```

Run with the generic test runner:
```bash
lua5.4 run-zil-test.lua tests.my-test
```

**Features:**
- ASSERT checks condition and prints [PASS] or [FAIL]
- Combine with ZIL operators: `==?`, `FSET?`, `LOC`, etc.
- Simple, minimal setup
- Only ZIL test files needed - one generic Lua runner for all tests

For integration test documentation, see **[tests/TESTS.md](tests/TESTS.md)**.

## Project Structure

- `main.lua` - Main entry point for running the game
- `zilscript/` - ZIL runtime implementation
  - `init.lua` - Main module for require system (loads when you `require "zilscript"`)
  - `base.lua` - Core loader functionality for .zil files
  - `bootstrap.lua` - Core runtime functions and globals (includes ASSERT function)
  - `parser.lua` - ZIL parser
  - `compiler.lua` - ZIL to Lua compiler
  - `evaluate.lua` - Expression evaluator
  - `runtime.lua` - Runtime loader utilities
  - `sourcemap.lua` - Source mapping for error messages
- `tests/` - Test framework and test files
  - `run_tests.lua` - Integration test runner
  - Pure ZIL test examples (test-simple-new.zil, test-insert-file.zil, etc.)
  - `zork1_basic.lua` - Basic integration tests
  - `zork1_walkthrough.lua` - Extended integration tests
  - `unit/` - Unit tests directory
    - `test_framework.lua` - Unit testing framework
    - `test_parser.lua` - Parser unit tests
    - `test_compiler.lua` - Compiler unit tests
    - `test_runtime.lua` - Runtime unit tests
    - `run_all.lua` - Unit test runner
- `zork1/` - Zork 1 game files (git submodule)
- `adventure/` - Additional adventure files

## Configuring ZIL Files

The list of ZIL files to compile is specified in `main.lua`:

```lua
local files = {
  "zork1/globals.zil",
  "zork1/parser.zil",
  "zork1/verbs.zil",
  "zork1/syntax.zil",
  "adventure/horror.zil",
  "zork1/main.zil",
}
```

You can modify this list to load different ZIL files or create your own adventure.

## Using the Require System

The ZIL runtime now supports a require-based loading system similar to [moonscript](https://github.com/leafo/moonscript), allowing you to load .zil files using Lua's standard `require()` function.

### Basic Usage

```lua
-- Initialize the ZIL loader
require "zil"

-- Now you can require .zil files just like Lua modules
-- This will automatically compile and load zork1/actions.zil
local actions = require "zork1.actions"
```

### How It Works

When you `require "zil"`:
1. The ZIL loader is automatically installed into Lua's package system
2. A `package.zilpath` is created (similar to `package.path`) that tells Lua where to find .zil files
3. When you `require` a module, Lua will search for both .lua and .zil files
4. If a .zil file is found, it's automatically compiled to Lua and executed
5. The compiled module is cached by Lua's require system (no recompilation on subsequent requires)

### Example

```lua
require "zil"  -- Initialize the loader

-- Load ZIL modules
local test = require "tests.test-require"  -- Loads tests/test-require.zil

-- The compiled code is cached
local test2 = require "tests.test-require"  -- Reuses cached version
```

For a complete example, see [examples/require_example.lua](examples/require_example.lua).

### Advanced Usage

The `zil` module also provides utility functions:

```lua
local zil = require "zil"

-- Compile ZIL code to Lua
local lua_code = zil.to_lua('<ROUTINE FOO () <RETURN 1>>')

-- Load ZIL code from a string
local chunk = zil.loadstring('<ROUTINE BAR () <TELL "Hello">>')

-- Load and execute a ZIL file
zil.dofile("myfile.zil")

-- Manage the loader
zil.remove_loader()  -- Remove the ZIL loader
zil.insert_loader()  -- Re-insert the ZIL loader
```

### Debugging: Saving Compiled Lua Files

By default, .zil files are compiled to Lua in memory only. For debugging purposes, you can enable saving of the compiled .lua files:

```lua
local zil = require "zil"

-- Enable saving compiled .lua files for modules
zil.config.save_lua = true

-- Now when you require a .zil module, it will save the compiled .lua file
require "mymodule"  -- Creates mymodule.zil.lua

-- Disable to stop saving files
zil.config.save_lua = false
```

When enabled, each .zil module loaded via `require()` will save its compiled Lua code to a `.zil.lua` file in the same directory. This is useful for:
- Debugging compilation issues
- Understanding how ZIL code translates to Lua
- Examining generated code for performance analysis

**Note:** The generated `.zil.lua` files are automatically excluded from git via `.gitignore`.

## Development

### Architecture

The ZIL runtime is modular and well-tested, with a compiler architecture inspired by TypeScript:

- **Parser** (`zilscript/parser.lua`): Parses ZIL source code into AST
- **Compiler** (`zilscript/compiler/`): Compiles ZIL AST to Lua code (12 focused modules)
  - **Core modules**: `init`, `buffer`, `utils`, `value`, `fields`, `forms`, `toplevel`, `print_node`
  - **TypeScript-inspired modules** ✨: `visitor`, `diagnostics`, `emitter`, `checker`
- **Runtime** (`zilscript/runtime.lua`): Executes compiled Lua code
- **Bootstrap** (`zilscript/bootstrap.lua`): Core runtime functions and globals
- **Source Mapping** (`zilscript/sourcemap.lua`): Maps Lua errors back to ZIL source locations

See [zilscript/compiler/README.md](zilscript/compiler/README.md) for detailed compiler module documentation.

### Key Features

- **Source Mapping**: Error messages reference ZIL source files, not generated Lua files (see [SOURCE_MAPPING.md](SOURCE_MAPPING.md))
- **Modular Compiler**: Clean separation of concerns across 12 focused modules
- **TypeScript-Inspired Architecture**: Visitor pattern, diagnostic collection, semantic checking, and structured emission
- **Test Infrastructure**: 149+ unit test assertions plus comprehensive integration tests
- **Test Assertions**: Built-in test commands for verifying game state

### Debugging

Generated Lua files (with `zil_` prefix) are created during compilation and excluded from git via `.gitignore`.

## License

See individual game files for their respective licenses.
