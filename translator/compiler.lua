local utils = require "translator.utils"
local paradigms = require "translator.paradigms"
local compiler = {}

local uniques = {
  ["должен"] = {"но","ен","на","ны"},
}

local case = {
  ["И"]   = 1,   -- именительный ед.
  ["Р"]   = 2,   -- родительный ед.
  ["Д"]   = 3,   -- дательный ед.
  ["В"]   = 4,   -- винительный ед.
  ["Т"]   = 5,   -- творительный ед.
  ["П"]   = 6,   -- предложный ед.
}

-- local u_endings = {
--   ["011"] = "ен",    -- I do
--   ["012"] = "ен",    -- you do (sg)
--   ["03"]  = "но",    -- he/she/it does
--   ["031"] = "ен",    -- he/she/it does
--   ["032"] = "на",    -- he/she/it does
--   ["11"]  = "ны",    -- we do
--   ["12"]  = "ны",    -- you do (pl)
--   ["13"]  = "ны",    -- they do
-- }

local function get_gender(s)
  local conf = compiler.base[utils.decode(s, true)]
  return conf and conf:byte(3)&3
end

local function find(s, n, t)
  for i = n, #s do
    if s[i]:sub(1,1) == t then return s[i] end
  end
end

local printers = {
  A = function(a, e, s, i)
    local _a = utils.extract(a)
    local d = utils.decode(_a:sub(1, #_a-2), true)
    local b = compiler.base[d]
    local code = (b:byte(2)==0x80 and b:byte(3) or b:byte(4))&~0x80
    e.gender = get_gender(find(s, i, 'N'))
    return paradigms.adjective(a, code, e)
  end,
  R = function(t, e)
    local num1, num2 = t:match("R(%d)(%d)")
    local a, b = num1 or 0, num2 or 3
    e.plural, e.person = a ~= '0', tonumber(b)
    return utils.decode(t, true)
  end,
  N = function(t, e) 
    local d = utils.decode(t, true)
    local b = compiler.base[d]
    e.gender = get_gender(t)
    e.plural = e.plural and (b:byte(3)&0x4) == 0
    return paradigms.noun(t, b:byte(4)&~0x80, e)
  end,
  P = function(t, e) 
    if case[utils.decode(t:sub(3,3), true)] then
      e.form = case[utils.decode(t:sub(3,3), true)]
      return utils.decode(t:sub(4))
    else
      e.form = case[utils.decode(t:sub(2,2), true)]
      return utils.decode(t:sub(3))
    end
  end,
  Z = function(t, e)
    local d = utils.decode(t, true)
    if e.imperative and (compiler.base[d]:byte(2)&2)~=2 then
      t = compiler.base[d]:sub(6)
      d = utils.decode(t)
    end
    e.form, e.imperative = case["В"], false
    if e.infinitive then e.infinitive = false return d end
    return paradigms.verb(t, compiler.base[d]:byte(4)&~0x80, e)
  end,
  U = function(t, e)
    local _u = utils.extract(t)
    local d = utils.decode(t, true)
    local u = uniques[d]
    e.infinitive, e.imperative = true, true
    return utils.decode(_u:sub(1,#_u-2))..u[e.plural and 4 or (e.gender+1)]
  end,
  T = function() return "" end,
  X = function() return "" end,
  [" "] = function (t, _) return utils.decode(t, true) end,
  C = function (t, _) return utils.decode(t, true) end,
  D = function (t, _) return utils.decode(t:sub(2), false) end,
}

printers.V = printers.Z
printers.G = printers.Z

function compiler.compile(s)
  local e = { plural = false, gender = 1, person = 3, form = 1, imperative = false }
  local c = {}

  -- for i, w in ipairs(s) do print(utils.decode(w)) end

  for i, w in ipairs(s) do
    -- print(w)
    if w:match"[,%!%.;:]" then
      if #c > 0 then c[#c] = c[#c]..w
      else table.insert(c, w) end
    else
      local func = printers[w:sub(1,1)]
      local ok, res = pcall(func, w, e, s, i)
      local s = ok and res or utils.decode(w, true)..'*'
      if #s > 0 then table.insert(c, s) end
      if not ok then print(res) end
    end
  end
  print("")
  print(table.concat(c, " "))
  print("")
end

-- print(
  --   table.concat({
  --     noun(s.subject.noun, table.unpack(s.subject)),
  --     verb(s.verb.verb, read_transform(s.subject.noun), s.verb.secondary),
  --     noun(s.object.noun, table.unpack(s.object))}, 
  --   " "))

return compiler