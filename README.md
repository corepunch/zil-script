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

The project includes a test framework for automated testing of ZIL programs.

### Running Tests

To run the default test suite:

```bash
lua tests/run_tests.lua
```

To run a specific test file:

```bash
lua tests/run_tests.lua tests/zork1_extended.lua
```

### Available Test Files

- `tests/zork1_basic.lua` - Basic game interaction tests
- `tests/zork1_extended.lua` - Extended command sequence tests

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
  - `run_tests.lua` - Test runner
  - `zork1_basic.lua` - Basic tests
  - `zork1_extended.lua` - Extended tests
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

### Adding New Tests

1. Create a new test file in `tests/` (e.g., `tests/my_test.lua`)
2. Define test commands following the format in existing test files
3. Run the test with `lua tests/run_tests.lua tests/my_test.lua`

### Debugging

The generated Lua files (with `zil_` prefix) are created during compilation but are excluded from git via `.gitignore`.

## License

See individual game files for their respective licenses.
