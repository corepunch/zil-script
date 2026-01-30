# ZIL Runtime Test Suite

This document describes all tests available in the ZIL runtime project.

## Overview

The ZIL runtime includes comprehensive testing at multiple levels:
- **Unit Tests**: Test individual components in isolation (parser, compiler, runtime)
- **Integration Tests**: Test the full ZIL runtime with real game code
- **Parser/Runtime Tests**: Test specific ZIL language features
- **Game Tests**: Test complete game walkthroughs

## Running All Tests

```bash
make test              # Run all tests (unit + integration)
make test-unit         # Run unit tests only
make test-integration  # Run integration tests only
```

For a complete list of test targets:
```bash
make help
```

## Unit Tests

Unit tests are located in `tests/unit/` and test individual components in isolation.

### Running Unit Tests

```bash
make test-unit                    # Run all unit tests
lua tests/unit/run_all.lua        # Direct execution
lua tests/unit/test_parser.lua    # Run specific test file
```

### Unit Test Files

| File | Component | Tests | Description |
|------|-----------|-------|-------------|
| `test_parser.lua` | Parser | 60 tests | ZIL syntax parsing, expressions, special forms |
| `test_compiler.lua` | Compiler | 44 tests | ZIL to Lua compilation, routines, objects, control flow |
| `test_runtime.lua` | Runtime | 25 tests | Environment creation, code execution, error handling |
| `test_sourcemap.lua` | Source Mapping | 5 tests | Source map storage, traceback translation |
| `test_framework.lua` | - | - | Unit testing framework (assertions, test organization) |

**Total Unit Tests**: 134+ tests

## Integration Tests

Integration tests compile and run full ZIL programs to validate end-to-end functionality.

### Zork1 Integration Tests

Test the ZIL runtime using the Zork1 game.

```bash
make test-zork1                           # Run all Zork1 tests
lua tests/run_tests.lua tests/zork1_basic.lua
lua tests/run_tests.lua tests/zork1_walkthrough.lua
```

| File | Description |
|------|-------------|
| `zork1_basic.lua` | Basic game interactions (movement, inventory, examine) |
| `zork1_walkthrough.lua` | Extended command sequences and game mechanics |

### Parser/Runtime Tests

Tests inspired by ZILF that validate core ZIL language features using minimal test worlds.

```bash
make test-parser       # Run all parser/runtime tests
make test-directions   # Run specific test
```

Each test consists of a `.zil` file (minimal test world) and a `.lua` file (test commands).

| Test File | ZIL File | Tests |
|-----------|----------|-------|
| `test-directions.lua` | `test-directions.zil` | Direction parsing and movement |
| `test-take.lua` | `test-take.zil` | TAKE command with various objects |
| `test-containers.lua` | `test-containers.zil` | Container interactions (open/close, put/take) |
| `test-light.lua` | `test-light.zil` | Light sources and darkness mechanics |
| `test-pronouns.lua` | `test-pronouns.zil` | Pronoun resolution and object interactions |
| `test-clock.lua` | `test-clock.zil` | Clock mechanics |

### Horror Game Tests

Tests for the horror.zil adventure game.

```bash
make test-horror-all        # Run all horror tests
make test-horror-helpers    # Test helper functions
make test-horror-partial    # Test accessible portions
make test-horror-failures   # Test failure conditions
make test-horror            # Complete walkthrough
```

| File | Description |
|------|-------------|
| `horror-test-helpers.lua` | Verify test helper functions work |
| `horror-partial.lua` | Test accessible portions (lit rooms) |
| `horror-failures.lua` | Test that prerequisites are required |
| `horror-walkthrough.lua` | Complete game walkthrough |

### Source Mapping Tests

Tests for ZIL source location mapping in error messages.

```bash
lua tests/test_sourcemap_integration.lua
lua tests/test_line_accuracy.lua
lua tests/test_comprehensive_accuracy.lua
```

| File | Description |
|------|-------------|
| `test_sourcemap_integration.lua` | Full compilation and error translation pipeline |
| `test_line_accuracy.lua` | Simple line number accuracy test |
| `test_comprehensive_accuracy.lua` | Detailed line mapping with multiple routines |
| `verify_fix.lua` | Verify off-by-one fix for source mapping |

### Test Assertion Tests

Tests for the test assertion framework itself.

```bash
lua tests/run_tests.lua tests/test-assertions.lua
lua tests/run_tests.lua tests/test-check-commands.lua
```

| File | Description |
|------|-------------|
| `test-assertions.lua` | Test assertion commands (assert-inventory, assert-flag, etc.) |
| `test-check-commands.lua` | Test check commands (check-inventory, check-flag, etc.) |

### Demonstration Files

Demonstration files for features (not run in test suite).

| File | Description |
|------|-------------|
| `demo_sourcemap.lua` | Before/after comparison of source mapping |
| `demo_realistic.lua` | Real-world source mapping scenario |

## Test Assertion Commands

Test files can use special assertion commands to verify game state. These are handled by `zil/bootstrap.lua`.

### Assertion Commands (Return pass/fail)

| Command | Usage | Description |
|---------|-------|-------------|
| `test:assert-inventory` | `test:assert-inventory OBJECT true/false` | Assert object in/not in inventory |
| `test:assert-flag` | `test:assert-flag OBJECT FLAG true/false` | Assert flag is/isn't set |
| `test:assert-location` | `test:assert-location OBJECT LOCATION` | Assert object at location |

### Check Commands (Return ok/error)

| Command | Usage | Description |
|---------|-------|-------------|
| `test:get-location` | `test:get-location` | Get current room name |
| `test:check-inventory` | `test:check-inventory OBJECT` | Check if object in inventory |
| `test:check-flag` | `test:check-flag OBJECT FLAG` | Check if flag is set |
| `test:check-location` | `test:check-location OBJECT LOCATION` | Check if object at location |

### Common Flags

- `OPENBIT` - Container/door is open
- `ONBIT` - Light source is lit / Room is naturally lit
- `TAKEBIT` - Object can be taken
- `LIGHTBIT` - Object is a light source
- `CONTBIT` - Object is a container

## Writing Tests

### Creating Unit Tests

1. Create test file in `tests/unit/` (e.g., `test_mycomponent.lua`)
2. Use the test framework from `test_framework.lua`
3. Structure tests with `test.describe()` and `t.it()`
4. Add to `tests/unit/run_all.lua`

Example:
```lua
local test = require 'tests.unit.test_framework'
local mymodule = require 'mymodule'

test.describe("My Component", function(t)
    t.it("should do something", function(assert)
        local result = mymodule.do_something()
        assert.assert_equal(result, expected)
    end)
end)

local success = test.summary()
os.exit(success and 0 or 1)
```

### Creating Integration Tests

1. Create test file in `tests/` (e.g., `tests/my_test.lua`)
2. Define test structure with `files` and `commands`
3. Use assertion commands to verify state
4. Run with `lua tests/run_tests.lua tests/my_test.lua`

Example:
```lua
return {
    name = "My Test",
    files = {
        "zork1/globals.zil",
        "tests/my-test.zil",
        "zork1/parser.zil",
        "zork1/verbs.zil",
        "zork1/syntax.zil",
        "zork1/main.zil",
    },
    commands = {
        {
            input = "north",
            description = "Move north"
        },
        {
            here = "HALLWAY",
            description = "Verify at hallway"
        },
        {
            take = "KEY",
            description = "Verify key in inventory"
        },
    }
}
```

### Creating Parser/Runtime Tests

1. Create a `.zil` file with minimal test world:
   - Define test rooms with `FLAGS RLANDBIT ONBIT`
   - Define test objects with appropriate flags
   - Implement `GO()` routine
   - Include necessary globals

2. Create a `.lua` test file:
   - Load required ZIL files
   - Define command sequences
   - Use assertions to verify behavior

3. Run with `lua tests/run_tests.lua tests/test-myfeature.lua`

## Test Coverage

### Unit Test Coverage
- ✅ Parser: Comprehensive syntax coverage (60 tests)
- ✅ Compiler: Routines, objects, control flow (44 tests)
- ✅ Runtime: Execution, loading, errors (25 tests)
- ✅ Source Mapping: Mapping and translation (5 tests)

### Integration Test Coverage
- ✅ Zork1: Basic commands and extended sequences
- ✅ Parser Features: Directions, containers, light, take, pronouns, clock
- ✅ Horror Game: Walkthroughs and failure conditions
- ✅ Source Mapping: End-to-end error translation
- ✅ Test Assertions: Test framework commands

### Additional Tests Not in CI
- Horror game tests (optional, may be too long for CI)
- Source mapping accuracy tests (optional, development-focused)

## CI/CD Integration

Tests are automatically run on pull requests and pushes to main/master branches via GitHub Actions (`.github/workflows/test.yml`).

**Tests included in CI:**
- **Unit tests**: Parser, Compiler, Runtime, Source Mapping (134+ tests)
- **Zork1 integration tests**: Basic and walkthrough tests
- **Parser/runtime tests**: Directions, take, containers, light, pronouns, clock
- **Test assertion tests**: Test framework command verification

## Test Results Interpretation

Unit tests show pass/fail counts:
```
✓ 60/60 parser tests passed
✓ 44/44 compiler tests passed
```

Integration tests show command execution:
```
[SKIP] Move north - normal command execution
[TEST] pass: assertion succeeded
[TEST] fail: assertion failed (shows details)
[TEST] ok: check command executed
```

## Additional Documentation

For more details on specific topics:
- **General test info**: See `tests/README.md`
- **Source mapping**: See `SOURCE_MAPPING.md`
- **Compiler modules**: See `zil/compiler/README.md`
