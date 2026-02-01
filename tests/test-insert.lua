#!/usr/bin/env lua5.4
require "zil"
require "zil.bootstrap"

function ASSERT(condition, msg)
	if condition then
		print("[PASS] " .. (msg or "Assertion passed"))
		return true
	else
		print("[FAIL] " .. (msg or "Assertion failed"))
		return false
	end
end

_G.io_write = io.write
_G.io_flush = io.flush

require "tests.test-insert-file"
GO()
io.flush()
