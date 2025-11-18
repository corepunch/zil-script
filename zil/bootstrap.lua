-- zil_init.lua
-- Equivalent of zil_newstate() in plain Lua

-- === Object Flags ===
ZIL_ObjectFlags = {
  "SACREDBIT", "FIGHTBIT", "TOUCHBIT", "WEARBIT", "SEARCHBIT",
  "NWALLBIT", "NONLANDBIT", "TRANSBIT", "SURFACEBIT", "INVISIBLE",
  "STAGGERED", "OPENBIT", "RLANDBIT", "TRYTAKEBIT", "NDESCBIT",
  "TURNBIT", "READBIT", "TAKEBIT", "CONTBIT", "ONBIT", "FOODBIT",
  "DRINKBIT", "DOORBIT", "CLIMBBIT", "RMUNGBIT", "FLAMEBIT",
  "BURNBIT", "VEHBIT", "TOOLBIT", "WEAPONBIT", "ACTORBIT",
  "LIGHTBIT", "MAZEBIT"
}

OQANY=1

PSQOBJECT=128
PSQVERB=64
PSQADJECTIVE=32
PSQDIRECTION=16
PSQPREPOSITION=8
PSQBUZZ_WORD=4

P1QNONE=0
P1QOBJECT=0
P1QVERB=1
P1QADJECTIVE=2
P1QDIRECTION=3

-- === Register globals ===
for i, flag in ipairs(ZIL_ObjectFlags) do
  _G[flag] = i
end

-- === Core globals ===
VERBS   = {}
QUEUES  = {}
ROOMS   = {}
_OBJECTS = {}
_PROPERTIES = {}

_VTBL = {}
_OTBL = {}

T = true
CR = "\n"
VERB = ""
PRSO = nil
PRSI = nil

M_FATAL = 2
M_HANDLED = 1
M_NOT_HANDLED = nil
M_OBJECT = nil
M_BEG = 1
M_END = 6
M_ENTER = 2
M_LOOK = 3
M_FLASH = 4
M_OBJDESC = 5

local cache = {
	verbs = {},
	words = {},
	actions = {},
}

local vocabulary = {}

-- === Utility functions ===

function VERBQ(...)
  for _, v in ipairs {...} do
    if VERB == v then return true end
  end
  return false
end

function TELL(...)
  for _, v in ipairs {...} do
    io.write(tostring(v))
  end
end

function PRINT(str) print(str) end
PRINTI = PRINT
PRINTB = PRINT
PRINTN = PRINT
function PRINTC(ch) io.write(string.char(ch)) end
function CRLF() print() end

-- Logic / bitwise
function NOT(a) return not a end
function PASS(a) return a end
function BAND(a, b) return a & b end
function BOR(a, b) return a | b end
function BTST(a, b) return (a & b) == b end

-- Arithmetic / comparison
function EQUALQ(a, ...) for _, v in ipairs {...} do if a == v then return true end end end
function NEQUALQ(a, b) return a ~= b end
function GQ(a, b) return a > b end
function LQ(a, b) return a < b end
function GEQ(a, b) return a >= b end
function LEQ(a, b) return a <= b end
function ZEROQ(a) return a == 0 end
function ONEQ(a) return a == 1 end

function SETG(var, val) _G[var] = val return val end
function ADD(a, b) return a + b end
function SUB(a, b) return a - b end
function DIV(a, b) return a / b end
function MUL(a, b) return a * b end

-- function GQ(a, b) return a > b end
-- IGRTRQ = GQ
LESSQ = LQ
MULL = MUL

-- Object / room ops
function LOC(obj) return obj.IN end
function INQ(obj, room) return obj.IN == room end
function MOVE(obj, dest) obj.IN = dest end
function REMOVE(obj) obj.IN = nil end

function FIRSTQ(obj)
	for _, o in ipairs(_OBJECTS) do
		if o.IN == obj then return o end
	end
end

function NEXTQ(obj)
  local parent = obj.IN
  local found = false
  for _, o in ipairs(_OBJECTS) do
    if o.IN == parent then
      if found then return o end
      if o == obj then found = true end
    end
  end
end

function FSET(obj, flag) obj.FLAGS = (obj.FLAGS or 0) | (1<<flag) end
function FCLEAR(obj, flag) obj.FLAGS = (obj.FLAGS or 0) & ~(1<<flag) end
function FSETQ(obj, flag) return obj.FLAGS and (obj.FLAGS & (1<<flag)) ~= 0 end
function PUTP(obj, prop, val) obj[prop] = val end
function GETP(obj, prop) return obj[prop] end

function REST(s, i)
	if type(s) == 'table' then s = string.char(#s)..table.concat(s) end
	return s:sub((i or 1) + 1)
end

function APPLY(func, ...) return func and func(...) end
function PUT(obj, i, val) obj[i * 2] = val end
function PUTB(obj, i, val) obj[i] = val end
-- function GET(t, i) return type(t) == 'table' and t[i * 2] or 0 end
-- function GETB(t, i) return type(t) == 'table' and t[i] or 0 end

function GETB(s, i) 
	if type(s) == 'number' then return s end
	if type(s) == 'table' then 
		if i == 0 and s.max_size then return s.max_size end
		if s.size_at_one then
			if i == 1 then return #s end
			s = string.char(s.max_size or #s)..string.char(#s)..table.concat(s)
		else
			s = string.char(#s)..table.concat(s)
		end
	end
	return s:byte(i + 1) or 0
end

function GET(s, i)
	if s == 0 then
		-- Z-machine header mockup
		s = {
			[0] = 3,       -- version (not actually used)
			[1] = 15,      -- release number (Release 15)
			[8] = 0,       -- Flags 2 (transcript bit is bit 0)
	}
	end
	assert(type(s) == 'table', "GET requires a table")
	return i == 0 and #s or s[i]
	-- if type(s) == 'table' then return s.index and s:index(i) or s[i] end
	-- return GETB(s, i * 2) | (GETB(s, i * 2 + 1) << 8)
end

function READ()
	local s = "walk north"--io.read()
	local parse = {}
	for pos, word in s:gmatch("()(%S+)") do
		local index = cache.words[word:lower()] or 0
		table.insert(parse, string.char(index, index >> 8, #word, pos))
	end
	parse.max_size = 120
	parse.size_at_one = true
	parse.index = function (self, key)
		assert((key - 1) % 2 == 0)
		local word = self[1+(key-1)/2]
		print(self, 1+(key-1)/2, key)
		return vocabulary[word:byte(1) | (word:byte(2) << 8)]
	end
	return string.char(#s)..s:lower(), parse
end

local function learn(word, type, func)
	local prim = {
		[PSQOBJECT]=P1QOBJECT,
		[PSQVERB]=P1QVERB,
		[PSQADJECTIVE]=P1QADJECTIVE,
		[PSQDIRECTION]=P1QDIRECTION,
		[PSQPREPOSITION]=P1QOBJECT,
		[PSQBUZZ_WORD]=P1QNONE,
	}
	if not word then return 0 end
	word = word:lower()
	-- print(word, func)
	if cache.words[word] then
		local index = cache.words[word]
		local ent = vocabulary[index]
		local new = string.char(0,0,0,ent:byte(4)|type,ent:byte(5),func)
		vocabulary[index] = new
		return index
	else
		table.insert(vocabulary, string.char(0,0,0,type|prim[type],func,0))
		cache.words[word] = #vocabulary
		_G['WQ'..string.upper(word)] = vocabulary[#vocabulary]
		return #vocabulary
	end
end

function DIRECTIONS(...)
	for _, dir in ipairs {...} do
		table.insert(_PROPERTIES, dir)
		learn(dir:lower(), PSQDIRECTION, #_PROPERTIES)
	end
end

function SYNTAX(syn)
	local name = syn.VERB:lower()
	local prev = cache.verbs[name]
	local function encode(s)
		local function action_id(action)
			if not action then return 0 end
			for i, a in ipairs(cache.actions) do if action == a then return i end end
			table.insert(cache.actions, action)
			return #cache.actions
		end
		return string.char(
			s.OBJECT and (s.SUBJECT and 2 or 1) or 0,
			learn(s.PREFIX, PSQPREPOSITION, 0),
			learn(s.JOIN, PSQPREPOSITION, 0),
			s.OBJECT and s.OBJECT.FIND or 0,
			s.SUBJECT and s.SUBJECT.FIND or 0,
			s.OBJECT and s.OBJECT.WHERE or 0,
			s.SUBJECT and s.SUBJECT.WHERE or 0,
			action_id(s.ACTION)
		)
	end
	if prev then
		table.insert(VERBS[prev], encode(syn))
	else
		table.insert(VERBS, {encode(syn)})
		cache.verbs[name] = #VERBS
		learn(name, PSQVERB, 255-#VERBS)
	end
end

function OBJECT(object)
	assert(_G[object.NAME], object.NAME.." must be declared before definition")
	table.insert(_OBJECTS, _G[object.NAME])
	for k, v in pairs(object) do _G[object.NAME][k] = v end
	for _, adj in ipairs(object.ADJECTIVE or {}) do learn(adj, PSQADJECTIVE, 0) end
	for _, syn in ipairs(object.SYNONYM or {}) do learn(syn, PSQOBJECT, #_OBJECTS) end
end

function BUZZ(...)
	for _, buzz in ipairs {...} do
		learn(buzz, PSQBUZZ_WORD, 0)
	end
end

function SYNONYM(verb, ...)
  for _, syn in ipairs {...} do
    cache.words[syn] = cache.words[verb]
		_G['WQ'..syn:upper()] = cache.words[verb]
  end
end

ROOM = OBJECT

-- Queue / control
function QUEUE(i, turns)
  local t = {FUNC = i, TURNS = turns}
  table.insert(QUEUES, t)
  return t
end

function ENABLE(i) i.ENABLED = true end
function DISABLE(i) i.ENABLED = false end

-- === Done ===
print("ZIL runtime initialized.")
