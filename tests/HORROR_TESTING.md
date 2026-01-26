# Testing horror.zil for Winnability

This document describes how to test that the horror.zil adventure game is winnable using the automated test infrastructure.

## Overview

The test infrastructure provides two key capabilities:

1. **Automated walkthrough testing** - Run a complete game walkthrough to verify the game can be completed
2. **State verification helpers** - Check game state during tests to ensure puzzles are solved correctly

## Running the Horror Walkthrough Test

To verify that horror.zil is winnable, run the complete walkthrough test:

```bash
lua tests/run_tests.lua tests/horror-walkthrough.lua
```

This test executes all 101 commands from the complete walkthrough documented in `adventure/horror-walkthrough.md`, including:
- Taking all necessary items
- Solving all puzzles (key puzzles, steam valve, chain cutting, safe puzzle)
- Navigating through all 22 rooms
- Reaching the final chapel location
- Triggering the win condition (saying "hello" to Patient 189)

## Test Helper Commands

The test infrastructure includes special helper commands that can be used in test files to verify game state. These commands are prefixed with `test:` and are handled by the bootstrap system.

### Available Test Commands

#### `test:get-location`
Returns the current room/location name.

**Example:**
```lua
{
    input = "test:get-location",
    description = "Verify starting location"
}
```

**Returns:**
```lua
{
    status = "ok",
    location = "SANITARIUM_GATE",
    message = "Current location: SANITARIUM_GATE"
}
```

#### `test:check-inventory <object-name>`
Checks if an object is in the player's inventory.

**Example:**
```lua
{
    input = "test:check-inventory BRASS_KEY",
    description = "Verify brass key in inventory"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "BRASS_KEY",
    in_inventory = true,
    message = "BRASS_KEY is in player's inventory"
}
```

#### `test:check-flag <object-name> <flag-name>`
Checks if an object has a specific flag set (e.g., OPENBIT, ONBIT, TAKEBIT).

**Example:**
```lua
{
    input = "test:check-flag OIL_LANTERN ONBIT",
    description = "Verify lantern is lit"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "OIL_LANTERN",
    flag = "ONBIT",
    is_set = true,
    message = "OIL_LANTERN has ONBIT"
}
```

#### `test:check-location <object-name> <location-name>`
Checks if an object is at a specific location (room or container).

**Example:**
```lua
{
    input = "test:check-location BRASS_PLAQUE SANITARIUM_GATE",
    description = "Verify plaque is at gate"
}
```

**Returns:**
```lua
{
    status = "ok",
    object = "BRASS_PLAQUE",
    location = "SANITARIUM_GATE",
    is_at_location = true,
    message = "BRASS_PLAQUE is at SANITARIUM_GATE"
}
```

## Common ZIL Flags

When using `test:check-flag`, here are the most commonly used flags:

- `OPENBIT` - Container/door is open
- `ONBIT` - Light source is lit / Room is naturally lit
- `TAKEBIT` - Object can be taken
- `CONTBIT` - Object is a container
- `LIGHTBIT` - Object is a light source
- `DOORBIT` - Object is a door
- `READBIT` - Object can be read
- `TOUCHBIT` - Object has been touched/taken
- `INVISIBLE` - Object is not visible

## Object and Room Names

Object and room names in ZIL are defined with hyphens (e.g., `SANITARIUM-GATE`, `BRASS-KEY`), but when compiled to Lua, these hyphens are converted to underscores. When using test helper commands, you must use the Lua names with underscores:

- **ZIL definition**: `<OBJECT BRASS-PLAQUE ...>` 
- **Test command**: `test:check-inventory BRASS_PLAQUE`

Examples:
- Rooms: `SANITARIUM_GATE`, `RECEPTION_ROOM`, `CHAPEL`, etc.
- Objects: `BRASS_KEY`, `OIL_LANTERN`, `PATIENT_LEDGER`, etc.

You can find the ZIL names in the `.zil` source files and convert hyphens to underscores for use in test commands.

## Creating Custom Tests

You can create custom test files to verify specific scenarios or puzzle sequences. Here's a minimal example:

```lua
return {
    name = "Horror.zil Key Puzzle Test",
    files = {
        "zork1/globals.zil",
        "adventure/horror.zil",
        "zork1/parser.zil",
        "zork1/verbs.zil",
        "zork1/syntax.zil",
        "zork1/main.zil",
    },
    commands = {
        {
            input = "north",
            description = "Enter sanitarium"
        },
        {
            input = "west",
            description = "Go to reception"
        },
        {
            input = "take key",
            description = "Take brass key"
        },
        {
            input = "test:check-inventory BRASS_KEY",
            description = "Verify we have the key"
        },
        {
            input = "unlock drawer",
            description = "Unlock the drawer"
        },
        {
            input = "test:check-flag BOTTOM_DRAWER OPENBIT",
            description = "Verify drawer is now open"
        },
        {
            input = "take ledger",
            description = "Take the patient ledger"
        },
    }
}
```

Save this to a file like `tests/horror-key-puzzle.lua` and run it with:

```bash
lua tests/run_tests.lua tests/horror-key-puzzle.lua
```

## Implementation Details

The test helper functions are implemented in `zil/bootstrap.lua`:
- `check_flag(obj_name, flag_name)` - Checks object flags
- `check_location(obj_name, location_name)` - Checks object location
- `check_inventory(obj_name)` - Checks player inventory
- `get_location()` - Gets current player location
- `handle_test_command(cmd)` - Parses and dispatches test commands

These functions are integrated into the game's READ loop and respond to inputs prefixed with `test:`.

## Verifying Winnability

To verify horror.zil is winnable:

1. Run the complete walkthrough test
2. Check that all test assertions pass (inventory checks, flag checks, location checks)
3. Verify the final win condition is reached (entering chapel and greeting Patient 189)

The test should complete without errors, demonstrating that:
- All necessary items can be found and collected
- All puzzles can be solved with the available items and commands
- All required rooms can be accessed
- The win condition can be triggered

## Troubleshooting

### Test Command Not Found
If you see "Unknown test command", ensure:
- The command starts with `test:`
- The command syntax is correct
- Object and room names match those defined in the .zil file (case-sensitive)

### Object Not Found
If you see "Object not found", verify:
- The object name is spelled correctly
- The object name matches the ZIL definition (usually UPPERCASE-WITH-HYPHENS)
- The object exists in the loaded game files

### Flag Not Set
If a flag check shows `is_set = false` when you expected true:
- Verify the action that should set the flag was executed successfully
- Check the game output for error messages
- Ensure prerequisite items or conditions are met
