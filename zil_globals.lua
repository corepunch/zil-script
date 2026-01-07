GLOBAL_OBJECTS = DECL_OBJECT("GLOBAL_OBJECTS")
LOCAL_GLOBALS = DECL_OBJECT("LOCAL_GLOBALS")
ROOMS = DECL_OBJECT("ROOMS")
INTNUM = DECL_OBJECT("INTNUM")
PSEUDO_OBJECT = DECL_OBJECT("PSEUDO_OBJECT")
IT = DECL_OBJECT("IT")
NOT_HERE_OBJECT = DECL_OBJECT("NOT_HERE_OBJECT")
BLESSINGS = DECL_OBJECT("BLESSINGS")
STAIRS = DECL_OBJECT("STAIRS")
SAILOR = DECL_OBJECT("SAILOR")
GROUND = DECL_OBJECT("GROUND")
GRUE = DECL_OBJECT("GRUE")
LUNGS = DECL_OBJECT("LUNGS")
ME = DECL_OBJECT("ME")
ADVENTURER = DECL_OBJECT("ADVENTURER")
PATHOBJ = DECL_OBJECT("PATHOBJ")
ZORKMID = DECL_OBJECT("ZORKMID")
HANDS = DECL_OBJECT("HANDS")

OBJECT {
	NAME = "GLOBAL_OBJECTS",
	FLAGS = {"RMUNGBIT","INVISIBLE","TOUCHBIT","SURFACEBIT","TRYTAKEBIT","OPENBIT","SEARCHBIT","TRANSBIT","ONBIT","RLANDBIT","FIGHTBIT","STAGGERED","WEARBIT"},
}
OBJECT {
	NAME = "LOCAL_GLOBALS",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"ZZMGCK"},
	DESCFCN = PATH_OBJECT,
	GLOBAL = GLOBAL_OBJECTS,
	ADVFCN = 0,
	FDESC = "F",
	LDESC = "F",
	PSEUDO = "FOOBAR",
	CONTFCN = 0,
	VTYPE = 1,
	SIZE = 0,
	CAPACITY = 0,
}
OBJECT {
	NAME = "ROOMS",
	IN = ROOMS,
}
OBJECT {
	NAME = "INTNUM",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"INTNUM"},
	FLAGS = {"TOOLBIT"},
	DESC = "number",
}
OBJECT {
	NAME = "PSEUDO_OBJECT",
	LOC = LOCAL_GLOBALS,
	DESC = "pseudo",
	ACTION = CRETIN_FCN,
}
OBJECT {
	NAME = "IT",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"IT","THEM","HER","HIM"},
	DESC = "random object",
	FLAGS = {"NDESCBIT","TOUCHBIT"},
}
OBJECT {
	NAME = "NOT_HERE_OBJECT",
	DESC = "such thing",
	ACTION = NOT_HERE_OBJECT_F,
}
NOT_HERE_OBJECT_F = function(...)
	local TBL
  local PRSOQ = T
	local OBJ
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(EQUALQ(PRSO, NOT_HERE_OBJECT) and EQUALQ(PRSI, NOT_HERE_OBJECT)) return __tmp end) then 
    	__tmp = TELL("Those things aren't here!", CR)
    	error(true)
  elseif APPLY(function() __tmp = EQUALQ(PRSO, NOT_HERE_OBJECT) return __tmp end) then 
    	__tmp = APPLY(function() TBL = P_PRSO return TBL end)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = APPLY(function() TBL = P_PRSI return TBL end)
    	__tmp = APPLY(function() PRSOQ = nil return PRSOQ end)
  end

	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)

  if APPLY(function() __tmp = EQUALQ(WINNER, PLAYER) return __tmp end) then 
    	__tmp = TELL("You can't see any ")
    	__tmp = NOT_HERE_PRINT(PRSOQ)
    	__tmp = TELL(" here!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("The ", D, WINNER, " seems confused. \"I don't see any ")
    	__tmp = NOT_HERE_PRINT(PRSOQ)
    	__tmp = TELL(" here!\"", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NOT_HERE_OBJECT_F\n'..__res) end
end
_NOT_HERE_OBJECT_F = {
}
NOT_HERE_PRINT = function(...)
	local PRSOQ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = P_OFLAG return __tmp end) then 
    
    if APPLY(function() __tmp = P_XADJ return __tmp end) then 
      	__tmp = PRINTB(P_XADJN)
    end

    
    if APPLY(function() __tmp = P_XNAM return __tmp end) then 
      	__tmp = PRINTB(P_XNAM)
    end

  elseif APPLY(function() __tmp = PRSOQ return __tmp end) then 
    	__tmp = BUFFER_PRINT(GET(P_ITBL, P_NC1), GET(P_ITBL, P_NC1L), nil)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = BUFFER_PRINT(GET(P_ITBL, P_NC2), GET(P_ITBL, P_NC2L), nil)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NOT_HERE_PRINT\n'..__res) end
end
_NOT_HERE_PRINT = {
}
NULL_F = function(...)
	local A1, A2 = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	error(false)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NULL_F\n'..__res) end
end
_NULL_F = {
}
LOAD_MAX = 100
LOAD_ALLOWED = 100
OBJECT {
	NAME = "BLESSINGS",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"BLESSINGS","GRACES"},
	DESC = "blessings",
	FLAGS = {"NDESCBIT"},
}
OBJECT {
	NAME = "STAIRS",
	LOC = LOCAL_GLOBALS,
	SYNONYM = {"STAIRS","STEPS","STAIRCASE","STAIRWAY"},
	ADJECTIVE = {"STONE","DARK","MARBLE","FORBIDDING","STEEP"},
	DESC = "stairs",
	FLAGS = {"NDESCBIT","CLIMBBIT"},
	ACTION = STAIRS_F,
}
STAIRS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(THROUGH) return __tmp end) then 
    	__tmp = TELL("You should say whether you want to go up or down.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STAIRS_F\n'..__res) end
end
_STAIRS_F = {
	'THROUGH',
}
OBJECT {
	NAME = "SAILOR",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"SAILOR","FOOTPAD","AVIATOR"},
	DESC = "sailor",
	FLAGS = {"NDESCBIT"},
	ACTION = SAILOR_FCN,
}
SAILOR_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(TELL) return __tmp end) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    	__tmp = TELL("You can't talk to the sailor that way.", CR)
  elseif APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    
    	__tmp = TELL("There is no sailor to be seen.", CR)
  elseif APPLY(function() __tmp = VERBQ(HELLO) return __tmp end) then 
    	__tmp = APPLY(function() HS = ADD(HS, 1) return HS end)
    
    if APPLY(function() __tmp = ZEROQ(MOD(HS, 20)) return __tmp end) then 
      	__tmp = TELL("You seem to be repeating yourself.", CR)
    elseif APPLY(function() __tmp = ZEROQ(MOD(HS, 10)) return __tmp end) then 
      	__tmp = TELL("I think that phrase is getting a bit worn out.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("Nothing happens here.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SAILOR_FCN\n'..__res) end
end
_SAILOR_FCN = {
	'TELL',
	'EXAMINE',
	'HELLO',
}
OBJECT {
	NAME = "GROUND",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"GROUND","SAND","DIRT","FLOOR"},
	DESC = "ground",
	ACTION = GROUND_FUNCTION,
}
GROUND_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(VERBQ(PUT, PUT_ON) and EQUALQ(PRSI, GROUND)) return __tmp end) then 
    	__tmp = PERFORM(VQDROP, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = EQUALQ(HERE, SANDY_CAVE) return __tmp end) then 
    	__tmp = SAND_FUNCTION()
  elseif APPLY(function() __tmp = VERBQ(DIG) return __tmp end) then 
    	__tmp = TELL("The ground is too hard for digging here.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GROUND_FUNCTION\n'..__res) end
end
_GROUND_FUNCTION = {
	'PUT',
	'DIG',
}
OBJECT {
	NAME = "GRUE",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"GRUE"},
	ADJECTIVE = {"LURKING","SINISTER","HUNGRY","SILENT"},
	DESC = "lurking grue",
	ACTION = GRUE_FUNCTION,
}
GRUE_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("The grue is a sinister, lurking presence in the dark places of the earth. Its favorite diet is adventurers, but its insatiable appetite is tempered by its fear of light. No grue has ever been seen by the light of day, and few have survived its fearsome jaws to tell the tale.", CR)
  elseif APPLY(function() __tmp = VERBQ(FIND) return __tmp end) then 
    	__tmp = TELL("There is no grue here, but I'm sure there is at least one lurking in the darkness nearby. I wouldn't let my light go out if I were you!", CR)
  elseif APPLY(function() __tmp = VERBQ(LISTEN) return __tmp end) then 
    	__tmp = TELL("It makes no sound but is always lurking in the darkness nearby.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GRUE_FUNCTION\n'..__res) end
end
_GRUE_FUNCTION = {
	'EXAMINE',
	'FIND',
	'LISTEN',
}
OBJECT {
	NAME = "LUNGS",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"LUNGS","AIR","MOUTH","BREATH"},
	DESC = "blast of air",
	FLAGS = {"NDESCBIT"},
}
OBJECT {
	NAME = "ME",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"ME","MYSELF","SELF","CRETIN"},
	DESC = "cretin",
	FLAGS = {"ACTORBIT"},
	ACTION = CRETIN_FCN,
}
CRETIN_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(TELL) return __tmp end) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    	__tmp = TELL("Talking to yourself is said to be a sign of impending mental collapse.", CR)
  elseif APPLY(function() __tmp = PASS(VERBQ(GIVE) and EQUALQ(PRSI, ME)) return __tmp end) then 
    	__tmp = PERFORM(VQTAKE, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = VERBQ(MAKE) return __tmp end) then 
    	__tmp = TELL("Only you can do that.", CR)
  elseif APPLY(function() __tmp = VERBQ(DISEMBARK) return __tmp end) then 
    	__tmp = TELL("You'll have to do that on your own.", CR)
  elseif APPLY(function() __tmp = VERBQ(EAT) return __tmp end) then 
    	__tmp = TELL("Auto-cannibalism is not the answer.", CR)
  elseif APPLY(function() __tmp = VERBQ(ATTACK, MUNG) return __tmp end) then 
    
    if APPLY(function() __tmp = PASS(PRSI and FSETQ(PRSI, WEAPONBIT)) return __tmp end) then 
      	__tmp = JIGS_UP("If you insist.... Poof, you're dead!")
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("Suicide is not the answer.", CR)
    end

  elseif APPLY(function() __tmp = VERBQ(THROW) return __tmp end) then 
    
    if APPLY(function() __tmp = EQUALQ(PRSO, ME) return __tmp end) then 
      	__tmp = TELL("Why don't you just walk like normal people?", CR)
    end

  elseif APPLY(function() __tmp = VERBQ(TAKE) return __tmp end) then 
    	__tmp = TELL("How romantic!", CR)
  elseif APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    
    if APPLY(function() __tmp = EQUALQ(HERE, LOC(MIRROR_1), LOC(MIRROR_2)) return __tmp end) then 
      	__tmp = TELL("Your image in the mirror looks tired.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("That's difficult unless your eyes are prehensile.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CRETIN_FCN\n'..__res) end
end
_CRETIN_FCN = {
	'TELL',
	'GIVE',
	'MAKE',
	'DISEMBARK',
	'EAT',
	'ATTACK',
	'THROW',
	'TAKE',
	'EXAMINE',
}
OBJECT {
	NAME = "ADVENTURER",
	SYNONYM = {"ADVENTURER"},
	DESC = "cretin",
	FLAGS = {"NDESCBIT","INVISIBLE","SACREDBIT","ACTORBIT"},
	STRENGTH = 0,
	ACTION = 0,
}
OBJECT {
	NAME = "PATHOBJ",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"TRAIL","PATH"},
	ADJECTIVE = {"FOREST","NARROW","LONG","WINDING"},
	DESC = "passage",
	FLAGS = {"NDESCBIT"},
	ACTION = PATH_OBJECT,
}
PATH_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(TAKE, FOLLOW) return __tmp end) then 
    	__tmp = TELL("You must specify a direction to go.", CR)
  elseif APPLY(function() __tmp = VERBQ(FIND) return __tmp end) then 
    	__tmp = TELL("I can't help you there....", CR)
  elseif APPLY(function() __tmp = VERBQ(DIG) return __tmp end) then 
    	__tmp = TELL("Not a chance.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PATH_OBJECT\n'..__res) end
end
_PATH_OBJECT = {
	'TAKE',
	'FIND',
	'DIG',
}
OBJECT {
	NAME = "ZORKMID",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"ZORKMID"},
	DESC = "zorkmid",
	ACTION = ZORKMID_FUNCTION,
}
ZORKMID_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("The zorkmid is the unit of currency of the Great Underground Empire.", CR)
  elseif APPLY(function() __tmp = VERBQ(FIND) return __tmp end) then 
    	__tmp = TELL("The best way to find zorkmids is to go out and look for them.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ZORKMID_FUNCTION\n'..__res) end
end
_ZORKMID_FUNCTION = {
	'EXAMINE',
	'FIND',
}
OBJECT {
	NAME = "HANDS",
	LOC = GLOBAL_OBJECTS,
	SYNONYM = {"PAIR","HANDS","HAND"},
	ADJECTIVE = {"BARE"},
	DESC = "pair of hands",
	FLAGS = {"NDESCBIT","TOOLBIT"},
}
