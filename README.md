<img width="1536" height="750" alt="ChatGPT Image Jan 29, 2026 at 11_29_14 AM" src="https://github.com/user-attachments/assets/c47af592-c21f-4b86-9a51-b22432890298" />

A Lua-based runtime for the Zork Implementation Language (ZIL).

## Overview

This project provides a runtime environment for executing ZIL programs, including the classic Zork adventure games.

## Features

- **ZIL to Lua Compilation**: Compiles ZIL source code to Lua for execution
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

The project includes comprehensive testing at multiple levels: unit tests (134+), integration tests, and game walkthroughs.

### Quick Start

```bash
make test              # Run all tests (unit + integration)
make test-unit         # Run unit tests only
make test-integration  # Run integration tests only
```

### Test Categories

- **Unit Tests**: Parser (60 tests), Compiler (44 tests), Runtime (25 tests), Source Mapping (5 tests)
- **Integration Tests**: Zork1 game tests, parser/runtime tests, horror game tests
- **Parser/Runtime Tests**: Directions, containers, light, take, pronouns

For complete test documentation including all available tests, how to write tests, and test assertion commands, see **[tests/TESTS.md](tests/TESTS.md)**.

## Project Structure

- `main.lua` - Main entry point for running the game
- `zil/` - ZIL runtime implementation
  - `bootstrap.lua` - Core runtime functions and globals
  - `parser.lua` - ZIL parser
  - `compiler.lua` - ZIL to Lua compiler
  - `evaluate.lua` - Expression evaluator
- `tests/` - Test framework and test files
  - `run_tests.lua` - Integration test runner
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

## Development

### Architecture

The ZIL runtime is modular and well-tested, with a compiler architecture inspired by TypeScript:

- **Parser** (`zil/parser.lua`): Parses ZIL source code into AST
- **Compiler** (`zil/compiler/`): Compiles ZIL AST to Lua code (12 focused modules)
  - **Core modules**: `init`, `buffer`, `utils`, `value`, `fields`, `forms`, `toplevel`, `print_node`
  - **TypeScript-inspired modules** ✨: `visitor`, `diagnostics`, `emitter`, `checker`
- **Runtime** (`zil/runtime.lua`): Executes compiled Lua code
- **Bootstrap** (`zil/bootstrap.lua`): Core runtime functions and globals
- **Source Mapping** (`zil/sourcemap.lua`): Maps Lua errors back to ZIL source locations

See [zil/compiler/README.md](zil/compiler/README.md) for compiler module documentation.
See [TYPESCRIPT_IMPROVEMENTS.md](TYPESCRIPT_IMPROVEMENTS.md) for details on TypeScript-inspired improvements.
See [TYPESCRIPT_PATTERN_EVIDENCE.md](TYPESCRIPT_PATTERN_EVIDENCE.md) for proof that TypeScript uses the same code patterns.

### Key Features

- **Source Mapping**: Error messages reference ZIL source files, not generated Lua files (see [SOURCE_MAPPING.md](SOURCE_MAPPING.md))
- **Modular Compiler**: Clean separation of concerns across 12 focused modules
- **TypeScript-Inspired Architecture**: Visitor pattern, diagnostic collection, semantic checking, and structured emission
- **Proven Patterns**: Uses same `node[i].property` pattern as TypeScript (see [TYPESCRIPT_PATTERN_EVIDENCE.md](TYPESCRIPT_PATTERN_EVIDENCE.md))
- **Test Infrastructure**: 149+ unit test assertions plus comprehensive integration tests
- **Test Assertions**: Built-in test commands for verifying game state

### Debugging

Generated Lua files (with `zil_` prefix) are created during compilation and excluded from git via `.gitignore`.

## License

See individual game files for their respective licenses.
