SANITARIUM_GATE = DECL_OBJECT("SANITARIUM_GATE")
BRASS_PLAQUE = DECL_OBJECT("BRASS_PLAQUE")
SANITARIUM_ENTRANCE = DECL_OBJECT("SANITARIUM_ENTRANCE")
WALLPAPER = DECL_OBJECT("WALLPAPER")
RECEPTION_ROOM = DECL_OBJECT("RECEPTION_ROOM")
OAK_DESK = DECL_OBJECT("OAK_DESK")
BOTTOM_DRAWER = DECL_OBJECT("BOTTOM_DRAWER")
BRASS_KEY = DECL_OBJECT("BRASS_KEY")
PATIENT_LEDGER = DECL_OBJECT("PATIENT_LEDGER")
OPERATING_THEATER = DECL_OBJECT("OPERATING_THEATER")
OPERATING_TABLE = DECL_OBJECT("OPERATING_TABLE")
METAL_CABINET = DECL_OBJECT("METAL_CABINET")
SCALPEL = DECL_OBJECT("SCALPEL")
ETHER_BOTTLE = DECL_OBJECT("ETHER_BOTTLE")
PATIENT_WARD = DECL_OBJECT("PATIENT_WARD")
BED_FRAMES = DECL_OBJECT("BED_FRAMES")
HEAVY_DOOR = DECL_OBJECT("HEAVY_DOOR")
CHAINS = DECL_OBJECT("CHAINS")
MORGUE = DECL_OBJECT("MORGUE")
REFRIGERATED_DRAWERS = DECL_OBJECT("REFRIGERATED_DRAWERS")
DISSECTION_TABLE = DECL_OBJECT("DISSECTION_TABLE")
CANVAS_BUNDLE = DECL_OBJECT("CANVAS_BUNDLE")
MORDECAI_JOURNAL = DECL_OBJECT("MORDECAI_JOURNAL")
STRANGE_SERUM = DECL_OBJECT("STRANGE_SERUM")

DIRECTIONS("NORTH", "EAST", "WEST", "SOUTH", "NE", "NW", "SE", "SW", "UP", "DOWN", "IN", "OUT", "LAND", nil)
RELEASEID = 1
ROOM {
	NAME = "SANITARIUM_GATE",
	LOC = ROOMS,
	DESC = "Sanitarium Gate",
	LDESC = "You stand before the rusted iron gates of an abandoned sanitarium. The structure looms against the darkening sky, its windows like hollow eye sockets. Weeds choke the gravel path leading north to the entrance. A corroded brass plaque hangs askew on the gate.",
	NORTH = SANITARIUM_ENTRANCE,
	FLAGS = {"LIGHTBIT"},
}
PLAQUE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(READ, EXAMINE) return __tmp end) then 
    	__tmp = TELL("The plaque reads: 'Blackwood Sanitarium - Est. 1898 - Closed by Order 1952'", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PLAQUE_F\n'..__res) end
end
_PLAQUE_F = {
	'READ',
}
OBJECT {
	NAME = "BRASS_PLAQUE",
	LOC = SANITARIUM_GATE,
	SYNONYM = {"PLAQUE","BRASS","SIGN"},
	ADJECTIVE = {"BRASS","CORRODED"},
	DESC = "brass plaque",
	LDESC = "The plaque reads: 'Blackwood Sanitarium - Est. 1898 - Closed by Order 1952'",
	FLAGS = {"READBIT","TAKEBIT"},
	TEXT = "Blackwood Sanitarium - Est. 1898 - Closed by Order 1952",
	SIZE = 5,
	ACTION = PLAQUE_F,
}
ROOM {
	NAME = "SANITARIUM_ENTRANCE",
	LOC = ROOMS,
	DESC = "Sanitarium Entrance Hall",
	LDESC = "The entrance hall reeks of mildew and decay. Peeling wallpaper reveals water-stained plaster beneath. A grand staircase ascends to darkness in the east. To the west, a doorway leads to what might have been a reception area. North, you can make out an operating theater through a half-open door.",
	SOUTH = SANITARIUM_GATE,
	WEST = RECEPTION_ROOM,
	NORTH = OPERATING_THEATER,
	EAST = PATIENT_WARD,
	FLAGS = {"LIGHTBIT"},
}
OBJECT {
	NAME = "WALLPAPER",
	LOC = SANITARIUM_ENTRANCE,
	SYNONYM = {"WALLPAPER","PAPER","PLASTER"},
	ADJECTIVE = {"PEELING"},
	DESC = "peeling wallpaper",
	LDESC = "Victorian-era wallpaper depicting pastoral scenes, now grotesquely warped by moisture.",
	FLAGS = {"NDESCBIT"},
	ACTION = WALLPAPER_F,
}
WALLPAPER_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("Victorian-era wallpaper depicting pastoral scenes, now grotesquely warped by moisture and black mold.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WALLPAPER_F\n'..__res) end
end
_WALLPAPER_F = {
	'EXAMINE',
}
ROOM {
	NAME = "RECEPTION_ROOM",
	LOC = ROOMS,
	DESC = "Reception Room",
	LDESC = "This cramped room once served as the sanitarium's reception. A heavy oak desk sits against one wall, its surface thick with dust. Filing cabinets line the opposite wall, their drawers hanging open like gaping mouths. Something glints among the papers scattered on the floor.",
	EAST = SANITARIUM_ENTRANCE,
	FLAGS = {"LIGHTBIT"},
}
OBJECT {
	NAME = "OAK_DESK",
	LOC = RECEPTION_ROOM,
	SYNONYM = {"DESK"},
	ADJECTIVE = {"HEAVY","OAK"},
	DESC = "oak desk",
	LDESC = "The desk has three drawers. Only the bottom drawer appears intact.",
	FLAGS = {"NDESCBIT","CONTBIT","OPENBIT","SURFACEBIT"},
	ACTION = DESK_F,
}
DESK_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("The desk has three drawers. The top two are broken and empty. The bottom drawer appears intact but is locked tight.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESK_F\n'..__res) end
end
_DESK_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "BOTTOM_DRAWER",
	LOC = OAK_DESK,
	SYNONYM = {"DRAWER"},
	ADJECTIVE = {"BOTTOM"},
	DESC = "bottom drawer",
	LDESC = "A sturdy drawer that seems to be locked.",
	FLAGS = {"CONTBIT","NDESCBIT"},
	CAPACITY = 10,
	ACTION = DRAWER_F,
}
DRAWER_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(VERBQ(OPEN) and FSETQ(BOTTOM_DRAWER, OPENBIT)) return __tmp end) then 
    	__tmp = TELL("The drawer is already open.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(OPEN, UNLOCK) and NOT(FSETQ(BOTTOM_DRAWER, OPENBIT)) and NOT(INQ(BRASS_KEY, WINNER))) return __tmp end) then 
    	__tmp = TELL("The drawer is locked. You need a key.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(OPEN, UNLOCK) and NOT(FSETQ(BOTTOM_DRAWER, OPENBIT)) and INQ(BRASS_KEY, WINNER)) return __tmp end) then 
    	__tmp = TELL("You unlock the bottom drawer with the brass key. It slides open with a groan, revealing a leather-bound ledger inside.", CR)
    	__tmp = FCLEAR(BOTTOM_DRAWER, NDESCBIT)
    	__tmp = FSET(BOTTOM_DRAWER, OPENBIT)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DRAWER_F\n'..__res) end
end
_DRAWER_F = {
	'OPEN',
	'OPEN',
	'OPEN',
}
OBJECT {
	NAME = "BRASS_KEY",
	LOC = RECEPTION_ROOM,
	SYNONYM = {"KEY"},
	ADJECTIVE = {"BRASS","SMALL"},
	DESC = "brass key",
	LDESC = "A small brass key, cold to the touch.",
	FLAGS = {"TAKEBIT"},
	SIZE = 2,
	ACTION = BRASSKEY_F,
}
BRASSKEY_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("A small brass key with the number '3' engraved on its head. It's ice cold despite being indoors.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BRASSKEY_F\n'..__res) end
end
_BRASSKEY_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "PATIENT_LEDGER",
	LOC = BOTTOM_DRAWER,
	SYNONYM = {"LEDGER","BOOK","JOURNAL"},
	ADJECTIVE = {"PATIENT","LEATHER"},
	DESC = "patient ledger",
	LDESC = "A leather-bound ledger with names and dates. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.'",
	FLAGS = {"READBIT","TAKEBIT"},
	TEXT = "Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.",
	SIZE = 8,
	ACTION = LEDGER_F,
}
LEDGER_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(READ, EXAMINE) return __tmp end) then 
    	__tmp = TELL("The ledger contains patient records spanning decades. The entries become more disturbing toward the end. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai. May God have mercy on us all.'", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LEDGER_F\n'..__res) end
end
_LEDGER_F = {
	'READ',
}
ROOM {
	NAME = "OPERATING_THEATER",
	LOC = ROOMS,
	DESC = "Operating Theater",
	LDESC = "The circular theater is dominated by a stained operating table in the center. Rusty surgical instruments lie scattered about. Rising tiers of benches circle the table, where students once observed procedures. A metal cabinet stands in the shadows, its door slightly ajar. The air here is thick with an oppressive dread.",
	SOUTH = SANITARIUM_ENTRANCE,
	FLAGS = {"LIGHTBIT"},
}
OBJECT {
	NAME = "OPERATING_TABLE",
	LOC = OPERATING_THEATER,
	SYNONYM = {"TABLE"},
	ADJECTIVE = {"OPERATING","STAINED"},
	DESC = "operating table",
	LDESC = "The table is covered in dark stains. Leather restraints dangle from its edges.",
	FLAGS = {"NDESCBIT","SURFACEBIT"},
	ACTION = OPTABLE_F,
}
OPTABLE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("The operating table is covered in dark brown stains that you hope are just rust. Leather restraints dangle from all four corners. Deep gouges mar the metal surface, as if someone struggled violently against the bindings.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('OPTABLE_F\n'..__res) end
end
_OPTABLE_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "METAL_CABINET",
	LOC = OPERATING_THEATER,
	SYNONYM = {"CABINET"},
	ADJECTIVE = {"METAL","MEDICAL"},
	DESC = "metal cabinet",
	LDESC = "A tall cabinet with glass doors, now cracked and clouded.",
	FLAGS = {"NDESCBIT","CONTBIT","OPENBIT","TRANSBIT"},
	ACTION = CABINET_F,
}
CABINET_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("The cabinet's glass doors are cracked but still intact. Inside, you can see various medical instruments, including a scalpel and a bottle.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CABINET_F\n'..__res) end
end
_CABINET_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "SCALPEL",
	LOC = METAL_CABINET,
	SYNONYM = {"SCALPEL","KNIFE","BLADE"},
	ADJECTIVE = {"SURGICAL","RUSTY"},
	DESC = "rusty scalpel",
	LDESC = "A surgical scalpel, its blade dulled by rust but still sharp enough to cut.",
	FLAGS = {"TAKEBIT","WEAPONBIT","TOOLBIT"},
	SIZE = 3,
	ACTION = SCALPEL_F,
}
SCALPEL_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("The scalpel's blade is rusty but still razor-sharp along one edge. The handle is stained with something dark.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SCALPEL_F\n'..__res) end
end
_SCALPEL_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "ETHER_BOTTLE",
	LOC = METAL_CABINET,
	SYNONYM = {"BOTTLE","ETHER","CHLOROFORM"},
	ADJECTIVE = {"GLASS"},
	DESC = "bottle of ether",
	LDESC = "A glass bottle labeled 'Ether - Handle with Care'. Some liquid remains inside.",
	FLAGS = {"TAKEBIT"},
	SIZE = 5,
	ACTION = ETHER_F,
}
ETHER_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("A glass bottle with a faded label reading 'Ether - Handle with Care'. About a quarter of the liquid remains.", CR)
    	error(true)
  elseif APPLY(function() __tmp = VERBQ(DRINK) return __tmp end) then 
    	__tmp = TELL("That would be an extremely bad idea.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ETHER_F\n'..__res) end
end
_ETHER_F = {
	'EXAMINE',
	'DRINK',
}
ROOM {
	NAME = "PATIENT_WARD",
	LOC = ROOMS,
	DESC = "Patient Ward",
	LDESC = "A long corridor lined with rusted bed frames. Tattered curtains hang between them, offering the ghost of privacy. At the far end, a heavy door sealed with chains blocks further passage. Scratches cover the door's surface, as if made by desperate fingers. The floor is littered with patient records and broken glass.",
	WEST = SANITARIUM_ENTRANCE,
	NORTH = {MORGUE, flag = CHAINS_CUT_FLAG},
	FLAGS = {"LIGHTBIT"},
}
OBJECT {
	NAME = "BED_FRAMES",
	LOC = PATIENT_WARD,
	SYNONYM = {"BEDS","FRAMES","BED","FRAME"},
	ADJECTIVE = {"RUSTED"},
	DESC = "bed frames",
	LDESC = "Skeletal remains of hospital beds, springs poking through rotted mattresses.",
	FLAGS = {"NDESCBIT"},
	ACTION = BEDS_F,
}
BEDS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("Dozens of bed frames line the walls. The mattresses have rotted away, leaving only rusted springs and metal frames. Some still have restraint straps attached.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BEDS_F\n'..__res) end
end
_BEDS_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "HEAVY_DOOR",
	LOC = PATIENT_WARD,
	SYNONYM = {"DOOR"},
	ADJECTIVE = {"HEAVY","SEALED","LOCKED","MORGUE"},
	DESC = "heavy door",
	LDESC = "The door is secured with thick chains and a padlock. Deep scratches mar its surface.",
	FLAGS = {"NDESCBIT"},
	ACTION = HEAVYDOOR_F,
}
HEAVYDOOR_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(VERBQ(EXAMINE) and NOT(CHAINS_CUT_FLAG)) return __tmp end) then 
    	__tmp = TELL("The heavy door is secured with thick chains and a rusted padlock. Deep scratches cover its surface, made by fingernails. A tarnished plaque reads 'MORGUE'.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(EXAMINE) and CHAINS_CUT_FLAG) return __tmp end) then 
    	__tmp = TELL("The door stands open, chains lying in a heap on the floor. Beyond lies darkness.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(OPEN) and NOT(CHAINS_CUT_FLAG)) return __tmp end) then 
    	__tmp = TELL("The door is secured with heavy chains. You need to cut through them.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HEAVYDOOR_F\n'..__res) end
end
_HEAVYDOOR_F = {
	'EXAMINE',
	'EXAMINE',
	'OPEN',
}
OBJECT {
	NAME = "CHAINS",
	LOC = PATIENT_WARD,
	SYNONYM = {"CHAINS","CHAIN","PADLOCK"},
	ADJECTIVE = {"THICK"},
	DESC = "chains",
	LDESC = "Heavy chains secured with a rusted padlock.",
	FLAGS = {"NDESCBIT"},
	ACTION = CHAINS_F,
}
CHAINS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(VERBQ(EXAMINE) and NOT(CHAINS_CUT_FLAG)) return __tmp end) then 
    	__tmp = TELL("Thick iron chains wrap around the door handles, secured with a massive rusted padlock. The chains look old but still strong.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(ATTACK) and NOT(CHAINS_CUT_FLAG) and NOT(INQ(SCALPEL, WINNER))) return __tmp end) then 
    	__tmp = TELL("The chains are too strong to break with your bare hands. You need a sharp tool.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(VERBQ(ATTACK) and NOT(CHAINS_CUT_FLAG) and INQ(SCALPEL, WINNER)) return __tmp end) then 
    	__tmp = TELL("You saw through the rusty chains with the scalpel. It takes several minutes of effort, but finally they fall away with a crash. The heavy door creaks open, revealing a passage north into darkness.", CR)
    	__tmp = APPLY(function() CHAINS_CUT_FLAG = T return CHAINS_CUT_FLAG end)
    	__tmp = REMOVE(CHAINS)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CHAINS_F\n'..__res) end
end
_CHAINS_F = {
	'EXAMINE',
	'ATTACK',
	'ATTACK',
}
ROOM {
	NAME = "MORGUE",
	LOC = ROOMS,
	DESC = "Morgue",
	LDESC = "The temperature drops as you enter the morgue. Refrigerated drawers line both walls. In the center, a dissection table holds what appears to be a canvas-wrapped bundle. Medical instruments hang on the wall. A journal rests on a small desk in the corner. This place feels wrong, as though something lingers here still.",
	SOUTH = PATIENT_WARD,
	FLAGS = {"LIGHTBIT"},
}
OBJECT {
	NAME = "REFRIGERATED_DRAWERS",
	LOC = MORGUE,
	SYNONYM = {"DRAWERS","DRAWER","REFRIGERATOR"},
	ADJECTIVE = {"REFRIGERATED","METAL"},
	DESC = "refrigerated drawers",
	LDESC = "Most drawers are empty, but one is slightly open.",
	FLAGS = {"NDESCBIT","CONTBIT","OPENBIT"},
	ACTION = DRAWERS_F,
}
DRAWERS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("The refrigeration units line both walls. Most drawers are empty or contain only bones. One drawer is slightly ajar, a faint luminescent glow emanating from within.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DRAWERS_F\n'..__res) end
end
_DRAWERS_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "DISSECTION_TABLE",
	LOC = MORGUE,
	SYNONYM = {"TABLE"},
	ADJECTIVE = {"DISSECTION","AUTOPSY"},
	DESC = "dissection table",
	LDESC = "A metal table with drainage channels carved into its surface.",
	FLAGS = {"NDESCBIT","SURFACEBIT"},
	ACTION = DISTABLE_F,
}
DISTABLE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE, LOOK_INSIDE) return __tmp end) then 
    	__tmp = TELL("The dissection table is made of stainless steel with drainage channels carved into its surface. Dark stains pool in the grooves. A canvas-wrapped bundle lies upon it.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DISTABLE_F\n'..__res) end
end
_DISTABLE_F = {
	'EXAMINE',
}
OBJECT {
	NAME = "CANVAS_BUNDLE",
	LOC = DISSECTION_TABLE,
	SYNONYM = {"BUNDLE","CANVAS","BODY","CORPSE"},
	ADJECTIVE = {"WRAPPED"},
	DESC = "canvas bundle",
	LDESC = "A human-shaped bundle wrapped in stained canvas. You'd rather not investigate further.",
	FLAGS = {"TAKEBIT"},
	SIZE = 50,
	ACTION = BUNDLE_F,
}
BUNDLE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("A human-shaped bundle wrapped in stained canvas. The fabric is rotted and discolored. You'd rather not investigate further, though part of you wonders if this is Patient 237.", CR)
    	error(true)
  elseif APPLY(function() __tmp = VERBQ(OPEN, UNWRAP) return __tmp end) then 
    	__tmp = TELL("You have no desire to see what lies within. Some mysteries are better left undisturbed.", CR)
    	error(true)
  elseif APPLY(function() __tmp = VERBQ(TAKE) return __tmp end) then 
    	__tmp = TELL("You can't bring yourself to touch it.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BUNDLE_F\n'..__res) end
end
_BUNDLE_F = {
	'EXAMINE',
	'OPEN',
	'TAKE',
}
OBJECT {
	NAME = "MORDECAI_JOURNAL",
	LOC = MORGUE,
	SYNONYM = {"JOURNAL","DIARY","NOTEBOOK","BOOK"},
	ADJECTIVE = {"DOCTOR","MORDECAI"},
	DESC = "doctor's journal",
	LDESC = "Dr. Mordecai's personal journal. The final entry describes an experimental procedure that went terribly wrong. The handwriting becomes increasingly erratic.",
	FLAGS = {"READBIT","TAKEBIT"},
	TEXT = "The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. I have made a terrible mistake. God forgive me, I must seal this place.",
	SIZE = 6,
	ACTION = JOURNAL_F,
}
JOURNAL_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(READ, EXAMINE) return __tmp end) then 
    	__tmp = TELL("Dr. Mordecai's personal journal. The final entry is dated October 31, 1952. The handwriting becomes increasingly erratic: 'The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.'", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('JOURNAL_F\n'..__res) end
end
_JOURNAL_F = {
	'READ',
}
OBJECT {
	NAME = "STRANGE_SERUM",
	LOC = REFRIGERATED_DRAWERS,
	SYNONYM = {"SERUM","VIAL","BOTTLE"},
	ADJECTIVE = {"STRANGE","GLOWING"},
	DESC = "vial of serum",
	LDESC = "A glass vial containing luminescent liquid. The label reads 'Compound 237 - DO NOT USE'",
	FLAGS = {"TAKEBIT"},
	SIZE = 4,
	ACTION = SERUM_F,
}
SERUM_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = VERBQ(EXAMINE) return __tmp end) then 
    	__tmp = TELL("A glass vial containing a faintly glowing liquid. The label reads 'Compound 237 - DO NOT USE'. The serum pulses with an unnatural light.", CR)
    	error(true)
  elseif APPLY(function() __tmp = VERBQ(DRINK) return __tmp end) then 
    	__tmp = TELL("You bring the vial to your lips but your survival instinct stops you. This substance killed Patient 237. You lower the vial, hands trembling.", CR)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SERUM_F\n'..__res) end
end
_SERUM_F = {
	'EXAMINE',
	'DRINK',
}
CHAINS_CUT_FLAG = nil
GO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() HERE = SANITARIUM_GATE return HERE end)
	__tmp =   THIS_IS_IT(BRASS_PLAQUE)

  if APPLY(function() __tmp = NOT(FSETQ(HERE, TOUCHBIT)) return __tmp end) then 
    	__tmp = V_VERSION()
    	__tmp = CRLF()
  end

	__tmp = APPLY(function() LIT = T return LIT end)
	__tmp = APPLY(function() WINNER = ADVENTURER return WINNER end)
	__tmp = APPLY(function() PLAYER = WINNER return PLAYER end)
	__tmp =   MOVE(WINNER, HERE)
	__tmp =   V_LOOK()
	__tmp =   MAIN_LOOP()
	error(123)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GO\n'..__res) end
end
_GO = {
}
