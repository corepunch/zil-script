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
VERBS   = nil
QUEUES  = {}
ROOMS   = {}
PROPERTIES = {}
-- PREPOSITIONS: Pre-allocated array format [0]=count, [1]=word_ptr1, [2]=index1, ...
-- Maximum 128 prepositions, format: index_count, then pairs of (word_ptr, original_index)
PREPOSITIONS = {[0] = 0}  -- Initialize with count = 0
PREPOSITIONS._hash = {}   -- Helper hash for quick lookup during population
ADJECTIVES = {}
ACTIONS = {}
PREACTIONS = {}
OBJECTS = {}
FLAGS = {}
FUNCTIONS = {}
_DIRECTIONS = {}

DESCS = {}
DIRS = {}

_VTBL = {}
_OTBL = {}

T = true
CR = "\n"
PRSA = nil
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

local suggestions = {
	READBIT = "READ",
	TAKEBIT = "TAKE",
	CONTBIT = "OPEN",
	DOORBIT = "OPEN",
}

local function objects_in_room(room)
	local i = 0
	return function()
		while true do
			i = i + 1
			local o = OBJECTS[i]
			if not o then return nil end
			if i ~= ADVENTURER and o.LOC == room then return i, o end
		end
	end
end

local function connected_exits(room)
    local i, keys = 0, {}
    for d in pairs(_DIRECTIONS) do keys[#keys+1]=d end
    return function()
        while i<#keys do
            i=i+1; local d=_DIRECTIONS[keys[i]]; local pp=GETPT(room,d)
            if pp then return keys[i], pp end
        end
    end
end

local function add_items(room)
	local items = {}
	for obj in objects_in_room(room) do
		local verbs = {}
		local action = GETP(obj, PQACTION)
		local text = GETP(obj, PQTEXT) and not FSETQ(obj, READBIT)
		local item = GETP(obj, PQDESC) or ""
		if action then
			local func = FUNCTIONS[tonumber(action)]
			for k, v in pairs(_G) do if v == func then verbs = _G['_'..k] break end end
		end
		if text then table.insert(verbs, "EXAMINE") end
		local fnd = function(name, array) 
			for _, n in ipairs(array) do if n == name then return true end end
		end
		for k, v in pairs(suggestions) do
			if FSETQ(obj, _G[k]) and not fnd(v, verbs) then
				table.insert(verbs, v)
			end
		end
		local words = {}
		for word in item:gmatch("%S+") do
			table.insert(words, word:sub(1,1):upper() .. word:sub(2):lower())
		end
		table.insert(items, {table.concat(words, " "), verbs, add_items(obj)})
	end
	return items
end

local function add_exits(room)
	local exits = {}
	for d, pp in connected_exits(room) do
		if PTSIZE(pp) == 1 then
			local desc = GETP(GETB(pp, 0), PQDESC)
			if not FSETQ(GETB(pp, 0), ONBIT) then
				desc = desc .. " (pitch black)"
			end
			table.insert(exits, {d, desc})
		elseif PTSIZE(pp) == 2 then
			table.insert(exits, {d, string.format("\"%s\"", mem:string(GET(pp, 0)))})
		end
	end
	return exits
end

local function encode_fptr(n)
  return string.format("<@F:%X>", n)
end

local function decode_fptr(s)
    local hex = s:match("<@F:([A-Fa-f0-9]+)>")
    return hex and tonumber(hex, 16)
end

local function makeword(val)
	return string.char(val&0xff, (val>>8)&0xff)
end

local mem = setmetatable({size=0},{__index={
	write = function(self, buffer, pos)
		if not pos then pos = self.size + 1 end  -- Append if no pos
		local buf_len = #buffer
		for i = 1, buf_len do
			local byte = buffer:byte(i)
			if pos + i - 1 > self.size then self.size = pos + i - 1 end
			self[pos + i] = byte
		end
		return pos
	end,

	stringprop = function (self, s)
		if type(s) == 'number' then s = encode_fptr(s) end
		return makeword(self:write(makeword(#s)..s))
	end,

	write_word = function(mem, k) return mem:write(makeword(k)) end,
	writestring2 = function(mem, s) return mem:write(makeword(#s)..s) end,

	table_to_str = function(self, start, end_pos)
		local bytes = {}
		local len = end_pos - start + 1
		for i = 1, len do bytes[i] = self:byte(start + i - 1) or 0 end
		return string.char(table.unpack(bytes))
	end,

	byte = function(self, idx) return self[idx+1] end,
	word = function(self, ptr) return self:byte(ptr)|(self:byte(ptr+1)<<8) end,
	string = function(self, ptr)
		local str = self:table_to_str(ptr + 2, ptr + self:word(ptr) + 1)
		return decode_fptr(str) or str
	end,

	read = function(self, size, pos)
		if size <= 0 then return "" end
		return self:table_to_str(pos, pos + size - 1)
	end
}})

local cache = {
	verbs = {},
	words = {},
	synonyms = {},
}

local function fn(f) 
	for n, ff in ipairs(FUNCTIONS) do if f == ff then return n end end
	table.insert(FUNCTIONS, f)
	return #FUNCTIONS
end

local function register(tbl, value)
	local n = 0
	if type(value) == "string" then value = value:lower() end
	
	-- Special handling for PREPOSITIONS to maintain array format
	if tbl == PREPOSITIONS then
		if tbl._hash[value] then
			return tbl._hash[value]
		end
		-- Count existing entries in the hash
		for k, v in pairs(tbl._hash) do n = n + 1 end
		local index = n + 1
		tbl._hash[value] = index
		-- Will be filled in learn() when word_ptr is available
		return index
	end
	
	-- Original logic for other tables
	for k, v in pairs(tbl) do n = n + 1 end
	if not tbl[value] then tbl[value] = n + 1 end
	return tbl[value]
end

-- === Utility functions ===

function VERBQ(...)
	return EQUALQ(PRSA, ...)
end

function RANDOM(base)
	local value = math.random(1, base)
	-- print(value)
	return value
end

function PICK_ONE(table)
	local num = mem:word(table)/2
	-- local sel = math.random(2, num)
	local sel = RANDOM(num-1)+1
	return mem:word(table+sel*2)
	-- local table_size = mem:byte(table)
	-- return mem:word(table + RANDOM(table_size) * 2)
end

function RANDOM_ELEMENT(frob)
	return GET(frob, RANDOM(GET(frob, 0)))
end

function PROB(base)
	return RANDOM(100) <= base
end

ZPROB = PROB

-- At the top of bootstrap, add output buffer
local output_buffer = {}

local function io_write(...)
	-- Check if io_write was overridden globally (for tests)
	if _G.io_write then
		return _G.io_write(...)
	end
	-- Default: buffered mode for coroutine-based games
	for i = 1, select("#", ...) do
		table.insert(output_buffer, tostring(select(i, ...)))
	end
end

local function io_flush()
	-- Check if io_flush was overridden globally (for tests)
	if _G.io_flush then
		return _G.io_flush()
	end
	-- Default: return buffered content
	local text = table.concat(output_buffer)
	output_buffer = {}
	return text
end

function TELL(...)
	local object = false
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if v == D then object = true
		elseif object then object = false io_write(GETP(v, _G["PQDESC"]))
		elseif type(v) == "number" then io_write(mem:string(v))
		elseif v == '>' then -- skip
		else io_write(tostring(v)) end
	end
	return true
end

function PRINT(n) io_write(mem:string(n)) end
function PRINTD(ptr) io_write(GETP(ptr, _G["PQDESC"])) end
function PRINTR(ptr) io_write(GETP(ptr, _G["PQLDESC"])) end
function PRINTB(ptr)
	-- Debug: uncomment to see what's happening
	-- io_write("[PRINTB ptr=" .. tostring(ptr) .. "]")
	for word, index in pairs(cache.words) do
		if index == ptr then 
			io_write(word)
			return
		end
	end
	-- If we get here, no word was found for this pointer
	-- io_write("[NO_WORD:" .. tostring(ptr) .. "]")
end
function PRINTI(n) io_write(tostring(n)) end
function PRINTN(n) io_write(tostring(n)) end
function PRINTC(ch) io_write(string.char(ch)) end
function CRLF() io_write("\n") end

function JIGS_UP(msg)
	TELL(msg, CR)
	MOVE(WINNER, HERE)
	-- os.exit(1)
end

-- === Test Helper Functions ===
-- These functions can be called from tests to verify game state

-- Helper function to find an object by name
local function find_object_by_name(obj_name)
	-- Convert hyphens to underscores for ZIL naming convention
	obj_name = obj_name:gsub("-", "_")
	for n, o in ipairs(OBJECTS) do
		if o.NAME == obj_name then
			return n, o
		end
	end
	return nil, nil
end

-- ANSI color codes for test output
local GREEN = "\27[1;32m"
local RED = "\27[1;31m"
local RESET = "\27[0m"

local function assert_flag(obj_name, flag_name)	
	local obj_num = find_object_by_name(obj_name)
	local flag = _G[flag_name]
	assert(obj_num, "Object not found: " .. obj_name)	
	assert(flag, "Unknown flag: " .. flag_name)	
	assert(FSETQ(obj_num, flag), "Object does not have flag: " .. flag_name)
end

local function assert_no_flag(obj_name, flag_name)
	local obj_num = find_object_by_name(obj_name)
	local flag = _G[flag_name]
	assert(obj_num, "Object not found: " .. obj_name)
	assert(flag, "Unknown flag: " .. flag_name)
	assert(not FSETQ(obj_num, flag), "Object has flag (expected NOT to have): " .. flag_name)
end

local function assert_location(obj_name, location_name)
	local obj_num = find_object_by_name(obj_name)
	local loc_num = find_object_by_name(location_name)
	assert(obj_num, "Object not found: " .. obj_name)	
	assert(loc_num, "Location not found: " .. location_name)
	local actual_loc = LOC(obj_num)
	if actual_loc ~= loc_num then
		local actual_name = actual_loc and OBJECTS[actual_loc] and OBJECTS[actual_loc].NAME or tostring(actual_loc)
		error(obj_name .. " is not at the specified location: " .. location_name .. " (actually at: " .. actual_name .. ")")
	end
end

local function assert_inventory(obj_name)
	assert_location(obj_name, "ADVENTURER")
end

local function assert_lose(obj_name)
	local obj_num = find_object_by_name(obj_name)
	local loc_num = find_object_by_name("ADVENTURER")
	assert(obj_num, "Object not found: " .. obj_name)	
	assert(loc_num, "Location not found: " .. "ADVENTURER")
	assert(LOC(obj_num) ~= loc_num, obj_name .. " is still in inventory")
end

local function assert_here(location_name)
	assert_location("ADVENTURER", location_name)
end

local function assert_global(var_name)
	assert(_G[var_name], "Global variable not set: " .. var_name)
end

local function set_start_location(location_name)
	local loc_num = find_object_by_name(location_name)
	local adv_num = find_object_by_name("ADVENTURER")
	assert(loc_num, "Location not found: " .. location_name)
	assert(adv_num, "ADVENTURER not found")
	-- Update global state
	_G.HERE = loc_num
	_G.WINNER = adv_num
	-- Move the adventurer
	MOVE(adv_num, loc_num)
end

local function move_object_to_location(obj_name, location_name)
	local obj_num = find_object_by_name(obj_name)
	local loc_num = find_object_by_name(location_name)
	assert(obj_num, "Object not found: " .. obj_name)
	assert(loc_num, "Location not found: " .. location_name)
	-- Move the object to the location
	MOVE(obj_num, loc_num)
	-- Special handling for THIEF: clear INVISIBLE flag so they can be interacted with
	if obj_name:upper():gsub("-", "_") == "THIEF" and _G.INVISIBLE then
		FCLEAR(obj_num, _G.INVISIBLE)
	end
end

local test_cmds = {
	["test:flag"] = { assert_flag, 3 },
	["test:no-flag"] = { assert_no_flag, 3 },
	["test:no_flag"] = { assert_no_flag, 3 },  -- underscore version for test runner
	["test:here"] = { assert_here, 2 },
	["test:location"] = { assert_location, 3 },
	["test:take"] = { assert_inventory, 2 },
	["test:global"] = { assert_global, 2 },
	["test:lose"] = { assert_lose, 2 },
	["test:start-location"] = { set_start_location, 2 },
	["test:move"] = { move_object_to_location, 3 },
}

local routes = {
	['room-items'] = add_items,
	['room-exits'] = add_exits,
}

-- Parse test command and execute appropriate check
local function handle_test_command(cmd)
	local parts = {}
	for part in cmd:gmatch("%S+") do table.insert(parts, part) end
	local cmd_info = test_cmds[parts[1]]
	if cmd_info and #parts >= cmd_info[2] then
		return cmd_info[1](table.unpack(parts, 2))
	else
		TELL(RED, "[TEST] Unknown test command: ", cmd, RESET, CR)
	end
end

-- Modified READ to yield with output
function READ(inbuf, parse)
	-- Yield with accumulated output, get input back
	local s = coroutine.yield(io_flush())
	::restart_read::
	if routes[s] then
		s = coroutine.yield(routes[s](HERE))
		goto restart_read
	end
	-- Handle test commands (starting with "test:")
	if s and s:match("^test:") then
		local ok, err = pcall(handle_test_command, s)
		io_flush()
		s = coroutine.yield(not ok and err or nil)
		goto restart_read
	end
	-- Handle nil input (e.g., EOF)
	if not s then
		os.exit(0)
	end
	
	local p = {}
	for pos, word in s:gmatch("()(%S+)") do
		local index = cache.words[word:lower()] or 0
		table.insert(p, makeword(index).. string.char(#word, pos&0xff))
	end
	mem:write(s: lower()..'\0', inbuf+1)
	mem:write(string.char(#p)..table.concat(p), parse+1)
end

-- Logic / bitwise
function NOT(a) return not a or a == 0 end
function PASS(a) return a end
function BAND(a, b) return a & b end
function BOR(a, b) return a | b end
function BTST(a, b) return (a & b) == b end

-- Arithmetic / comparison
function EQUALQ(a, ...) 
	for i = 1, select("#", ...) do
    if (a or 0) == (select(i, ...) or 0) then return true end
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
function ADD(a, b) return (a or 0) + (b or 0) end
function SUB(a, b) return (a or 0) - (b or 0) end
function DIV(a, b) return (a or 0) // (b or 0) end
function MUL(a, b) return (a or 0) * (b or 0) end

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
	local function upper2(word)
		local specials = {
			["."] = "PERIOD",
			[","] = "COMMA",
			["\""] = "QUOTE",
		}
		return specials[word] or word:upper()
	end
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
		local ent = mem:read(7, cache.words[word])
		local new = string.char(0,0,0,0,ent:byte(5)|atom,ent:byte(6),value or OQANY)
		mem:write(new, index)
	else
		local enc = string.char(0,0,0,0,atom|prim[atom],value or OQANY,0)
		local pos = mem:write(enc)
		cache.words[word] = pos
		_G['WQ'..upper2(word)] = enc
	end
	for _, syn in ipairs(cache.synonyms[word] or {}) do
		mem:write(mem:read(8, cache.words[word]), cache.words[syn:lower()])
	end
	
	-- Special handling for PREPOSITIONS: populate array format immediately
	if atom == PSQPREPOSITION and value and type(value) == 'number' then
		local word_ptr = cache.words[word]
		if word_ptr and PREPOSITIONS._hash[word] then
			-- Add to array format: [0]=count, [1]=word_ptr1, [2]=index1, [3]=word_ptr2, [4]=index2, ...
			local count = PREPOSITIONS[0]
			PREPOSITIONS[count * 2 + 1] = word_ptr
			PREPOSITIONS[count * 2 + 2] = value
			PREPOSITIONS[0] = count + 1
		end
	end
	
	return value or cache.words[word]
end

function FSET(obj, flag) getobj(obj).FLAGS = (getobj(obj).FLAGS or 0) | (1<<flag) end
function FCLEAR(obj, flag) getobj(obj).FLAGS = (getobj(obj).FLAGS or 0) & ~(1<<flag) end
function FSETQ(obj, flag) return getobj(obj).FLAGS and (getobj(obj).FLAGS & (1<<flag)) ~= 0 end
function GETPT(obj, prop)
	local tbl = getobj(obj).tbl
	local l = mem:byte(tbl)+tbl+1
	local pname, psize = mem:byte(l), mem:byte(l+1)
	local header = 2
	while psize > 0 do
		if pname==prop then return l+header end
		l = l+psize+header
		pname, psize = mem:byte(l), mem:byte(l+1)
	end
end
function PTSIZE(ptr)
	return mem:byte(ptr-1)
end
function PUTP(obj, prop, val)
	local ptr = GETPT(obj, prop)
	if type(val) == 'string' then
		assert(PTSIZE(ptr) == 2, "String property "..prop.." size must be 2")
		mem:write(mem:stringprop(val), ptr)
		return
	elseif type(val) == 'function' then
		assert(PTSIZE(ptr) == 2, "Function property "..prop.." size must be 2")
		mem:write(mem:stringprop(fn(val)), ptr)
	end
	assert(type(val) == 'number', "Only numbers are supported in PUTP, not "..type(val))
	assert(PTSIZE(ptr) == 1, "Number property "..prop.." size must be 1 for value "..val)
	mem:write(string.char(math.min(math.max(0,val),0xff)), ptr)
end
function GETP(obj, prop)
	if not GETPT(obj, prop) then return nil end
	local ptr = GETPT(obj, prop)
	local ptsize = PTSIZE(ptr)
	if ptsize == 1 then return mem:byte(ptr) end
	if ptsize == 2 then return mem:word(ptr) ~= 0 and mem:string(mem:word(ptr)) or nil end
	assert(false, "Unsupported property to get")
end
function NEXTP(obj, prop)
	-- Returns the next property number after prop
	-- If prop is 0, returns the first property
	-- If no more properties, returns 0
	local tbl = getobj(obj).tbl
	local l = mem:byte(tbl)+tbl+1
	local pname, psize = mem:byte(l), mem:byte(l+1)
	local header = 2
	local found = (prop == 0)  -- If prop is 0, return first property
	while psize > 0 do
		if found then
			-- Return this property (the next one after prop)
			return pname
		end
		if pname == prop then
			-- Found the requested property, next iteration will return the next one
			found = true
		end
		l = l+psize+header
		pname, psize = mem:byte(l), mem:byte(l+1)
	end
	return 0  -- No more properties
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

function OBJECT(object)
	local function findobj(name)
		for n, o in ipairs(OBJECTS) do
			if o.NAME == name then return o, n end
		end
	end
	local function makeprop(body, name)
		local num = register(PROPERTIES, name)
		if not _G["PQ"..name] then _G["PQ"..name] = num end
		return string.char(num,#body)..body
	end
	if object.DESC then
		table.insert(DESCS, object.DESC)
		table.insert(DESCS, object.DESC:lower())
	end
	local o, n = findobj(object.NAME)
	local t = {string.char(#object.NAME), object.NAME}
	assert(o, "Can't find object "..object.NAME)
	for k, v in pairs(object) do
		if k == "NAME" then 
		elseif k == "SYNONYM" then
			local body = table.concat2(v, function(syn)
				return makeword(learn(syn, PSQOBJECT, nil))
			end)
			table.insert(t, makeprop(body, k))
		elseif k == "ADJECTIVE" then
			table.insert(t, makeprop(table.concat2(v, function(adj)
				return string.char(learn(adj, PSQADJECTIVE, ADJECTIVES))
			end), k))
		elseif k == "FLAGS" then
			for _, f in ipairs(v) do
				if not _G[f] then _G[f] = register(FLAGS, f) end
				o.FLAGS = o.FLAGS | (1 << _G[f])
			end
		elseif k == "GLOBAL" then table.insert(t, makeprop(table.concat2(v, string.char), k))
		elseif k == "LOC" then o.LOC = v
		-- using PQACTION for ACTION property, commented out original function support
		elseif k == "ACTION" or k == "DESCFCN" then 
			table.insert(t, makeprop(type(v) == 'function' and mem:stringprop(fn(v)) or '\0\0', k))
		elseif type(v) == 'string' then table.insert(t, makeprop(mem:stringprop(v), k))
		elseif type(v) == 'number' then table.insert(t, makeprop(string.char(math.min(v,0xff)), k))
		elseif type(v) == 'function' then table.insert(t, makeprop(mem:stringprop(fn(v)), k))
		elseif _DIRECTIONS[k] then			
			local str
			if v.per then
				str = makeword(fn(v.per))..string.char(0) -- FEXIT = 3
			elseif type(v[1]) == 'string' then
				str = mem:write(v[1].."\0") -- NEXIT = 2
			else
				str = string.char(v[1]) -- UEXIT = 1
				local say = v.say and mem:write(v.say.."\0") or 0
				if v.door then
					str = str..string.char(v.door)..makeword(say)..string.char(0) -- DEXIT = 5
				elseif v.flag then
					str = str..string.char(v.flag)..makeword(say) -- CEXIT = 4
				end
			end
			table.insert(t, makeprop(str, k))
		else 
			assert(false, "Unsupported property "..k.." of type "..type(v))
		end
	end
	table.insert(t, string.char(0,0))
	o.tbl = mem:write(table.concat(t))
end

function REST(s, i)
	if type(s) == 'number' then
		return s+(i or 1)
	end
	if type(s) == 'table' then s = string.char(#s)..table.concat(s) end
	return s:sub((i or 1) + 1)
end

function APPLY(func, ...)
	if type(func) == 'number' then
		if func == 0 then return end
		return FUNCTIONS[func](...)
	else
		return func and func(...)
	end
end

function PUT(obj, i, val)
	assert(type(obj) == 'number', "PUT: Only number types, not "..type(obj))
	mem:write(makeword(type(val) == 'function' and fn(val) or val or 0), obj+i*2)
end

function PUTB(s, i, val) 
	assert(type(s) == 'number', "PUTB: Only number types, not "..type(s))
	mem:write(string.char(math.min(val,0xff)), s+i)
end
-- function GET(t, i) return type(t) == 'table' and t[i * 2] or 0 end
-- function GETB(t, i) return type(t) == 'table' and t[i] or 0 end

function GETB(s, i)
	assert(type(s) == 'number', "GETB: Only number types")
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
		if not GETB(s,i*2) then print("First argument NULL in GET at",i,": ", debug.traceback()) end
		if not GETB(s,i*2+1) then print("Second argument NULL in GET at",i,": ", debug.traceback()) end
		return GETB(s,i*2)|(GETB(s,i*2+1)<<8)
	end
	assert(type(s) == 'table', "GET requires a table")
	return i == 0 and #s or s[i]
	-- if type(s) == 'table' then return s.index and s:index(i) or s[i] end
	-- return GETB(s, i * 2) | (GETB(s, i * 2 + 1) << 8)
end

function DIRECTIONS(...)
	for _, dir in ipairs {...} do
		_DIRECTIONS[dir] = learn(dir, PSQDIRECTION, PROPERTIES)
		if dir ~= "IN" and dir ~= "OUT" then
			table.insert(DIRS, dir:lower())
		end
	end
end

local function action_id(ACTIONS, action)
	for i, a in ipairs(ACTIONS) do if action == a then return i end end
	table.insert(ACTIONS, action)
	return #ACTIONS
end

function TRACEBACK()
	print(debug.traceback())
end

function PTABLE(tbl, size)
	local out = {}
	for i = 0, size do table.insert(out, GET(tbl, i)) end
	print(table.concat(out, " "))
end

function SYNTAX(syn)
	VERBS = VERBS or mem:write(string.rep('\0\0', 256))
	local name = syn.VERB:lower()
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
	if cache.verbs[name] then
		local ptr = GET(VERBS, cache.verbs[name])
		local num = GETB(ptr, 0)
		local bytecode = encode(syn)
		mem:write(string.char(num + 1), ptr)
		mem:write(bytecode, ptr + 1 + num * #bytecode)
	else
		local num = register(cache.verbs, name)
		local bytecode = string.rep(encode(syn), _G["NUM_"..syn.VERB] or 1)
		PUT(VERBS, num, mem:write(string.char(1)..bytecode))
		_G['ACTQ'..syn.VERB] = learn(name, PSQVERB, 255-num)
	end
	_G[syn.ACTION:gsub("_", "Q", 1)] = action
	if syn.PREACTION then 
		PREACTIONS[action] = fn(_G[syn.PREACTION]) 
	end
end

function BUZZ(...)
	for _, buzz in ipairs {...} do
		learn(buzz, PSQBUZZ_WORD, nil)
		_G['WQ'..buzz:upper()] = cache.words[buzz:lower()]
	end
end

function SYNONYM(verb, ...)
	verb = verb:lower()
	cache.synonyms[verb] = {...}
  for _, syn in ipairs {...} do
		if cache.words[verb] then
			cache.words[syn:lower()] = mem:write(mem:read(8, cache.words[verb]))
		else
			cache.words[syn:lower()] = mem:write(string.rep('\0', 8))
		end
		_G['WQ'..syn:upper()] = cache.words[syn:lower()]
  end
end

ROOM = OBJECT

function ITABLE(size)
	local address = mem:write_word(size)
	mem:write(string.rep("\0", size))
	return address
end

function TABLE(...)
	local tbl = {}
	for i = 1, select("#", ...) do
    local v = select(i, ...)
		if type(v) == 'string' then table.insert(tbl, makeword(mem:writestring2(v)))
		elseif type(v) == 'number' then table.insert(tbl, makeword(v))
		elseif type(v) == 'nil' then table.insert(tbl, makeword(0))
		else error("LTABLE: Unsupported type "..type(v))
		end
	end
	return mem:write(table.concat(tbl))
end

function LTABLE(...)
	local tbl = {}
	for i = 1, select("#", ...) do
    local v = select(i, ...)
		if type(v) == 'string' then table.insert(tbl, makeword(mem:writestring2(v)))
		elseif type(v) == 'number' then table.insert(tbl, makeword(v))
		elseif type(v) == 'nil' then table.insert(tbl, makeword(0))
		else error("LTABLE: Unsupported type "..type(v))
		end
	end
	local address = mem:write_word((#{...}))
	mem:write(table.concat(tbl))
	return address
end

BUZZ(".", ",", "\"")


-- ENABLE/DISABLE helpers for clock interrupts
-- These are defined as macros in ZIL (macros.zil) but we implement them as functions
-- ENABLE: <DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>
-- DISABLE: <DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>
function ENABLE(i)
    PUT(i, C_ENABLEDQ, 1)
    return i
end

function DISABLE(i)
    PUT(i, C_ENABLEDQ, 0)
    return i
end

function FLAMINGQ(OBJ)
	return FSETQ(OBJ, FLAMEBIT) and FSETQ(OBJ, ONBIT)
end

function OPENABLEQ(OBJ)
		return FSETQ(OBJ, DOORBIT) or FSETQ(OBJ, CONTBIT)
end

function CO_CREATE(func)
	local co = coroutine.create(func)
	coroutine.resume(co)  -- Start the coroutine
	return co
end

 -- if only_flag is true, return only success flag, for chaining of arguments
function CO_RESUME(co, param, only_flag)
	local ok, err = coroutine.resume(co, param)
	if only_flag then
		return ok
	else
		return ok, err
	end
end

-- === Finalize PREPOSITIONS table ===
-- REMOVED: PREPOSITIONS now uses pre-allocated array format that's populated during learn()
-- The array format [0]=count, [1]=word_ptr1, [2]=index1, ... is built incrementally
-- function FINALIZE_PREPOSITIONS()
-- 	-- Guard against being called multiple times
-- 	if PREPOSITIONS[0] ~= nil then
-- 		return  -- Already finalized
-- 	end
-- 	
-- 	-- Build array format: [0]=count, [1]=word_ptr1, [2]=index1, [3]=word_ptr2, [4]=index2, ...
-- 	local temp = {}
-- 	for word, index in pairs(PREPOSITIONS) do
-- 		if type(word) == "string" then
-- 			temp[index] = word
-- 		end
-- 	end
-- 	
-- 	-- Convert to array format, counting only successfully added entries
-- 	local array = {}
-- 	local count = 0
-- 	for index, word in ipairs(temp) do
-- 		local word_ptr = cache.words[word]
-- 		if word_ptr then
-- 			count = count + 1
-- 			array[count * 2 - 1] = word_ptr  -- word pointer at odd indices
-- 			array[count * 2] = index          -- index at even indices
-- 		end
-- 	end
-- 	
-- 	array[0] = count  -- Store actual count at index 0
-- 	
-- 	-- Replace PREPOSITIONS with the array
-- 	PREPOSITIONS = array
-- end

-- === File Inclusion ===
-- INSERT_FILE loads and executes a ZIL file
-- This is used by INSERT-FILE directive to include other files
function INSERT_FILE(filename)
	-- Convert module-style filename (e.g., "zork1.globals") to file path
	local name_path = filename:gsub("%.", "/")
	local file, filepath
	
	-- Search for the file using package.zilpath if available
	if package and package.zilpath then
		for path_pattern in package.zilpath:gmatch("[^;]+") do
			filepath = path_pattern:gsub("?", name_path)
			file = io.open(filepath, "r")
			if file then
				break
			end
		end
	end
	
	-- If not found, try direct path with .zil extension
	if not file then
		filepath = name_path .. ".zil"
		file = io.open(filepath, "r")
	end
	
	-- If still not found, try the filename as-is
	if not file then
		filepath = filename
		file = io.open(filepath, "r")
	end
	
	if not file then
		error(string.format("INSERT_FILE: Cannot open file '%s' (tried package.zilpath and direct paths)", filename))
	end
	
	local content = file:read("*all")
	file:close()
	
	-- Parse and compile the ZIL content
	local parser = require 'zilscript.parser'
	local compiler = require 'zilscript.compiler'
	
	local ok, ast = pcall(parser.parse, content, filename)
	if not ok then
		error(string.format("INSERT_FILE: Failed to parse '%s': %s", filename, ast))
	end
	
	local result = compiler.compile(ast, filename .. ".lua")
	
	-- Execute the compiled code in the current environment
	local chunk, load_err = load(result.combined, "@" .. filename  .. '.zil', "t", _G)
	if not chunk then
		error(string.format("INSERT_FILE: Failed to load '%s': %s", filename, load_err))
	end
	
	local exec_ok, exec_err = pcall(chunk)
	if not exec_ok then
		error(string.format("INSERT_FILE: Failed to execute '%s': %s", filename, exec_err))
	end
end

-- === Done ===
print("ZIL runtime initialized.")
