#!/usr/bin/env lua5.4
-- Generic ZIL test runner
-- Usage: lua5.4 run-zil-test.lua test-name
--   e.g., lua5.4 run-zil-test.lua tests.test-simple-new

local GREEN = "\27[1;32m"
local RED = "\27[1;31m"
local NEUTRAL = "\27[36m"
local RESET = "\27[0m"

local success = true

-- ASSERT that checks condition and prints [PASS] or [FAIL]
function ASSERT(condition, msg)
	if condition then
		print(GREEN .. "[PASS] " .. (msg or "Assertion passed") .. RESET)
		return true
	else
		success = false
		print(RED .. "[FAIL] " .. (msg or "Assertion failed") .. RESET)
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

print("Running ZIL test: " .. test_module)
require(test_module)

-- Run the GO routine
GO()

-- Flush any remaining output
io.flush()

os.exit(success and 0 or 1)