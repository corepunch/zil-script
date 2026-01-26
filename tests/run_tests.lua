#!/usr/bin/env lua
-- Test runner for ZIL runtime
-- Usage: lua tests/run_tests.lua [test_file]

local runtime = require 'zil.runtime'
local test_format = require 'zil.test_format'

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
		
		-- print("> " .. cmd.input)
		-- Capture the output from the game
		local output = game_coro:resume(cmd.input)

		local GREEN = "\27[1;32m"
		local RED = "\27[1;31m"
		local NEUTRAL = "\27[36m"
		local RESET = "\27[0m"

		local function feedback(test, err)
			if err then
				print(RED .. "[FAIL] " .. (cmd.description or test) .. RESET)
				print(RED .. output .. RESET)
				if type(err) == "string" then print(RED .. err .. RESET) end
			else
				print(GREEN .. "[PASS] " .. (cmd.description or test) .. RESET)
			end
		end
		local function report(test) 
			feedback(test, game_coro:resume(test:gsub("-", "_")))
		end

		if cmd.here then
			report("test:here "..cmd.here)
		elseif cmd.inventory then
			report("test:inventory "..cmd.inventory)
		elseif cmd.flag then
			report("test:flag "..cmd.flag)
		elseif cmd.text then
			feedback(cmd.text, not (output or ""):find(cmd.text, 1, true))
		else
			print(NEUTRAL .. "[SKIP] " .. (cmd.description or cmd.input) .. RESET)
		end
		-- print(output)
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
