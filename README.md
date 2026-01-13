# ZIL Runtime

A Lua-based runtime for the Zork Implementation Language (ZIL).

## Overview

This project provides a runtime environment for executing ZIL programs, including the classic Zork adventure games.

## Requirements

- Lua 5.4 or compatible version

## Running the Game

To run the game in interactive mode:

```bash
lua main.lua
```

This will compile the ZIL files specified in `main.lua` and start the interactive game.

## Testing

The project includes both unit tests for individual components and integration tests for the full game runtime.

### Running Unit Tests

To run all unit tests:

```bash
lua tests/unit/run_all.lua
```

To run tests for a specific component:

```bash
lua tests/unit/test_parser.lua    # Parser tests
lua tests/unit/test_compiler.lua  # Compiler tests
lua tests/unit/test_runtime.lua   # Runtime tests
```

### Running Integration Tests

To run the default integration test suite:

```bash
lua tests/run_tests.lua
```

To run a specific integration test file:

```bash
lua tests/run_tests.lua tests/zork1_extended.lua
```

### Available Test Files

**Unit Tests** (in `tests/unit/`):
- `test_parser.lua` - Parser module tests
- `test_compiler.lua` - Compiler module tests
- `test_runtime.lua` - Runtime module tests

**Integration Tests** (in `tests/`):
- `zork1_basic.lua` - Basic game interaction tests
- `zork1_extended.lua` - Extended command sequence tests

#### Parser/Runtime Tests (Inspired by ZILF)

- `tests/test-directions.lua` - Direction and movement parsing
- `tests/test-take.lua` - TAKE command functionality  
- `tests/test-containers.lua` - Container interactions
- `tests/test-light.lua` - Light source mechanics
- `tests/test-pronouns.lua` - Basic object interactions

#### Parser/Runtime Tests (Inspired by ZILF)

- `tests/test-directions.lua` - Direction and movement parsing
- `tests/test-take.lua` - TAKE command functionality  
- `tests/test-containers.lua` - Container interactions
- `tests/test-light.lua` - Light source mechanics
- `tests/test-pronouns.lua` - Basic object interactions

See `tests/README.md` for detailed information on writing and running tests.

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
  - `zork1_extended.lua` - Extended integration tests
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

### Code Quality

The ZIL runtime codebase is structured for testability and maintainability:

- **Modular Design**: Parser, compiler, and runtime are separate modules with clear interfaces
- **Unit Testing**: 120+ unit tests cover core functionality
- **Integration Testing**: Full end-to-end tests validate game execution
- **Error Handling**: Proper error reporting for parsing, compilation, and runtime errors

### Adding New Tests

1. Create a new test file in `tests/` (e.g., `tests/my_test.lua`)
2. Define test commands following the format in existing test files
3. Run the test with `lua tests/run_tests.lua tests/my_test.lua`

### Debugging

The generated Lua files (with `zil_` prefix) are created during compilation but are excluded from git via `.gitignore`.

## License

See individual game files for their respective licenses.
