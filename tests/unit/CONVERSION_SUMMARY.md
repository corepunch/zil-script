# Unit Test Conversion Analysis Summary

## Question
Can we convert Lua tests in `tests/unit/` to ZIL?

## Answer
**NO** - The Lua unit tests should remain in Lua. Conversion is not feasible or desirable.

## Why Not?

### 1. **Different Testing Layers**
- **Lua unit tests** test the *compiler infrastructure* (parser, compiler, runtime modules)
- **ZIL tests** test the *compiled game functionality* (game logic, runtime behavior)

### 2. **Module Access Limitations**
ZIL code cannot access Lua modules:
```zil
; This CANNOT work in ZIL:
; - No way to require 'zilscript.parser'
; - No way to call parser.parse()
; - No way to inspect AST structures
; - No way to call compiler.compile()
```

### 3. **Circular Dependency Problem**
- Lua tests verify the compilation process itself
- ZIL code IS the output of that compilation process
- You can't test the compiler from within compiled code

### 4. **Proof of Concept**
See `tests/unit/test-zil-limitations.zil` - a working ZIL test that demonstrates:
- ✅ What CAN be tested in ZIL (runtime behavior, math, logic)
- ❌ What CANNOT be tested in ZIL (compiler internals, module access)

Run it with:
```bash
lua5.4 run-zil-test.lua tests.unit.test-zil-limitations
```

(The `run-zil-test.lua` runner is in the repository root)

## What Each Test Type Does

### Lua Unit Tests (`tests/unit/*.lua`)
**Purpose**: White-box testing of compiler infrastructure

**Tests**:
- `test_parser.lua` - Parser module (AST generation)
- `test_compiler.lua` - Compiler module (Lua code generation)
- `test_runtime.lua` - Runtime module (environment setup)
- `test_sourcemap.lua` - Source mapping (error translation)
- `test_defmac.lua` - Macro definitions
- `test_macro_expansion.lua` - Macro expansion

**Example**:
```lua
local parser = require 'zilscript.parser'
t.it("should parse numbers", function(assert)
    local ast = parser.parse("42")
    assert.assert_equal(ast[1].type, "number")
end)
```

### ZIL Tests (`tests/*.zil`)
**Purpose**: Black-box testing of runtime functionality

**Tests**:
- `test-simple-new.zil` - Basic runtime features
- `test-containers.zil` - Container interactions
- `test-directions.zil` - Movement and navigation
- `test-pronouns.zil` - Pronoun resolution
- Game walkthrough tests

**Example**:
```zil
<ROUTINE RUN-TEST ()
    <ASSERT "Math works" <==? <+ 2 3> 5>>
    <ASSERT "Objects work" <==? <LOC ,APPLE> ,TESTROOM>>
>
```

## Recommendation

### Keep Current Structure ✅
1. **Lua unit tests** (`tests/unit/`) - Test compiler internals
2. **ZIL integration tests** (`tests/`) - Test game functionality

This separation is proper software architecture, not a limitation.

### Want More Tests?

**For compiler/parser testing** → Write Lua unit tests  
**For game functionality testing** → Write ZIL tests

## Testing Coverage Summary

| Test Type | Count | Purpose | Language | Layer |
|-----------|-------|---------|----------|-------|
| Parser tests | 60 | Test parsing | Lua | Infrastructure |
| Compiler tests | 44 | Test compilation | Lua | Infrastructure |
| Runtime tests | 25 | Test execution | Lua | Infrastructure |
| Source map tests | 5 | Test error mapping | Lua | Infrastructure |
| ZIL integration | Many | Test game features | ZIL | Application |

**Total**: 134+ Lua unit tests + Many ZIL integration tests

## See Also

- **Full Analysis**: `tests/unit/CONVERSION_ANALYSIS.md`
- **Proof of Concept**: `tests/unit/test-zil-limitations.zil`
- **Test Documentation**: `tests/TESTS.md`
- **Test README**: `tests/README.md`

## Conclusion

The Lua unit tests in `tests/unit/` **cannot and should not** be converted to ZIL. They test the compilation infrastructure that produces ZIL's runtime environment. The current test architecture is sound and follows software engineering best practices with clear separation between infrastructure testing (Lua) and application testing (ZIL).
