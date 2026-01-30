# ZIL Runtime Tests

This directory contains tests for the ZIL runtime and parser.

## Quick Start

```bash
make test              # Run all tests (unit + integration)
make test-unit         # Run unit tests only
make test-integration  # Run integration tests only
```

For comprehensive test documentation including:
- Complete list of all tests
- How to run specific tests
- How to write new tests
- Test assertion commands reference
- Test coverage details

**See [TESTS.md](TESTS.md)**

## Test Categories

- **Unit Tests** (`unit/`): Parser (60 tests), Compiler (44 tests), Runtime (25 tests), Source Mapping (5 tests)
- **Integration Tests**: Zork1 game tests, parser/runtime tests, horror game tests
- **Parser/Runtime Tests**: Minimal test worlds for specific ZIL features (directions, containers, light, take, pronouns, clock)

## Writing Tests

### Integration Test Structure

Test files return a table with `name`, `files` (ZIL files to load), and `commands` (test sequence):

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
    }
}
```

### Test Assertion Commands

Commands can use special assertion fields to verify game state:

| Assertion | Description |
|-----------|-------------|
| `here = "ROOM"` | Assert player at location |
| `take = "OBJECT"` | Assert object in inventory |
| `lose = "OBJECT"` | Assert object NOT in inventory |
| `flag = "OBJECT FLAG"` | Assert object has flag |
| `no_flag = "OBJECT FLAG"` | Assert object doesn't have flag |
| `start = "ROOM"` | Teleport to location |
| `global = "VAR"` | Assert global variable set |
| `text = "phrase"` | Assert output contains text |

See [TESTS.md](TESTS.md) for complete documentation and examples.

## Test Infrastructure

- **Test Runner** (`run_tests.lua`): Loads ZIL files, executes commands, displays results
- **Unit Framework** (`unit/test_framework.lua`): Assertions, test organization, reporting
- **Assertion Commands**: Built into `zil/bootstrap.lua` for state verification

For detailed information about all available tests, writing new tests, and test commands, see **[TESTS.md](TESTS.md)**.

