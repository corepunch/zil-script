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
	
	-- Prepare test commands
	local commands = {}
	for _, cmd in ipairs(test_config.commands) do
		table.insert(commands, cmd.input)
	end
	
	-- Set up test mode
	game.TEST_COMMANDS = commands
	game.ON_TEST_COMPLETE = function()
		print("\n=== Test commands completed ===")
		os.exit(0)
	end
	
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
	
	-- Run the game with test commands
	if not runtime.start_game(game, true) then
		print("Failed to start game")
		return false
	end
	
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
