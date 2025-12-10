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
	if type(t) == 'string' then
		for i = 1, #s do if t:sub(1,1) == s:sub(i,i) then return t end end
	else
		for i = 1, #s do if t[s:sub(i,i)] then return t[s:sub(i,i)] end end
	end
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
    if i > #r then return nil end
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

local function pop(r)
	if not r or #r == 0 then return nil, r end
	if r:sub(1,1) == "`" then
		local close = r:find("`", 2)  -- find second backtick
		if close then return r:sub(close + 1), r:sub(2, close - 1) end
	end
	return r:sub(2), r:sub(1, 1)
end

local function eat(r, value)
	local s, c = pop(r)
	assert(not c or c == value)
	return s
end

local function replace(ts, j, r, m)
	local _r, t = pop(r)
	if t == ' ' then ts[j] = ' ' end
	if m:find'*' and (j >= ts or j == 1) then return _r, j+1 end
	ts[j] = t and #t > 1 and t or (t == '@' and find(ts[j], m) or (t and find(ts[j], t) or ts[j]))
	return _r, j+1
end

local function try_match_pattern(ts, m, j, r)
	for t, v in pattern_tokens(m) do
		if t == 'wildcard' then
			if j ~= 1 and j ~= #ts then return false end
			r = eat(r, '@')
		elseif t == 'select' then
			if find(ts[j],v) then r,j=replace(ts,j,r,v)
			else return false end
		elseif t == 'any' then
			for n = j, #ts do
				j = n
				if find(ts[n], v) then
				else break end
			end
			r = eat(r, '$')
		elseif t == 'literal' then
			if ts[j].__word == v then r,j=replace(ts,j,r,v)
			else return false end
		elseif t == 'char' and (v == 'Z' and find(ts[j], "VNA") or find(ts[j], v)) then
			j=j+1
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
	if match_pattern(ts, "*<TAO>[NV]`ever`", "@$@`Dкогда-либо`") then
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
	for _, n in ipairs(ts) do
		echo('blue', "%s", n)
	end
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