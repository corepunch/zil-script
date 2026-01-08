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

-- Start the game
if not runtime.start_game(game) then
	os.exit(1)
end

-- local ast = parser.parse_file "zork1/actions.zil"
-- local result = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(result.body)