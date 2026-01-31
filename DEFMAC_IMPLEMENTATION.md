# DEFMAC and FORM Support

## Quick Summary

✅ **DEFMAC** - Macro definitions (compile-time)
✅ **FORM** - Code construction (used in macros)

## What Was Implemented

### 1. DEFMAC (Macro Definition)

**Purpose**: Define compile-time macros that generate code.

**Example**:
```zil
<DEFMAC BSET ('OBJ "ARGS" BITS)
  <MULTIBITS FSET .OBJ .BITS>>
```

**How it works**:
- Parsed like ROUTINE but handled differently
- Stored in `compiler.macros` table
- **Does NOT generate runtime code** (compile-time only)
- Parameters can be quoted (`'OBJ`), rest (`"ARGS"`), or normal (`BITS`)

**Implementation**:
- File: `zil/compiler/toplevel.lua`
- Function: `TopLevel.compileMacro()`
- Storage: `compiler.macros[name] = {params, body}`

### 2. FORM (Code Construction)

**Purpose**: Construct code forms at compile-time (used in macro bodies).

**Example**:
```zil
<FORM FSET .OBJ .BITS>
```

**Generated Lua**:
```lua
{type='expr', name='FSET', OBJ, BITS}
```

**How it works**:
- FORM creates a table representing a ZIL expression
- First argument is the form name
- Rest are the form's arguments
- Used inside macros to build code structures

**Implementation**:
- File: `zil/compiler/forms.lua`
- Handler: `form.FORM`
- Generates table constructor with form metadata

## Usage Examples

### Example 1: Simple Macro
```zil
<DEFMAC BSET ('OBJ "ARGS" BITS)
  <FORM FSET .OBJ .BITS>>
```

This defines a macro `BSET` that:
- Takes object (`'OBJ` - quoted parameter)
- Takes variable args (`"ARGS"` - rest parameter)
- Takes bits list (`BITS` - normal parameter)
- Generates a `FSET` form with the object and bits

### Example 2: Conditional Macro
```zil
<DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
  <COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
        (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>
```

This macro chooses different forms based on whether optional arg is present.

### Example 3: Complex Macro
```zil
<DEFMAC RFATAL ()
  '<PROG () <PUSH 2> <RSTACK>>>
```

This macro generates a quoted PROG form (note the `'` before PROG).

## Comparison with ROUTINE

| Aspect | ROUTINE | DEFMAC |
|--------|---------|---------|
| **Purpose** | Runtime function | Compile-time macro |
| **Execution** | At runtime | At compile-time |
| **Output** | Generates Lua function | No runtime code |
| **Storage** | Compiled to Lua | Stored in `compiler.macros` |
| **Parameters** | Regular params | Can be quoted/rest params |
| **Body** | ZIL code | Usually FORM expressions |

## Current Limitations

### ⚠️ Macro Expansion Not Yet Implemented

The current implementation:
- ✅ Parses DEFMAC definitions
- ✅ Stores macro definitions
- ✅ Handles FORM expressions
- ❌ Does NOT yet expand macro calls

**Example of what's NOT working yet**:
```zil
<DEFMAC BSET ('OBJ "ARGS" BITS) ...>
<BSET MY-OBJECT FLAG1 FLAG2>  ; This won't expand yet!
```

To fully support macros, we need to add:
1. Macro call detection during compilation
2. Parameter substitution
3. Body expansion
4. Recursive expansion

### Workaround

For now, you can:
- Define macros (they're stored)
- Use FORM directly in code
- Manually write what the macro would generate

## Testing

Run tests with:
```bash
lua tests/unit/test_defmac.lua
```

Test coverage:
- ✅ DEFMAC parsing
- ✅ DEFMAC compilation
- ✅ FORM parsing
- ✅ FORM code generation
- ✅ No runtime code for DEFMAC

## Technical Details

### Parameter Types

1. **Quoted ('OBJ)**:
   - Indicates compile-time evaluation
   - Parameter is NOT evaluated before macro expansion
   - Used for variables, forms, etc.

2. **Rest ("ARGS")**:
   - Collects remaining arguments
   - Similar to variadic parameters
   - String indicates it's a rest parameter

3. **Normal (BITS)**:
   - Regular parameter
   - Evaluated normally

### FORM Structure

FORM generates a table with:
```lua
{
  type = 'expr',
  name = '<form-name>',
  [1] = <arg1>,
  [2] = <arg2>,
  ...
}
```

This matches the AST node structure, allowing macros to construct valid ZIL code.

## Files Changed

1. **zil/compiler/init.lua** - Added `macros` table
2. **zil/compiler/toplevel.lua** - Added `compileMacro()` function
3. **zil/compiler/forms.lua** - Added `FORM` handler
4. **tests/unit/test_defmac.lua** - New test file (4 tests)
5. **tests/unit/run_all.lua** - Added new test to suite

## Future Enhancements

To complete macro support:

1. **Macro Expansion** (Phase 2):
   ```lua
   -- Detect macro calls in print_node
   -- Expand macro body with substituted parameters
   -- Recursively compile expanded code
   ```

2. **Quote Handling** (Phase 3):
   ```lua
   -- Handle quoted forms (')
   -- Prevent evaluation of quoted expressions
   -- Support backquote (`) and comma (,) for partial evaluation
   ```

3. **GVAL Support** (Phase 4):
   ```lua
   -- Get global value at compile-time
   -- Used in macro bodies: <FORM GVAL .ATM>
   ```

---

**Status**: ✅ Basic DEFMAC and FORM support complete
**Next**: Implement macro expansion mechanism (future enhancement)
