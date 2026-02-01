# Pure ZIL Testing Guide

This guide explains how to write self-contained tests entirely in ZIL using the new assertion functions.

## Overview

Pure ZIL tests allow you to write tests completely in ZIL without requiring Lua wrapper files. Tests can use:
- Built-in assertion functions (ASSERT-TRUE, ASSERT-EQUAL, etc.)
- INSERT-FILE to include shared test utilities
- Direct output mode for immediate test results

## Quick Start

### Simple Test Example

Create a test file `tests/my-test.zil`:

```zil
<CONSTANT RELEASEID 1>

<ROUTINE TEST-MY-FEATURE ()
    <TELL "Testing my feature..." CR>
    <ASSERT-TRUE T "Basic assertion">
    <ASSERT-EQUAL 5 5 "Numbers equal">
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-MY-FEATURE>>
```

Create a runner `tests/my-test.lua`:

```lua
#!/usr/bin/env lua5.4
require "zil"
require "zil.bootstrap"

ENABLE_DIRECT_OUTPUT()
require "tests.my-test"
GO()
```

Run it:
```bash
lua5.4 tests/my-test.lua
```

## Available Assertion Functions

### Basic Assertions

- `<ASSERT-TRUE condition "message">` - Assert condition is true
- `<ASSERT-FALSE condition "message">` - Assert condition is false
- `<ASSERT-EQUAL actual expected "message">` - Assert values are equal
- `<ASSERT-NOT-EQUAL actual expected "message">` - Assert values are different

### Object Location Assertions

- `<ASSERT-IN-INVENTORY object "message">` - Assert object is in inventory
- `<ASSERT-NOT-IN-INVENTORY object "message">` - Assert object is not in inventory
- `<ASSERT-AT-LOCATION object location "message">` - Assert object at specific location

### Flag Assertions

- `<ASSERT-HAS-FLAG object flag "message">` - Assert object has flag set
- `<ASSERT-NOT-HAS-FLAG object flag "message">` - Assert object doesn't have flag

### Test Summary

- `<TEST-SUMMARY>` - Print test results and exit with appropriate code

## Using INSERT-FILE

Tests can include shared utilities using INSERT-FILE:

**tests/test-utils.zil:**
```zil
<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROUTINE TEST-SETUP (ROOM-OBJ)
    <SETG HERE .ROOM-OBJ>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,ADVENTURER ,HERE>>
```

**tests/my-test.zil:**
```zil
<INSERT-FILE "test-utils">

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (FLAGS RLANDBIT ONBIT)>

<ROUTINE TEST-MY-FEATURE ()
    <TEST-SETUP ,TESTROOM>
    <ASSERT-AT-LOCATION ,ADVENTURER ,TESTROOM "Setup worked">
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-MY-FEATURE>>
```

## Complete Example

See `tests/test-pure-zil-example.zil` for a comprehensive example that tests:
- Basic assertions
- Object locations
- Flag checks
- Inventory management
- Movement between locations

## Running Tests

### Simple Approach (Recommended)

1. Create a test ZIL file: `tests/my-test.zil`
2. Create a simple runner: `tests/my-test.lua`:
   ```lua
   require "zil"
   require "zil.bootstrap"
   ENABLE_DIRECT_OUTPUT()
   require "tests.my-test"
   GO()
   ```
3. Run: `lua5.4 tests/my-test.lua`

### Using the Test Runner

For tests that don't need special setup, use the generic runner:

```bash
lua5.4 tests/run_simple_zil_test.lua tests/my-test.zil
```

## Best Practices

1. **Use descriptive messages** - Make assertions self-documenting
2. **Group related tests** - Use multiple ROUTINE blocks for organization
3. **Share common setup** - Use INSERT-FILE for test utilities
4. **Call TEST-SUMMARY** - Always end with TEST-SUMMARY for proper exit codes
5. **Keep tests focused** - Test one feature/behavior per test file

## Pure ZIL vs ZIL+Lua Tests

### Pure ZIL Tests (New)

**Pros:**
- Self-contained, everything in ZIL
- Can use INSERT-FILE to include dependencies
- Good for testing data structures and logic
- Simpler for developers who know ZIL

**Cons:**
- Cannot test parser/command processing directly
- Limited to testing compiled ZIL code

**Use for:** Testing game logic, object relationships, flag states, routines

### ZIL+Lua Tests (Existing)

**Pros:**
- Can test full game loop with command input
- Tests parser and command processing
- Can simulate player interactions

**Cons:**
- Requires two files (ZIL + Lua)
- More complex setup

**Use for:** Testing parser, verbs, command processing, player interactions

## Examples in Repository

- `tests/test-simple-assert.zil` - Basic assertions
- `tests/test-pure-zil-example.zil` - Comprehensive example
- `tests/test-insert-file.zil` - INSERT-FILE demonstration
- `tests/test-directions-pure.zil` - Testing room connections

## Technical Notes

### Direct Output Mode

Pure ZIL tests use `ENABLE_DIRECT_OUTPUT()` to print immediately instead of buffering for coroutine-based game loops. This is set in the Lua runner before calling GO().

### INSERT-FILE Processing

INSERT-FILE directives are processed during parsing by `zil/preprocessor.lua`. The preprocessor:
- Recursively includes files
- Resolves relative paths
- Prevents circular includes
- Adds .zil extension if needed

### Test Exit Codes

- `0` - All tests passed
- `1` - Some tests failed or no tests run

The exit code is set by `TEST-SUMMARY` based on test results.
