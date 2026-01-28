# Source Mapping for ZIL-to-Lua Backtraces

This feature automatically translates Lua file references in error messages and backtraces to their original ZIL source locations.

## Overview

When ZIL code is compiled to Lua and errors occur at runtime, the error messages reference Lua file names and line numbers. This makes debugging difficult because developers write ZIL code, not Lua code. 

The source mapping feature solves this by:
1. Tracking the mapping between generated Lua lines and original ZIL source locations during compilation
2. Automatically translating error messages to reference ZIL files instead of Lua files

## Example

**Before source mapping:**
```
zil_action.lua:235: no such variable whatever
```

**After source mapping:**
```
action.zil:123: no such variable whatever
```

## How It Works

### 1. Compilation Phase

During ZIL-to-Lua compilation (`zil/compiler.lua`):
- The compiler tracks which ZIL source line corresponds to each generated Lua line
- This mapping is stored in the `sourcemap` module
- Source information comes from the parser's metadata on AST nodes

### 2. Runtime Phase

When errors occur (`zil/runtime.lua`):
- Error messages and stack traces are captured
- The `sourcemap.translate_traceback()` function scans for Lua file references
- Each reference is looked up in the mapping table
- Lua references are replaced with their corresponding ZIL source locations

### 3. Source Map Module

The `zil/sourcemap.lua` module provides:
- `add_mapping(lua_file, lua_line, zil_file, zil_line, zil_col)` - Record a mapping
- `get_source(lua_file, lua_line)` - Retrieve ZIL source for a Lua location
- `translate_traceback(traceback_string)` - Translate a full traceback
- `clear()` - Clear all mappings (useful for testing)

## Testing

### Unit Tests
```bash
lua5.4 tests/unit/test_sourcemap.lua
```

Tests the source mapping module in isolation:
- Basic mapping storage and retrieval
- Traceback translation with single and multiple files
- Preservation of unmapped references

### Integration Test
```bash
lua5.4 tests/test_sourcemap_integration.lua
```

Tests the full compilation and error translation pipeline:
- Compiles a ZIL file
- Triggers an error
- Verifies the error message references ZIL source

### Demonstration
```bash
lua5.4 tests/demo_sourcemap.lua
```

Shows a before/after comparison of error messages with source mapping.

## Architecture

```
┌─────────────────┐
│   ZIL Source    │  (e.g., action.zil:123)
│   (Parser)      │
└────────┬────────┘
         │ Parses & attaches source metadata
         ▼
┌─────────────────┐
│   AST Nodes     │  (with line, col, filename in metadata)
│                 │
└────────┬────────┘
         │ Compiled by compiler.lua
         ▼
┌─────────────────┐
│  Lua Code       │  (e.g., zil_action.lua:235)
│  + Source Map   │
└────────┬────────┘
         │ Executed by runtime.lua
         ▼
┌─────────────────┐
│  Runtime Error  │  (Lua traceback)
└────────┬────────┘
         │ Translated by sourcemap.lua
         ▼
┌─────────────────┐
│  Translated     │  (ZIL source traceback)
│  Error Message  │
└─────────────────┘
```

## Limitations

1. **Line accuracy**: The mapping tracks the ZIL line that was being compiled when each Lua line was generated. For complex expressions that span multiple ZIL lines or generate multiple Lua lines, the mapping may not be exact but should be close enough for debugging.

2. **Unmapped references**: Some Lua code comes from:
   - The bootstrap file (`zil/bootstrap.lua`)
   - Runtime library functions
   - Code generated without source metadata
   
   These references remain as Lua file paths since there's no ZIL source to map to.

3. **Multi-line statements**: ZIL statements that compile to multiple Lua lines will all map to the same ZIL line (the line where the statement started).

## Implementation Details

### Buffer Line Tracking

The `Buffer()` function in `compiler.lua` now tracks:
- Current Lua line number
- Source metadata from the current AST node being compiled
- Records mappings when `write()` or `writeln()` is called

### Pattern Matching

The `translate_traceback()` function uses a regex pattern to find Lua file references:
```lua
"([@%s]*)([^%s:]+%.lua):(%d+):"
```

This matches:
- Optional whitespace/@ prefix (preserved)
- Filename ending in `.lua`
- Colon
- Line number
- Colon

### Integration Points

Source mapping is integrated at:
1. **Compiler**: Records mappings during code generation
2. **Runtime**: Translates errors in `execute()` and `create_game()`
3. **Tests**: Validates the feature works correctly

## Future Enhancements

Potential improvements:
- Column number preservation for multi-expression lines
- Source map file export for external debugging tools
- Interactive debugger integration
- Per-expression mapping for better precision
