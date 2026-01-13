-- Simple unit test framework for ZIL runtime
local M = {}

-- Test state
local current_suite = nil
local stats = {
	total = 0,
	passed = 0,
	failed = 0,
	suites = 0
}

-- Color codes for output
local colors = {
	reset = "\27[0m",
	red = "\27[31m",
	green = "\27[32m",
	yellow = "\27[33m",
	blue = "\27[34m"
}

-- Assertion functions
local function assert_equal(actual, expected, message)
	stats.total = stats.total + 1
	if actual == expected then
		stats.passed = stats.passed + 1
		io.write(colors.green .. "." .. colors.reset)
		return true
	else
		stats.failed = stats.failed + 1
		io.write(colors.red .. "F" .. colors.reset)
		local msg = message or string.format("Expected %s but got %s", tostring(expected), tostring(actual))
		table.insert(current_suite.failures, {
			test = current_suite.current_test,
			message = msg
		})
		return false
	end
end

local function assert_not_equal(actual, expected, message)
	stats.total = stats.total + 1
	if actual ~= expected then
		stats.passed = stats.passed + 1
		io.write(colors.green .. "." .. colors.reset)
		return true
	else
		stats.failed = stats.failed + 1
		io.write(colors.red .. "F" .. colors.reset)
		local msg = message or string.format("Expected not equal to %s", tostring(expected))
		table.insert(current_suite.failures, {
			test = current_suite.current_test,
			message = msg
		})
		return false
	end
end

local function assert_true(value, message)
	return assert_equal(value, true, message or "Expected true")
end

local function assert_false(value, message)
	return assert_equal(value, false, message or "Expected false")
end

local function assert_nil(value, message)
	return assert_equal(value, nil, message or "Expected nil")
end

local function assert_not_nil(value, message)
	stats.total = stats.total + 1
	if value ~= nil then
		stats.passed = stats.passed + 1
		io.write(colors.green .. "." .. colors.reset)
		return true
	else
		stats.failed = stats.failed + 1
		io.write(colors.red .. "F" .. colors.reset)
		local msg = message or "Expected not nil"
		table.insert(current_suite.failures, {
			test = current_suite.current_test,
			message = msg
		})
		return false
	end
end

local function assert_type(value, expected_type, message)
	stats.total = stats.total + 1
	local actual_type = type(value)
	if actual_type == expected_type then
		stats.passed = stats.passed + 1
		io.write(colors.green .. "." .. colors.reset)
		return true
	else
		stats.failed = stats.failed + 1
		io.write(colors.red .. "F" .. colors.reset)
		local msg = message or string.format("Expected type %s but got %s", expected_type, actual_type)
		table.insert(current_suite.failures, {
			test = current_suite.current_test,
			message = msg
		})
		return false
	end
end

local function assert_match(str, pattern, message)
	stats.total = stats.total + 1
	if type(str) == "string" and str:match(pattern) then
		stats.passed = stats.passed + 1
		io.write(colors.green .. "." .. colors.reset)
		return true
	else
		stats.failed = stats.failed + 1
		io.write(colors.red .. "F" .. colors.reset)
		local msg = message or string.format("String '%s' does not match pattern '%s'", tostring(str), pattern)
		table.insert(current_suite.failures, {
			test = current_suite.current_test,
			message = msg
		})
		return false
	end
end

-- Test suite management
function M.describe(name, fn)
	stats.suites = stats.suites + 1
	print("\n" .. colors.blue .. name .. colors.reset)
	
	current_suite = {
		name = name,
		failures = {},
		current_test = nil
	}
	
	-- Create test context with assertion functions
	local context = {
		it = function(test_name, test_fn)
			current_suite.current_test = test_name
			test_fn({
				assert_equal = assert_equal,
				assert_not_equal = assert_not_equal,
				assert_true = assert_true,
				assert_false = assert_false,
				assert_nil = assert_nil,
				assert_not_nil = assert_not_nil,
				assert_type = assert_type,
				assert_match = assert_match
			})
		end
	}
	
	-- Run the test suite
	fn(context)
	
	-- Print failures for this suite
	if #current_suite.failures > 0 then
		print("\n" .. colors.red .. "Failures:" .. colors.reset)
		for _, failure in ipairs(current_suite.failures) do
			print(string.format("  %s: %s", failure.test, failure.message))
		end
	end
end

-- Print final summary
function M.summary()
	print("\n\n" .. string.rep("=", 60))
	print(string.format("Test Suites: %d", stats.suites))
	print(string.format("Tests: %d total, %s%d passed%s, %s%d failed%s",
		stats.total,
		colors.green, stats.passed, colors.reset,
		stats.failed > 0 and colors.red or colors.reset, stats.failed, colors.reset
	))
	print(string.rep("=", 60))
	
	return stats.failed == 0
end

return M
