#!/usr/bin/env lua5.4
-- Test INSERT-FILE functionality using the ZIL require system
-- Usage: lua5.4 tests/test-insert.lua

require "zil"
require "zil.bootstrap"

ENABLE_DIRECT_OUTPUT()

require "tests.test-insert-file"

GO()
