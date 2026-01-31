#!/usr/bin/env lua
-- Run all unit tests

local test_files = {
	"tests/unit/test_parser.lua",
	"tests/unit/test_compiler.lua",
	"tests/unit/test_runtime.lua",
	"tests/unit/test_typescript_modules.lua",
	"tests/unit/test_defmac.lua",
	"tests/unit/test_macro_expansion.lua"
}

local all_passed = true

print("Running ZIL Runtime Unit Tests")
print(string.rep("=", 60))

for _, test_file in ipairs(test_files) do
	print("\n" .. test_file)
	local ok, why, code = os.execute("lua " .. test_file)
	local exit_code
	if type(ok) == "number" then
		-- Lua 5.1: os.execute returns a numeric exit status
		exit_code = ok
	elseif ok == true then
		-- Lua 5.2+: success indicated by true
		exit_code = 0
	else
		-- Lua 5.2+: failure; use returned exit code or default to 1
		exit_code = code or 1
	end
	if exit_code ~= 0 then
		all_passed = false
	end
end

print("\n" .. string.rep("=", 60))
if all_passed then
	print("All unit tests passed!")
	os.exit(0)
else
	print("Some unit tests failed!")
	os.exit(1)
end
