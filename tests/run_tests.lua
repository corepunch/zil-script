#!/usr/bin/env lua
-- Test runner for ZIL runtime
-- Usage: lua tests/run_tests.lua [test_file]

local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

local function execute(string, name, env)
	env._G = env
	local chunk, err = load(string, '@'..name, 't', env)
	if not chunk then
		print("Error: " .. err)
		return false
	else
		local ok, run_err = pcall(chunk, function(e)
			return debug.traceback(tostring(e), 2)
		end)
		if not ok then
			print("Runtime error: " .. run_err)
			return false
		else
			return true
		end
	end
end

local function run_test_file(test_file_path)
	print("=== Running test: " .. test_file_path .. " ===\n")
	
	-- Load test configuration
	local test_config = dofile(test_file_path)
	print("Test suite: " .. test_config.name .. "\n")
	
	-- Create game environment
	local game = { 
		print = print, 
		io = io, 
		setmetatable = setmetatable,
		ipairs = ipairs,
		pairs = pairs,
		table = table,
		tostring = tostring,
		tonumber = tonumber,
		type = type,
		string = string,
		pcall = pcall,
		error = error,
		assert = assert,
		debug = debug,
		select = select,
		math = math,
		next = next,
		os = os,
	}
	
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
	local file = assert(io.open("zil/bootstrap.lua", "r"))
	if not execute(file:read("*a"), 'bootstrap', game) then
		print("Failed to load bootstrap")
		return false
	end
	file:close()
	
	-- Load ZIL files
	local files = test_config.files or {
		"zork1/globals.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"adventure/horror.zil",
		"zork1/main.zil",
	}
	
	for _, f in ipairs(files) do
		local ast = parser.parse_file(f)
		local result = compiler.compile(ast)
		local basename = 'zil_'..(f:match("^.+[/\\](.+)$") or f):gsub(".zil", ".lua")
		
		if not execute(result.combined, basename, game) then
			print("Failed to load " .. f)
			return false
		end
	end
	
	-- Run the game with test commands
	if not execute("GO()", 'main', game) then
		print("Failed to start game")
		return false
	end
	
	return true
end

-- Main
local test_file = arg[1] or "tests/zork1_basic.lua"

if not io.open(test_file, "r") then
	print("Error: Test file not found: " .. test_file)
	print("Usage: lua tests/run_tests.lua [test_file]")
	os.exit(1)
end

local success = run_test_file(test_file)
os.exit(success and 0 or 1)
