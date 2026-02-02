# Testing Guide

## Test Organization

This project uses a hierarchical test organization with individual Make targets for each test file. This provides:
- **Fine-grained control**: Run individual tests or groups of tests
- **Parallel execution**: Make can run independent tests in parallel
- **Clear failure identification**: Know exactly which test failed
- **CI/CD flexibility**: Run different test suites for different scenarios

## Running Tests

### All Tests
```bash
make test              # Run all tests (unit + integration)
make test-all          # Alias for 'test'
```

### Test Categories
```bash
make test-unit         # Run unit tests only
make test-integration  # Run all integration tests
make test-parser       # Run all parser/runtime tests
make test-pure-zil     # Run pure ZIL tests (using ASSERT functions)
```

### Individual Tests

#### Parser/Runtime Tests
```bash
make test-simple-new      # Simple assertion tests
make test-insert-file     # INSERT-FILE functionality tests
make test-let             # LET form tests
make test-containers      # Container interaction tests
make test-directions      # Direction/movement tests
make test-light           # Light source tests
make test-pronouns        # Pronoun tests
make test-take            # TAKE command tests
make test-turnbit         # TURNBIT flag tests
make test-clock           # Clock system tests
make test-clock-direct    # Clock system direct tests
make test-assertions      # Assertion tests
make test-check-commands  # Check commands tests
```

#### Integration Tests
```bash
make test-zork1           # Zork1 walkthrough tests
make test-horror          # Horror complete walkthrough
make test-horror-all      # All horror tests
make test-horror-helpers  # Horror test helpers
make test-horror-partial  # Horror partial walkthrough
make test-horror-failures # Horror failing conditions
```

## Test File Types

### Runnable Tests
Test files with `RUN_TEST` routine that can be executed via `run-zil-test.lua`:
- `test-*.zil` - Standard test files
- `*-walkthrough.zil` - Full game walkthrough tests

### Helper/Library Files
Files used by other tests (no `RUN_TEST` routine):
- `test-directions-pure.zil` - Helper definitions for direction tests
- `test-require.zil` - Library for testing REQUIRE functionality
- `test-sourcemap.zil` - Error test file for source mapping

## Adding New Tests

When adding a new test file:

1. **Create the test file** in `tests/` directory:
   ```zil
   <ROUTINE RUN-TEST ()
       <TELL "=== My Test ===" CR>
       <ASSERT "Test passes" T>
       <TELL "Done!" CR>>
   ```

2. **Add Make target** in `Makefile`:
   ```make
   test-my-feature:
       @echo "Running my feature tests..."
       @lua5.4 run-zil-test.lua tests.test-my-feature
   ```

3. **Update .PHONY** declaration at top of Makefile

4. **Add to appropriate group** (e.g., `test-parser` dependencies)

5. **Add to CI workflow** in `.github/workflows/test.yml`:
   ```yaml
   - name: Run my feature tests
     run: lua5.4 run-zil-test.lua tests.test-my-feature
   ```

6. **Update help text** in Makefile

## CI/CD Testing

The GitHub Actions workflow (`.github/workflows/test.yml`) runs all tests on:
- Pull requests to main/master
- Pushes to main/master

Tests are run individually to provide clear failure identification and better reporting.

## Best Practices

### Individual Targets vs. Pattern Matching

**✅ Use individual targets** (current approach):
- Better for CI/CD reporting
- Explicit control over what runs
- Self-documenting
- Easy to exclude problematic tests temporarily

**❌ Avoid pattern matching** for test discovery:
- Hard to exclude specific tests
- Less clear in CI logs
- Harder to debug failures
- Can accidentally include helper files

### Test Naming

- Use `test-<feature>.zil` for runnable tests
- Use `<game>-walkthrough.zil` for full game tests
- Helper files can use any naming but won't be auto-discovered

### Test Organization

Group tests logically:
- `test-parser` - All parser/runtime tests
- `test-integration` - Full integration tests
- `test-pure-zil` - Pure ZIL tests without game dependencies

## Troubleshooting

### Test Not Running
- Check if test has `RUN_TEST` routine
- Verify test is added to Makefile
- Check for syntax errors in test file

### Test Timeout
- Some tests use coroutines and may appear to loop
- Increase timeout in CI if needed
- Check if test is waiting for input

### Missing Dependencies
- Run `git submodule update --init --recursive` for game dependencies
- Install Lua 5.4: `sudo apt-get install lua5.4`
