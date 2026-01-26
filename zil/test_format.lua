-- Test output formatting utilities
-- Provides consistent formatting for test results across different contexts

local M = {}

-- ANSI color codes for test status
-- Note: ok/pass and fail/error use the same colors respectively,
-- but are kept separate for semantic clarity and future flexibility
M.colors = {
	ok = "\27[1;32m",    -- Green for ok (check commands)
	pass = "\27[1;32m",  -- Green for pass (assert commands)
	fail = "\27[1;31m",  -- Red for fail (test assertions)
	error = "\27[1;31m", -- Red for error (command errors)
}

M.reset = "\27[0m"

-- Format a test result with color coding
-- @param result table with status and message fields
-- @return string formatted test output
function M.format_test_result(result)
	local color = M.colors[result.status] or ""
	return string.format("[TEST] %s%s%s: %s", color, result.status, M.reset, result.message)
end

return M
