#!/usr/bin/env lua5.4
-- Simple test using the ZIL require system
-- Usage: lua5.4 tests/test-simple.lua

require "zil"  -- Initialize ZIL system
require "zil.bootstrap"  -- Load ZIL runtime functions

-- Enable direct output mode for tests
ENABLE_DIRECT_OUTPUT()

-- Load and run the test
require "tests.test-simple-assert"

-- Run the test
GO()
