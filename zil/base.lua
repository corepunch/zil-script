-- ZIL base module
-- Provides loader functionality for .zil files similar to moonscript
-- Allows using require() to load .zil files automatically

local parser = require 'zil.parser'
local compiler = require 'zil.compiler'
local sourcemap = require 'zil.sourcemap'

local M = {}

-- Directory separator (OS-appropriate)
M.dirsep = package.config:sub(1,1)

-- Create package.zilpath from package.path
-- Converts .lua patterns to .zil patterns
local function create_zilpath(package_path)
	local zilpaths = {}
	for path in package_path:gmatch("[^;]+") do
		local prefix = path:match("^(.-)%.lua$")
		if prefix then
			table.insert(zilpaths, prefix .. ".zil")
		end
	end
	return table.concat(zilpaths, ";")
end

M.create_zilpath = create_zilpath

-- Convert ZIL source code to Lua
-- Returns compiled Lua code and source map table, or nil and error message
function M.to_lua(text, options)
	options = options or {}
	
	if type(text) ~= "string" then
		return nil, "expecting string (got " .. type(text) .. ")"
	end
	
	local ok, ast, err = pcall(parser.parse, text, options.filename)
	if not ok then
		return nil, "Parse error: " .. tostring(ast)
	end
	if not ast then
		return nil, err or "Parse failed"
	end
	
	local result = compiler.compile(ast, options.filename)
	if not result or not result.combined then
		return nil, "Compilation failed"
	end
	
	return result.combined, result
end

-- ZIL loader function for package.loaders/searchers
-- Searches for .zil files and compiles them on demand
function M.zil_loader(name)
	local name_path = name:gsub("%.", M.dirsep)
	local file, file_path
	
	-- Search through package.zilpath for the module
	for path in package.zilpath:gmatch("[^;]+") do
		file_path = path:gsub("?", name_path)
		file = io.open(file_path)
		if file then
			break
		end
	end
	
	if not file then
		return nil, "Could not find zil file for module: " .. name
	end
	
	-- Read the .zil file
	local text = file:read("*a")
	file:close()
	
	-- Compile to Lua
	local lua_code, err = M.to_lua(text, { filename = file_path })
	if not lua_code then
		error(file_path .. ": " .. err)
	end
	
	-- Load the compiled Lua code
	local chunk, load_err = load(lua_code, "@" .. file_path)
	if not chunk then
		error(file_path .. ": " .. load_err)
	end
	
	return chunk
end

-- Load ZIL code from a string
function M.loadstring(str, chunk_name, ...)
	chunk_name = chunk_name or "=(zil.loadstring)"
	
	local code, err = M.to_lua(str, { filename = chunk_name })
	if not code then
		return nil, err
	end
	
	return load(code, chunk_name, ...)
end

-- Load ZIL code from a file
function M.loadfile(fname, ...)
	local file, err = io.open(fname)
	if not file then
		return nil, err
	end
	
	local text = file:read("*a")
	file:close()
	
	return M.loadstring(text, "@" .. fname, ...)
end

-- Execute a ZIL file
function M.dofile(fname, ...)
	local f, err = M.loadfile(fname, ...)
	if not f then
		return error(err)
	end
	return f()
end

-- Insert the ZIL loader into package.loaders/searchers
-- pos: position to insert the loader (default: 2)
-- Returns true if inserted, false if already present
function M.insert_loader(pos)
	pos = pos or 2
	
	-- Create package.zilpath if it doesn't exist
	if not package.zilpath then
		package.zilpath = create_zilpath(package.path)
	end
	
	-- Get the loaders table (Lua 5.1 uses loaders, 5.2+ uses searchers)
	local loaders = package.loaders or package.searchers
	
	-- Check if loader is already installed
	for _, loader in ipairs(loaders) do
		if loader == M.zil_loader then
			return false
		end
	end
	
	-- Insert the loader
	table.insert(loaders, pos, M.zil_loader)
	return true
end

-- Remove the ZIL loader from package.loaders/searchers
-- Returns true if removed, false if not found
function M.remove_loader()
	local loaders = package.loaders or package.searchers
	
	for i, loader in ipairs(loaders) do
		if loader == M.zil_loader then
			table.remove(loaders, i)
			return true
		end
	end
	
	return false
end

-- Install ZIL loader into a specific environment
-- This marks the environment as having ZIL support and ensures package.zilpath exists
function M.install_into(env)
	-- Create package.zilpath if it doesn't exist
	if not package.zilpath then
		package.zilpath = create_zilpath(package.path)
	end
	
	-- Mark this environment as having ZIL loader installed
	env._ZIL_LOADER_INSTALLED = true
	
	return true
end

return M
