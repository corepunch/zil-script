#!/usr/bin/env lua5.4
-- Test using simplified approach
require "zil"
require "zil.bootstrap"

-- Set up ASSERT
function ASSERT(condition, msg)
	if condition then
		print("[PASS] " .. (msg or "Assertion passed"))
		return true
	else
		print("[FAIL] " .. (msg or "Assertion failed"))
		return false
	end
end

-- Set up direct output
_G.io_write = io.write
_G.io_flush = io.flush

-- Load test
require "tests.test-simple-new"

-- Run test
GO()

-- Flush output
io.flush()
