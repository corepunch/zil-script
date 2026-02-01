#!/usr/bin/env lua5.4
-- Pure ZIL Test Runner
-- This runner loads and executes pure ZIL test files that use ASSERT functions
-- Usage: lua5.4 tests/run_pure_zil_test.lua tests/test-pure-zil-example.zil

-- Initialize ZIL require system
require 'zil'

local runtime = require 'zil.runtime'

local function run_pure_zil_test(test_file_path)
	print("=== Running pure ZIL test: " .. test_file_path .. " ===\n")
	
	-- Create game environment
	local game = runtime.create_game_env()
	
	-- Load bootstrap
	assert(runtime.init(game, true), "Failed to load bootstrap")

	-- Set up deterministic random for reproducibility
	local seed = 0
	local rnd = [[local n=]] .. tostring(seed) .. [[
	function RANDOM(max)
	  local m=n
	  n=n+1
	  return m%max+1
	end]]
	runtime.execute(rnd, 'random', game, false)
	
	-- Load required ZIL modules
	game.require('zil')
	local modules = {
		"zork1.globals",  -- Core globals
		test_file_path:match("^(.+)%.zil$"),  -- The test file itself (without .zil extension)
	}
	assert(runtime.load_modules(game, modules, {silent = true}), "Failed to load modules")
	
	-- Execute the GO routine which runs the tests
	local ok, err = pcall(function()
		game.GO()
	end)
	
	if not ok then
		print("\n\27[1;31mError running test:\27[0m")
		print(err)
		os.exit(1)
	end
end

-- Main
local test_file = arg[1]
if not test_file then
	print("Usage: lua5.4 tests/run_pure_zil_test.lua <test.zil>")
	print("Example: lua5.4 tests/run_pure_zil_test.lua tests/test-pure-zil-example.zil")
	os.exit(1)
end

-- Check if test file exists
local file_check = io.open(test_file, "r")
if not file_check then
	print("Error: Test file not found: " .. test_file)
	os.exit(1)
end
file_check:close()

run_pure_zil_test(test_file)
