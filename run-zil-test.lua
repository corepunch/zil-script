#!/usr/bin/env lua5.4
-- Generic ZIL test runner
-- Usage: lua5.4 run-zil-test.lua test-name
--   e.g., lua5.4 run-zil-test.lua tests.test-simple-new

-- ASSERT that checks condition and prints [PASS] or [FAIL]
function ASSERT(condition, msg)
	if condition then
		print("[PASS] " .. (msg or "Assertion passed"))
		return true
	else
		print("[FAIL] " .. (msg or "Assertion failed"))
		return false
	end
end

require "zil"
require "zil.bootstrap"

-- Set up direct output (bypass ZIL's buffering system)
_G['io_write'] = io.write
_G['io_flush'] = io.flush

-- Load the test module from command line argument
local test_module = arg[1]
if not test_module then
	print("Error: No test module specified")
	print("Usage: lua5.4 run-zil-test.lua tests.test-name")
	os.exit(1)
end
require(test_module)

-- Run the GO routine
GO()

-- Flush any remaining output
io.flush()
