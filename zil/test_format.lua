-- Test output formatting utilities
-- Provides consistent formatting for test results across different contexts

local M = {}

-- ANSI color code constants
local GREEN_BOLD = "\27[1;32m"
local RED_BOLD = "\27[1;31m"
local RESET = "\27[0m"

-- ANSI color codes for test status
-- Note: ok/pass and fail/error use the same colors respectively,
-- but are kept separate for semantic clarity and future flexibility
M.colors = {
	ok = GREEN_BOLD,    -- Green for ok (check commands)
	pass = GREEN_BOLD,  -- Green for pass (assert commands)
	fail = RED_BOLD,    -- Red for fail (test assertions)
	error = RED_BOLD,   -- Red for error (command errors)
}

M.reset = RESET

-- Format a test result with color coding
-- @param result table with status and message fields
-- @return string formatted test output
function M.format_test_result(result)
	-- Validate input
	if type(result) ~= "table" then
		error(string.format("test_format.format_test_result: expected table, got %s: %s", 
			type(result), tostring(result)))
	end
	if not result.status then
		error(string.format("test_format.format_test_result: result.status is required (got %s)", 
			type(result.status)))
	end
	if not result.message then
		error(string.format("test_format.format_test_result: result.message is required (got %s)", 
			type(result.message)))
	end
	
	-- Get color, warn if status is unknown
	local color = M.colors[result.status]
	if not color then
		io.stderr:write(string.format("WARNING: Unknown test status '%s', using no color\n", result.status))
		color = ""
	end
	
	return string.format("[TEST] %s%s%s: %s", color, result.status, M.reset, result.message)
end

return M
