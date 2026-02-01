-- Direct tests for clock/interrupt system
-- These tests verify the QUEUE, INT, and CLOCKER functions work correctly

-- Initialize ZIL require system
require 'zil'

local runtime = require 'zil.runtime'

print("=== Clock System Direct Tests ===\n")

-- Load clock.zil
local files = {
  "zork1/globals.zil",
  "zork1/clock.zil",
  "zork1/verbs.zil",  -- For MOVES
  "zork1/main.zil",   -- For P_WON
}

local env = runtime.create_game_env()
runtime.load_bootstrap(env)
runtime.load_zil_files(files, env)

-- Helper to run code in env
local function run(code)
  local func, err = load("return " .. code, "test", "t", env)
  if not func then
    func = load(code, "test", "t", env)
  end
  if not func then error("Failed to compile: " .. err) end
  return func()
end

-- Test 1: Verify globals are defined
print("Test 1: Verify clock globals are defined")
assert(env.C_TABLE, "C_TABLE should be defined")
assert(env.C_TABLELEN == 180, "C_TABLELEN should be 180")
assert(env.C_DEMONS == 180, "C_DEMONS should be 180")
assert(env.C_INTS == 180, "C_INTS should be 180")
assert(env.C_INTLEN == 6, "C_INTLEN should be 6")
assert(env.C_ENABLEDQ == 0, "C_ENABLEDQ should be 0")
assert(env.C_TICK == 1, "C_TICK should be 1")
assert(env.C_RTN == 2, "C_RTN should be 2")
assert(env.CLOCK_WAIT == nil or env.CLOCK_WAIT == false, "CLOCK_WAIT should be nil or false, got " .. tostring(env.CLOCK_WAIT))
assert(env.MOVES == 0, "MOVES should be 0")
print("✓ All globals defined correctly\n")

-- Test 2: Verify C_TABLE is a memory address, not a Lua table
print("Test 2: Verify C_TABLE is a memory address")
assert(type(env.C_TABLE) == "number", "C_TABLE should be a number (memory address), got " .. type(env.C_TABLE))
print("✓ C_TABLE is a memory address:", env.C_TABLE, "\n")

-- Test 3: Verify functions are defined
print("Test 3: Verify clock functions are defined")
assert(type(env.QUEUE) == "function", "QUEUE should be a function")
assert(type(env.INT) == "function", "INT should be a function")
assert(type(env.CLOCKER) == "function", "CLOCKER should be a function")
print("✓ All functions defined\n")

-- Test 4: Test INT function - create a demon
print("Test 4: Test INT function (demon)")
-- Create a test function and register it
env.TEST_INTERRUPT = function()
  print("  Test demon called!")
  return env.T
end
local fn_idx = #env.FUNCTIONS + 1
env.FUNCTIONS[fn_idx] = env.TEST_INTERRUPT

print("  Calling INT with function index:", fn_idx, "(as demon)")
print("  C_INTS before:", env.C_INTS)
print("  C_DEMONS before:", env.C_DEMONS)

local cint = run(string.format([[
  INT(%d, T)
]], fn_idx))

print("  Result from INT:", cint, type(cint))
print("  C_INTS after:", env.C_INTS)
print("  C_DEMONS after:", env.C_DEMONS)

assert(cint, "INT should return a demon entry")
print("✓ INT created demon entry\n")

-- Test 5: Test QUEUE function
print("Test 5: Test QUEUE function")
local result = run(string.format([[
  QUEUE(%d, 5)
]], fn_idx))
assert(result, "QUEUE should return the interrupt entry")
print("✓ QUEUE set tick count\n")

-- Test 6: Test CLOCKER increments MOVES
print("Test 6: Test CLOCKER increments MOVES")
local initial_moves = env.MOVES
run("CLOCKER()")
assert(env.MOVES == initial_moves + 1, string.format("MOVES should increment (was %d, now %d)", initial_moves, env.MOVES))
print("✓ CLOCKER incremented MOVES\n")

-- Test 7: Test CLOCK_WAIT pauses clock
print("Test 7: Test CLOCK_WAIT pauses clock")
env.CLOCK_WAIT = true
local moves_before = env.MOVES
run("CLOCKER()")
assert(env.CLOCK_WAIT == nil or env.CLOCK_WAIT == false, "CLOCK_WAIT should be cleared")
assert(env.MOVES == moves_before, "MOVES should not increment when clock is paused")
print("✓ CLOCK_WAIT pauses clock correctly\n")

print("\n=== All Clock System Tests Passed ===")

-- Additional comprehensive tests
print("\n=== Additional Comprehensive Tests ===\n")

-- Test 8: Test demon firing when tick counts down
print("Test 8: Test demon firing")
-- Create a completely new unique function for this test
-- Use a high index to avoid conflicts
local test8_idx = 1000 + math.random(1, 10000)
env.FUNCTIONS[test8_idx] = function()
  env.test8_fired = (env.test8_fired or 0) + 1
  return env.T
end

print("  Creating new demon with unique function index:", test8_idx)

-- Create as demon (not regular interrupt) since P_WON is false
local demon8 = env.INT(test8_idx, env.T)  -- Create demon directly without run()
print("  Demon address:", demon8)
print("  C_DEMONS:", env.C_DEMONS, " C_TABLELEN:", env.C_TABLELEN)
print("  CLOCKER will scan from", env.C_DEMONS + 1, "to", env.C_TABLELEN)
env.ENABLE(demon8)
env.QUEUE(test8_idx, 2)
local tick = env.GET(demon8, env.C_TICK)
print("  Queued demon with tick:", tick)

-- First CLOCKER call - should decrement to 1, not fire
env.test8_fired = 0
env.CLOCKER()
tick = env.GET(demon8, env.C_TICK)
print("  After 1st CLOCKER: tick =", tick, ", fired =", env.test8_fired > 0)
assert(env.test8_fired == 0, "Demon should not fire on first CLOCKER (tick=2 -> 1)")
print("  ✓ Tick=2: Demon not fired")

-- Second CLOCKER call - should decrement to 0 and fire
env.test8_fired = 0  
env.CLOCKER()
tick = env.GET(demon8, env.C_TICK)
print("  After 2nd CLOCKER: tick =", tick, ", fired =", env.test8_fired > 0)
assert(env.test8_fired > 0, "Demon should fire on second CLOCKER (tick=1 -> 0)")
print("  ✓ Tick=1: Demon fired")
print("✓ Demon fires at correct time\n")

-- Test 9: Test finding existing demon
print("Test 9: Test INT finds existing demon")
local first_int = env.INT(test8_idx, env.T)
local second_int = env.INT(test8_idx, env.T)
assert(first_int == second_int, string.format("INT should return same entry for same function (got %s and %s)", tostring(first_int), tostring(second_int)))
print("✓ INT reuses existing demon entry\n")

-- Test 10: Test multiple demons
print("Test 10: Test multiple demons")
local test10_idx1 = 2000 + math.random(1, 1000)
local test10_idx2 = 3000 + math.random(1, 1000)
env.FUNCTIONS[test10_idx1] = function() env.count1 = (env.count1 or 0) + 1; return env.T end
env.FUNCTIONS[test10_idx2] = function() env.count2 = (env.count2 or 0) + 1; return env.T end

-- Create demons and enable them
local d1 = env.INT(test10_idx1, env.T)
local d2 = env.INT(test10_idx2, env.T)
env.ENABLE(d1)
env.ENABLE(d2)
env.QUEUE(test10_idx1, 1)
env.QUEUE(test10_idx2, 2)

env.count1, env.count2 = 0, 0
env.CLOCKER()  -- d1 should fire (tick 1->0), d2 should not (tick 2->1)
assert(env.count1 == 1, "First demon should fire")
assert(env.count2 == 0, "Second demon should not fire yet")

env.CLOCKER()  -- d2 should fire (tick 1->0)
assert(env.count2 == 1, "Second demon should fire")
print("✓ Multiple demons work correctly\n")

-- Test 11: Test C_INTS and C_DEMONS boundaries
print("Test 11: Test demon tracking")
print("  C_INTS:", env.C_INTS, " (decreases when demons are created)")
print("  C_DEMONS:", env.C_DEMONS, " (decreases when demons are created)")
assert(env.C_INTS < 180, "C_INTS should decrease as demons are added")
assert(env.C_DEMONS < 180, "C_DEMONS should decrease as demons are created")
print("✓ Demon boundaries correct\n")

-- Test 12: Test demon tick=0 doesn't fire
print("Test 12: Test tick=0 demons don't fire")
local test12_idx = 4000 + math.random(1, 1000)
env.FUNCTIONS[test12_idx] = function() env.zero_fired = true; return env.T end
local d12 = env.INT(test12_idx, env.T)
env.ENABLE(d12)
env.QUEUE(test12_idx, 0)

env.zero_fired = false
env.CLOCKER()
assert(not env.zero_fired, "Demon with tick=0 should not fire")
print("✓ Tick=0 demons don't fire\n")

print("\n=== All Comprehensive Tests Passed ===")

