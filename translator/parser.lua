local utils = require "translator.utils"
local rules = require "translator.rules"
local parser = {}

local function echo(color, s, ...)
	local colors = {
		reset  = "\27[0m",
		red    = "\27[31m",
		green  = "\27[32m",
		yellow = "\27[33m",
		blue   = "\27[34m",
		magenta= "\27[35m",
		cyan   = "\27[36m",
		white  = "\27[37m",
	}
	local f = string.format(s, ...)
	print(colors[color]..f..colors.reset)
end

local function is(word, class)
	if not word then return false end
  for i = 1, #class do
		if word:sub(1,1) == 'W' then
			if word:upper():find(class:sub(i,i)) then return true end
		else
			if word:sub(1,1):upper() == class:sub(i,i) then return true end
		end
	end
end

local function find(t, s)
	if not t then return false end
	if type(t) == 'string' then t = { [t:sub(1,1)] = t } end
	for i = 1, #s do if t[s:sub(i,i)] then return t[s:sub(i,i)] end end
	if s:find('F') then return find(t, 'A') end
end

local choose

-- предлог
local function preposition(t, p, i)
  return find(t[i], "P") or t[i][1]
end

-- существительное
local function conjunction(t, p, i)
  return find(t[i], "C") or preposition(t, p, i)
end

-- существительное
local function noun(t, p, i)
  return find(t[i], "N") or conjunction(t, p, i)
end

-- прилагательное перед существительным
local function adverb(t, p, i)
  return is(choose(t, p, i+1), "ANP") and find(t[i], "DI") or noun(t, p, i)
end

-- прилагательное перед существительным
local function adj(t, p, i)
  return is(choose(t, p, i+1), "AN") and find(t[i], "AO") or adverb(t, p, i)
end

-- глагол после местоимения
local function verb(t, p, i)
	return is(p, "XRN~") and find(t[i], "VZGXF") or adj(t, p, i)
end

-- местоимение
choose = function(t, p, i)
	if not t[i] then return nil end
  if #t[i] == 1 then return t[i][1] end
	return find(t[i], "RS") or verb(t, p, i)
end

local function pattern_tokens(m)
  local i = 1
  return function()
    if i > #m then return nil end
    local c = m:sub(i, i)
    if c == '[' then
      local j, close = i + 1, m:find(']', i)
      if not close then error("Unclosed [") end
      i = close + 1
      return 'select', m:sub(j, close - 1)  -- content between [ ]
    elseif c == '<' then
      local j, close = i + 1, m:find('>', i)
      if not close then error("Unclosed <") end
      i = close + 1
      return 'any', m:sub(j, close - 1)  -- content between < >
    elseif c == '`' then
      local j, close = i + 1, m:find('`', i + 1)
      if not close then error("Unclosed `") end
      i = close + 1
      return 'literal', m:sub(j, close - 1)  -- content between ` `
    elseif c == '*' then
      i = i + 1
      return 'wildcard', '*'
    elseif c == '~' then
      i = i + 1
      return 'rest', '~'
    else
      i = i + 1
      return 'char', c
    end
  end
end

local function replacement_tokens(r)
  local i = 1
  return function()
    if not r or i > #r then return nil end
    local c = r:sub(i, i)
    if c == '`' then
      local close = r:find('`', i + 1)
      if not close then error("Unclosed `") end
      local content = r:sub(i + 1, close - 1)
      i = close + 1
      return 'literal', content
    else
      i = i + 1
      return 'char', c
    end
  end
end

local function eat(value, _, c)
	assert(not c or c == value)
end

local function replace(ts, j, m, t, s)
	if s == ' ' then ts[j] = ' '
	elseif m:find'*' and (j >= ts or j == 1) then
	elseif t == 'literal' then ts[j] = s
	elseif s == '@' then ts[j] = find(ts[j], m)
	elseif s then ts[j] = find(ts[j], s) end
	return j+1
end

local function try_match_pattern(ts, m, j, r)
	local f = replacement_tokens(r)
	for t, v in pattern_tokens(m) do
		if t == 'wildcard' then
			if j > 1 and j <= #ts then return false end
			eat('@', f())
		elseif t == 'select' then
			if find(ts[j],v) then j=replace(ts,j,v,f())
			else return false end
		elseif t == 'any' then
			for n = j, #ts do
				if find(ts[n], v) then j=replace(ts,j,v,nil,r and '@')
				else j=n break end
			end
			eat('$', f())
		elseif t == 'literal' then
			if ts[j].__word == v then j=replace(ts,j,v,f())
			else return false end
		elseif t == 'char' and (v == 'Z' and find(ts[j], "VNA") or find(ts[j], v)) then
			j=replace(ts,j,v,f())
		elseif t == 'rest' then
			-- local rest = m:sub(i+1)
			-- for k = j+1, #ts do
			-- 	if match_pattern(table.sub(ts,k), rest) then
			-- 		return true
			-- 	end
			-- end
			-- return false
		else
			return false
		end
	end
	return true
end

local function match_pattern(ts, m, r)
	for i = 1, #ts do
		if try_match_pattern(ts, m, i) then
			try_match_pattern(ts, m, i, r)
			return true
		end
	end
end

local function loop(ts)
	-- if match_pattern(ts, "*<TAO>[NV]`ever`", "@$@`Dкогда-либо`") then
	-- if match_pattern(ts, "*`no`,RXK*", "@y    ") then
	if match_pattern(ts, "V<TAO>NG", "@$NF") then
		echo('green', '*cool*') else echo('red', '*not cool*')
	end
	-- for _, r in ipairs(rules.basic) do
	-- 	local pat, act, flag = table.unpack(r)
	-- 	if match_pattern(ts, pat) then			
	-- 	end
	-- end
end

function parser.collect(ts)
	loop(ts)
	for _, n in ipairs(ts) do echo('blue', "%s", utils.decode(n)) end
	return ts
  -- local out, prev = {}, nil
  -- for i = 1, #ts do
	-- 	local sym = choose(ts, prev, i)
	-- 	if sym and sym ~= "" then
	-- 		if sym:sub(1,1) == 'W' then
	-- 			for word in sym:gmatch("([%a ][0-9]*[\127-\255]+)") do
	-- 				table.insert(out, word)
	-- 				prev = word
	-- 			end
	-- 		else
	-- 			table.insert(out, sym)
	-- 			prev = sym
	-- 		end
	-- 		-- print(utils.decode(sym))
	-- 	else
	-- 		print('skip', utils.debug(ts[i], nil, 1))
	-- 	end
  -- end
  -- return out
end

return parser