# ZIL Runtime Tests

This directory contains tests for the ZIL runtime and parser.

## Test Categories

### Parser/Runtime Tests (Inspired by ZILF)

The following tests focus on core ZIL parser and runtime functionality, inspired by the ZILF test suite:

- `test-directions.lua` / `test-directions.zil` - Tests direction/movement parsing and execution
- `test-take.lua` / `test-take.zil` - Tests the TAKE command with various objects
- `test-containers.lua` / `test-containers.zil` - Tests container interactions (open/close, put/take)
- `test-light.lua` / `test-light.zil` - Tests light source mechanics and darkness handling
- `test-pronouns.lua` / `test-pronouns.zil` - Tests basic command execution and object interactions

Each test consists of:
- A `.zil` file defining a minimal test world with specific objects and rooms
- A `.lua` file defining the test commands to execute

### Game Integration Tests

- `zork1_basic.lua` - Basic Zork1 game interaction tests
- `zork1_extended.lua` - Extended command sequence tests

## Running Tests

To run a specific test file:

```bash
lua tests/run_tests.lua tests/test-directions.lua
```

To run the default test suite:

```bash
lua tests/run_tests.lua
```

## Test File Format

Test files are Lua scripts that return a table with the following structure:

```lua
return {
    name = "Test Suite Name",
    
    -- List of ZIL files to compile and load
    files = {
        "zork1/globals.zil",
        "tests/test-directions.zil",
        "zork1/parser.zil",
        "zork1/verbs.zil",
        "zork1/syntax.zil",
        "zork1/main.zil",
    },
    
    -- List of commands to execute in sequence
    commands = {
        {
            input = "north",
            description = "Move north to hallway"
        },
        {
            input = "look",
            description = "Look at the new room"
        },
        -- Add more commands...
    }
}
```

## Writing Tests

### Creating Parser/Runtime Tests

1. Create a ZIL file with a minimal test world:
   - Define test rooms with appropriate FLAGS (RLANDBIT and ONBIT for lit, walkable rooms)
   - Define test objects with relevant FLAGS (TAKEBIT, CONTBIT, etc.)
   - Implement a GO() routine to initialize the game state
   - Include necessary globals from zork1/globals.zil

2. Create a Lua test file that:
   - Loads zork1/globals.zil, your test ZIL file, parser, verbs, syntax, and main
   - Defines a sequence of commands to test specific functionality

3. Run the test using `run_tests.lua`

### Important ZIL Flags

- `RLANDBIT` - Room is walkable on land (required for movement)
- `ONBIT` - Room is naturally lit (or object provides light when set)
- `LIGHTBIT` - Object is a light source (keep this set, toggle ONBIT to control illumination)
- `TAKEBIT` - Object can be taken
- `CONTBIT` - Object is a container
- `OPENBIT` - Container is open

### Example Test Structure

See `tests/test-directions.zil` and `tests/test-directions.lua` for a complete example.

## Test Runner Behavior

The test runner will:
- Load the ZIL runtime and bootstrap
- Compile and execute the specified ZIL files
- Execute each command in sequence
- Display the game output for each command
- Exit cleanly after all commands are executed

## Adding New Test Files

You can create additional test files for different scenarios:
- Test specific verbs or commands
- Test parser edge cases
- Test game mechanics (combat, puzzles, etc.)
- Test custom ZIL code

Each test file can use different ZIL files by specifying them in the `files` array.

