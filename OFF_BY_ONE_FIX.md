# Fix for Off-By-One Error in Source Mapping

## Problem
Source mapping was reporting line numbers that were 1 line too high. For example:
- Actual ZIL code on line 3527 would be reported as line 3528 in error messages

## Root Cause
In `zil/compiler.lua`, the `writeln()` function was recording source mappings **after** incrementing the line counter:

```lua
-- OLD CODE (BUGGY):
writeln = function(fmt, ...)
  -- ... write text and newline ...
  count_newlines_and_map(text)
  
  current_line = current_line + 1  -- Increment FIRST
  
  -- Record mapping for the NEW line number (off by one!)
  sourcemap.add_mapping(..., current_line, ...)
end
```

This meant that line N in the Lua code was being mapped to ZIL source from line N+1.

## Solution
Record the mapping **before** incrementing the line counter:

```lua
-- NEW CODE (FIXED):
writeln = function(fmt, ...)
  -- ... write text and newline ...
  count_newlines_and_map(text)
  
  -- Record mapping for the CURRENT line (correct!)
  sourcemap.add_mapping(..., current_line, ...)
  
  current_line = current_line + 1  -- Increment AFTER
end
```

## Verification
Created comprehensive tests that verify line numbers are accurate:
- `tests/test_line_accuracy.lua` - Simple test showing correct mappings
- `tests/test_comprehensive_accuracy.lua` - Detailed test with multiple routines
- `tests/verify_fix.lua` - Verification that the fix resolves the issue

## Result
Line numbers in error messages now correctly match the ZIL source:
- ZIL line 2 → Lua line 4 (previously would have been Lua line 5)
- ZIL line 6 → Lua line 15 (previously would have been Lua line 16)
- etc.

Error messages now show the correct line number from the ZIL source file.
