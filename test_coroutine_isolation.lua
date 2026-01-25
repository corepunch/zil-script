-- Test that demonstrates coroutine isolation
local runtime = require 'zil.runtime'

print("=== Testing Coroutine Isolation ===\n")

-- Create two separate game environments
local game1 = runtime.create_game_env()
local game2 = runtime.create_game_env()

-- Add a test variable to each environment
game1.test_var = "Game 1"
game2.test_var = "Game 2"

-- Load bootstrap for both
assert(runtime.load_bootstrap(game1, true), "Failed to load bootstrap for game1")
assert(runtime.load_bootstrap(game2, true), "Failed to load bootstrap for game2")

-- Verify isolation
print("Game 1 test_var:", game1.test_var)
print("Game 2 test_var:", game2.test_var)
print()

-- Test that READ function exists in both and uses coroutines
assert(type(game1.READ) == "function", "READ not defined in game1")
assert(type(game2.READ) == "function", "READ not defined in game2")
print("✓ Both games have READ function")
print("✓ Game environments are isolated")
print()

-- Create coroutines for both games (if they had GO functions)
-- These GO functions use infinite loops and yield to allow multiple resumes
-- This is intentional for testing coroutine isolation - the test controls
-- how many times each coroutine is resumed
game1.GO = function()
	while true do
		game1.call_count = (game1.call_count or 0) + 1
		print("Game 1 GO called, count:", game1.call_count)
		coroutine.yield()
	end
end

game2.GO = function()
	while true do
		game2.call_count = (game2.call_count or 0) + 1
		print("Game 2 GO called, count:", game2.call_count)
		coroutine.yield()
	end
end

-- Create coroutines
local coro1 = runtime.create_game(game1, true)
local coro2 = runtime.create_game(game2, true)

-- Run them
coro1:resume()
coro2:resume()
coro1:resume()

-- Verify isolation
print("\nAfter running:")
print("Game 1 call_count:", game1.call_count)
print("Game 2 call_count:", game2.call_count)

assert(game1.call_count == 2, "Game 1 should have been called twice")
assert(game2.call_count == 1, "Game 2 should have been called once")
print("\n✓ Coroutines maintain proper isolation")
print("✓ All isolation tests passed!")
