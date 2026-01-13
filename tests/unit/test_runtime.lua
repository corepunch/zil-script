#!/usr/bin/env lua
-- Unit tests for zil/runtime.lua

local test = require 'tests.unit.test_framework'
local runtime = require 'zil.runtime'

test.describe("Runtime - Environment Creation", function(t)
	t.it("should create game environment", function(assert)
		local env = runtime.create_game_env()
		
		assert.assert_not_nil(env)
		assert.assert_type(env, "table")
	end)
	
	t.it("should include standard Lua functions", function(assert)
		local env = runtime.create_game_env()
		
		assert.assert_not_nil(env.print)
		assert.assert_not_nil(env.io)
		assert.assert_not_nil(env.table)
		assert.assert_not_nil(env.string)
		assert.assert_not_nil(env.math)
	end)
	
	t.it("should include type checking functions", function(assert)
		local env = runtime.create_game_env()
		
		assert.assert_not_nil(env.type)
		assert.assert_not_nil(env.tostring)
		assert.assert_not_nil(env.tonumber)
	end)
end)

test.describe("Runtime - Code Execution", function(t)
	t.it("should execute simple Lua code", function(assert)
		local env = runtime.create_game_env()
		local code = "x = 42"
		
		local success = runtime.execute(code, "test", env, true)
		
		assert.assert_true(success)
		assert.assert_equal(env.x, 42)
	end)
	
	t.it("should return false on syntax error", function(assert)
		local env = runtime.create_game_env()
		local code = "this is not valid lua @@#$"
		
		local success = runtime.execute(code, "test", env, true)
		
		assert.assert_false(success)
	end)
	
	t.it("should return false on runtime error", function(assert)
		local env = runtime.create_game_env()
		local code = "error('test error')"
		
		local success = runtime.execute(code, "test", env, true)
		
		assert.assert_false(success)
	end)
	
	t.it("should execute functions in environment", function(assert)
		local env = runtime.create_game_env()
		local code = [[
			function add(a, b)
				return a + b
			end
			result = add(10, 20)
		]]
		
		local success = runtime.execute(code, "test", env, true)
		
		assert.assert_true(success)
		assert.assert_equal(env.result, 30)
	end)
	
	t.it("should set _G to environment", function(assert)
		local env = runtime.create_game_env()
		local code = "_G.test_val = 123"
		
		runtime.execute(code, "test", env, true)
		
		assert.assert_equal(env.test_val, 123)
	end)
end)

test.describe("Runtime - Bootstrap Loading", function(t)
	t.it("should load bootstrap file", function(assert)
		local env = runtime.create_game_env()
		
		local success = runtime.load_bootstrap(env, true)
		
		assert.assert_true(success)
		-- Bootstrap should define some ZIL runtime functions
		assert.assert_type(env, "table")
	end)
end)

test.describe("Runtime - ZIL File Loading", function(t)
	t.it("should handle empty file list", function(assert)
		local env = runtime.create_game_env()
		runtime.load_bootstrap(env, true)
		
		local success = runtime.load_zil_files({}, env, {silent = true})
		
		assert.assert_true(success)
	end)
	
	t.it("should return false for non-existent file", function(assert)
		local env = runtime.create_game_env()
		runtime.load_bootstrap(env, true)
		
		local success = runtime.load_zil_files(
			{"non_existent_file.zil"},
			env,
			{silent = true}
		)
		
		assert.assert_false(success)
	end)
end)

test.describe("Runtime - Game Startup", function(t)
	t.it("should handle start_game when GO not defined", function(assert)
		local env = runtime.create_game_env()
		
		-- Don't load bootstrap, so GO() is not defined
		local success = runtime.start_game(env, true)
		
		assert.assert_false(success)
	end)
	
	t.it("should call GO function if defined", function(assert)
		local env = runtime.create_game_env()
		
		-- Define a simple GO function
		env.GO = function() 
			env.game_started = true
			return true
		end
		
		runtime.start_game(env, true)
		
		assert.assert_equal(env.game_started, true)
	end)
end)

test.describe("Runtime - Options Handling", function(t)
	t.it("should respect silent option in execute", function(assert)
		local env = runtime.create_game_env()
		
		-- Should not print errors when silent = true
		local success = runtime.execute("error('test')", "test", env, true)
		assert.assert_false(success)
		
		-- Silent = false would print, but we can't easily test that
	end)
	
	t.it("should handle options in load_zil_files", function(assert)
		local env = runtime.create_game_env()
		runtime.load_bootstrap(env, true)
		
		-- Test with silent option
		local success = runtime.load_zil_files(
			{}, 
			env, 
			{silent = true}
		)
		
		assert.assert_true(success)
	end)
end)

-- Run tests and exit with appropriate code
local success = test.summary()
os.exit(success and 0 or 1)
