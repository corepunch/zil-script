-- ZIL Runtime loader module
-- Shared functionality for loading and executing ZIL files

local parser = require 'zil.parser'
local compiler = require 'zil.compiler'
local sourcemap = require 'zil.sourcemap'

local M = {}

-- Create a standard game environment with all required globals
function M.create_game_env()
	return { 
		print = print, 
		io = io,
		os = os,
		coroutine = coroutine,
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
		translate = sourcemap.translate,
	}
end

-- Execute a Lua string in the given environment
-- Returns true on success, false on failure
function M.execute(code, name, env, silent)
	env._G = env
	local chunk, err = load(code, '@'..name, 't', env)
	if not chunk then
		if not silent then
			print("Error: " .. err)
		end
		return false
	end
	
	local ok, run_err = pcall(chunk)
	if not ok then
		-- Translate the error traceback to use ZIL source locations
		local translated_err = sourcemap.translate(tostring(run_err))
		-- if not silent then
			print("Runtime error: " .. translated_err)
		-- end
		return false
	end
	
	return true
end

local dir = PROJECTDIR or "."

-- Load and execute the bootstrap file
-- Returns true on success, false on failure
function M.load_bootstrap(env, silent)
	local file = assert(io.open(dir.."/zil/bootstrap.lua", "r"))
	local bootstrap_code = file:read("*a")
	file:close()
	
	local success = M.execute(bootstrap_code, 'bootstrap', env, silent)
	if success and not silent then
		print("Loaded bootstrap")
	end
	return success
end

-- Compile and execute a list of ZIL files
-- Options table can contain:
--   - save_lua: if true, saves compiled .lua files to disk
--   - silent: if true, suppresses load messages
-- Returns true if all files loaded successfully
function M.load_zil_files(files, env, options)
	options = options or {}
	
	for _, f in ipairs(files) do
		local ok, ast, err = pcall(parser.parse_file, dir.."/"..f)
		if not ok then
			-- pcall caught an exception thrown during parsing (e.g., syntax error)
			if not options.silent then
				print("Failed to parse " .. f .. ": " .. tostring(ast))
			end
			return false
		end
		if not ast then
			-- parse_file successfully returned nil (e.g., file not found)
			if not options.silent then
				print("Failed to parse " .. f .. ": " .. (err or "unknown error"))
			end
			return false
		end
		
		local basename = 'zil_'..(f:match("^.+[/\\](.+)$") or f):gsub(".zil", ".lua")
		local result = compiler.compile(ast, basename)
		
		-- Optionally save the compiled Lua file
		-- if options.save_lua then
			local file = io.open(dir.."/"..basename, "w")
			if file then
				file:write(result.combined)
				file:close()
			end
		-- end
		
		-- Execute the compiled code
		if not M.execute(result.combined, basename, env, options.silent) then
			if not options.silent then
				print("Failed to load " .. f)
			end
			return false
		end
		
		if not options.silent then
			print("Loaded " .. basename)
		end
	end
	
	return true
end

-- Create a coroutine for the game that yields on input
-- Returns a coroutine object
function M.create_game(env, silent)
	return {
		-- Start the game by calling GO()
		-- Returns true on success, false on failure
		coroutine = coroutine.create(function()
			local success = M.execute("GO()", 'main', env, silent)
			if not success then
				error("Failed to start game: GO() not defined or failed")
			end
			if not silent then
				print("\n*** Game has ended ***\n")
			end
		end),
		-- Resume the game coroutine with input
		-- Returns: status (boolean), result (any value or error message)
		-- resume = function (self, input) return coroutine.resume(self.coroutine, input) end,
		resume = function (self, input) 
			local ok, response = coroutine.resume(self.coroutine, input)
			if not ok then
				error(response)
			end
			return response
		end,
		-- Check if the coroutine is still running
		is_running = function(self) return coroutine.status(self.coroutine) ~= "dead" end,
	}
end


return M
