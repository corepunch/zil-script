local runtime = require 'zil.runtime'
local test_format = require 'zil.test_format'

local files = {
  "zork1/globals.zil",
  "zork1/clock.zil",
  "zork1/parser.zil",
  "zork1/verbs.zil",
  -- "zork1/actions.zil",
  "zork1/syntax.zil",
  -- "zork1/dungeon.zil",
  "adventure/horror.zil",
  "zork1/main.zil",
}

-- Create game environment
local env = runtime.create_game_env()

-- Load bootstrap
if not runtime.load_bootstrap(env) then
	os.exit(1)
end

-- Load ZIL files (save compiled .lua files to disk)
if not runtime.load_zil_files(files, env, {save_lua = true}) then
	os.exit(1)
end

local esc = "\27["

local function highlight(text)
  for _, dir in ipairs(env.DESCS) do
    local fmt = esc .. "1;32m%s" .. esc .. "0m"
    local cap = dir:sub(1,1):upper() .. dir:sub(2)
    text = text:gsub("(%f[%a]" .. dir .. "%f[%A])", function(m) return fmt:format(m) end)
    text = text:gsub("(%f[%a]" .. cap .. "%f[%A])", function(m) return fmt:format(m) end)
  end
  for _, dir in ipairs(env.DIRS) do
    local fmt = esc .. "1;36m%s" .. esc .. "0m"
    local cap = dir:sub(1,1):upper() .. dir:sub(2)
    text = text:gsub("(%f[%a]" .. dir .. "%f[%A])", function(m) return fmt:format(m) end)
    text = text:gsub("(%f[%a]" .. cap .. "%f[%A])", function(m) return fmt:format(m) end)
  end
  return text
end

-- Create env as a coroutine
local game, input = runtime.create_game(env), nil
repeat
	local res = game:resume(input)
  
	-- Check if result is a test response (table with status)
	if type(res) == "table" and res.status then
		io.write(test_format.format_test_result(res) .. "\n")
	else
		io.write(highlight(res))
	end
	-- if res.items then
	--   print("\nItems:")
	--   for item, verbs in pairs(res.items) do
	--     if #verbs > 0 then
	--       print(string.format("  %s (%s)", item:upper(), table.concat(verbs, ', ')))
	--     else
	--       print(string.format("  %s", item:upper()))
	--     end
	--   end
	-- end
	-- if res.exits then
	--   print("\nExits:")
	--   for exit, desc in pairs(res.exits) do
	--     print(string.format("  %s -> %s", exit, desc))
	--   end
	-- end
	input = io.read()
	io.write("\n")
until not input or not game:is_running()

-- local ast = parser.parse_file "zork1/actions.zil"
-- local res = compiler.compile(ast)

-- print(parser.view(ast, 0))
-- print(res.body)