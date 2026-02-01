#!/usr/bin/env lua5.4
-- Simple Pure ZIL Test Runner (no game loop)
-- This runner loads and executes pure ZIL test files that use ASSERT functions directly
-- Usage: lua5.4 tests/run_simple_zil_test.lua tests/test-simple-assert.zil

-- Load bootstrap first
require 'zil.bootstrap'

local compiler = require 'zil.compiler'
local preprocessor = require 'zil.preprocessor'

local function run_simple_zil_test(test_file_path)
	print("=== Running simple ZIL test: " .. test_file_path .. " ===\n")
	
	-- Read the test file
	local file = io.open(test_file_path, "r")
	if not file then
		print("Error: Could not open file: " .. test_file_path)
		os.exit(1)
	end
	local code = file:read("*a")
	file:close()
	
	-- Parse the ZIL code (with INSERT-FILE preprocessing)
	local ast, parse_err = preprocessor.parse(code, test_file_path)
	if not ast then
		print("Parse error:", parse_err)
		os.exit(1)
	end
	
	-- Compile the ZIL code
	local result, compile_err = compiler.compile(ast, test_file_path)
	if not result then
		print("Compile error:", compile_err)
		os.exit(1)
	end
	
	-- Load and execute the compiled code
	local chunk, load_err = load(result.combined, test_file_path)
	if not chunk then
		print("Load error:", load_err)
		os.exit(1)
	end
	
	-- Execute the chunk to define functions
	local ok, exec_err = pcall(chunk)
	if not ok then
		print("Execution error:", exec_err)
		os.exit(1)
	end
	
	-- Enable direct output mode for simple tests
	if _G.ENABLE_DIRECT_OUTPUT then
		_G.ENABLE_DIRECT_OUTPUT()
	end
	
	-- Call the GO function which should run the tests
	if _G.GO then
		local test_ok, test_err = pcall(_G.GO)
		if not test_ok then
			print("\nTest execution error:", test_err)
			os.exit(1)
		end
	else
		print("Error: No GO() function found in test file")
		os.exit(1)
	end
end

-- Main
local test_file = arg[1]
if not test_file then
	print("Usage: lua5.4 tests/run_simple_zil_test.lua <test.zil>")
	print("Example: lua5.4 tests/run_simple_zil_test.lua tests/test-simple-assert.zil")
	os.exit(1)
end

-- Check if test file exists
local file_check = io.open(test_file, "r")
if not file_check then
	print("Error: Test file not found: " .. test_file)
	os.exit(1)
end
file_check:close()

run_simple_zil_test(test_file)
