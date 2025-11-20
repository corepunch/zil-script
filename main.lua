local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

local files = {
  "/Users/igor/Developer/zork1-main/globals.zil",
  "/Users/igor/Developer/zork1-main/verbs.zil",
  "/Users/igor/Developer/zork1-main/actions.zil",
  "/Users/igor/Developer/zork1-main/syntax.zil",
  "/Users/igor/Developer/zork1-main/dungeon.zil",
  "/Users/igor/Developer/zork1-main/parser.zil",
  "/Users/igor/Developer/zork1-main/main.zil",
}

local game = { 
	print = print, 
	io = io, 
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
}

local function execute(string, name)
	game._G = game
	local chunk, err = load(string, '@'..name, 't', game)
	if not chunk then
		print(err)
	else
		local ok, run_err = pcall(chunk, function(e)
        return debug.traceback(tostring(e), 2)
    end)
		if not ok then
			print(run_err)
			os.exit(1)
		else
			print("Loaded "..name)
			return true
		end
	end
end

local file = assert(io.open("zil/bootstrap.lua", "r"))
execute(file:read("*a"), 'bootstrap')
file:close()

for _, f in ipairs(files) do
	local ast = parser.parse_file(f)
	local result = compiler.compile(ast)
	local basename = 'zil_'..(f:match("^.+[/\\](.+)$") or f):gsub(".zil", ".lua")
	local file = io.open(basename, "w")
	if file then
		file:write(result.combined)
		file:close()
	end
	execute(result.combined, basename)
end

execute("GO()", 'main')

-- local ast = parser.parse_file "/Users/igor/Developer/zork1-main/actions.zil"
-- local result = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(result.body)