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

D = 0xBAADF00D

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
PROPERTIES = {}
PREPOSITIONS = {}
ADJECTIVES = {}
ACTIONS = {}
PREACTIONS = {}
OBJECTS = {}
FLAGS = {}
FUNCTIONS = {}
_DIRECTIONS = {}

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

local mem = ""

local cache = {
	verbs = {},
	words = {},
}

local function fn(f) 
	for n, ff in ipairs(FUNCTIONS) do if f == ff then return n end end
	table.insert(FUNCTIONS, f)
	return #FUNCTIONS
end

local function register(tbl, value)
	local n = 0
	if type(value) == "string" then value = value:lower() end
	for k, v in pairs(tbl) do n = n + 1 end
	if not tbl[value] then tbl[value] = n + 1 end
	return tbl[value]
end

local function tohex(s)
    local t = {}
    for i = 1, #s do
        t[#t+1] = string.format("%02X", s:byte(i))
    end
    return table.concat(t, " ")
end

local function writemem(buffer, pos)
	if pos then
		mem = mem:sub(1,pos-1)..buffer..mem:sub(pos+#buffer)
		return pos
	else
		local idx = #mem
		mem = mem..buffer
		return idx+1
	end
end

local function encode_fptr(n)
  return string.format("<@F:%X>", n)
end

local function decode_fptr(s)
    local hex = s:match("<@F:([A-Fa-f0-9]+)>")
    return hex and tonumber(hex, 16)
end

local function writestring(str)
	if type(str) == 'number' then str = encode_fptr(str) end
	local len = #str
	local ptr = writemem(string.char(len&0xff)..string.char((len>>8)&0xff)..str)
	return string.char(ptr&0xff, (ptr>>8)&0xff)
end

local function readstring(ptr)
	local len = mem:byte(ptr)|(mem:byte(ptr+1)<<8)
	local str = mem:sub(ptr+2, ptr+len+1)
	return decode_fptr(str) or str
end

local function readmem(size, pos)
	return mem:sub(pos,pos+size-1)
end

-- === Utility functions ===

function VERBQ(...)
	return EQUALQ(VERB, ...)
end

function TELL(...)
	local object = false
	for i = 1, select("#", ...) do
    local v = select(i, ...)
		if v == "You can't go there without a vehicle." then print(debug.traceback()) end
		if v == D then object = true
		elseif object then
			object = false
			io.write(GETP(v, _G["PQDESC"]))
    else io.write(tostring(v)) end
  end
end

function PRINT(str) print(str) end
PRINTI = PRINT
PRINTB = PRINT
PRINTN = PRINT
function PRINTC(ch) io.write(string.char(ch)) end
function CRLF() print() end

-- Logic / bitwise
function NOT(a) return not a or a == 0 end
function PASS(a) return a end
function BAND(a, b) return a & b end
function BOR(a, b) return a | b end
function BTST(a, b) return (a & b) == b end

-- Arithmetic / comparison
function EQUALQ(a, ...) 
	for i = 1, select("#", ...) do
    if a == select(i, ...) then return true end
  end
  return false
end
function NEQUALQ(a, b) return (a or 0) ~= (b or 0) end
function GQ(a, b) return (a or 0) > (b or 0) end
function LQ(a, b) return (a or 0) < (b or 0) end
function GEQ(a, b) return (a or 0) >= (b or 0) end
function LEQ(a, b) return (a or 0) <= (b or 0) end
function ZEROQ(a) return (a or 0) == 0 end
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
local function getobj(num) return OBJECTS[num] end

function LOC(obj) return getobj(obj).LOC end
function INQ(obj, room) return getobj(obj).LOC == room end
function MOVE(obj, dest) getobj(obj).LOC = dest end
function REMOVE(obj) getobj(obj).LOC = nil end

function FIRSTQ(obj)
	for n, o in ipairs(OBJECTS) do
		if o.LOC == obj then return n end
	end
end

function NEXTQ(obj)
  local parent = getobj(obj).LOC
  local found = false
  for n, o in ipairs(OBJECTS) do
    if o.LOC == parent then
      if found then return n end
      if n == obj then found = true end
    end
  end
end

local function learn(word, atom, value)
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
	if type(value) == 'table' then value = register(value, word) end
	if cache.words[word] then
		local index = cache.words[word]
		local ent = readmem(7, cache.words[word])
		local new = string.char(0,0,0,0,ent:byte(5)|atom,ent:byte(6),value or OQANY)
		writemem(new, index)
	else
		local enc = string.char(0,0,0,0,atom|prim[atom],value or OQANY,0)
		local pos = writemem(enc)
		cache.words[word] = pos
		_G['WQ'..string.upper(word)] = enc
	end
	return value or cache.words[word]
end

function FSET(obj, flag) getobj(obj).FLAGS = (getobj(obj).FLAGS or 0) | (1<<flag) end
function FCLEAR(obj, flag) getobj(obj).FLAGS = (getobj(obj).FLAGS or 0) & ~(1<<flag) end
function FSETQ(obj, flag) return getobj(obj).FLAGS and (getobj(obj).FLAGS & (1<<flag)) ~= 0 end
function GETPT(obj, prop)
	local tbl = getobj(obj).tbl
	local l = mem:byte(tbl)+tbl+1
	local p = mem:byte(l)
	while p > 0 do
		if (p&31)==prop then return l+1 end
		l = l+(p>>5)+2
		p = mem:byte(l)
	end
end
function PTSIZE(ptr)
	return (mem:byte(ptr-1)>>5)+1
end
function PUTP(obj, prop, val)
	local ptr = GETPT(obj, prop)
	assert(type(val) == 'number', "Only numbers are supported in PUTP")
	assert(PTSIZE(ptr) == 1, "Number size must be 1")
	writemem(string.char(val), ptr)
end
function GETP(obj, prop)
	if not GETPT(obj, prop) then return nil end
	local ptr = GETPT(obj, prop)
	local ptsize = PTSIZE(ptr)
	if ptsize == 1 then return mem:byte(ptr) end
	if ptsize == 2 then return readstring(mem:byte(ptr)|(mem:byte(ptr+1)<<8)) end
	assert(false, "Unsupported property to get")
end

table.concat2 = function(t, fn)
	local tmp = {}
	for i, s in ipairs(t) do tmp[i] = fn(s) end
	return table.concat(tmp)
end

function DECL_OBJECT(name)
	table.insert(OBJECTS, {NAME=name,FLAGS=0})
	return #OBJECTS
end

local function makeword(val)
	return string.char(val&0xff, (val>>8)&0xff)
end

function OBJECT(object)
	local function findobj(name)
		for _, o in ipairs(OBJECTS) do
			if o.NAME == name then return o end
		end
	end
	local function makeprop(body, name)
		local num = register(PROPERTIES, name)
		if not _G["PQ"..name] then _G["PQ"..name] = num end
		return string.char(num|((#body-1)<<5))..body
	end
	local o = findobj(object.NAME)
	local t = {string.char(#object.NAME), object.NAME}
	assert(o, "Can't find object "..object.NAME)
	for k, v in pairs(object) do
		if k == "SYNONYM" then
			local body = table.concat2(v, function(syn)
				return makeword(learn(syn, PSQOBJECT, nil))
			end)
			table.insert(t, makeprop(body, k))
		elseif k == "ADJECTIVE" then
			local body = table.concat2(v, function(adj)
				return string.char(learn(adj, PSQADJECTIVE, ADJECTIVES))
			end)
			table.insert(t, makeprop(body, k))
		elseif k == "FLAGS" then
			for _, f in ipairs(v) do
				if not _G[f] then _G[f] = register(FLAGS, f) end
				o.FLAGS = o.FLAGS | (1 << _G[f])
			end
		elseif k == "LOC" then o.LOC = v
		elseif type(v) == 'string' then table.insert(t, makeprop(writestring(v), k))
		elseif type(v) == 'number' then table.insert(t, makeprop(string.char(v&0xff), k))
		elseif type(v) == 'function' then table.insert(t, makeprop(writestring(fn(v)), k))
		elseif _DIRECTIONS[k] then
			local str = string.char(v[1])
			local say = v.say and writemem(v.say.."\0") or makeword(0)
			if v.door then
				str = str..string.char(v.door)..say..string.char(0)
			elseif v.flag then
				str = str..string.char(v.flag)..say
			end
			table.insert(t, makeprop(str, k))
		else 
			assert(false, "Unsupported property "..k.." of type "..type(v))
		end
	end
	table.insert(t, string.char(0))
	o.tbl = writemem(table.concat(t))
end

function REST(s, i)
	if type(s) == 'number' then
		return s+(i or 1)
	end
	if type(s) == 'table' then s = string.char(#s)..table.concat(s) end
	return s:sub((i or 1) + 1)
end

function APPLY(func, ...)
	if type(func)=='number' then
		if func == 0 then return end
		FUNCTIONS[func](...)
	else
		return func and func(...)
	end
end

function PUT(obj, i, val)
	i = i * 2
	if type(obj) == 'number' then
		local code = string.char(i&0xff, (i>>8)&0xff)
		writemem(code, i)
	else
		obj[i] = val
	end
end
function PUTB(obj, i, val) 
	if type(obj) == 'number' then
		local code = string.char(i&0xff)
		writemem(code, i)
	else
		obj[i] = val
	end
end
-- function GET(t, i) return type(t) == 'table' and t[i * 2] or 0 end
-- function GETB(t, i) return type(t) == 'table' and t[i] or 0 end

function GETB(s, i)
	assert(type(s) == 'number')
	if s == 0 then return GET(s) end
	return mem:byte(s+i)
	-- if s == 0 then return GET(s)
	-- elseif type(s) == 'string' then return i==0 and #i or s:byte(i)
	-- elseif type(s) == 'table' then return i==0 and #s or table.concat(s):byte(i)
	-- elseif type(s) == 'number' then return mem:byte(s+i)
	-- else 
	-- 	error("GETB: Unsupported type "..type(s))
	-- end
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
	if not i then return 0 end
	if type(s) == 'number' then
		return GETB(s,i*2)|(GETB(s,i*2+1)<<8)
	end
	assert(type(s) == 'table', "GET requires a table")
	return i == 0 and #s or s[i]
	-- if type(s) == 'table' then return s.index and s:index(i) or s[i] end
	-- return GETB(s, i * 2) | (GETB(s, i * 2 + 1) << 8)
end

local buf = true

function READ(inbuf, parse)
	if not buf then os.exit(0) end
	local s = "open mailbox"
	-- local s = io.read()
	local p = {}
	for pos, word in s:gmatch("()(%S+)") do
		local index = cache.words[word:lower()] or 0
		table.insert(p, string.char(index&0xff, index>>8, #word, pos))
	end
	writemem(s:lower()..'\0', inbuf+1)
	writemem(string.char(#p)..table.concat(p), parse+1)
	buf = false
end

function DIRECTIONS(...)
	for _, dir in ipairs {...} do
		_DIRECTIONS[dir] = learn(dir, PSQDIRECTION, PROPERTIES)
	end
end

local function action_id(ACTIONS, action)
	for i, a in ipairs(ACTIONS) do if action == a then return i end end
	table.insert(ACTIONS, action)
	return #ACTIONS
end

function SYNTAX(syn)
	local name = syn.VERB:lower()
	local prev = cache.verbs[name]
	local action = action_id(ACTIONS, fn(_G[syn.ACTION]))
	local function encode(s)
		return string.char(
			s.OBJECT and (s.SUBJECT and 2 or 1) or 0,
			learn(s.PREFIX, PSQPREPOSITION, PREPOSITIONS),
			learn(s.JOIN, PSQPREPOSITION, PREPOSITIONS),
			s.OBJECT and s.OBJECT.FIND or 0,
			s.SUBJECT and s.SUBJECT.FIND or 0,
			s.OBJECT and s.OBJECT.WHERE or 0,
			s.SUBJECT and s.SUBJECT.WHERE or 0,
			action
		)
	end
	if prev then
		table.insert(VERBS[prev], encode(syn))
	else
		table.insert(VERBS, {encode(syn)})
		cache.verbs[name] = #VERBS
		_G['ACTQ'..syn.VERB] = learn(name, PSQVERB, 255-#VERBS)
	end
	_G[syn.ACTION:gsub("_", "Q", 1)] = action
	if syn.PREACTION then PREACTIONS[action] = fn(_G[syn.PREACTION]) end
end

function BUZZ(...)
	for _, buzz in ipairs {...} do
		learn(buzz, PSQBUZZ_WORD, nil)
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

local function write_word(k)
	return writemem(string.char(k&0xff,(k>>8)&0xff))
end

local function write_string(k)
	local address = write_word(#mem)
	mem = mem..k
	return address
end

function ITABLE(size)
	local address = write_word(size)
	writemem(string.rep("\0", size))
	return address
end

function LTABLE(...)
	local tbl = {}
	for _, v in ipairs {...} do
		if type(v) == 'string' then table.insert(tbl, makeword(write_string(v)))
		elseif type(v) == 'number' then table.insert(tbl, makeword(v))
		else error("LTABLE: Unsupported type")
		end
	end
	local address = write_word((#{...})*2)
	writemem(table.concat(tbl))
	return address
end

function CLOCKER()

end
-- function TABLE(...)
-- 	local contents = {}
-- 	for _, k in ipairs {...} do
-- 		if type(k) == 'string' then
-- 			table.insert(contents, write_string(k))
-- 		elseif type(k) == "number" then
-- 			table.insert(contents, k)
-- 		else
-- 			print(debug.traceback())
-- 			error("Can't use type "..type(k).." in table")
-- 		end
-- 	end
-- 	local address = #mem + 1
-- 	for _, k in ipairs(contents) do
-- 		write_word(k)
-- 	end
-- 	return address
-- end

-- LTABLE = TABLE

-- === Done ===
print("ZIL runtime initialized.")
