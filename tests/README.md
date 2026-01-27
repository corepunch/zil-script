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

### Horror.zil Game Integration Tests

The following tests validate the horror.zil adventure game:

- `horror-test-helpers.lua` - Basic verification that helper functions work
- `horror-partial.lua` - Tests accessible portions of the game (lit rooms only)
- `horror-walkthrough.lua` - Complete game walkthrough test
- `horror-failures.lua` - **NEW**: Tests failing conditions to ensure prerequisites are required

**Running horror.zil tests:**
```bash
# Run the failing conditions test
lua tests/run_tests.lua tests/horror-failures.lua

# Run partial walkthrough
lua tests/run_tests.lua tests/horror-partial.lua

# Run all horror tests
make test-horror-all
```

### Zork1 Game Integration Tests

- `zork1_basic.lua` - Basic Zork1 game interaction tests
- `zork1_extended.lua` - Extended command sequence tests

## Test Types

### Unit Tests

Unit tests test individual components (parser, compiler, runtime) in isolation. They are located in the `unit/` subdirectory.

**Running unit tests:**

```bash
# Run all unit tests
lua tests/unit/run_all.lua

# Run specific component tests
lua tests/unit/test_parser.lua
lua tests/unit/test_compiler.lua
lua tests/unit/test_runtime.lua
```

**Unit test components:**

- `test_parser.lua` - Tests for `zil/parser.lua`
  - Basic type parsing (numbers, strings, identifiers, symbols)
  - Expression and list parsing
  - Special forms (comments, placeholders, etc.)
  - Complex ZIL constructs
  
- `test_compiler.lua` - Tests for `zil/compiler.lua`
  - Routine compilation
  - Object compilation
  - Constants and globals
  - Control flow structures
  - Output format validation
  
- `test_runtime.lua` - Tests for `zil/runtime.lua`
  - Environment creation
  - Code execution
  - Bootstrap loading
  - ZIL file loading
  - Error handling

- `test_framework.lua` - Simple unit testing framework
  - Assertion functions (assert_equal, assert_type, etc.)
  - Test suite organization
  - Test result reporting

### Integration Tests

Integration tests test the full ZIL runtime using the Zork1 adventure game.

## Running Integration Tests

To run a specific test file:

```bash
lua tests/run_tests.lua tests/test-directions.lua
```

To run the default test suite:

```bash
lua tests/run_tests.lua
```

## Integration Test File Format

Test files are Lua scripts that return a table with the following structure:

```lua
return {
    name = "Test Suite Name",
    
    -- Optional: Set starting location (default is the game's default starting location)
    start = "ROOM_NAME",
    
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

**Note:** The `start` parameter sets the player's initial location before any commands are executed. Use this instead of a `start_location` command at the beginning of your test.

## Test Assertion Commands

The test framework provides several assertion commands that can be used in test files to verify game state. These commands are specified as keys in the command table instead of using the `input` field.

### Available Test Commands

#### `here` - Assert Player Location
Asserts that the player (ADVENTURER) is at a specific location.

**Usage:**
```lua
{
    here = "RECEPTION_ROOM",
    description = "Verify player is in Reception Room"
}
```

#### `take` - Assert Object in Inventory
Asserts that an object is in the player's inventory.

**Usage:**
```lua
{
    take = "BRASS_KEY",
    description = "Verify brass key is in inventory"
}
```

#### `lose` - Assert Object NOT in Inventory
Asserts that an object is NOT in the player's inventory.

**Usage:**
```lua
{
    lose = "BRASS_PLAQUE",
    description = "Verify plaque is not in inventory"
}
```

#### `flag` - Assert Object Has Flag
Asserts that an object has a specific flag set.

**Usage:**
```lua
{
    flag = "BOTTOM_DRAWER OPENBIT",
    description = "Verify drawer is open"
}
```

**Common flags:**
- `OPENBIT` - Container/door is open
- `ONBIT` - Light source is lit / Room is naturally lit
- `TAKEBIT` - Object can be taken
- `LIGHTBIT` - Object is a light source
- `CONTBIT` - Object is a container

#### `no_flag` - Assert Object Does NOT Have Flag
Asserts that an object does NOT have a specific flag set. Useful for testing failing conditions.

**Usage:**
```lua
{
    no_flag = "BOTTOM_DRAWER OPENBIT",
    description = "Verify drawer is NOT open (locked)"
}
```

#### `start_location` - Set Starting Location
Sets the player's starting location to a specific room. Useful for testing different game states or scenarios.

**Usage:**
```lua
{
    start_location = "RECEPTION_ROOM",
    description = "Start at Reception Room"
}
```

**Note:** This moves the player to the specified location but does not reset object states or inventory. To test fresh scenarios, you may need to carefully manage object states in your test sequence.

#### `global` - Assert Global Variable Set
Asserts that a global variable is set (truthy value).

**Usage:**
```lua
{
    global = "SOME_FLAG",
    description = "Verify global flag is set"
}
```

#### `text` - Assert Output Contains Text
Asserts that the game output contains specific text (case-insensitive).

**Usage:**
```lua
{
    input = "examine plaque",
    text = "blackwood sanitarium",
    description = "Verify plaque mentions Blackwood Sanitarium"
}
```

### Example Test with Assertions

```lua
return {
    name = "Drawer Unlock Test",
    start = "RECEPTION_ROOM",  -- Start at Reception Room
    files = {
        "zork1/globals.zil",
        "adventure/horror.zil",
        "zork1/parser.zil",
        "zork1/verbs.zil",
        "zork1/syntax.zil",
        "zork1/main.zil",
    },
    commands = {
        -- Verify we're at the right location
        {
            here = "RECEPTION_ROOM",
            description = "Verify we are at Reception Room"
        },
        -- Test failing condition: drawer is locked
        {
            no_flag = "BOTTOM_DRAWER OPENBIT",
            description = "Verify drawer is NOT open initially"
        },
        {
            input = "open drawer",
            description = "Try to open locked drawer (should fail)"
        },
        {
            no_flag = "BOTTOM_DRAWER OPENBIT",
            description = "Verify drawer is still NOT open"
        },
        -- Get the key
        {
            input = "take key",
            description = "Take the brass key"
        },
        {
            take = "BRASS_KEY",
            description = "Verify key is in inventory"
        },
        -- Unlock and open drawer
        {
            input = "unlock drawer with key",
            description = "Unlock the drawer"
        },
        {
            input = "open drawer",
            description = "Open the drawer"
        },
        {
            flag = "BOTTOM_DRAWER OPENBIT",
            description = "Verify drawer is now open"
        },
    }
}
```

### Test Passing Criteria

- Tests with `input` field are always marked as `[SKIP]` - they execute but are not validated
- Tests with assertion fields (`here`, `take`, `flag`, etc.) are marked as:
  - `[PASS]` if the assertion succeeds
  - `[FAIL]` if the assertion fails (with error details)

This allows you to verify that game state matches expected conditions after executing commands.

## Writing Integration Tests

### Creating Parser/Runtime Tests

1. Create a ZIL file with a minimal test world:
   - Define test rooms with appropriate FLAGS (RLANDBIT and ONBIT for lit, walkable rooms)
   - Define test objects with relevant FLAGS (TAKEBIT, CONTBIT, etc.)
   - Implement a GO() routine to initialize the game state
   - Include necessary globals from zork1/globals.zil

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

## Example Integration Tests

See `tests/zork1_basic.lua` for example tests based on the commands originally in `zil/bootstrap.lua`.

## Adding New Test Files

### Adding Unit Tests

To add new unit tests:

1. Create a new test file in `tests/unit/` (e.g., `test_mycomponent.lua`)
2. Use the test framework from `test_framework.lua`
3. Structure your tests using `test.describe()` and `t.it()`
4. Add the test file to `tests/unit/run_all.lua`

Example unit test structure:

```lua
#!/usr/bin/env lua
local test = require 'tests.unit.test_framework'
local mymodule = require 'mymodule'

test.describe("My Component - Feature X", function(t)
    t.it("should do something", function(assert)
        local result = mymodule.do_something()
        assert.assert_equal(result, expected_value)
    end)
end)

local success = test.summary()
os.exit(success and 0 or 1)
```

### Adding Integration Tests

You can create additional integration test files for different scenarios:
- Test specific verbs or commands
- Test parser edge cases
- Test game mechanics (combat, puzzles, etc.)
- Test custom ZIL code
- `tests/zork1_movement.lua` - Test movement commands
- `tests/zork1_inventory.lua` - Test inventory management
- `tests/zork1_puzzles.lua` - Test puzzle solving

Each test file can use different ZIL files by specifying them in the `files` array.

