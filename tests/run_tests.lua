#!/usr/bin/env lua
-- Test runner for ZIL runtime
-- Usage: lua tests/run_tests.lua [test_file]

local runtime = require 'zil.runtime'

local function run_test_file(test_file_path)
	print("=== Running test: " .. test_file_path .. " ===\n")
	
	-- Load test configuration
	local test_config = dofile(test_file_path)
	print("Test suite: " .. test_config.name .. "\n")
	
	-- Create game environment
	local game = runtime.create_game_env()
	
	-- Load bootstrap
	if not runtime.load_bootstrap(game, true) then
		print("Failed to load bootstrap")
		return false
	end
	
	-- Load ZIL files (use defaults or custom list from test config)
	local files = test_config.files or {
		"zork1/globals.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"adventure/horror.zil",
		"zork1/main.zil",
	}
	
	if not runtime.load_zil_files(files, game, {silent = true}) then
		print("Failed to load ZIL files")
		return false
	end
	
	-- Create game as a coroutine
	local game_coro = runtime.create_game(game, true)
	
	-- Start the game (first resume to initialize - no input needed yet)
	local result = game_coro:resume()
	if result then
		print(result)
	end
	
	-- Feed test commands to the coroutine
	for i, cmd in ipairs(test_config.commands) do
		if not game_coro:is_running() then
			print("\nGame ended unexpectedly after command " .. (i-1))
			break
		end
		
		print("> " .. cmd.input)
		result = game_coro:resume(cmd.input)
		if result then
			-- Check if result is a test response (table with status)
			if type(result) == "table" and result.status then
				print(string.format("[TEST] %s: %s", result.status, result.message))
			else
				print(result)
			end
		end
	end
	
	print("\n=== Test commands completed ===")
	return true
end

-- Main
local test_file = arg[1] or "tests/zork1_basic.lua"

-- Check if test file exists
local file_check = io.open(test_file, "r")
if not file_check then
	print("Error: Test file not found: " .. test_file)
	print("Usage: lua tests/run_tests.lua [test_file]")
	os.exit(1)
end
file_check:close()

local success = run_test_file(test_file)
os.exit(success and 0 or 1)
