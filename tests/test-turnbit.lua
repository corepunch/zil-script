-- Test TURNBIT flag functionality
local runtime = require 'zil.runtime'

print("=== TURNBIT Flag Test ===")

local modules = {
  "zork1.globals",
  "zork1.clock",
  "zork1.parser",
  "zork1.verbs",
  "zork1.syntax",
  "tests.test-turnbit",
  "zork1.main",
}

-- Create game environment
local env = runtime.create_game_env()

-- Load bootstrap
if not runtime.init(env) then
	print("Failed to load bootstrap")
	os.exit(1)
end

-- Install ZIL support and load modules
env.require('zil')
if not runtime.load_modules(env, modules) then
	print("Failed to load modules")
	os.exit(1)
end

-- Create game as coroutine
local game = runtime.create_game(env)

local function send_command(cmd)
	local res = game:resume(cmd)
	print(res)
	return res
end

-- Start the game
local res = game:resume()
print(res)

-- Test 1: Turn valve WITH TURNBIT - should succeed
print("\n--- Test 1: TURN VALVE (has TURNBIT) ---")
send_command("turn valve")
if env.VALVE_TURNED then
	print("✓ PASS: Valve was turned successfully")
else
	print("✗ FAIL: Valve was not turned (should have succeeded)")
	os.exit(1)
end

-- Reset for next test
env.VALVE_TURNED = false
print("\n--- Test 2: TURN VALVE WITH BARE HANDS (no tool specified) ---")
send_command("turn valve")
-- Should print "Your bare hands don't appear to be enough."
-- and NOT turn the valve
if env.VALVE_TURNED then
	print("✗ FAIL: Valve was turned (should have been blocked by bare hands check)")
	os.exit(1)
else
	print("✓ PASS: Valve was correctly blocked from turning with bare hands")
end

-- Test 3: Turn wheel WITHOUT TURNBIT - should fail
print("\n--- Test 3: TURN WHEEL (no TURNBIT) ---")
send_command("turn wheel")
if env.WHEEL_TURNED then
	print("✗ FAIL: Wheel was turned (should have been blocked)")
	os.exit(1)
else
	print("✓ PASS: Wheel was correctly blocked from turning")
end

print("\n=== All tests passed! ===")
