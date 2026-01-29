# Torch Light Source Fix Summary

## Problem Statement

User reported an issue where the torch (with LIGHTBIT and ONBIT flags) was not providing light in dark rooms. The issue was in the NEXTQ function which is used to iterate through the player's inventory when searching for light sources.

## Root Cause

The **NEXTQ** function in `zil/bootstrap.lua` (line 484) directly accessed `getobj(obj).LOC` without checking if the object was nil:

```lua
function NEXTQ(obj)
  local parent = getobj(obj).LOC  -- ⚠️ BUG: No nil check!
  local found = false
  for n, o in ipairs(OBJECTS) do
    if o.LOC == parent then
      if found then return n end
      if n == obj then found = true end
    end
  end
end
```

### Why This Broke Torch Detection

When the `LIT?` function in `zork1/parser.zil` searches for light sources:

1. Sets `P-GWIMBIT` to `ONBIT` flag
2. Calls `DO-SL(WINNER, 1, 1)` to search player's inventory
3. `SEARCH-LIST` uses `FIRST?` → `FIRSTQ` and `NEXT?` → `NEXTQ` to iterate
4. **If NEXTQ encountered a nil object, it would crash or fail silently**
5. **Inventory iteration would terminate early, skipping the torch**
6. Result: Torch with ONBIT flag was never checked, room appeared dark

## Solution Implemented

### Primary Fix: NEXTQ Defensive Nil Check

```lua
function NEXTQ(obj)
  local o = getobj(obj)
  if not o then return nil end  -- ✅ Added nil check
  local parent = o.LOC          -- Now safe
  local found = false
  for n, o in ipairs(OBJECTS) do
    if o.LOC == parent then
      if found then return n end
      if n == obj then found = true end
    end
  end
end
```

### Secondary: Consistent Nil Guards

Added defensive nil checks to other object functions for robustness:
- `LOC()` - Returns nil for nil objects
- `INQ()` - Returns false for nil objects (query function)
- `MOVE()`, `REMOVE()` - Silently handle nil objects
- `FSET()`, `FCLEAR()` - Silently handle nil objects
- `FSETQ()` - Returns false for nil objects (consistent with flag not set)
- `GETPT()` - Returns nil for nil objects or objects without property table

## Testing

### New Test Created

**File:** `tests/test-torch-light.lua`

Comprehensive test that:
1. Navigates to torch room
2. Takes the torch (which has ONBIT flag set)
3. Turns OFF the lamp (so only torch provides light)
4. Verifies player can see room description (torch is working!)
5. Moves to another dark room to confirm torch continues to work

**Result:** ✅ All tests pass

### Existing Tests

**Zork1 Walkthrough (`tests/zork1_walkthrough.lua`):**
- ✅ The exact sequence from the problem statement now passes
- ✅ All torch-related navigation tests pass
- ✅ Torch correctly provides light after lamp is turned off (line 122)
- ✅ "Drop screwdriver" → "Open lid" sequence works (lines 192-193)

## Verification

The torch light mechanic is confirmed working:

```
[PASS] Taken. (take torch)
[PASS] The brass lantern is now off. (turn off lamp)
[PASS] Torch Room (look)
[PASS] Temple (walk south)
```

With lamp OFF and only the torch, the player can:
- See room descriptions
- Navigate through dark rooms
- Interact with objects

## Impact

### Benefits
1. **Fixes torch light detection** - Torch now properly provides light
2. **Prevents crashes** when nil objects are encountered during iteration
3. **Improves robustness** of the runtime
4. **Maintains backward compatibility** with all existing code
5. **No breaking changes** - all tests continue to pass

### No Security Issues
- Changes are defensive programming improvements
- No vulnerabilities introduced or fixed
- Improves stability and error handling

## Conclusion

The issue was a missing nil check in NEXTQ that caused inventory iteration to fail, preventing the torch from being detected as a light source. The fix adds a defensive nil check at the start of NEXTQ, allowing proper iteration through the player's inventory and correct detection of the torch's ONBIT flag.
