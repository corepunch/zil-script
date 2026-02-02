# Unit Tests - Lua-Based Infrastructure Testing

This directory contains **Lua unit tests** that test the ZIL compiler infrastructure (parser, compiler, runtime modules).

## Why Lua?

These tests **must be in Lua** because they:
1. Test the compilation process itself (parser → compiler → runtime)
2. Require direct access to internal Lua modules
3. Inspect AST structures and generated Lua code
4. Verify the infrastructure that makes ZIL possible

**These tests CANNOT be converted to ZIL** - see [CONVERSION_ANALYSIS.md](CONVERSION_ANALYSIS.md) for detailed explanation.

## Test Files

| File | Tests | What It Tests |
|------|-------|---------------|
| `test_parser.lua` | 60 | ZIL syntax parsing into AST |
| `test_compiler.lua` | 44 | ZIL AST compilation to Lua code |
| `test_runtime.lua` | 25 | Lua execution environment setup |
| `test_sourcemap.lua` | 5 | Source location mapping for errors |
| `test_defmac.lua` | 10 | DEFMAC macro definition |
| `test_macro_expansion.lua` | 9 | Macro expansion during compilation |
| `test_typescript_modules.lua` | - | TypeScript-inspired compiler modules |
| `test_framework.lua` | - | Testing framework implementation |

**Total: 134+ test assertions**

## Running Tests

```bash
# Run all unit tests
make test-unit

# Or run directly
lua5.4 tests/unit/run_all.lua

# Run individual test file
lua5.4 tests/unit/test_parser.lua
```

## Test Framework

Uses a simple custom testing framework (`test_framework.lua`) with:
- Test suites: `test.describe()`
- Individual tests: `t.it()`
- Assertions: `assert.assert_equal()`, `assert.assert_not_nil()`, etc.

## Example Test

```lua
local test = require 'tests.unit.test_framework'
local parser = require 'zilscript.parser'

test.describe("Parser - Basic Types", function(t)
    t.it("should parse numbers", function(assert)
        local ast = parser.parse("42")
        assert.assert_not_nil(ast)
        assert.assert_equal(ast[1].type, "number")
        assert.assert_equal(ast[1].value, 42)
    end)
end)
```

## What About ZIL Tests?

**ZIL tests are in `tests/` directory** and test compiled game functionality:
- `tests/test-simple-new.zil` - Runtime features
- `tests/test-containers.zil` - Container interactions
- `tests/test-directions.zil` - Navigation
- And many more integration tests

See `tests/TESTS.md` for ZIL test documentation.

## Proof of Concept

`test-zil-limitations.zil` demonstrates:
- ✅ What ZIL CAN test (runtime behavior)
- ❌ What ZIL CANNOT test (compiler internals)

Run it: `lua5.4 run-zil-test.lua tests.unit.test-zil-limitations`

(Note: `run-zil-test.lua` is in the repository root)

## Documentation

- **Why no conversion?** → [CONVERSION_SUMMARY.md](CONVERSION_SUMMARY.md)
- **Detailed analysis** → [CONVERSION_ANALYSIS.md](CONVERSION_ANALYSIS.md)
- **All tests** → [../TESTS.md](../TESTS.md)

## Key Takeaway

**Lua unit tests** and **ZIL tests** serve different purposes:
- **Lua tests** (this directory) → Test compiler infrastructure
- **ZIL tests** (`tests/`) → Test game functionality

This separation is intentional and follows sound software engineering principles.
