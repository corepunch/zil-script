# Horror.zil Winnability Test Results

## Summary

This document summarizes the results of implementing and running winnability tests for horror.zil.

## Test Infrastructure Implemented

1. **Helper Functions in `zil/bootstrap.lua`**:
   - `test:get-location` - Returns current room name
   - `test:check-inventory OBJECT_NAME` - Checks if object is in player's inventory
   - `test:check-flag OBJECT_NAME FLAG_NAME` - Checks if object has a specific flag set
   - `test:check-location OBJECT_NAME LOCATION_NAME` - Checks if object is at a specific location

2. **Test Files Created**:
   - `tests/horror-test-helpers.lua` - Basic test to verify helper functions work
   - `tests/horror-partial.lua` - Tests accessible portions of the game
   - `tests/horror-walkthrough.lua` - Complete walkthrough test template
   - `tests/HORROR_TESTING.md` - Complete documentation

3. **Enhanced Test Runner** (`tests/run_tests.lua`):
   - Displays game output and test assertion results
   - Shows test results in format: `[TEST] status: message`

## Test Results

### Winnability Assessment: **NOT WINNABLE** (Current Implementation)

The automated tests have identified the following blocking issues in horror.zil:

### Issue 1: Light Source Accessibility Problem

**Problem**: Many rooms are dark (lacking ONBIT flag):
- OPERATING-THEATER
- PATIENT-WARD  
- MORGUE
- All basement rooms (BASEMENT-STAIRS, BASEMENT-CORRIDOR, BOILER-ROOM, STORAGE-ROOM, etc.)

**Root Cause**: The only light sources (flashlight and oil lantern) are located in dark basement rooms (BOILER-ROOM and STORAGE-ROOM respectively), creating an impossible chicken-and-egg situation.

**Evidence**: Test output shows "It is pitch black. You are likely to be eaten by a grue" when entering these rooms, and grue kills prevent further exploration.

**Recommended Fix**: 
- Option A: Add ONBIT flag to OPERATING-THEATER, PATIENT-WARD, and MORGUE rooms
- Option B: Move OIL-LANTERN to a lit room (RECEPTION-ROOM or SANITARIUM-GATE)

### Issue 2: Container Item Access Problem

**Problem**: Items inside containers cannot be taken using standard "take" command.

**Specific Case**: PATIENT-LEDGER in BOTTOM-DRAWER
- Opening the drawer shows: "Opening the bottom drawer reveals a patient ledger"
- Looking shows the ledger in the drawer
- Command "take ledger" results in: "You can't see any ledger here!"
- Test assertion confirms: `[TEST] ok: PATIENT_LEDGER is at BOTTOM_DRAWER`

**Evidence**: 
```
> open drawer
Opening the bottom drawer reveals a patient ledger.

> take ledger
You can't see any ledger here!

> test:check-location PATIENT_LEDGER BOTTOM_DRAWER
[TEST] ok: PATIENT_LEDGER is at BOTTOM_DRAWER
```

**Recommended Fix**: Review and fix the verb handling for taking items from open containers in horror.zil or zork1 verbs.

## What Works

The test infrastructure successfully demonstrates:

1. **State Verification**: All test helper commands work correctly
   - Location tracking: `[TEST] ok: Current location: SANITARIUM_GATE`
   - Inventory checks: `[TEST] ok: BRASS_PLAQUE is in player's inventory`
   - Flag checks: `[TEST] ok: BOTTOM_DRAWER has OPENBIT`
   - Location checks: `[TEST] ok: PATIENT_LEDGER is at BOTTOM_DRAWER`

2. **Basic Gameplay Mechanics**: 
   - Movement between rooms works
   - Taking items from rooms works (e.g., BRASS-PLAQUE, BRASS-KEY)
   - Using items works (unlocking drawer with key)
   - Opening containers works (BOTTOM-DRAWER opens successfully)

3. **Issue Detection**: The tests clearly identify where gameplay breaks down

## Next Steps

To make horror.zil winnable:

1. **Address Light Source Issue**: 
   ```zil
   ; In horror.zil, change OPERATING-THEATER definition:
   <ROOM OPERATING-THEATER
         ...
         (FLAGS RLANDBIT ONBIT)>  ; Add ONBIT
   
   ; Similar changes for PATIENT-WARD and MORGUE
   ```

2. **Fix Container Access**: Review verb implementation for taking items from open containers

3. **Re-run Tests**: After fixes, run:
   ```bash
   lua5.3 tests/run_tests.lua tests/horror-walkthrough.lua
   ```

4. **Verify Win Condition**: Ensure all 101 walkthrough commands complete successfully and reach the chapel win condition

## Conclusion

The test infrastructure is **working correctly** and successfully identifies game-breaking issues. The tests provide:
- Automated verification of game state
- Clear identification of where gameplay breaks
- A template for complete winnability testing once issues are fixed
- Documentation for future test creation

Horror.zil, once the identified issues are resolved, should be fully testable using the provided test suite to verify it is winnable from start to finish.
