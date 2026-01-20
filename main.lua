local runtime = require 'zil.runtime'

local files = {
  "zork1/globals.zil",
  "zork1/parser.zil",
  "zork1/verbs.zil",
  -- "zork1/actions.zil",
  "zork1/syntax.zil",
  -- "zork1/dungeon.zil",
  "adventure/horror.zil",
  "zork1/main.zil",
}

-- Create game environment
local game = runtime.create_game_env()

-- Load bootstrap
if not runtime.load_bootstrap(game) then
	os.exit(1)
end

-- Load ZIL files (save compiled .lua files to disk)
if not runtime.load_zil_files(files, game, {save_lua = true}) then
	os.exit(1)
end

-- Create game as a coroutine
local game_coro = runtime.create_game_coroutine(game)

-- Start the game (first resume to initialize - no input needed yet)
local status, result = runtime.resume_game(game_coro)
if not status then
	print("Error starting game: " .. tostring(result))
	os.exit(1)
end

-- Main game loop - resume with input from io.read()
while runtime.is_running(game_coro) do
	local input = io.read()
	if not input then
		-- EOF or error - exit gracefully
		os.exit(0)
	end
	
	status, result = runtime.resume_game(game_coro, input)
	if not status then
		print("Error in game: " .. tostring(result))
		os.exit(1)
	end
end

-- local ast = parser.parse_file "zork1/actions.zil"
-- local result = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(result.body)