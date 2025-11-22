
WEST_HOUSE = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are standing in an open field west of a white house, with a boarded front door.")
    
    if WON_FLAG then 
      	__tmp = TELL(" A secret path leads southwest into the forest.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WEST_HOUSE\n'..__res) end
end
EAST_HOUSE = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are behind the white house. A path leads into the forest to the east. In one corner of the house there is a small window which is ")
    
    if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
      	__tmp = TELL("open.")
    elseif T then 
      	__tmp = TELL("slightly ajar.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('EAST_HOUSE\n'..__res) end
end
OPEN_CLOSE = function(...)
	local OBJ, STROPN, STRCLS = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN) then 
    
    if FSETQ(OBJ, OPENBIT) then 
      	__tmp = TELL(PICK_ONE(DUMMY))
    elseif T then 
      	__tmp = TELL(STROPN)
      	__tmp = FSET(OBJ, OPENBIT)
    end

    	__tmp = CRLF()
  elseif VERBQ(CLOSE) then 
    
    if FSETQ(OBJ, OPENBIT) then 
      	__tmp = TELL(STRCLS)
      	__tmp = FCLEAR(OBJ, OPENBIT)
      	__tmp = T
    elseif T then 
      	__tmp = TELL(PICK_ONE(DUMMY))
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('OPEN_CLOSE\n'..__res) end
end
BOARD_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE, EXAMINE) then 
    	__tmp = TELL("The boards are securely fastened.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BOARD_F\n'..__res) end
end
TEETH_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(BRUSH) and EQUALQ(PRSO, TEETH)) then 
    
    if PASS(EQUALQ(PRSI, PUTTY) and INQ(PRSI, WINNER)) then 
      	__tmp = JIGS_UP("Well, you seem to have been brushing your teeth with some sort of glue. As a result, your mouth gets glued together (with your nose) and you die of respiratory failure.")
    elseif NOT(PRSI) then 
      	__tmp = TELL("Dental hygiene is highly recommended, but I'm not sure what you want to brush them with.", CR)
    elseif T then 
      	__tmp = TELL("A nice idea, but with a ", D, PRSI, "?", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TEETH_F\n'..__res) end
end
GRANITE_WALL_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(HERE, NORTH_TEMPLE) then 
    
    if VERBQ(FIND) then 
      	__tmp = TELL("The west wall is solid granite here.", CR)
    elseif VERBQ(TAKE, RAISE, LOWER) then 
      	__tmp = TELL("It's solid granite.", CR)
    end

  elseif EQUALQ(HERE, TREASURE_ROOM) then 
    
    if VERBQ(FIND) then 
      	__tmp = TELL("The east wall is solid granite here.", CR)
    elseif VERBQ(TAKE, RAISE, LOWER) then 
      	__tmp = TELL("It's solid granite.", CR)
    end

  elseif EQUALQ(HERE, SLIDE_ROOM) then 
    
    if VERBQ(FIND, READ) then 
      	__tmp = TELL("It only SAYS \"Granite Wall\".", CR)
    elseif T then 
      	__tmp = TELL("The wall isn't granite.", CR)
    end

  elseif T then 
    	__tmp = TELL("There is no granite wall here.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GRANITE_WALL_F\n'..__res) end
end
SONGBIRD_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(FIND, TAKE) then 
    	__tmp = TELL("The songbird is not here but is probably nearby.", CR)
  elseif VERBQ(LISTEN) then 
    	__tmp = TELL("You can't hear the songbird now.", CR)
  elseif VERBQ(FOLLOW) then 
    	__tmp = TELL("It can't be followed.", CR)
  elseif T then 
    	__tmp = TELL("You can't see any songbird here.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SONGBIRD_F\n'..__res) end
end
WHITE_HOUSE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(HERE, KITCHEN, LIVING_ROOM, ATTIC) then 
    
    if VERBQ(FIND) then 
      	__tmp = TELL("Why not find your brains?", CR)
    elseif VERBQ(WALK_AROUND) then 
      	__tmp = GO_NEXT(IN_HOUSE_AROUND)
      	__tmp = T
    end

  elseif NOT(PASS(EQUALQ(HERE, EAST_OF_HOUSE, WEST_OF_HOUSE) or EQUALQ(HERE, NORTH_OF_HOUSE, SOUTH_OF_HOUSE))) then 
    
    if VERBQ(FIND) then 
      
      if EQUALQ(HERE, CLEARING) then 
        	__tmp = TELL("It seems to be to the west.", CR)
      elseif T then 
        	__tmp = TELL("It was here just a minute ago....", CR)
      end

    elseif T then 
      	__tmp = TELL("You're not at the house.", CR)
    end

  elseif VERBQ(FIND) then 
    	__tmp = TELL("It's right here! Are you blind or something?", CR)
  elseif VERBQ(WALK_AROUND) then 
    	__tmp = GO_NEXT(HOUSE_AROUND)
    	__tmp = T
  elseif VERBQ(EXAMINE) then 
    	__tmp = TELL("The house is a beautiful colonial house which is painted white. It is clear that the owners must have been extremely wealthy.", CR)
  elseif VERBQ(THROUGH, OPEN) then 
    
    if EQUALQ(HERE, EAST_OF_HOUSE) then 
      
      if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
        	__tmp = GOTO(KITCHEN)
      elseif T then 
        	__tmp = TELL("The window is closed.", CR)
        	__tmp = THIS_IS_IT(KITCHEN_WINDOW)
      end

    elseif T then 
      	__tmp = TELL("I can't see how to get in from here.", CR)
    end

  elseif VERBQ(BURN) then 
    	__tmp = TELL("You must be joking.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WHITE_HOUSE_F\n'..__res) end
end
GO_NEXT = function(...)
	local TBL = ...
	local VAL
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() VAL = LKP(HERE, TBL) return VAL end) then 
    
    if NOT(GOTO(VAL)) then 
      	__tmp = 2
    elseif T then 
      	__tmp = 1
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GO_NEXT\n'..__res) end
end
FOREST_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(WALK_AROUND) then 
    
    if PASS(EQUALQ(HERE, WEST_OF_HOUSE, NORTH_OF_HOUSE, SOUTH_OF_HOUSE) or EQUALQ(HERE, EAST_OF_HOUSE)) then 
      	__tmp = TELL("You aren't even in the forest.", CR)
    end

    	__tmp = GO_NEXT(FOREST_AROUND)
  elseif VERBQ(DISEMBARK) then 
    	__tmp = TELL("You will have to specify a direction.", CR)
  elseif VERBQ(FIND) then 
    	__tmp = TELL("You cannot see the forest for the trees.", CR)
  elseif VERBQ(LISTEN) then 
    	__tmp = TELL("The pines and the hemlocks seem to be murmuring.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FOREST_F\n'..__res) end
end
MOUNTAIN_RANGE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) then 
    	__tmp = TELL("Don't you believe me? The mountains are impassable!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MOUNTAIN_RANGE_F\n'..__res) end
end
WATER_F = function(...)
	local AV
	local W
	local PIQ
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(SGIVE) then 
    	error(false)
  elseif VERBQ(THROUGH, BOARD) then 
    	__tmp = TELL(PICK_ONE(SWIMYUKS), CR)
    	error(true)
  elseif VERBQ(FILL) then 
    	__tmp = APPLY(function() W = PRSI return W end)
    	__tmp = APPLY(function() PRSA = VQPUT return PRSA end)
    	__tmp = APPLY(function() PRSI = PRSO return PRSI end)
    	__tmp = APPLY(function() PRSO = W return PRSO end)
    	__tmp = APPLY(function() PIQ = nil return PIQ end)
  elseif PASS(EQUALQ(PRSO, GLOBAL_WATER) or EQUALQ(PRSO, WATER)) then 
    	__tmp = APPLY(function() W = PRSO return W end)
    	__tmp = APPLY(function() PIQ = nil return PIQ end)
  else 
    	__tmp = APPLY(function() W = PRSI return W end)
    
    if W then 
      	__tmp = APPLY(function() PIQ = T return PIQ end)
    end

  end


  if EQUALQ(W, GLOBAL_WATER) then 
    	__tmp = APPLY(function() W = WATER return W end)
    
    if VERBQ(TAKE, PUT) then 
      	__tmp = REMOVE_CAREFULLY(W)
    end

  end


  if PIQ then 
    	__tmp = APPLY(function() PRSI = W return PRSI end)
  elseif T then 
    	__tmp = APPLY(function() PRSO = W return PRSO end)
  end

	__tmp = APPLY(function() AV = LOC(WINNER) return AV end)

  if NOT(FSETQ(AV, VEHBIT)) then 
    	__tmp = APPLY(function() AV = nil return AV end)
  end


  if PASS(VERBQ(TAKE, PUT) and NOT(PIQ)) then 
    
    if PASS(AV and PASS(EQUALQ(AV, PRSI) or PASS(NOT(PRSI) and NOT(INQ(W, AV))))) then 
      	__tmp = TELL("There is now a puddle in the bottom of the ", D, AV, ".", CR)
      	__tmp = REMOVE_CAREFULLY(PRSO)
      	__tmp = MOVE(PRSO, AV)
    elseif PASS(PRSI and NOT(EQUALQ(PRSI, BOTTLE))) then 
      	__tmp = TELL("The water leaks out of the ", D, PRSI, " and evaporates immediately.", CR)
      	__tmp = REMOVE_CAREFULLY(W)
    elseif INQ(BOTTLE, WINNER) then 
      
      if NOT(FSETQ(BOTTLE, OPENBIT)) then 
        	__tmp = TELL("The bottle is closed.", CR)
        	__tmp = THIS_IS_IT(BOTTLE)
      elseif NOT(FIRSTQ(BOTTLE)) then 
        	__tmp = MOVE(WATER, BOTTLE)
        	__tmp = TELL("The bottle is now full of water.", CR)
      elseif T then 
        	__tmp = TELL("The water slips through your fingers.", CR)
        	error(true)
      end

    elseif PASS(INQ(PRSO, BOTTLE) and VERBQ(TAKE) and NOT(PRSI)) then 
      	__tmp = TELL("It's in the bottle. Perhaps you should take that instead.", CR)
    elseif T then 
      	__tmp = TELL("The water slips through your fingers.", CR)
    end

  elseif PIQ then 
    
    if PASS(VERBQ(PUT) and GLOBAL_INQ(RIVER, HERE)) then 
      	__tmp = PERFORM(VQPUT, PRSO, RIVER)
    else 
      	__tmp = TELL("Nice try.", CR)
    end

    	error(true)
  elseif VERBQ(DROP, GIVE) then 
    
    if PASS(VERBQ(DROP) and INQ(WATER, BOTTLE) and NOT(FSETQ(BOTTLE, OPENBIT))) then 
      	__tmp = TELL("The bottle is closed.", CR)
      	error(true)
    end

    	__tmp = REMOVE_CAREFULLY(WATER)
    
    if AV then 
      	__tmp = TELL("There is now a puddle in the bottom of the ", D, AV, ".", CR)
      	__tmp = MOVE(WATER, AV)
    elseif T then 
      	__tmp = TELL("The water spills to the floor and evaporates immediately.", CR)
      	__tmp = REMOVE_CAREFULLY(WATER)
    end

  elseif VERBQ(THROW) then 
    	__tmp = TELL("The water splashes on the walls and evaporates immediately.", CR)
    	__tmp = REMOVE_CAREFULLY(WATER)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WATER_F\n'..__res) end
end
KITCHEN_WINDOW_FLAG = nil
KITCHEN_WINDOW_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE) then 
    	__tmp = APPLY(function() KITCHEN_WINDOW_FLAG = T return KITCHEN_WINDOW_FLAG end)
    	__tmp = OPEN_CLOSE(KITCHEN_WINDOW, "With great effort, you open the window far enough to allow entry.", "The window closes (more easily than it opened).")
  elseif PASS(VERBQ(EXAMINE) and NOT(KITCHEN_WINDOW_FLAG)) then 
    	__tmp = TELL("The window is slightly ajar, but not enough to allow entry.", CR)
  elseif VERBQ(WALK, BOARD, THROUGH) then 
    
    if EQUALQ(HERE, KITCHEN) then 
      	__tmp = DO_WALK(PQEAST)
    elseif T then 
      	__tmp = DO_WALK(PQWEST)
    end

    	error(true)
  elseif VERBQ(LOOK_INSIDE) then 
    	__tmp = TELL("You can see ")
    
    if EQUALQ(HERE, KITCHEN) then 
      	__tmp = TELL("a clear area leading towards a forest.", CR)
    elseif T then 
      	__tmp = TELL("what appears to be a kitchen.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('KITCHEN_WINDOW_F\n'..__res) end
end
GHOSTS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TELL) then 
    	__tmp = TELL("The spirits jeer loudly and ignore you.", CR)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif VERBQ(EXORCISE) then 
    	__tmp = TELL("Only the ceremony itself has any effect.", CR)
  elseif PASS(VERBQ(ATTACK, MUNG) and EQUALQ(PRSO, GHOSTS)) then 
    	__tmp = TELL("How can you attack a spirit with material objects?", CR)
  elseif T then 
    	__tmp = TELL("You seem unable to interact with these spirits.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GHOSTS_F\n'..__res) end
end
CAGE_TOP = T
BASKET_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(RAISE) then 
    
    if CAGE_TOP then 
      	__tmp = TELL(PICK_ONE(DUMMY), CR)
    elseif T then 
      	__tmp = MOVE(RAISED_BASKET, SHAFT_ROOM)
      	__tmp = MOVE(LOWERED_BASKET, LOWER_SHAFT)
      	__tmp = APPLY(function() CAGE_TOP = T return CAGE_TOP end)
      	__tmp = THIS_IS_IT(RAISED_BASKET)
      	__tmp = TELL("The basket is raised to the top of the shaft.", CR)
    end

  elseif VERBQ(LOWER) then 
    
    if NOT(CAGE_TOP) then 
      	__tmp = TELL(PICK_ONE(DUMMY), CR)
    elseif T then 
      	__tmp = MOVE(RAISED_BASKET, LOWER_SHAFT)
      	__tmp = MOVE(LOWERED_BASKET, SHAFT_ROOM)
      	__tmp = THIS_IS_IT(LOWERED_BASKET)
      	__tmp = TELL("The basket is lowered to the bottom of the shaft.", CR)
      	__tmp = APPLY(function() CAGE_TOP = nil return CAGE_TOP end)
      
      if PASS(LIT and NOT(APPLY(function() LIT = LITQ(HERE) return LIT end))) then 
        	__tmp = TELL("It is now pitch black.", CR)
      end

      	__tmp = T
    end

  elseif PASS(EQUALQ(PRSO, LOWERED_BASKET) or EQUALQ(PRSI, LOWERED_BASKET)) then 
    	__tmp = TELL("The basket is at the other end of the chain.", CR)
  elseif PASS(VERBQ(TAKE) and EQUALQ(PRSO, RAISED_BASKET, LOWERED_BASKET)) then 
    	__tmp = TELL("The cage is securely fastened to the iron chain.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BASKET_F\n'..__res) end
end
BAT_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TELL) then 
    	__tmp = FWEEP(6)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif VERBQ(TAKE, ATTACK, MUNG) then 
    
    if EQUALQ(LOC(GARLIC), WINNER, HERE) then 
      	__tmp = TELL("You can't reach him; he's on the ceiling.", CR)
    elseif T then 
      	__tmp = FLY_ME()
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BAT_F\n'..__res) end
end
FLY_ME = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   FWEEP(4)
	__tmp =   TELL("The bat grabs you by the scruff of your neck and lifts you away....", CR, CR)
	__tmp =   GOTO(PICK_ONE(BAT_DROPS), nil)

  if NOT(EQUALQ(HERE, ENTRANCE_TO_HADES)) then 
    	__tmp = V_FIRST_LOOK()
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FLY_ME\n'..__res) end
end
FWEEP = function(...)
	local N = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog43 = function()
    
    if LQ(APPLY(function() N = SUB(N, 1) return N end), 1) then 
      return true
    elseif T then 
      	__tmp = TELL("    Fweep!", CR)
    end


error(123) end
local __ok43, __res43
repeat __ok43, __res43 = pcall(__prog43)
until __ok43 or __res43 ~= 123
if not __ok43 then error(__res43)
else __tmp = __res43 or true end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FWEEP\n'..__res) end
end
BAT_DROPS = LTABLE(0,MINE_1,MINE_2,MINE_3,MINE_4,LADDER_TOP,LADDER_BOTTOM,SQUEEKY_ROOM,MINE_ENTRANCE)
BELL_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(RING) then 
    
    if PASS(EQUALQ(HERE, LLD_ROOM) and NOT(LLD_FLAG)) then 
      	error(false)
    elseif T then 
      	__tmp = TELL("Ding, dong.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BELL_F\n'..__res) end
end
HOT_BELL_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = TELL("The bell is very hot and cannot be taken.", CR)
  elseif PASS(VERBQ(RUB) or PASS(VERBQ(RING) and PRSI)) then 
    
    if FSETQ(PRSI, BURNBIT) then 
      	__tmp = TELL("The ", D, PRSI, " burns and is consumed.", CR)
      	__tmp = REMOVE_CAREFULLY(PRSI)
    elseif EQUALQ(PRSI, HANDS) then 
      	__tmp = TELL("The bell is too hot to touch.", CR)
    elseif T then 
      	__tmp = TELL("The heat from the bell is too intense.", CR)
    end

  elseif VERBQ(POUR_ON) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = TELL("The water cools the bell and is evaporated.", CR)
    	__tmp = QUEUE(I_XBH, 0)
    	__tmp = I_XBH()
  elseif VERBQ(RING) then 
    	__tmp = TELL("The bell is too hot to reach.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HOT_BELL_F\n'..__res) end
end
BOARDED_WINDOW_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN) then 
    	__tmp = TELL("The windows are boarded and can't be opened.", CR)
  elseif VERBQ(MUNG) then 
    	__tmp = TELL("You can't break the windows open.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BOARDED_WINDOW_FCN\n'..__res) end
end
NAILS_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = TELL("The nails, deeply imbedded in the door, cannot be removed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NAILS_PSEUDO\n'..__res) end
end
CRACK_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(THROUGH) then 
    	__tmp = TELL("You can't fit through the crack.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CRACK_FCN\n'..__res) end
end
KITCHEN_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in the kitchen of the white house. A table seems to have been used recently for the preparation of food. A passage leads to the west and a dark staircase can be seen leading upward. A dark chimney leads down and to the east is a small window which is ")
    
    if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
      	__tmp = TELL("open.", CR)
    elseif T then 
      	__tmp = TELL("slightly ajar.", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_UP) and EQUALQ(PRSO, STAIRS)) then 
      	__tmp = DO_WALK(PQUP)
    elseif PASS(VERBQ(CLIMB_UP) and EQUALQ(PRSO, STAIRS)) then 
      	__tmp = TELL("There are no stairs leading down.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('KITCHEN_FCN\n'..__res) end
end
STONE_BARROW_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(RARG, M_BEG) and PASS(VERBQ(ENTER) or PASS(VERBQ(WALK) and EQUALQ(PRSO, PQWEST, PQIN)) or PASS(VERBQ(THROUGH) and EQUALQ(PRSO, BARROW)))) then 
    	__tmp = TELL("Inside the Barrow| As you enter the barrow, the door closes inexorably behind you. Around you it is dark, but ahead is an enormous cavern, brightly lit. Through its center runs a wide stream. Spanning the stream is a small wooden footbridge, and beyond a path leads into a dark tunnel. Above the bridge, floating in the air, is a large sign. It reads:  All ye who stand before this bridge have completed a great and perilous adventure which has tested your wit and courage. You have mastered")
    
    if EQUALQ(BAND(GETB(0, 1), 8), 0) then 
      	__tmp = TELL(" the first part of the ZORK trilogy. Those who pass over this bridge must be prepared to undertake an even greater adventure that will severely test your skill and bravery!| | The ZORK trilogy continues with \"ZORK II: The Wizard of Frobozz\" and is completed in \"ZORK III: The Dungeon Master.\"", CR)
    elseif T then 
      	__tmp = TELL(" ZORK: The Great Underground Empire.|", CR)
    end

    	__tmp = FINISH()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STONE_BARROW_FCN\n'..__res) end
end
BARROW_DOOR_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE) then 
    	__tmp = TELL("The door is too heavy.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BARROW_DOOR_FCN\n'..__res) end
end
BARROW_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(THROUGH) then 
    	__tmp = DO_WALK(PQWEST)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BARROW_FCN\n'..__res) end
end
TROPHY_CASE_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, TROPHY_CASE)) then 
    	__tmp = TELL("The trophy case is securely fastened to the wall.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TROPHY_CASE_FCN\n'..__res) end
end
RUG_MOVED = nil
LIVING_ROOM_FCN = function(...)
	local RARG = ...
	local RUGQ
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in the living room. There is a doorway to the east")
    
    if MAGIC_FLAG then 
      	__tmp = TELL(". To the west is a cyclops-shaped opening in an old wooden door, above which is some strange gothic lettering, ")
    elseif T then 
      	__tmp = TELL(", a wooden door with strange gothic lettering to the west, which appears to be nailed shut, ")
    end

    	__tmp = TELL("a trophy case, ")
    	__tmp = APPLY(function() RUGQ = RUG_MOVED return RUGQ end)
    
    if PASS(RUGQ and FSETQ(TRAP_DOOR, OPENBIT)) then 
      	__tmp = TELL("and a rug lying beside an open trap door.")
    elseif RUGQ then 
      	__tmp = TELL("and a closed trap door at your feet.")
    elseif FSETQ(TRAP_DOOR, OPENBIT) then 
      	__tmp = TELL("and an open trap door at your feet.")
    elseif T then 
      	__tmp = TELL("and a large oriental rug in the center of the room.")
    end

    	__tmp = CRLF()
    	__tmp = T
  elseif EQUALQ(RARG, M_END) then 
    
    if PASS(VERBQ(TAKE) or PASS(VERBQ(PUT) and EQUALQ(PRSI, TROPHY_CASE))) then 
      
      if INQ(PRSO, TROPHY_CASE) then 
        	__tmp = TOUCH_ALL(PRSO)
      end

      	__tmp = APPLY(function() SCORE = ADD(BASE_SCORE, OTVAL_FROB()) return SCORE end)
      	__tmp = SCORE_UPD(0)
      	error(false)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LIVING_ROOM_FCN\n'..__res) end
end
TOUCH_ALL = function(...)
	local OBJ = ...
	local F
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() F = FIRSTQ(OBJ) return F end)

  local __prog44 = function()
    
    if NOT(F) then 
      return true
    elseif T then 
      	__tmp = FSET(F, TOUCHBIT)
      
      if FIRSTQ(F) then 
        	__tmp = TOUCH_ALL(F)
      end

    end

    APPLY(function() F = NEXTQ(F) return F end)

error(123) end
local __ok44, __res44
repeat __ok44, __res44 = pcall(__prog44)
until __ok44 or __res44 ~= 123
if not __ok44 then error(__res44)
else __tmp = __res44 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TOUCH_ALL\n'..__res) end
end
OTVAL_FROB = function(...)
	local O = ...
	local F
  local SCORE = 0
	if select('#', ...) < 1 then O = TROPHY_CASE end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() F = FIRSTQ(O) return F end)

  local __prog45 = function()
    
    if NOT(F) then 
      error(SCORE)
    end

    APPLY(function() SCORE = ADD(SCORE, GETP(F, PQTVALUE)) return SCORE end)
    
    if FIRSTQ(F) then 
      	__tmp = OTVAL_FROB(F)
    end

    APPLY(function() F = NEXTQ(F) return F end)

error(123) end
local __ok45, __res45
repeat __ok45, __res45 = pcall(__prog45)
until __ok45 or __res45 ~= 123
if not __ok45 then error(__res45)
else __tmp = __res45 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('OTVAL_FROB\n'..__res) end
end
TRAP_DOOR_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(RAISE) then 
    	__tmp = PERFORM(VQOPEN, TRAP_DOOR)
    	error(true)
  elseif PASS(VERBQ(OPEN, CLOSE) and EQUALQ(HERE, LIVING_ROOM)) then 
    	__tmp = OPEN_CLOSE(PRSO, "The door reluctantly opens to reveal a rickety staircase descending into darkness.", "The door swings shut and closes.")
  elseif PASS(VERBQ(LOOK_UNDER) and EQUALQ(HERE, LIVING_ROOM)) then 
    
    if FSETQ(TRAP_DOOR, OPENBIT) then 
      	__tmp = TELL("You see a rickety staircase descending into darkness.", CR)
    elseif T then 
      	__tmp = TELL("It's closed.", CR)
    end

  elseif EQUALQ(HERE, CELLAR) then 
    
    if PASS(VERBQ(OPEN, UNLOCK) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      	__tmp = TELL("The door is locked from above.", CR)
    elseif PASS(VERBQ(CLOSE) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      	__tmp = FCLEAR(TRAP_DOOR, TOUCHBIT)
      	__tmp = FCLEAR(TRAP_DOOR, OPENBIT)
      	__tmp = TELL("The door closes and locks.", CR)
    elseif VERBQ(OPEN, CLOSE) then 
      	__tmp = TELL(PICK_ONE(DUMMY), CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TRAP_DOOR_FCN\n'..__res) end
end
CELLAR_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in a dark and damp cellar with a narrow passageway leading north, and a crawlway to the south. On the west is the bottom of a steep metal ramp which is unclimbable.", CR)
  elseif EQUALQ(RARG, M_ENTER) then 
    
    if PASS(FSETQ(TRAP_DOOR, OPENBIT) and NOT(FSETQ(TRAP_DOOR, TOUCHBIT))) then 
      	__tmp = FCLEAR(TRAP_DOOR, OPENBIT)
      	__tmp = FSET(TRAP_DOOR, TOUCHBIT)
      	__tmp = TELL("The trap door crashes shut, and you hear someone barring it.", CR, CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CELLAR_FCN\n'..__res) end
end
CHIMNEY_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(EXAMINE) then 
    	__tmp = TELL("The chimney leads ")
    
    if EQUALQ(HERE, KITCHEN) then 
      	__tmp = TELL("down")
    elseif T then 
      	__tmp = TELL("up")
    end

    	__tmp = TELL("ward, and looks climbable.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CHIMNEY_F\n'..__res) end
end
UP_CHIMNEY_FUNCTION = function(...)
	local F
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(APPLY(function() F = FIRSTQ(WINNER) return F end)) then 
    	__tmp = TELL("Going up empty-handed is a bad idea.", CR)
    	error(false)
  elseif PASS(PASS(NOT(APPLY(function() F = NEXTQ(F) return F end)) or NOT(NEXTQ(F))) and INQ(LAMP, WINNER)) then 
    
    if NOT(FSETQ(TRAP_DOOR, OPENBIT)) then 
      	__tmp = FCLEAR(TRAP_DOOR, TOUCHBIT)
    end

    error(KITCHEN)
  elseif T then 
    	__tmp = TELL("You can't get up there with what you're carrying.", CR)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('UP_CHIMNEY_FUNCTION\n'..__res) end
end
TRAP_DOOR_EXIT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if RUG_MOVED then 
    
    if FSETQ(TRAP_DOOR, OPENBIT) then 
      error(CELLAR)
    elseif T then 
      	__tmp = TELL("The trap door is closed.", CR)
      	__tmp = THIS_IS_IT(TRAP_DOOR)
      	error(false)
    end

  elseif T then 
    	__tmp = TELL("You can't go that way.", CR)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TRAP_DOOR_EXIT\n'..__res) end
end
RUG_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(RAISE) then 
    	__tmp = TELL("The rug is too heavy to lift")
    
    if RUG_MOVED then 
      	__tmp = TELL(".", CR)
    elseif T then 
      	__tmp = TELL(", but in trying to take it you have noticed an irregularity beneath it.", CR)
    end

  elseif VERBQ(MOVE, PUSH) then 
    
    if RUG_MOVED then 
      	__tmp = TELL("Having moved the carpet previously, you find it impossible to move it again.", CR)
    elseif T then 
      	__tmp = TELL("With a great effort, the rug is moved to one side of the room, revealing the dusty cover of a closed trap door.", CR)
      	__tmp = FCLEAR(TRAP_DOOR, INVISIBLE)
      	__tmp = THIS_IS_IT(TRAP_DOOR)
      	__tmp = APPLY(function() RUG_MOVED = T return RUG_MOVED end)
    end

  elseif VERBQ(TAKE) then 
    	__tmp = TELL("The rug is extremely heavy and cannot be carried.", CR)
  elseif PASS(VERBQ(LOOK_UNDER) and NOT(RUG_MOVED) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
    	__tmp = TELL("Underneath the rug is a closed trap door. As you drop the corner of the rug, the trap door is once again concealed from view.", CR)
  elseif VERBQ(CLIMB_ON) then 
    
    if PASS(NOT(RUG_MOVED) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      	__tmp = TELL("As you sit, you notice an irregularity underneath it. Rather than be uncomfortable, you stand up again.", CR)
    else 
      	__tmp = TELL("I suppose you think it's a magic carpet?", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RUG_FCN\n'..__res) end
end
AXE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if TROLL_FLAG then 
    	__tmp = nil
  elseif T then 
    	__tmp = WEAPON_FUNCTION(AXE, TROLL)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('AXE_F\n'..__res) end
end
STILETTO_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   WEAPON_FUNCTION(STILETTO, THIEF)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STILETTO_FUNCTION\n'..__res) end
end
WEAPON_FUNCTION = function(...)
	local W, V = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(INQ(V, HERE)) then 
    	error(false)
  elseif VERBQ(TAKE) then 
    
    if INQ(W, V) then 
      	__tmp = TELL("The ", D, V, " swings it out of your reach.", CR)
    elseif T then 
      	__tmp = TELL("The ", D, W, " seems white-hot. You can't hold on to it.", CR)
    end

    	__tmp = T
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WEAPON_FUNCTION\n'..__res) end
end
TROLL_FCN = function(...)
	local MODE = ...
	if select('#', ...) < 1 then MODE = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TELL) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = TELL("The troll isn't much of a conversationalist.", CR)
  elseif EQUALQ(MODE, F_BUSYQ) then 
    
    if INQ(AXE, TROLL) then 
      	__tmp = nil
    elseif PASS(INQ(AXE, HERE) and PROB(75, 90)) then 
      	__tmp = FSET(AXE, NDESCBIT)
      	__tmp = FCLEAR(AXE, WEAPONBIT)
      	__tmp = MOVE(AXE, TROLL)
      	__tmp = PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room.")
      	__tmp = PASS(INQ(TROLL, HERE) and TELL("The troll, angered and humiliated, recovers his weapon. He appears to have an axe to grind with you.", CR))
      	__tmp = T
    elseif INQ(TROLL, HERE) then 
      	__tmp = PUTP(TROLL, PQLDESC, "A pathetically babbling troll is here.")
      	__tmp = TELL("The troll, disarmed, cowers in terror, pleading for his life in the guttural tongue of the trolls.", CR)
      	__tmp = T
    end

  elseif EQUALQ(MODE, F_DEAD) then 
    
    if INQ(AXE, TROLL) then 
      	__tmp = MOVE(AXE, HERE)
      	__tmp = FCLEAR(AXE, NDESCBIT)
      	__tmp = FSET(AXE, WEAPONBIT)
    end

    	__tmp = APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_UNCONSCIOUS) then 
    	__tmp = FCLEAR(TROLL, FIGHTBIT)
    
    if INQ(AXE, TROLL) then 
      	__tmp = MOVE(AXE, HERE)
      	__tmp = FCLEAR(AXE, NDESCBIT)
      	__tmp = FSET(AXE, WEAPONBIT)
    end

    	__tmp = PUTP(TROLL, PQLDESC, "An unconscious troll is sprawled on the floor. All passages out of the room are open.")
    	__tmp = APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_CONSCIOUS) then 
    
    if INQ(TROLL, HERE) then 
      	__tmp = FSET(TROLL, FIGHTBIT)
      	__tmp = TELL("The troll stirs, quickly resuming a fighting stance.", CR)
    end

    
    if INQ(AXE, TROLL) then 
      	__tmp = PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room.")
    elseif INQ(AXE, TROLL_ROOM) then 
      	__tmp = FSET(AXE, NDESCBIT)
      	__tmp = FCLEAR(AXE, WEAPONBIT)
      	__tmp = MOVE(AXE, TROLL)
      	__tmp = PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room.")
    elseif T then 
      	__tmp = PUTP(TROLL, PQLDESC, "A troll is here.")
    end

    	__tmp = APPLY(function() TROLL_FLAG = nil return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_FIRSTQ) then 
    
    if PROB(33) then 
      	__tmp = FSET(TROLL, FIGHTBIT)
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
      	__tmp = T
    end

  elseif NOT(MODE) then 
    
    if VERBQ(EXAMINE) then 
      	__tmp = TELL(GETP(TROLL, PQLDESC), CR)
    elseif PASS(PASS(VERBQ(THROW, GIVE) and PRSO and EQUALQ(PRSI, TROLL)) or VERBQ(TAKE, MOVE, MUNG)) then 
      	__tmp = AWAKEN(TROLL)
      
      if VERBQ(THROW, GIVE) then 
        
        if PASS(EQUALQ(PRSO, AXE) and INQ(AXE, WINNER)) then 
          	__tmp = TELL("The troll scratches his head in confusion, then takes the axe.", CR)
          	__tmp = FSET(TROLL, FIGHTBIT)
          	__tmp = MOVE(AXE, TROLL)
          	error(true)
        elseif EQUALQ(PRSO, TROLL, AXE) then 
          	__tmp = TELL("You would have to get the ", D, PRSO, " first, and that seems unlikely.", CR)
          	error(true)
        end

        
        if VERBQ(THROW) then 
          	__tmp = TELL("The troll, who is remarkably coordinated, catches the ", D, PRSO)
        elseif T then 
          	__tmp = TELL("The troll, who is not overly proud, graciously accepts the gift")
        end

        
        if PASS(PROB(20) and EQUALQ(PRSO, KNIFE, SWORD, AXE)) then 
          	__tmp = REMOVE_CAREFULLY(PRSO)
          	__tmp = TELL(" and eats it hungrily. Poor troll, he dies from an internal hemorrhage and his carcass disappears in a sinister black fog.", CR)
          	__tmp = REMOVE_CAREFULLY(TROLL)
          	__tmp = APPLY(GETP(TROLL, PQACTION), F_DEAD)
          	__tmp = APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
        elseif EQUALQ(PRSO, KNIFE, SWORD, AXE) then 
          	__tmp = MOVE(PRSO, HERE)
          	__tmp = TELL(" and, being for the moment sated, throws it back. Fortunately, the troll has poor control, and the ", D, PRSO, " falls to the floor. He does not look pleased.", CR)
          	__tmp = FSET(TROLL, FIGHTBIT)
        elseif T then 
          	__tmp = TELL(" and not having the most discriminating tastes, gleefully eats it.", CR)
          	__tmp = REMOVE_CAREFULLY(PRSO)
        end

      elseif VERBQ(TAKE, MOVE) then 
        	__tmp = TELL("The troll spits in your face, grunting \"Better luck next time\" in a rather barbarous accent.", CR)
      elseif VERBQ(MUNG) then 
        	__tmp = TELL("The troll laughs at your puny gesture.", CR)
      end

    elseif VERBQ(LISTEN) then 
      	__tmp = TELL("Every so often the troll says something, probably uncomplimentary, in his guttural tongue.", CR)
    elseif PASS(TROLL_FLAG and VERBQ(HELLO)) then 
      	__tmp = TELL("Unfortunately, the troll can't hear you.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TROLL_FCN\n'..__res) end
end
GRATE_REVEALED = nil
GRUNLOCK = nil
LEAVES_APPEAR = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(FSETQ(GRATE, OPENBIT)) and NOT(GRATE_REVEALED)) then 
    
    if VERBQ(MOVE, TAKE) then 
      	__tmp = TELL("In disturbing the pile of leaves, a grating is revealed.", CR)
    elseif T then 
      	__tmp = TELL("With the leaves moved, a grating is revealed.", CR)
    end

    	__tmp = FCLEAR(GRATE, INVISIBLE)
    	__tmp = APPLY(function() GRATE_REVEALED = T return GRATE_REVEALED end)
  end

	__tmp = nil
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LEAVES_APPEAR\n'..__res) end
end
LEAF_PILE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(COUNT) then 
    	__tmp = TELL("There are 69,105 leaves here.", CR)
  elseif VERBQ(BURN) then 
    	__tmp = LEAVES_APPEAR()
    	__tmp = REMOVE_CAREFULLY(PRSO)
    
    if INQ(PRSO, HERE) then 
      	__tmp = TELL("The leaves burn.", CR)
    elseif T then 
      	__tmp = JIGS_UP("The leaves burn, and so do you.")
    end

  elseif VERBQ(CUT) then 
    	__tmp = TELL("You rustle the leaves around, making quite a mess.", CR)
    	__tmp = LEAVES_APPEAR()
    	error(true)
  elseif VERBQ(MOVE, TAKE) then 
    
    if VERBQ(MOVE) then 
      	__tmp = TELL("Done.", CR)
    end

    
    if GRATE_REVEALED then 
      	error(false)
    end

    	__tmp = LEAVES_APPEAR()
    
    if VERBQ(TAKE) then 
      	error(false)
    elseif T then 
      	error(true)
    end

  elseif PASS(VERBQ(LOOK_UNDER) and NOT(GRATE_REVEALED)) then 
    	__tmp = TELL("Underneath the pile of leaves is a grating. As you release the leaves, the grating is once again concealed from view.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LEAF_PILE\n'..__res) end
end
CLEARING_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_ENTER) then 
    
    if NOT(GRATE_REVEALED) then 
      	__tmp = FSET(GRATE, INVISIBLE)
    end

  elseif EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in a clearing, with a forest surrounding you on all sides. A path leads south.")
    
    if FSETQ(GRATE, OPENBIT) then 
      	__tmp = CRLF()
      	__tmp = TELL("There is an open grating, descending into darkness.")
    elseif GRATE_REVEALED then 
      	__tmp = CRLF()
      	__tmp = TELL("There is a grating securely fastened into the ground.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CLEARING_FCN\n'..__res) end
end
MAZE_11_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_ENTER) then 
    	__tmp = FCLEAR(GRATE, INVISIBLE)
  elseif EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in a small room near the maze. There are twisty passages in the immediate vicinity.", CR)
    
    if FSETQ(GRATE, OPENBIT) then 
      	__tmp = TELL("Above you is an open grating with sunlight pouring in.")
    elseif GRUNLOCK then 
      	__tmp = TELL("Above you is a grating.")
    elseif T then 
      	__tmp = TELL("Above you is a grating locked with a skull-and-crossbones lock.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAZE_11_FCN\n'..__res) end
end
GRATE_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(OPEN) and EQUALQ(PRSI, KEYS)) then 
    	__tmp = PERFORM(VQUNLOCK, GRATE, KEYS)
    	error(true)
  elseif VERBQ(LOCK) then 
    
    if EQUALQ(HERE, GRATING_ROOM) then 
      	__tmp = APPLY(function() GRUNLOCK = nil return GRUNLOCK end)
      	__tmp = TELL("The grate is locked.", CR)
    elseif EQUALQ(HERE, GRATING_CLEARING) then 
      	__tmp = TELL("You can't lock it from this side.", CR)
    end

  elseif PASS(VERBQ(UNLOCK) and EQUALQ(PRSO, GRATE)) then 
    
    if PASS(EQUALQ(HERE, GRATING_ROOM) and EQUALQ(PRSI, KEYS)) then 
      	__tmp = APPLY(function() GRUNLOCK = T return GRUNLOCK end)
      	__tmp = TELL("The grate is unlocked.", CR)
    elseif PASS(EQUALQ(HERE, GRATING_CLEARING) and EQUALQ(PRSI, KEYS)) then 
      	__tmp = TELL("You can't reach the lock from here.", CR)
    elseif T then 
      	__tmp = TELL("Can you unlock a grating with a ", D, PRSI, "?", CR)
    end

  elseif VERBQ(PICK) then 
    	__tmp = TELL("You can't pick the lock.", CR)
  elseif VERBQ(OPEN, CLOSE) then 
    
    if GRUNLOCK then 
      	__tmp = OPEN_CLOSE(GRATE, APPLY(function()
        if EQUALQ(HERE, CLEARING) then 
          	__tmp = "The grating opens."
        elseif T then 
          	__tmp = "The grating opens to reveal trees above you."
        end
 end), "The grating is closed.")
      
      if FSETQ(GRATE, OPENBIT) then 
        
        if PASS(NOT(EQUALQ(HERE, CLEARING)) and NOT(GRATE_REVEALED)) then 
          	__tmp = TELL("A pile of leaves falls onto your head and to the ground.", CR)
          	__tmp = APPLY(function() GRATE_REVEALED = T return GRATE_REVEALED end)
          	__tmp = MOVE(LEAVES, HERE)
        end

        	__tmp = FSET(GRATING_ROOM, ONBIT)
      elseif T then 
        	__tmp = FCLEAR(GRATING_ROOM, ONBIT)
      end

    elseif T then 
      	__tmp = TELL("The grating is locked.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, GRATE)) then 
    
    if GQ(GETP(PRSO, PQSIZE), 20) then 
      	__tmp = TELL("It won't fit through the grating.", CR)
    elseif T then 
      	__tmp = MOVE(PRSO, GRATING_ROOM)
      	__tmp = TELL("The ", D, PRSO, " goes through the grating into the darkness below.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GRATE_FUNCTION\n'..__res) end
end
MAZE_DIODES = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You won't be able to get back up to the tunnel you are going through when it gets to the next room.", CR, CR)

  if EQUALQ(HERE, MAZE_2) then 
    	__tmp = MAZE_4
  elseif EQUALQ(HERE, MAZE_7) then 
    	__tmp = DEAD_END_1
  elseif EQUALQ(HERE, MAZE_9) then 
    	__tmp = MAZE_11
  elseif EQUALQ(HERE, MAZE_12) then 
    	__tmp = MAZE_5
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAZE_DIODES\n'..__res) end
end
RUSTY_KNIFE_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = PASS(INQ(SWORD, WINNER) and TELL("As you touch the rusty knife, your sword gives a single pulse of blinding blue light.", CR))
    	__tmp = nil
  elseif PASS(PASS(EQUALQ(PRSI, RUSTY_KNIFE) and VERBQ(ATTACK)) or PASS(VERBQ(SWING) and EQUALQ(PRSO, RUSTY_KNIFE) and PRSI)) then 
    	__tmp = REMOVE_CAREFULLY(RUSTY_KNIFE)
    	__tmp = JIGS_UP("As the knife approaches its victim, your mind is submerged by an overmastering will. Slowly, your hand turns, until the rusty blade is an inch from your neck. The knife seems to sing as it savagely slits your throat.")
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RUSTY_KNIFE_FCN\n'..__res) end
end
KNIFE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = FCLEAR(ATTIC_TABLE, NDESCBIT)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('KNIFE_F\n'..__res) end
end
SKELETON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE, RUB, MOVE, PUSH, RAISE, LOWER, ATTACK, KICK, KISS) then 
    	__tmp = TELL("A ghost appears in the room and is appalled at your desecration of the remains of a fellow adventurer. He casts a curse on your valuables and banishes them to the Land of the Living Dead. The ghost leaves, muttering obscenities.", CR)
    	__tmp = ROB(HERE, LAND_OF_LIVING_DEAD, 100)
    	__tmp = ROB(ADVENTURER, LAND_OF_LIVING_DEAD)
    	__tmp = T
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SKELETON\n'..__res) end
end
TORCH_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(EXAMINE) then 
    	__tmp = TELL("The torch is burning.", CR)
  elseif PASS(VERBQ(POUR_ON) and EQUALQ(PRSI, TORCH)) then 
    	__tmp = TELL("The water evaporates before it gets close.", CR)
  elseif PASS(VERBQ(LAMP_OFF) and FSETQ(PRSO, ONBIT)) then 
    	__tmp = TELL("You nearly burn your hand trying to extinguish the flame.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TORCH_OBJECT\n'..__res) end
end
MIRROR_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in a large square room with tall ceilings. On the south wall is an enormous mirror which fills the entire wall. There are exits on the other three sides of the room.", CR)
    
    if MIRROR_MUNG then 
      	__tmp = TELL("Unfortunately, the mirror has been destroyed by your recklessness.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MIRROR_ROOM\n'..__res) end
end
MIRROR_MUNG = nil
MIRROR_MIRROR = function(...)
  local RM2 = MIRROR_ROOM_2
	local L1
	local L2
	local N
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(MIRROR_MUNG) and VERBQ(RUB)) then 
    
    if PASS(PRSI and NOT(EQUALQ(PRSI, HANDS))) then 
      	__tmp = TELL("You feel a faint tingling transmitted through the ", D, PRSI, ".", CR)
      	error(true)
    end

    
    if EQUALQ(HERE, RM2) then 
      	__tmp = APPLY(function() RM2 = MIRROR_ROOM_1 return RM2 end)
    end

    	__tmp = APPLY(function() L1 = FIRSTQ(HERE) return L1 end)
    	__tmp = APPLY(function() L2 = FIRSTQ(RM2) return L2 end)
    
    local __prog46 = function()
      
      if NOT(L1) then 
        return true
      end

      APPLY(function() N = NEXTQ(L1) return N end)
      MOVE(L1, RM2)
      APPLY(function() L1 = N return L1 end)

error(123) end
local __ok46, __res46
repeat __ok46, __res46 = pcall(__prog46)
until __ok46 or __res46 ~= 123
if not __ok46 then error(__res46)
else __tmp = __res46 or true end

    
    local __prog47 = function()
      
      if NOT(L2) then 
        return true
      end

      APPLY(function() N = NEXTQ(L2) return N end)
      MOVE(L2, HERE)
      APPLY(function() L2 = N return L2 end)

error(123) end
local __ok47, __res47
repeat __ok47, __res47 = pcall(__prog47)
until __ok47 or __res47 ~= 123
if not __ok47 then error(__res47)
else __tmp = __res47 or true end

    	__tmp = GOTO(RM2, nil)
    	__tmp = TELL("There is a rumble from deep within the earth and the room shakes.", CR)
  elseif VERBQ(LOOK_INSIDE, EXAMINE) then 
    
    if MIRROR_MUNG then 
      	__tmp = TELL("The mirror is broken into many pieces.")
    elseif T then 
      	__tmp = TELL("There is an ugly person staring back at you.")
    end

    	__tmp = CRLF()
  elseif VERBQ(TAKE) then 
    	__tmp = TELL("The mirror is many times your size. Give up.", CR)
  elseif VERBQ(MUNG, THROW, ATTACK) then 
    
    if MIRROR_MUNG then 
      	__tmp = TELL("Haven't you done enough damage already?", CR)
    elseif T then 
      	__tmp = APPLY(function() MIRROR_MUNG = T return MIRROR_MUNG end)
      	__tmp = APPLY(function() LUCKY = nil return LUCKY end)
      	__tmp = TELL("You have broken the mirror. I hope you have a seven years' supply of good luck handy.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MIRROR_MIRROR\n'..__res) end
end
TORCH_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("This is a large room with a prominent doorway leading to a down staircase. Above you is a large dome. Up around the edge of the dome (20 feet up) is a wooden railing. In the center of the room sits a white marble pedestal.", CR)
    
    if DOME_FLAG then 
      	__tmp = TELL("A piece of rope descends from the railing above, ending some five feet above your head.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TORCH_ROOM_FCN\n'..__res) end
end
DOME_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are at the periphery of a large dome, which forms the ceiling of another room below. Protecting you from a precipitous drop is a wooden railing which circles the dome.", CR)
    
    if DOME_FLAG then 
      	__tmp = TELL("Hanging down from the railing is a rope which ends about ten feet from the floor below.", CR)
    end

  elseif EQUALQ(RARG, M_ENTER) then 
    
    if DEAD then 
      	__tmp = TELL("As you enter the dome you feel a strong pull as if from a wind drawing you over the railing and down.", CR)
      	__tmp = MOVE(WINNER, TORCH_ROOM)
      	__tmp = APPLY(function() HERE = TORCH_ROOM return HERE end)
      	error(true)
    elseif VERBQ(LEAP) then 
      	__tmp = JIGS_UP("I'm afraid that the leap you attempted has done you in.")
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DOME_ROOM_FCN\n'..__res) end
end
LLD_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are outside a large gateway, on which is inscribed||   Abandon every hope all ye who enter here!|| The gate is open; through it you can see a desolation, with a pile of mangled bodies in one corner. Thousands of voices, lamenting some hideous fate, can be heard.", CR)
    
    if PASS(NOT(LLD_FLAG) and NOT(DEAD)) then 
      	__tmp = TELL("The way through the gate is barred by evil spirits, who jeer at your attempts to pass.", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if VERBQ(EXORCISE) then 
      
      if NOT(LLD_FLAG) then 
        
        if PASS(INQ(BELL, WINNER) and INQ(BOOK, WINNER) and INQ(CANDLES, WINNER)) then 
          	__tmp = TELL("You must perform the ceremony.", CR)
        elseif T then 
          	__tmp = TELL("You aren't equipped for an exorcism.", CR)
        end

      end

    elseif PASS(NOT(LLD_FLAG) and VERBQ(RING) and EQUALQ(PRSO, BELL)) then 
      	__tmp = APPLY(function() XB = T return XB end)
      	__tmp = REMOVE_CAREFULLY(BELL)
      	__tmp = THIS_IS_IT(HOT_BELL)
      	__tmp = MOVE(HOT_BELL, HERE)
      	__tmp = TELL("The bell suddenly becomes red hot and falls to the ground. The wraiths, as if paralyzed, stop their jeering and slowly turn to face you. On their ashen faces, the expression of a long-forgotten terror takes shape.", CR)
      
      if INQ(CANDLES, WINNER) then 
        	__tmp = TELL("In your confusion, the candles drop to the ground (and they are out).", CR)
        	__tmp = MOVE(CANDLES, HERE)
        	__tmp = FCLEAR(CANDLES, ONBIT)
        	__tmp = DISABLE(INT(I_CANDLES))
      end

      	__tmp = ENABLE(QUEUE(I_XB, 6))
      	__tmp = ENABLE(QUEUE(I_XBH, 20))
    elseif PASS(XC and VERBQ(READ) and EQUALQ(PRSO, BOOK) and NOT(LLD_FLAG)) then 
      	__tmp = TELL("Each word of the prayer reverberates through the hall in a deafening confusion. As the last word fades, a voice, loud and commanding, speaks: \"Begone, fiends!\" A heart-stopping scream fills the cavern, and the spirits, sensing a greater power, flee through the walls.", CR)
      	__tmp = REMOVE_CAREFULLY(GHOSTS)
      	__tmp = APPLY(function() LLD_FLAG = T return LLD_FLAG end)
      	__tmp = DISABLE(INT(I_XC))
    end

  elseif EQUALQ(RARG, M_END) then 
    
    if PASS(XB and INQ(CANDLES, WINNER) and FSETQ(CANDLES, ONBIT) and NOT(XC)) then 
      	__tmp = APPLY(function() XC = T return XC end)
      	__tmp = TELL("The flames flicker wildly and appear to dance. The earth beneath your feet trembles, and your legs nearly buckle beneath you. The spirits cower at your unearthly power.", CR)
      	__tmp = DISABLE(INT(I_XB))
      	__tmp = ENABLE(QUEUE(I_XC, 3))
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LLD_ROOM\n'..__res) end
end
XB = nil
XC = nil
I_XB = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PASS(XC or PASS(EQUALQ(HERE, ENTRANCE_TO_HADES) and TELL("The tension of this ceremony is broken, and the wraiths, amused but shaken at your clumsy attempt, resume their hideous jeering.", CR)))
	__tmp = APPLY(function() XB = nil return XB end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_XB\n'..__res) end
end
I_XC = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() XC = nil return XC end)
	__tmp =   I_XB()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_XC\n'..__res) end
end
I_XBH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   REMOVE_CAREFULLY(HOT_BELL)
	__tmp =   MOVE(BELL, ENTRANCE_TO_HADES)

  if EQUALQ(HERE, ENTRANCE_TO_HADES) then 
    	__tmp = TELL("The bell appears to have cooled down.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_XBH\n'..__res) end
end
GATE_FLAG = nil
GATES_OPEN = nil
DAM_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are standing on the top of the Flood Control Dam #3, which was quite a tourist attraction in times far distant. There are paths to the north, south, and west, and a scramble down.", CR)
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      	__tmp = TELL("The water level behind the dam is low: The sluice gates have been opened. Water rushes through the dam and downstream.", CR)
    elseif GATES_OPEN then 
      	__tmp = TELL("The sluice gates are open, and water rushes through the dam. The water level behind the dam is still high.", CR)
    elseif LOW_TIDE then 
      	__tmp = TELL("The sluice gates are closed. The water level in the reservoir is quite low, but the level is rising quickly.", CR)
    elseif T then 
      	__tmp = TELL("The sluice gates on the dam are closed. Behind the dam, there can be seen a wide reservoir. Water is pouring over the top of the now abandoned dam.", CR)
    end

    	__tmp = TELL("There is a control panel here, on which a large metal bolt is mounted. Directly above the bolt is a small green plastic bubble")
    
    if GATE_FLAG then 
      	__tmp = TELL(" which is glowing serenely")
    end

    	__tmp = TELL(".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DAM_ROOM_FCN\n'..__res) end
end
BOLT_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TURN) then 
    
    if EQUALQ(PRSI, WRENCH) then 
      
      if GATE_FLAG then 
        	__tmp = FCLEAR(RESERVOIR_SOUTH, TOUCHBIT)
        
        if GATES_OPEN then 
          	__tmp = APPLY(function() GATES_OPEN = nil return GATES_OPEN end)
          	__tmp = FCLEAR(LOUD_ROOM, TOUCHBIT)
          	__tmp = TELL("The sluice gates close and water starts to collect behind the dam.", CR)
          	__tmp = ENABLE(QUEUE(I_RFILL, 8))
          	__tmp = QUEUE(I_REMPTY, 0)
          	__tmp = T
        elseif T then 
          	__tmp = APPLY(function() GATES_OPEN = T return GATES_OPEN end)
          	__tmp = TELL("The sluice gates open and water pours through the dam.", CR)
          	__tmp = ENABLE(QUEUE(I_REMPTY, 8))
          	__tmp = QUEUE(I_RFILL, 0)
          	__tmp = T
        end

      elseif T then 
        	__tmp = TELL("The bolt won't turn with your best effort.", CR)
      end

    elseif NOT(EQUALQ(PRSI, nil, HANDS, ROOMS)) then 
      	__tmp = TELL("The bolt won't turn using the ", D, PRSI, ".", CR)
    end

  elseif VERBQ(TAKE) then 
    	__tmp = INTEGRAL_PART()
  elseif VERBQ(OIL) then 
    	__tmp = TELL("Hmm. It appears the tube contained glue, not oil. Turning the bolt won't get any easier....", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BOLT_F\n'..__res) end
end
BUBBLE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = INTEGRAL_PART()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BUBBLE_F\n'..__res) end
end
INTEGRAL_PART = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It is an integral part of the control panel.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('INTEGRAL_PART\n'..__res) end
end
I_RFILL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   FSET(RESERVOIR, NONLANDBIT)
	__tmp =   FCLEAR(RESERVOIR, RLANDBIT)
	__tmp =   FCLEAR(DEEP_CANYON, TOUCHBIT)
	__tmp =   FCLEAR(LOUD_ROOM, TOUCHBIT)
	__tmp =   PASS(INQ(TRUNK, RESERVOIR) and FSET(TRUNK, INVISIBLE))
	__tmp = APPLY(function() LOW_TIDE = nil return LOW_TIDE end)

  if EQUALQ(HERE, RESERVOIR) then 
    
    if FSETQ(LOC(WINNER), VEHBIT) then 
      	__tmp = TELL("The boat lifts gently out of the mud and is now floating on the reservoir.", CR)
    elseif T then 
      	__tmp = JIGS_UP("You are lifted up by the rising river! You try to swim, but the currents are too strong. You come closer, closer to the awesome structure of Flood Control Dam #3. The dam beckons to you. The roar of the water nearly deafens you, but you remain conscious as you tumble over the dam toward your certain doom among the rocks at its base.")
    end

  elseif EQUALQ(HERE, DEEP_CANYON) then 
    	__tmp = TELL("A sound, like that of flowing water, starts to come from below.", CR)
  elseif EQUALQ(HERE, LOUD_ROOM) then 
    	__tmp = TELL("All of a sudden, an alarmingly loud roaring sound fills the room. Filled with fear, you scramble away.", CR)
    	__tmp = GOTO(PICK_ONE(LOUD_RUNS))
  elseif EQUALQ(HERE, RESERVOIR_NORTH, RESERVOIR_SOUTH) then 
    	__tmp = TELL("You notice that the water level has risen to the point that it is impossible to cross.", CR)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_RFILL\n'..__res) end
end
LOUD_RUNS = LTABLE(0,DAMP_CAVE,ROUND_ROOM,DEEP_CANYON)
I_REMPTY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   FSET(RESERVOIR, RLANDBIT)
	__tmp =   FCLEAR(RESERVOIR, NONLANDBIT)
	__tmp =   FCLEAR(DEEP_CANYON, TOUCHBIT)
	__tmp =   FCLEAR(LOUD_ROOM, TOUCHBIT)
	__tmp =   FCLEAR(TRUNK, INVISIBLE)
	__tmp = APPLY(function() LOW_TIDE = T return LOW_TIDE end)

  if PASS(EQUALQ(HERE, RESERVOIR) and FSETQ(LOC(WINNER), VEHBIT)) then 
    	__tmp = TELL("The water level has dropped to the point at which the boat can no longer stay afloat. It sinks into the mud.", CR)
  elseif EQUALQ(HERE, DEEP_CANYON) then 
    	__tmp = TELL("The roar of rushing water is quieter now.", CR)
  elseif EQUALQ(HERE, RESERVOIR_NORTH, RESERVOIR_SOUTH) then 
    	__tmp = TELL("The water level is now quite low here and you could easily cross over to the other side.", CR)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_REMPTY\n'..__res) end
end
DROWNINGS = TABLE("up to your ankles.","up to your shin.","up to your knees.","up to your hips.","up to your waist.","up to your chest.","up to your neck.","over your head.","high in your lungs.")
WATER_LEVEL = 0
BUTTON_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(READ) then 
    	__tmp = TELL("They're greek to you.", CR)
  elseif VERBQ(PUSH) then 
    
    if EQUALQ(PRSO, BLUE_BUTTON) then 
      
      if ZEROQ(WATER_LEVEL) then 
        	__tmp = FCLEAR(LEAK, INVISIBLE)
        	__tmp = TELL("There is a rumbling sound and a stream of water appears to burst from the east wall of the room (apparently, a leak has occurred in a pipe).", CR)
        	__tmp = APPLY(function() WATER_LEVEL = 1 return WATER_LEVEL end)
        	__tmp = ENABLE(QUEUE(I_MAINT_ROOM, -1))
        	__tmp = T
      elseif T then 
        	__tmp = TELL("The blue button appears to be jammed.", CR)
      end

    elseif EQUALQ(PRSO, RED_BUTTON) then 
      	__tmp = TELL("The lights within the room ")
      
      if FSETQ(HERE, ONBIT) then 
        	__tmp = FCLEAR(HERE, ONBIT)
        	__tmp = TELL("shut off.", CR)
      elseif T then 
        	__tmp = FSET(HERE, ONBIT)
        	__tmp = TELL("come on.", CR)
      end

    elseif EQUALQ(PRSO, BROWN_BUTTON) then 
      	__tmp = FCLEAR(DAM_ROOM, TOUCHBIT)
      	__tmp = APPLY(function() GATE_FLAG = nil return GATE_FLAG end)
      	__tmp = TELL("Click.", CR)
    elseif EQUALQ(PRSO, YELLOW_BUTTON) then 
      	__tmp = FCLEAR(DAM_ROOM, TOUCHBIT)
      	__tmp = APPLY(function() GATE_FLAG = T return GATE_FLAG end)
      	__tmp = TELL("Click.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BUTTON_F\n'..__res) end
end
TOOL_CHEST_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(EXAMINE) then 
    	__tmp = TELL("The chests are all empty.", CR)
  elseif VERBQ(TAKE, OPEN, PUT) then 
    	__tmp = REMOVE_CAREFULLY(TOOL_CHEST)
    	__tmp = TELL("The chests are so rusty and corroded that they crumble when you touch them.", CR)
  elseif VERBQ(OPEN) then 
    	__tmp = TELL("The chests are already open.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TOOL_CHEST_FCN\n'..__res) end
end
I_MAINT_ROOM = function(...)
	local HEREQ
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() HEREQ = EQUALQ(HERE, MAINTENANCE_ROOM) return HEREQ end)

  if HEREQ then 
    	__tmp = TELL("The water level here is now ")
    	__tmp = TELL(GET(DROWNINGS, DIV(WATER_LEVEL, 2)))
    	__tmp = CRLF()
  end

	__tmp = APPLY(function() WATER_LEVEL = ADD(1, WATER_LEVEL) return WATER_LEVEL end)

  if NOT(LQ(WATER_LEVEL, 14)) then 
    	__tmp = MUNG_ROOM(MAINTENANCE_ROOM, "The room is full of water and cannot be entered.")
    	__tmp = QUEUE(I_MAINT_ROOM, 0)
    
    if HEREQ then 
      	__tmp = JIGS_UP("I'm afraid you have done drowned yourself.")
    end

  elseif PASS(INQ(WINNER, INFLATED_BOAT) and EQUALQ(HERE, MAINTENANCE_ROOM, DAM_ROOM, DAM_LOBBY)) then 
    	__tmp = JIGS_UP("The rising water carries the boat over the dam, down the river, and over the falls. Tsk, tsk.")
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_MAINT_ROOM\n'..__res) end
end
LEAK_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if GQ(WATER_LEVEL, 0) then 
    
    if PASS(VERBQ(PUT, PUT_ON) and EQUALQ(PRSO, PUTTY)) then 
      	__tmp = FIX_MAINT_LEAK()
    elseif VERBQ(PLUG) then 
      
      if EQUALQ(PRSI, PUTTY) then 
        	__tmp = FIX_MAINT_LEAK()
      elseif T then 
        	__tmp = WITH_TELL(PRSI)
      end

    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LEAK_FUNCTION\n'..__res) end
end
FIX_MAINT_LEAK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() WATER_LEVEL = -1 return WATER_LEVEL end)
	__tmp =   QUEUE(I_MAINT_ROOM, 0)
	__tmp =   TELL("By some miracle of Zorkian technology, you have managed to stop the leak in the dam.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIX_MAINT_LEAK\n'..__res) end
end
PUTTY_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(PASS(VERBQ(OIL) and EQUALQ(PRSI, PUTTY)) or PASS(VERBQ(PUT) and EQUALQ(PRSO, PUTTY))) then 
    	__tmp = TELL("The all-purpose gunk isn't a lubricant.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PUTTY_FCN\n'..__res) end
end
TUBE_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(PUT) and EQUALQ(PRSI, TUBE)) then 
    	__tmp = TELL("The tube refuses to accept anything.", CR)
  elseif VERBQ(SQUEEZE) then 
    
    if PASS(FSETQ(PRSO, OPENBIT) and INQ(PUTTY, PRSO)) then 
      	__tmp = MOVE(PUTTY, WINNER)
      	__tmp = TELL("The viscous material oozes into your hand.", CR)
    elseif FSETQ(PRSO, OPENBIT) then 
      	__tmp = TELL("The tube is apparently empty.", CR)
    elseif T then 
      	__tmp = TELL("The tube is closed.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TUBE_FUNCTION\n'..__res) end
end
DAM_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE) then 
    	__tmp = TELL("Sounds reasonable, but this isn't how.", CR)
  elseif VERBQ(PLUG) then 
    
    if EQUALQ(PRSI, HANDS) then 
      	__tmp = TELL("Are you the little Dutch boy, then? Sorry, this is a big dam.", CR)
    elseif T then 
      	__tmp = TELL("With a ", D, PRSI, "? Do you know how big this dam is? You could only stop a tiny leak with that.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DAM_FUNCTION\n'..__res) end
end
WITH_TELL = function(...)
	local OBJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("With a ", D, OBJ, "?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WITH_TELL\n'..__res) end
end
RESERVOIR_SOUTH_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      	__tmp = TELL("You are in a long room, to the north of which was formerly a lake. However, with the water level lowered, there is merely a wide stream running through the center of the room.")
    elseif GATES_OPEN then 
      	__tmp = TELL("You are in a long room. To the north is a large lake, too deep to cross. You notice, however, that the water level appears to be dropping at a rapid rate. Before long, it might be possible to cross to the other side from here.")
    elseif LOW_TIDE then 
      	__tmp = TELL("You are in a long room, to the north of which is a wide area which was formerly a reservoir, but now is merely a stream. You notice, however, that the level of the stream is rising quickly and that before long it will be impossible to cross here.")
    elseif T then 
      	__tmp = TELL("You are in a long room on the south shore of a large lake, far too deep and wide for crossing.")
    end

    	__tmp = CRLF()
    	__tmp = TELL("There is a path along the stream to the east or west, a steep pathway climbing southwest along the edge of a chasm, and a path leading into a canyon to the southeast.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RESERVOIR_SOUTH_FCN\n'..__res) end
end
RESERVOIR_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(RARG, M_END) and NOT(FSETQ(LOC(WINNER), VEHBIT)) and NOT(GATES_OPEN) and LOW_TIDE) then 
    	__tmp = TELL("You notice that the water level here is rising rapidly. The currents are also becoming stronger. Staying here seems quite perilous!", CR)
  elseif EQUALQ(RARG, M_LOOK) then 
    
    if LOW_TIDE then 
      	__tmp = TELL("You are on what used to be a large lake, but which is now a large mud pile. There are \"shores\" to the north and south.")
    elseif T then 
      	__tmp = TELL("You are on the lake. Beaches can be seen north and south. Upstream a small stream enters the lake through a narrow cleft in the rocks. The dam can be seen downstream.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RESERVOIR_FCN\n'..__res) end
end
RESERVOIR_NORTH_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      	__tmp = TELL("You are in a large cavernous room, the south of which was formerly a lake. However, with the water level lowered, there is merely a wide stream running through there.")
    elseif GATES_OPEN then 
      	__tmp = TELL("You are in a large cavernous area. To the south is a wide lake, whose water level appears to be falling rapidly.")
    elseif LOW_TIDE then 
      	__tmp = TELL("You are in a cavernous area, to the south of which is a very wide stream. The level of the stream is rising rapidly, and it appears that before long it will be impossible to cross to the other side.")
    elseif T then 
      	__tmp = TELL("You are in a large cavernous room, north of a large lake.")
    end

    	__tmp = CRLF()
    	__tmp = TELL("There is a slimy stairway leaving the room to the north.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RESERVOIR_NORTH_FCN\n'..__res) end
end
BOTTLE_FUNCTION = function(...)
  local EQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(THROW) and EQUALQ(PRSO, BOTTLE)) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = APPLY(function() EQ = T return EQ end)
    	__tmp = TELL("The bottle hits the far wall and shatters.", CR)
  elseif VERBQ(MUNG) then 
    	__tmp = APPLY(function() EQ = T return EQ end)
    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = TELL("A brilliant maneuver destroys the bottle.", CR)
  elseif VERBQ(SHAKE) then 
    
    if PASS(FSETQ(PRSO, OPENBIT) and INQ(WATER, PRSO)) then 
      	__tmp = APPLY(function() EQ = T return EQ end)
    end

  end


  if PASS(EQ and INQ(WATER, PRSO)) then 
    	__tmp = TELL("The water spills to the floor and evaporates.", CR)
    	__tmp = REMOVE_CAREFULLY(WATER)
    	__tmp = T
  elseif EQ then 
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BOTTLE_FUNCTION\n'..__res) end
end
CYCLOWRATH = 0
CYCLOPS_FCN = function(...)
	local COUNT
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() COUNT = CYCLOWRATH return COUNT end)

  if EQUALQ(WINNER, CYCLOPS) then 
    
    if CYCLOPS_FLAG then 
      	__tmp = TELL("No use talking to him. He's fast asleep.", CR)
    elseif VERBQ(ODYSSEUS) then 
      	__tmp = APPLY(function() WINNER = ADVENTURER return WINNER end)
      	__tmp = PERFORM(VQODYSSEUS)
      	error(true)
    else 
      	__tmp = TELL("The cyclops prefers eating to making conversation.", CR)
    end

  elseif CYCLOPS_FLAG then 
    
    if VERBQ(EXAMINE) then 
      	__tmp = TELL("The cyclops is sleeping like a baby, albeit a very ugly one.", CR)
    elseif VERBQ(ALARM, KICK, ATTACK, BURN, MUNG) then 
      	__tmp = TELL("The cyclops yawns and stares at the thing that woke him up.", CR)
      	__tmp = APPLY(function() CYCLOPS_FLAG = nil return CYCLOPS_FLAG end)
      	__tmp = FSET(CYCLOPS, FIGHTBIT)
      
      if LQ(COUNT, 0) then 
        	__tmp = APPLY(function() CYCLOWRATH = SUB(COUNT) return CYCLOWRATH end)
      elseif T then 
        	__tmp = APPLY(function() CYCLOWRATH = COUNT return CYCLOWRATH end)
      end

    end

  elseif VERBQ(EXAMINE) then 
    	__tmp = TELL("A hungry cyclops is standing at the foot of the stairs.", CR)
  elseif PASS(VERBQ(GIVE) and EQUALQ(PRSI, CYCLOPS)) then 
    
    if EQUALQ(PRSO, LUNCH) then 
      
      if NOT(LQ(COUNT, 0)) then 
        	__tmp = REMOVE_CAREFULLY(LUNCH)
        	__tmp = TELL("The cyclops says \"Mmm Mmm. I love hot peppers! But oh, could I use a drink. Perhaps I could drink the blood of that thing.\"  From the gleam in his eye, it could be surmised that you are \"that thing\".", CR)
        	__tmp = APPLY(function() CYCLOWRATH = MIN(-1, SUB(COUNT)) return CYCLOWRATH end)
      end

      	__tmp = ENABLE(QUEUE(I_CYCLOPS, -1))
    elseif PASS(EQUALQ(PRSO, WATER) or PASS(EQUALQ(PRSO, BOTTLE) and INQ(WATER, BOTTLE))) then 
      
      if LQ(COUNT, 0) then 
        	__tmp = REMOVE_CAREFULLY(WATER)
        	__tmp = MOVE(BOTTLE, HERE)
        	__tmp = FSET(BOTTLE, OPENBIT)
        	__tmp = FCLEAR(CYCLOPS, FIGHTBIT)
        	__tmp = TELL("The cyclops takes the bottle, checks that it's open, and drinks the water. A moment later, he lets out a yawn that nearly blows you over, and then falls fast asleep (what did you put in that drink, anyway?).", CR)
        	__tmp = APPLY(function() CYCLOPS_FLAG = T return CYCLOPS_FLAG end)
      elseif T then 
        	__tmp = TELL("The cyclops apparently is not thirsty and refuses your generous offer.", CR)
      end

    elseif EQUALQ(PRSO, GARLIC) then 
      	__tmp = TELL("The cyclops may be hungry, but there is a limit.", CR)
    elseif T then 
      	__tmp = TELL("The cyclops is not so stupid as to eat THAT!", CR)
    end

  elseif VERBQ(THROW, ATTACK, MUNG) then 
    	__tmp = ENABLE(QUEUE(I_CYCLOPS, -1))
    
    if VERBQ(MUNG) then 
      	__tmp = TELL("\"Do you think I'm as stupid as my father was?\", he says, dodging.", CR)
    elseif T then 
      	__tmp = TELL("The cyclops shrugs but otherwise ignores your pitiful attempt.", CR)
      
      if VERBQ(THROW) then 
        	__tmp = MOVE(PRSO, HERE)
      end

      	error(true)
    end

  elseif VERBQ(TAKE) then 
    	__tmp = TELL("The cyclops doesn't take kindly to being grabbed.", CR)
  elseif VERBQ(TIE) then 
    	__tmp = TELL("You cannot tie the cyclops, though he is fit to be tied.", CR)
  elseif VERBQ(LISTEN) then 
    	__tmp = TELL("You can hear his stomach rumbling.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CYCLOPS_FCN\n'..__res) end
end
I_CYCLOPS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(CYCLOPS_FLAG or DEAD) then 
    	error(true)
  elseif NOT(EQUALQ(HERE, CYCLOPS_ROOM)) then 
    	__tmp = DISABLE(INT(I_CYCLOPS))
  elseif T then 
    
    if GQ(ABS(CYCLOWRATH), 5) then 
      	__tmp = DISABLE(INT(I_CYCLOPS))
      	__tmp = JIGS_UP("The cyclops, tired of all of your games and trickery, grabs you firmly. As he licks his chops, he says \"Mmm. Just like Mom used to make 'em.\" It's nice to be appreciated.")
    elseif T then 
      
      if LQ(CYCLOWRATH, 0) then 
        	__tmp = APPLY(function() CYCLOWRATH = SUB(CYCLOWRATH, 1) return CYCLOWRATH end)
      elseif T then 
        	__tmp = APPLY(function() CYCLOWRATH = ADD(CYCLOWRATH, 1) return CYCLOWRATH end)
      end

      
      if NOT(CYCLOPS_FLAG) then 
        	__tmp = TELL(NTH(CYCLOMAD, SUB(ABS(CYCLOWRATH), 1)), CR)
      end

    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_CYCLOPS\n'..__res) end
end
CYCLOPS_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("This room has an exit on the northwest, and a staircase leading up.", CR)
    
    if PASS(CYCLOPS_FLAG and NOT(MAGIC_FLAG)) then 
      	__tmp = TELL("The cyclops is sleeping blissfully at the foot of the stairs.", CR)
    elseif MAGIC_FLAG then 
      	__tmp = TELL("The east wall, previously solid, now has a cyclops-sized opening in it.", CR)
    elseif ZEROQ(CYCLOWRATH) then 
      	__tmp = TELL("A cyclops, who looks prepared to eat horses (much less mere adventurers), blocks the staircase. From his state of health, and the bloodstains on the walls, you gather that he is not very friendly, though he likes people.", CR)
    elseif GQ(CYCLOWRATH, 0) then 
      	__tmp = TELL("The cyclops is standing in the corner, eyeing you closely. I don't think he likes you very much. He looks extremely hungry, even for a cyclops.", CR)
    elseif LQ(CYCLOWRATH, 0) then 
      	__tmp = TELL("The cyclops, having eaten the hot peppers, appears to be gasping. His enflamed tongue protrudes from his man-sized mouth.", CR)
    end

  elseif EQUALQ(RARG, M_ENTER) then 
    	__tmp = PASS(ZEROQ(CYCLOWRATH) or ENABLE(INT(I_CYCLOPS)))
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CYCLOPS_ROOM_FCN\n'..__res) end
end
CYCLOMAD = TABLE("The cyclops seems somewhat agitated.","The cyclops appears to be getting more agitated.","The cyclops is moving about the room, looking for something.","The cyclops was looking for salt and pepper. No doubt they are condiments for his upcoming snack.","The cyclops is moving toward you in an unfriendly manner.","You have two choices: 1. Leave  2. Become dinner.")
LOUD_FLAG = nil
LOUD_ROOM_FCN = function(...)
	local RARG = ...
	local WRD
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("This is a large room with a ceiling which cannot be detected from the ground. There is a narrow passage from east to west and a stone stairway leading upward.")
    
    if PASS(LOUD_FLAG or PASS(NOT(GATES_OPEN) and LOW_TIDE)) then 
      	__tmp = TELL(" The room is eerie in its quietness.")
    elseif T then 
      	__tmp = TELL(" The room is deafeningly loud with an undetermined rushing sound. The sound seems to reverberate from all of the walls, making it difficult even to think.")
    end

    	__tmp = CRLF()
  elseif PASS(EQUALQ(RARG, M_END) and GATES_OPEN and NOT(LOW_TIDE)) then 
    	__tmp = TELL("It is unbearably loud here, with an ear-splitting roar seeming to come from all around you. There is a pounding in your head which won't stop. With a tremendous effort, you scramble out of the room.", CR, CR)
    	__tmp = GOTO(PICK_ONE(LOUD_RUNS))
    	error(false)
  elseif EQUALQ(RARG, M_ENTER) then 
    
    if PASS(LOUD_FLAG or PASS(NOT(GATES_OPEN) and LOW_TIDE)) then 
      	error(false)
    elseif PASS(GATES_OPEN and NOT(LOW_TIDE)) then 
      	error(false)
    elseif T then 
      	__tmp = V_FIRST_LOOK()
      
      if P_CONT then 
        	__tmp = TELL("The rest of your commands have been lost in the noise.", CR)
        	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
      end

      
      local __prog48 = function()
        
        if NOT(SUPER_BRIEF) then 
          	__tmp = CRLF()
        end

        TELL(">")
        READ(P_INBUF, P_LEXV)
        
        if ZEROQ(GETB(P_LEXV, P_LEXWORDS)) then 
          	__tmp = TELL("I beg your pardon?", CR)
          	error(123)
        end

        APPLY(function() WRD = GET(P_LEXV, 1) return WRD end)
        
        if EQUALQ(WRD, WQGO, WQWALK, WQRUN) then 
          	__tmp = APPLY(function() WRD = GET(P_LEXV, 3) return WRD end)
        elseif EQUALQ(WRD, WQSAY) then 
          	__tmp = APPLY(function() WRD = GET(P_LEXV, 5) return WRD end)
        end

        
        if EQUALQ(WRD, WQSAVE) then 
          	__tmp = V_SAVE()
        elseif EQUALQ(WRD, WQRESTORE) then 
          	__tmp = V_RESTORE()
        elseif EQUALQ(WRD, WQQ, WQQUIT) then 
          	__tmp = V_QUIT()
        elseif EQUALQ(WRD, WQW, WQWEST) then 
          error(GOTO(ROUND_ROOM))
        elseif EQUALQ(WRD, WQE, WQEAST) then 
          error(GOTO(DAMP_CAVE))
        elseif EQUALQ(WRD, WQU, WQUP) then 
          error(GOTO(DEEP_CANYON))
        elseif EQUALQ(WRD, WQBUG) then 
          	__tmp = TELL("That's only your opinion.", CR)
        elseif EQUALQ(WRD, WQECHO) then 
          	__tmp = APPLY(function() LOUD_FLAG = T return LOUD_FLAG end)
          	__tmp = FCLEAR(BAR, SACREDBIT)
          	__tmp = TELL("The acoustics of the room change subtly.", CR)
          
          if NOT(SUPER_BRIEF) then 
            	__tmp = CRLF()
          end

          return true
        elseif T then 
          	__tmp = V_ECHO()
        end


error(123) end
local __ok48, __res48
repeat __ok48, __res48 = pcall(__prog48)
until __ok48 or __res48 ~= 123
if not __ok48 then error(__res48)
else __tmp = __res48 or true end

    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LOUD_ROOM_FCN\n'..__res) end
end
DEEP_CANYON_F = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are on the south edge of a deep canyon. Passages lead off to the east, northwest and southwest. A stairway leads down.")
    
    if PASS(GATES_OPEN and NOT(LOW_TIDE)) then 
      	__tmp = TELL(" You can hear a loud roaring sound, like that of rushing water, from below.")
    elseif PASS(NOT(GATES_OPEN) and LOW_TIDE) then 
      	__tmp = CRLF()
      	error(true)
    elseif T then 
      	__tmp = TELL(" You can hear the sound of flowing water from below.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DEEP_CANYON_F\n'..__res) end
end
EGG_SOLVE = nil
THIEF_HERE = nil
THIEF_VS_ADVENTURER = function(...)
	local HEREQ = ...
	local ROBBEDQ
  local WINNER_ROBBEDQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(DEAD) and EQUALQ(HERE, TREASURE_ROOM)) then 
    	__tmp = PASS(NOT(DEAD) and EQUALQ(HERE, TREASURE_ROOM))
  elseif NOT(THIEF_HERE) then 
    
    if PASS(NOT(DEAD) and NOT(HEREQ) and PROB(30)) then 
      
      if INQ(STILETTO, THIEF) then 
        	__tmp = FCLEAR(THIEF, INVISIBLE)
        	__tmp = TELL("Someone carrying a large bag is casually leaning against one of the walls here. He does not speak, but it is clear from his aspect that the bag will be taken only over his dead body.", CR)
        	__tmp = APPLY(function() THIEF_HERE = T return THIEF_HERE end)
        	error(true)
      end

    elseif PASS(HEREQ and FSETQ(THIEF, FIGHTBIT) and NOT(WINNINGQ(THIEF))) then 
      	__tmp = TELL("Your opponent, determining discretion to be the better part of valor, decides to terminate this little contretemps. With a rueful nod of his head, he steps backward into the gloom and disappears.", CR)
      	__tmp = FSET(THIEF, INVISIBLE)
      	__tmp = FCLEAR(THIEF, FIGHTBIT)
      	__tmp = RECOVER_STILETTO()
      	error(true)
    elseif PASS(HEREQ and FSETQ(THIEF, FIGHTBIT) and PROB(90)) then 
      	error(false)
    elseif PASS(HEREQ and PROB(30)) then 
      	__tmp = TELL("The holder of the large bag just left, looking disgusted. Fortunately, he took nothing.", CR)
      	__tmp = FSET(THIEF, INVISIBLE)
      	__tmp = RECOVER_STILETTO()
      	error(true)
    elseif PROB(70) then 
      	error(false)
    elseif NOT(DEAD) then 
      
      if ROB(HERE, THIEF, 100) then 
        	__tmp = APPLY(function() ROBBEDQ = HERE return ROBBEDQ end)
      elseif ROB(WINNER, THIEF) then 
        	__tmp = APPLY(function() ROBBEDQ = PLAYER return ROBBEDQ end)
      end

      	__tmp = APPLY(function() THIEF_HERE = T return THIEF_HERE end)
      
      if PASS(ROBBEDQ and NOT(HEREQ)) then 
        	__tmp = TELL("A seedy-looking individual with a large bag just wandered through the room. On the way through, he quietly abstracted some valuables from ")
        
        if EQUALQ(ROBBEDQ, HERE) then 
          	__tmp = TELL("the room")
        else 
          	__tmp = TELL("your possession")
        end

        	__tmp = TELL(", mumbling something about \"Doing unto others before...\"", CR)
        	__tmp = STOLE_LIGHTQ()
      elseif HEREQ then 
        	__tmp = RECOVER_STILETTO()
        
        if ROBBEDQ then 
          	__tmp = TELL("The thief just left, still carrying his large bag. You may not have noticed that he ")
          
          if EQUALQ(ROBBEDQ, PLAYER) then 
            	__tmp = TELL("robbed you blind first.")
          elseif T then 
            	__tmp = TELL("appropriated the valuables in the room.")
          end

          	__tmp = CRLF()
          	__tmp = STOLE_LIGHTQ()
        elseif T then 
          	__tmp = TELL("The thief, finding nothing of value, left disgusted.", CR)
        end

        	__tmp = FSET(THIEF, INVISIBLE)
        	__tmp = APPLY(function() HEREQ = nil return HEREQ end)
        	error(true)
      elseif T then 
        	__tmp = TELL("A \"lean and hungry\" gentleman just wandered through, carrying a large bag. Finding nothing of value, he left disgruntled.", CR)
        	error(true)
      end

    end

  elseif T then 
    
    if HEREQ then 
      
      if PROB(30) then 
        
        if ROB(HERE, THIEF, 100) then 
          	__tmp = APPLY(function() ROBBEDQ = HERE return ROBBEDQ end)
        elseif ROB(WINNER, THIEF) then 
          	__tmp = APPLY(function() ROBBEDQ = PLAYER return ROBBEDQ end)
        end

        
        if ROBBEDQ then 
          	__tmp = TELL("The thief just left, still carrying his large bag. You may not have noticed that he ")
          
          if EQUALQ(ROBBEDQ, PLAYER) then 
            	__tmp = TELL("robbed you blind first.")
          elseif T then 
            	__tmp = TELL("appropriated the valuables in the room.")
          end

          	__tmp = CRLF()
          	__tmp = STOLE_LIGHTQ()
        elseif T then 
          	__tmp = TELL("The thief, finding nothing of value, left disgusted.", CR)
        end

        	__tmp = FSET(THIEF, INVISIBLE)
        	__tmp = APPLY(function() HEREQ = nil return HEREQ end)
        	__tmp = RECOVER_STILETTO()
      end

    end

  end

	error(false)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('THIEF_VS_ADVENTURER\n'..__res) end
end
STOLE_LIGHTQ = function(...)
	local OLD_LIT
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() OLD_LIT = LIT return OLD_LIT end)
	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)

  if PASS(NOT(LIT) and OLD_LIT) then 
    	__tmp = TELL("The thief seems to have left you in the dark.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STOLE_LIGHTQ\n'..__res) end
end
HACK_TREASURES = function(...)
	local X
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   RECOVER_STILETTO()
	__tmp =   FSET(THIEF, INVISIBLE)
	__tmp = APPLY(function() X = FIRSTQ(TREASURE_ROOM) return X end)

  local __prog49 = function()
    
    if NOT(X) then 
      return true
    elseif T then 
      	__tmp = FCLEAR(X, INVISIBLE)
    end

    APPLY(function() X = NEXTQ(X) return X end)

error(123) end
local __ok49, __res49
repeat __ok49, __res49 = pcall(__prog49)
until __ok49 or __res49 ~= 123
if not __ok49 then error(__res49)
else __tmp = __res49 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HACK_TREASURES\n'..__res) end
end
DEPOSIT_BOOTY = function(...)
	local RM = ...
	local X
	local N
  local FLG = nil
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() X = FIRSTQ(THIEF) return X end)

  local __prog50 = function()
    
    if NOT(X) then 
      error(FLG)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if EQUALQ(X, STILETTO, LARGE_BAG) then 
      	__tmp = EQUALQ(X, STILETTO, LARGE_BAG)
    elseif GQ(GETP(X, PQTVALUE), 0) then 
      	__tmp = MOVE(X, RM)
      	__tmp = APPLY(function() FLG = T return FLG end)
      
      if EQUALQ(X, EGG) then 
        	__tmp = APPLY(function() EGG_SOLVE = T return EGG_SOLVE end)
        	__tmp = FSET(EGG, OPENBIT)
      end

    end

    APPLY(function() X = N return X end)

error(123) end
local __ok50, __res50
repeat __ok50, __res50 = pcall(__prog50)
until __ok50 or __res50 ~= 123
if not __ok50 then error(__res50)
else __tmp = __res50 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DEPOSIT_BOOTY\n'..__res) end
end
ROB_MAZE = function(...)
	local RM = ...
	local X
	local N
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() X = FIRSTQ(RM) return X end)

  local __prog51 = function()
    
    if NOT(X) then 
      	error(false)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(FSETQ(X, TAKEBIT) and NOT(FSETQ(X, INVISIBLE)) and PROB(40)) then 
      	__tmp = TELL("You hear, off in the distance, someone saying \"My, I wonder what this fine ", D, X, " is doing here.\"", CR)
      
      if PROB(60, 80) then 
        	__tmp = MOVE(X, THIEF)
        	__tmp = FSET(X, TOUCHBIT)
        	__tmp = FSET(X, INVISIBLE)
      end

      return true
    end

    APPLY(function() X = N return X end)

error(123) end
local __ok51, __res51
repeat __ok51, __res51 = pcall(__prog51)
until __ok51 or __res51 ~= 123
if not __ok51 then error(__res51)
else __tmp = __res51 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ROB_MAZE\n'..__res) end
end
THIEF_ENGROSSED = nil
ROBBER_FUNCTION = function(...)
	local MODE = ...
  local FLG = nil
	local X
	if select('#', ...) < 1 then MODE = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TELL) then 
    	__tmp = TELL("The thief is a strong, silent type.", CR)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif NOT(MODE) then 
    
    if PASS(VERBQ(HELLO) and EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC)) then 
      	__tmp = TELL("The thief, being temporarily incapacitated, is unable to acknowledge your greeting with his usual graciousness.", CR)
    elseif PASS(EQUALQ(PRSO, KNIFE) and VERBQ(THROW) and NOT(FSETQ(THIEF, FIGHTBIT))) then 
      	__tmp = MOVE(PRSO, HERE)
      
      if PROB(10, 0) then 
        	__tmp = TELL("You evidently frightened the robber, though you didn't hit him. He flees")
        	__tmp = REMOVE(LARGE_BAG)
        	__tmp = APPLY(function() X = nil return X end)
        
        if INQ(STILETTO, THIEF) then 
          	__tmp = REMOVE(STILETTO)
          	__tmp = APPLY(function() X = T return X end)
        end

        
        if FIRSTQ(THIEF) then 
          	__tmp = MOVE_ALL(THIEF, HERE)
          	__tmp = TELL(", but the contents of his bag fall on the floor.")
        elseif T then 
          	__tmp = TELL(".")
        end

        	__tmp = MOVE(LARGE_BAG, THIEF)
        
        if X then 
          	__tmp = MOVE(STILETTO, THIEF)
        end

        	__tmp = CRLF()
        	__tmp = FSET(THIEF, INVISIBLE)
      elseif T then 
        	__tmp = TELL("You missed. The thief makes no attempt to take the knife, though it would be a fine addition to the collection in his bag. He does seem angered by your attempt.", CR)
        	__tmp = FSET(THIEF, FIGHTBIT)
      end

    elseif PASS(VERBQ(THROW, GIVE) and PRSO and NOT(EQUALQ(PRSO, THIEF)) and EQUALQ(PRSI, THIEF)) then 
      
      if LQ(GETP(THIEF, PQSTRENGTH), 0) then 
        	__tmp = PUTP(THIEF, PQSTRENGTH, SUB(GETP(THIEF, PQSTRENGTH)))
        	__tmp = ENABLE(INT(I_THIEF))
        	__tmp = RECOVER_STILETTO()
        	__tmp = PUTP(THIEF, PQLDESC, ROBBER_C_DESC)
        	__tmp = TELL("Your proposed victim suddenly recovers consciousness.", CR)
      end

      	__tmp = MOVE(PRSO, THIEF)
      
      if GQ(GETP(PRSO, PQTVALUE), 0) then 
        	__tmp = APPLY(function() THIEF_ENGROSSED = T return THIEF_ENGROSSED end)
        	__tmp = TELL("The thief is taken aback by your unexpected generosity, but accepts the ", D, PRSO, " and stops to admire its beauty.", CR)
      elseif T then 
        	__tmp = TELL("The thief places the ", D, PRSO, " in his bag and thanks you politely.", CR)
      end

    elseif VERBQ(TAKE) then 
      	__tmp = TELL("Once you got him, what would you do with him?", CR)
    elseif VERBQ(EXAMINE, LOOK_INSIDE) then 
      	__tmp = TELL("The thief is a slippery character with beady eyes that flit back and forth. He carries, along with an unmistakable arrogance, a large bag over his shoulder and a vicious stiletto, whose blade is aimed menacingly in your direction. I'd watch out if I were you.", CR)
    elseif VERBQ(LISTEN) then 
      	__tmp = TELL("The thief says nothing, as you have not been formally introduced.", CR)
    end

  elseif EQUALQ(MODE, F_BUSYQ) then 
    
    if INQ(STILETTO, THIEF) then 
      	__tmp = nil
    elseif INQ(STILETTO, LOC(THIEF)) then 
      	__tmp = MOVE(STILETTO, THIEF)
      	__tmp = FSET(STILETTO, NDESCBIT)
      
      if INQ(THIEF, HERE) then 
        	__tmp = TELL("The robber, somewhat surprised at this turn of events, nimbly retrieves his stiletto.", CR)
      end

      	__tmp = T
    end

  elseif EQUALQ(MODE, F_DEAD) then 
    	__tmp = MOVE(STILETTO, HERE)
    	__tmp = FCLEAR(STILETTO, NDESCBIT)
    	__tmp = APPLY(function() X = DEPOSIT_BOOTY(HERE) return X end)
    
    if EQUALQ(HERE, TREASURE_ROOM) then 
      	__tmp = APPLY(function() X = FIRSTQ(HERE) return X end)
      
      local __prog52 = function()
        
        if NOT(X) then 
          	__tmp = TELL("The chalice is now safe to take.", CR)
          return true
        elseif NOT(EQUALQ(X, CHALICE, THIEF, ADVENTURER)) then 
          	__tmp = FCLEAR(X, INVISIBLE)
          
          if NOT(FLG) then 
            	__tmp = APPLY(function() FLG = T return FLG end)
            	__tmp = TELL("As the thief dies, the power of his magic decreases, and his treasures reappear:", CR)
          end

          	__tmp = TELL("  A ", D, X)
          
          if PASS(FIRSTQ(X) and SEE_INSIDEQ(X)) then 
            	__tmp = TELL(", with ")
            	__tmp = PRINT_CONTENTS(X)
          end

          	__tmp = CRLF()
        end

        APPLY(function() X = NEXTQ(X) return X end)

error(123) end
local __ok52, __res52
repeat __ok52, __res52 = pcall(__prog52)
until __ok52 or __res52 ~= 123
if not __ok52 then error(__res52)
else __tmp = __res52 or true end

    elseif X then 
      	__tmp = TELL("His booty remains.", CR)
    end

    	__tmp = DISABLE(INT(I_THIEF))
  elseif EQUALQ(MODE, F_FIRSTQ) then 
    
    if PASS(THIEF_HERE and NOT(FSETQ(THIEF, INVISIBLE)) and PROB(20)) then 
      	__tmp = FSET(THIEF, FIGHTBIT)
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
      	__tmp = T
    end

  elseif EQUALQ(MODE, F_UNCONSCIOUS) then 
    	__tmp = DISABLE(INT(I_THIEF))
    	__tmp = FCLEAR(THIEF, FIGHTBIT)
    	__tmp = MOVE(STILETTO, HERE)
    	__tmp = FCLEAR(STILETTO, NDESCBIT)
    	__tmp = PUTP(THIEF, PQLDESC, ROBBER_U_DESC)
  elseif EQUALQ(MODE, F_CONSCIOUS) then 
    
    if EQUALQ(LOC(THIEF), HERE) then 
      	__tmp = FSET(THIEF, FIGHTBIT)
      	__tmp = TELL("The robber revives, briefly feigning continued unconsciousness, and, when he sees his moment, scrambles away from you.", CR)
    end

    	__tmp = ENABLE(INT(I_THIEF))
    	__tmp = PUTP(THIEF, PQLDESC, ROBBER_C_DESC)
    	__tmp = RECOVER_STILETTO()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ROBBER_FUNCTION\n'..__res) end
end
ROBBER_C_DESC = "There is a suspicious-looking individual, holding a bag, leaning against one wall. He is armed with a vicious-looking stiletto."
ROBBER_U_DESC = "There is a suspicious-looking individual lying unconscious on the ground."
LARGE_BAG_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    
    if EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC) then 
      	__tmp = TELL("Sadly for you, the robber collapsed on top of the bag. Trying to take it would wake him.", CR)
    elseif T then 
      	__tmp = TELL("The bag will be taken over his dead body.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, LARGE_BAG)) then 
    	__tmp = TELL("It would be a good trick.", CR)
  elseif VERBQ(OPEN, CLOSE) then 
    	__tmp = TELL("Getting close enough would be a good trick.", CR)
  elseif VERBQ(EXAMINE, LOOK_INSIDE) then 
    	__tmp = TELL("The bag is underneath the thief, so one can't say what, if anything, is inside.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LARGE_BAG_F\n'..__res) end
end
MOVE_ALL = function(...)
	local FROM, TO = ...
	local X
	local N
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() X = FIRSTQ(FROM) return X end) then 
    
    local __prog53 = function()
      
      if NOT(X) then 
        return true
      end

      APPLY(function() N = NEXTQ(X) return N end)
      FCLEAR(X, INVISIBLE)
      MOVE(X, TO)
      APPLY(function() X = N return X end)

error(123) end
local __ok53, __res53
repeat __ok53, __res53 = pcall(__prog53)
until __ok53 or __res53 ~= 123
if not __ok53 then error(__res53)
else __tmp = __res53 or true end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MOVE_ALL\n'..__res) end
end
CHALICE_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    
    if PASS(INQ(PRSO, TREASURE_ROOM) and INQ(THIEF, TREASURE_ROOM) and FSETQ(THIEF, FIGHTBIT) and NOT(FSETQ(THIEF, INVISIBLE)) and NOT(EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC))) then 
      	__tmp = TELL("You'd be stabbed in the back first.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, CHALICE)) then 
    	__tmp = TELL("You can't. It's not a very good chalice, is it?", CR)
  elseif T then 
    	__tmp = DUMB_CONTAINER()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CHALICE_FCN\n'..__res) end
end
TREASURE_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(RARG, M_ENTER) and ONEQ(GET(INT(I_THIEF), C_ENABLEDQ)) and NOT(DEAD)) then 
    
    if NOT(INQ(THIEF, HERE)) then 
      	__tmp = TELL("You hear a scream of anguish as you violate the robber's hideaway. Using passages unknown to you, he rushes to its defense.", CR)
      	__tmp = MOVE(THIEF, HERE)
    end

    	__tmp = FSET(THIEF, FIGHTBIT)
    	__tmp = FCLEAR(THIEF, INVISIBLE)
    	__tmp = THIEF_IN_TREASURE()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TREASURE_ROOM_FCN\n'..__res) end
end
THIEF_IN_TREASURE = function(...)
	local F
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() F = FIRSTQ(HERE) return F end)

  if PASS(F and NEXTQ(F)) then 
    	__tmp = TELL("The thief gestures mysteriously, and the treasures in the room suddenly vanish.", CR, CR)
  end


  local __prog54 = function()
    
    if NOT(F) then 
      return true
    elseif NOT(EQUALQ(F, CHALICE, THIEF)) then 
      	__tmp = FSET(F, INVISIBLE)
    end

    APPLY(function() F = NEXTQ(F) return F end)

error(123) end
local __ok54, __res54
repeat __ok54, __res54 = pcall(__prog54)
until __ok54 or __res54 ~= 123
if not __ok54 then error(__res54)
else __tmp = __res54 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('THIEF_IN_TREASURE\n'..__res) end
end
FRONT_DOOR_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN) then 
    	__tmp = TELL("The door cannot be opened.", CR)
  elseif VERBQ(BURN) then 
    	__tmp = TELL("You cannot burn this door.", CR)
  elseif VERBQ(MUNG) then 
    	__tmp = TELL("You can't seem to damage the door.", CR)
  elseif VERBQ(LOOK_BEHIND) then 
    	__tmp = TELL("It won't open.", CR)
  elseif VERBQ(READ) then 
    
    if EQUALQ(HERE, LIVING_ROOM) then 
      	__tmp = TELL("The engravings translate to \"This space intentionally left blank.\"")
    elseif TELL("There is no writing on this side.") then 
      	__tmp = TELL("There is no writing on this side.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FRONT_DOOR_FCN\n'..__res) end
end
BODY_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE) then 
    	__tmp = TELL("A force keeps you from taking the bodies.", CR)
  elseif VERBQ(MUNG, BURN) then 
    	__tmp = JIGS_UP("The voice of the guardian of the dungeon booms out from the darkness, \"Your disrespect costs you your life!\" and places your head on a sharp pole.")
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BODY_FUNCTION\n'..__res) end
end
BLACK_BOOK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN) then 
    	__tmp = TELL("The book is already open to page 569.", CR)
  elseif VERBQ(CLOSE) then 
    	__tmp = TELL("As hard as you try, the book cannot be closed.", CR)
  elseif PASS(VERBQ(TURN) or PASS(VERBQ(READ_PAGE) and EQUALQ(PRSI, INTNUM) and NOT(EQUALQ(P_NUMBER, 569)))) then 
    	__tmp = TELL("Beside page 569, there is only one other page with any legible printing on it. Most of it is unreadable, but the subject seems to be the banishment of evil. Apparently, certain noises, lights, and prayers are efficacious in this regard.", CR)
  elseif VERBQ(BURN) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = JIGS_UP("A booming voice says \"Wrong, cretin!\" and you notice that you have turned into a pile of dust. How, I can't imagine.")
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BLACK_BOOK\n'..__res) end
end
PAINTING_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(MUNG) then 
    	__tmp = PUTP(PRSO, PQTVALUE, 0)
    	__tmp = PUTP(PRSO, PQLDESC, "There is a worthless piece of canvas here.")
    	__tmp = TELL("Congratulations! Unlike the other vandals, who merely stole the artist's masterpieces, you have destroyed one.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PAINTING_FCN\n'..__res) end
end
LAMP_TABLE = TABLE(100,"The lamp appears a bit dimmer.",70,"The lamp is definitely dimmer now.",15,"The lamp is nearly out.",0)
LANTERN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(THROW) then 
    	__tmp = TELL("The lamp has smashed into the floor, and the light has gone out.", CR)
    	__tmp = DISABLE(INT(I_LANTERN))
    	__tmp = REMOVE_CAREFULLY(LAMP)
    	__tmp = MOVE(BROKEN_LAMP, HERE)
  elseif VERBQ(LAMP_ON) then 
    
    if FSETQ(LAMP, RMUNGBIT) then 
      	__tmp = TELL("A burned-out lamp won't light.", CR)
    elseif T then 
      	__tmp = ENABLE(INT(I_LANTERN))
      	__tmp = nil
    end

  elseif VERBQ(LAMP_OFF) then 
    
    if FSETQ(LAMP, RMUNGBIT) then 
      	__tmp = TELL("The lamp has already burned out.", CR)
    elseif T then 
      	__tmp = DISABLE(INT(I_LANTERN))
      	__tmp = nil
    end

  elseif VERBQ(EXAMINE) then 
    	__tmp = TELL("The lamp ")
    
    if FSETQ(LAMP, RMUNGBIT) then 
      	__tmp = TELL("has burned out.")
    elseif FSETQ(LAMP, ONBIT) then 
      	__tmp = TELL("is on.")
    elseif T then 
      	__tmp = TELL("is turned off.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LANTERN\n'..__res) end
end
MAILBOX_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, MAILBOX)) then 
    	__tmp = TELL("It is securely anchored.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAILBOX_F\n'..__res) end
end
MATCH_COUNT = 6
MATCH_FUNCTION = function(...)
	local CNT
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(LAMP_ON, BURN) and EQUALQ(PRSO, MATCH)) then 
    
    if GQ(MATCH_COUNT, 0) then 
      	__tmp = APPLY(function() MATCH_COUNT = SUB(MATCH_COUNT, 1) return MATCH_COUNT end)
    end

    
    if NOT(GQ(MATCH_COUNT, 0)) then 
      	__tmp = TELL("I'm afraid that you have run out of matches.", CR)
    elseif EQUALQ(HERE, LOWER_SHAFT, TIMBER_ROOM) then 
      	__tmp = TELL("This room is drafty, and the match goes out instantly.", CR)
    elseif T then 
      	__tmp = FSET(MATCH, FLAMEBIT)
      	__tmp = FSET(MATCH, ONBIT)
      	__tmp = ENABLE(QUEUE(I_MATCH, 2))
      	__tmp = TELL("One of the matches starts to burn.", CR)
      
      if NOT(LIT) then 
        	__tmp = APPLY(function() LIT = T return LIT end)
        	__tmp = V_LOOK()
      end

      	error(true)
    end

  elseif PASS(VERBQ(LAMP_OFF) and FSETQ(MATCH, FLAMEBIT)) then 
    	__tmp = TELL("The match is out.", CR)
    	__tmp = FCLEAR(MATCH, FLAMEBIT)
    	__tmp = FCLEAR(MATCH, ONBIT)
    	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if NOT(LIT) then 
      	__tmp = TELL("It's pitch black in here!", CR)
    end

    	__tmp = QUEUE(I_MATCH, 0)
    	error(true)
  elseif VERBQ(COUNT, OPEN) then 
    	__tmp = TELL("You have ")
    	__tmp = APPLY(function() CNT = SUB(MATCH_COUNT, 1) return CNT end)
    
    if NOT(GQ(CNT, 0)) then 
      	__tmp = TELL("no")
    elseif T then 
      	__tmp = TELL(N, CNT)
    end

    	__tmp = TELL(" match")
    
    if NOT(ONEQ(CNT)) then 
      	__tmp = TELL("es.")
    elseif T then 
      	__tmp = TELL(".")
    end

    	__tmp = CRLF()
  elseif VERBQ(EXAMINE) then 
    
    if FSETQ(MATCH, ONBIT) then 
      	__tmp = TELL("The match is burning.")
    elseif T then 
      	__tmp = TELL("The matchbook isn't very interesting, except for what's written on it.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MATCH_FUNCTION\n'..__res) end
end
I_MATCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The match has gone out.", CR)
	__tmp =   FCLEAR(MATCH, FLAMEBIT)
	__tmp =   FCLEAR(MATCH, ONBIT)
	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_MATCH\n'..__res) end
end
I_LANTERN = function(...)
	local TICK
  local TBL = VALUE(LAMP_TABLE)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   ENABLE(QUEUE(I_LANTERN, APPLY(function() TICK = GET(TBL, 0) return TICK end)))
	__tmp =   LIGHT_INT(LAMP, TBL, TICK)

  if NOT(ZEROQ(TICK)) then 
    	__tmp = APPLY(function() LAMP_TABLE = REST(TBL, 4) return LAMP_TABLE end)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_LANTERN\n'..__res) end
end
I_CANDLES = function(...)
	local TICK
  local TBL = VALUE(CANDLE_TABLE)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   FSET(CANDLES, TOUCHBIT)
	__tmp =   ENABLE(QUEUE(I_CANDLES, APPLY(function() TICK = GET(TBL, 0) return TICK end)))
	__tmp =   LIGHT_INT(CANDLES, TBL, TICK)

  if NOT(ZEROQ(TICK)) then 
    	__tmp = APPLY(function() CANDLE_TABLE = REST(TBL, 4) return CANDLE_TABLE end)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_CANDLES\n'..__res) end
end
LIGHT_INT = function(...)
	local OBJ, TBL, TICK = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if ZEROQ(TICK) then 
    	__tmp = FCLEAR(OBJ, ONBIT)
    	__tmp = FSET(OBJ, RMUNGBIT)
  end


  if PASS(HELDQ(OBJ) or INQ(OBJ, HERE)) then 
    
    if ZEROQ(TICK) then 
      	__tmp = TELL("You'd better have more light than from the ", D, OBJ, ".", CR)
    elseif T then 
      	__tmp = TELL(GET(TBL, 1), CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LIGHT_INT\n'..__res) end
end
MIN = function(...)
	local N1, N2 = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if LQ(N1, N2) then 
    	__tmp = N1
  elseif T then 
    	__tmp = N2
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MIN\n'..__res) end
end
CANDLES_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FSETQ(CANDLES, TOUCHBIT)) then 
    	__tmp = ENABLE(INT(I_CANDLES))
  end


  if EQUALQ(CANDLES, PRSI) then 
    	error(false)
  elseif T then 
    
    if VERBQ(LAMP_ON, BURN) then 
      
      if FSETQ(CANDLES, RMUNGBIT) then 
        	__tmp = TELL("Alas, there's not much left of the candles. Certainly not enough to burn.", CR)
      elseif NOT(PRSI) then 
        
        if FSETQ(MATCH, FLAMEBIT) then 
          	__tmp = TELL("(with the match)", CR)
          	__tmp = PERFORM(VQLAMP_ON, CANDLES, MATCH)
          	error(true)
        elseif T then 
          	__tmp = TELL("You should say what to light them with.", CR)
          	__tmp = 	error(2)
        end

      elseif PASS(EQUALQ(PRSI, MATCH) and FSETQ(MATCH, ONBIT)) then 
        	__tmp = TELL("The candles are ")
        
        if FSETQ(CANDLES, ONBIT) then 
          	__tmp = TELL("already lit.", CR)
        elseif T then 
          	__tmp = FSET(CANDLES, ONBIT)
          	__tmp = TELL("lit.", CR)
          	__tmp = ENABLE(INT(I_CANDLES))
        end

      elseif EQUALQ(PRSI, TORCH) then 
        
        if FSETQ(CANDLES, ONBIT) then 
          	__tmp = TELL("You realize, just in time, that the candles are already lighted.", CR)
        elseif T then 
          	__tmp = TELL("The heat from the torch is so intense that the candles are vaporized.", CR)
          	__tmp = REMOVE_CAREFULLY(CANDLES)
        end

      elseif T then 
        	__tmp = TELL("You have to light them with something that's burning, you know.", CR)
      end

    elseif VERBQ(COUNT) then 
      	__tmp = TELL("Let's see, how many objects in a pair? Don't tell me, I'll get it.", CR)
    elseif VERBQ(LAMP_OFF) then 
      	__tmp = DISABLE(INT(I_CANDLES))
      
      if FSETQ(CANDLES, ONBIT) then 
        	__tmp = TELL("The flame is extinguished.")
        	__tmp = FCLEAR(CANDLES, ONBIT)
        	__tmp = FSET(CANDLES, TOUCHBIT)
        	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
        
        if NOT(LIT) then 
          	__tmp = TELL(" It's really dark in here....")
        end

        	__tmp = CRLF()
        	error(true)
      elseif T then 
        	__tmp = TELL("The candles are not lighted.", CR)
      end

    elseif PASS(VERBQ(PUT) and FSETQ(PRSI, BURNBIT)) then 
      	__tmp = TELL("That wouldn't be smart.", CR)
    elseif VERBQ(EXAMINE) then 
      	__tmp = TELL("The candles are ")
      
      if FSETQ(CANDLES, ONBIT) then 
        	__tmp = TELL("burning.")
      elseif T then 
        	__tmp = TELL("out.")
      end

      	__tmp = CRLF()
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CANDLES_FCN\n'..__res) end
end
CANDLE_TABLE = TABLE(20,"The candles grow shorter.",10,"The candles are becoming quite short.",5,"The candles won't last long now.",0)
CAVE2_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_END) then 
    
    if PASS(INQ(CANDLES, WINNER) and PROB(50, 80) and FSETQ(CANDLES, ONBIT)) then 
      	__tmp = DISABLE(INT(I_CANDLES))
      	__tmp = FCLEAR(CANDLES, ONBIT)
      	__tmp = TELL("A gust of wind blows out your candles!", CR)
      
      if NOT(APPLY(function() LIT = LITQ(HERE) return LIT end)) then 
        	__tmp = TELL("It is now completely dark.", CR)
      end

    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CAVE2_ROOM\n'..__res) end
end
SWORD_FCN = function(...)
	local G
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(TAKE) and EQUALQ(WINNER, ADVENTURER)) then 
    	__tmp = ENABLE(QUEUE(I_SWORD, -1))
    	__tmp = nil
  elseif VERBQ(EXAMINE) then 
    
    if EQUALQ(APPLY(function() G = GETP(SWORD, PQTVALUE) return G end), 1) then 
      	__tmp = TELL("Your sword is glowing with a faint blue glow.", CR)
    elseif EQUALQ(G, 2) then 
      	__tmp = TELL("Your sword is glowing very brightly.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SWORD_FCN\n'..__res) end
end
BOOM_ROOM = function(...)
	local RARG = ...
  local DUMMYQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_END) then 
    
    if PASS(EQUALQ(RARG, M_END) and VERBQ(LAMP_ON, BURN) and EQUALQ(PRSO, CANDLES, TORCH, MATCH)) then 
      	__tmp = APPLY(function() DUMMYQ = T return DUMMYQ end)
    end

    
    if PASS(PASS(HELDQ(CANDLES) and FSETQ(CANDLES, ONBIT)) or PASS(HELDQ(TORCH) and FSETQ(TORCH, ONBIT)) or PASS(HELDQ(MATCH) and FSETQ(MATCH, ONBIT))) then 
      
      if DUMMYQ then 
        	__tmp = TELL("How sad for an aspiring adventurer to light a ", D, PRSO, " in a room which reeks of gas. Fortunately, there is justice in the world.", CR)
      elseif T then 
        	__tmp = TELL("Oh dear. It appears that the smell coming from this room was coal gas. I would have thought twice about carrying flaming objects in here.", CR)
      end

      	__tmp = JIGS_UP("|       ** BOOOOOOOOOOOM **")
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BOOM_ROOM\n'..__res) end
end
BAT_D = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(LOC(GARLIC), WINNER, HERE) then 
    	__tmp = TELL("In the corner of the room on the ceiling is a large vampire bat who is obviously deranged and holding his nose.", CR)
  elseif T then 
    	__tmp = TELL("A large vampire bat, hanging from the ceiling, swoops down at you!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BAT_D\n'..__res) end
end
BATS_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are in a small room which has doors only to the east and south.", CR)
  elseif PASS(EQUALQ(RARG, M_ENTER) and NOT(DEAD)) then 
    
    if NOT(EQUALQ(LOC(GARLIC), WINNER, HERE)) then 
      	__tmp = V_LOOK()
      	__tmp = CRLF()
      	__tmp = FLY_ME()
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BATS_ROOM\n'..__res) end
end
MACHINE_ROOM_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("This is a large, cold room whose sole exit is to the north. In one corner there is a machine which is reminiscent of a clothes dryer. On its face is a switch which is labelled \"START\". The switch does not appear to be manipulable by any human hand (unless the fingers are about 1/16 by 1/4 inch). On the front of the machine is a large lid, which is ")
    
    if FSETQ(MACHINE, OPENBIT) then 
      	__tmp = TELL("open.")
    elseif T then 
      	__tmp = TELL("closed.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MACHINE_ROOM_FCN\n'..__res) end
end
MACHINE_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, MACHINE)) then 
    	__tmp = TELL("It is far too large to carry.", CR)
  elseif VERBQ(OPEN) then 
    
    if FSETQ(MACHINE, OPENBIT) then 
      	__tmp = TELL(PICK_ONE(DUMMY), CR)
    elseif FIRSTQ(MACHINE) then 
      	__tmp = TELL("The lid opens, revealing ")
      	__tmp = PRINT_CONTENTS(MACHINE)
      	__tmp = TELL(".", CR)
      	__tmp = FSET(MACHINE, OPENBIT)
    elseif T then 
      	__tmp = TELL("The lid opens.", CR)
      	__tmp = FSET(MACHINE, OPENBIT)
    end

  elseif VERBQ(CLOSE) then 
    
    if FSETQ(MACHINE, OPENBIT) then 
      	__tmp = TELL("The lid closes.", CR)
      	__tmp = FCLEAR(MACHINE, OPENBIT)
      	__tmp = T
    elseif T then 
      	__tmp = TELL(PICK_ONE(DUMMY), CR)
    end

  elseif VERBQ(LAMP_ON) then 
    
    if NOT(PRSI) then 
      	__tmp = TELL("It's not clear how to turn it on with your bare hands.", CR)
    elseif T then 
      	__tmp = PERFORM(VQTURN, MACHINE_SWITCH, PRSI)
      	error(true)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MACHINE_F\n'..__res) end
end
MSWITCH_FUNCTION = function(...)
	local O
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TURN) then 
    
    if EQUALQ(PRSI, SCREWDRIVER) then 
      
      if FSETQ(MACHINE, OPENBIT) then 
        	__tmp = TELL("The machine doesn't seem to want to do anything.", CR)
      elseif T then 
        	__tmp = TELL("The machine comes to life (figuratively) with a dazzling display of colored lights and bizarre noises. After a few moments, the excitement abates.", CR)
        
        if INQ(COAL, MACHINE) then 
          	__tmp = REMOVE_CAREFULLY(COAL)
          	__tmp = MOVE(DIAMOND, MACHINE)
        elseif T then 
          
          local __prog55 = function()
            
            if APPLY(function() O = FIRSTQ(MACHINE) return O end) then 
              	__tmp = REMOVE_CAREFULLY(O)
            elseif T then 
              return true
            end


error(123) end
local __ok55, __res55
repeat __ok55, __res55 = pcall(__prog55)
until __ok55 or __res55 ~= 123
if not __ok55 then error(__res55)
else __tmp = __res55 or true end

          	__tmp = MOVE(GUNK, MACHINE)
        end

      end

    elseif NOT(EQUALQ(PRSI, nil, HANDS, ROOMS)) then 
      	__tmp = TELL("It seems that a ", D, PRSI, " won't do.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MSWITCH_FUNCTION\n'..__res) end
end
GUNK_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   REMOVE_CAREFULLY(GUNK)
	__tmp =   TELL("The slag was rather insubstantial, and crumbles into dust at your touch.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GUNK_FUNCTION\n'..__res) end
end
NO_OBJS = function(...)
	local RARG = ...
	local F
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_BEG) then 
    	__tmp = APPLY(function() F = FIRSTQ(WINNER) return F end)
    	__tmp = APPLY(function() EMPTY_HANDED = T return EMPTY_HANDED end)
    
    local __prog56 = function()
      
      if NOT(F) then 
        return true
      elseif GQ(WEIGHT(F), 4) then 
        	__tmp = APPLY(function() EMPTY_HANDED = nil return EMPTY_HANDED end)
        return true
      end

      APPLY(function() F = NEXTQ(F) return F end)

error(123) end
local __ok56, __res56
repeat __ok56, __res56 = pcall(__prog56)
until __ok56 or __res56 ~= 123
if not __ok56 then error(__res56)
else __tmp = __res56 or true end

    
    if PASS(EQUALQ(HERE, LOWER_SHAFT) and LIT) then 
      	__tmp = SCORE_UPD(LIGHT_SHAFT)
      	__tmp = APPLY(function() LIGHT_SHAFT = 0 return LIGHT_SHAFT end)
    end

    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NO_OBJS\n'..__res) end
end
SOUTH_TEMPLE_FCN = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_BEG) then 
    	__tmp = APPLY(function() COFFIN_CURE = NOT(INQ(COFFIN, WINNER)) return COFFIN_CURE end)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SOUTH_TEMPLE_FCN\n'..__res) end
end
LIGHT_SHAFT = 13
WHITE_CLIFFS_FUNCTION = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_END) then 
    
    if INQ(INFLATED_BOAT, WINNER) then 
      	__tmp = APPLY(function() DEFLATE = nil return DEFLATE end)
    elseif T then 
      	__tmp = APPLY(function() DEFLATE = T return DEFLATE end)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WHITE_CLIFFS_FUNCTION\n'..__res) end
end
SCEPTRE_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(WAVE, RAISE) then 
    
    if PASS(EQUALQ(HERE, ARAGAIN_FALLS) or EQUALQ(HERE, END_OF_RAINBOW)) then 
      
      if NOT(RAINBOW_FLAG) then 
        	__tmp = FCLEAR(POT_OF_GOLD, INVISIBLE)
        	__tmp = TELL("Suddenly, the rainbow appears to become solid and, I venture, walkable (I think the giveaway was the stairs and bannister).", CR)
        
        if PASS(EQUALQ(HERE, END_OF_RAINBOW) and INQ(POT_OF_GOLD, END_OF_RAINBOW)) then 
          	__tmp = TELL("A shimmering pot of gold appears at the end of the rainbow.", CR)
        end

        	__tmp = APPLY(function() RAINBOW_FLAG = T return RAINBOW_FLAG end)
      elseif T then 
        	__tmp = ROB(ON_RAINBOW, WALL)
        	__tmp = TELL("The rainbow seems to have become somewhat run-of-the-mill.", CR)
        	__tmp = APPLY(function() RAINBOW_FLAG = nil return RAINBOW_FLAG end)
        	error(true)
      end

    elseif EQUALQ(HERE, ON_RAINBOW) then 
      	__tmp = APPLY(function() RAINBOW_FLAG = nil return RAINBOW_FLAG end)
      	__tmp = JIGS_UP("The structural integrity of the rainbow is severely compromised, leaving you hanging in midair, supported only by water vapor. Bye.")
    elseif T then 
      	__tmp = TELL("A dazzling display of color briefly emanates from the sceptre.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SCEPTRE_FUNCTION\n'..__res) end
end
FALLS_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are at the top of Aragain Falls, an enormous waterfall with a drop of about 450 feet. The only path here is on the north end.", CR)
    
    if RAINBOW_FLAG then 
      	__tmp = TELL("A solid rainbow spans the falls.")
    elseif T then 
      	__tmp = TELL("A beautiful rainbow can be seen over the falls and to the west.")
    end

    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FALLS_ROOM\n'..__res) end
end
RAINBOW_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(CROSS, THROUGH) then 
    
    if EQUALQ(HERE, CANYON_VIEW) then 
      	__tmp = TELL("From here?!?", CR)
      	error(true)
    end

    
    if RAINBOW_FLAG then 
      
      if EQUALQ(HERE, ARAGAIN_FALLS) then 
        	__tmp = GOTO(END_OF_RAINBOW)
      elseif EQUALQ(HERE, END_OF_RAINBOW) then 
        	__tmp = GOTO(ARAGAIN_FALLS)
      elseif T then 
        	__tmp = TELL("You'll have to say which way...", CR)
      end

    elseif T then 
      	__tmp = TELL("Can you walk on water vapor?", CR)
    end

  elseif VERBQ(LOOK_UNDER) then 
    	__tmp = TELL("The Frigid River flows under the rainbow.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RAINBOW_FCN\n'..__res) end
end
DBOAT_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(PUT, PUT_ON) and EQUALQ(PRSO, PUTTY)) then 
    	__tmp = FIX_BOAT()
  elseif VERBQ(INFLATE, FILL) then 
    	__tmp = TELL("No chance. Some moron punctured it.", CR)
  elseif VERBQ(PLUG) then 
    
    if EQUALQ(PRSI, PUTTY) then 
      	__tmp = FIX_BOAT()
    elseif T then 
      	__tmp = WITH_TELL(PRSI)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DBOAT_FUNCTION\n'..__res) end
end
FIX_BOAT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Well done. The boat is repaired.", CR)
	__tmp =   MOVE(INFLATABLE_BOAT, LOC(PUNCTURED_BOAT))
	__tmp =   REMOVE_CAREFULLY(PUNCTURED_BOAT)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIX_BOAT\n'..__res) end
end
RIVER_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(PUT) then 
    
    if EQUALQ(PRSI, RIVER) then 
      
      if EQUALQ(PRSO, ME) then 
        	__tmp = JIGS_UP("You splash around for a while, fighting the current, then you drown.")
      elseif EQUALQ(PRSO, INFLATED_BOAT) then 
        	__tmp = TELL("You should get in the boat then launch it.", CR)
      elseif FSETQ(PRSO, BURNBIT) then 
        	__tmp = REMOVE_CAREFULLY(PRSO)
        	__tmp = TELL("The ", D, PRSO, " floats for a moment, then sinks.", CR)
      elseif T then 
        	__tmp = REMOVE_CAREFULLY(PRSO)
        	__tmp = TELL("The ", D, PRSO, " splashes into the water and is gone forever.", CR)
      end

    end

  elseif VERBQ(LEAP, THROUGH) then 
    	__tmp = TELL("A look before leaping reveals that the river is wide and dangerous, with swift currents and large, half-hidden rocks. You decide to forgo your swim.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RIVER_FUNCTION\n'..__res) end
end
RIVER_SPEEDS = LTABLE(RIVER_1,4,RIVER_2,4,RIVER_3,3,RIVER_4,2,RIVER_5,1)
RIVER_NEXT = LTABLE(RIVER_1,RIVER_2,RIVER_3,RIVER_4,RIVER_5)
RIVER_LAUNCH = LTABLE(DAM_BASE,RIVER_1,WHITE_CLIFFS_NORTH,RIVER_3,WHITE_CLIFFS_SOUTH,RIVER_4,SHORE,RIVER_5,SANDY_BEACH,RIVER_4,RESERVOIR_SOUTH,RESERVOIR,RESERVOIR_NORTH,RESERVOIR,STREAM_VIEW,IN_STREAM)
I_RIVER = function(...)
	local RM
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(EQUALQ(HERE, RIVER_1, RIVER_2, RIVER_3)) and NOT(EQUALQ(HERE, RIVER_4, RIVER_5))) then 
    	__tmp = DISABLE(INT(I_RIVER))
  elseif APPLY(function() RM = LKP(HERE, RIVER_NEXT) return RM end) then 
    	__tmp = TELL("The flow of the river carries you downstream.", CR, CR)
    	__tmp = GOTO(RM)
    	__tmp = ENABLE(QUEUE(I_RIVER, LKP(HERE, RIVER_SPEEDS)))
  elseif T then 
    	__tmp = JIGS_UP("Unfortunately, the magic boat doesn't provide protection from the rocks and boulders one meets at the bottom of waterfalls. Including this one.")
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_RIVER\n'..__res) end
end
RBOAT_FUNCTION = function(...)
	local RARG = ...
	local TMP
	if select('#', ...) < 1 then RARG = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_ENTER, M_END, M_LOOK) then 
    	__tmp = nil
  elseif EQUALQ(RARG, M_BEG) then 
    
    if VERBQ(WALK) then 
      
      if EQUALQ(PRSO, PQLAND, PQEAST, PQWEST) then 
        	error(false)
      elseif PASS(EQUALQ(HERE, RESERVOIR) and EQUALQ(PRSO, PQNORTH, PQSOUTH)) then 
        	error(false)
      elseif PASS(EQUALQ(HERE, IN_STREAM) and EQUALQ(PRSO, PQSOUTH)) then 
        	error(false)
      elseif T then 
        	__tmp = TELL("Read the label for the boat's instructions.", CR)
        	error(true)
      end

    elseif VERBQ(LAUNCH) then 
      
      if PASS(EQUALQ(HERE, RIVER_1, RIVER_2, RIVER_3) or EQUALQ(HERE, RIVER_4, RESERVOIR, IN_STREAM)) then 
        	__tmp = TELL("You are on the ")
        
        if EQUALQ(HERE, RESERVOIR) then 
          	__tmp = TELL("reservoir")
        elseif EQUALQ(HERE, IN_STREAM) then 
          	__tmp = TELL("stream")
        elseif T then 
          	__tmp = TELL("river")
        end

        	__tmp = TELL(", or have you forgotten?", CR)
      elseif EQUALQ(APPLY(function() TMP = GO_NEXT(RIVER_LAUNCH) return TMP end), 1) then 
        	__tmp = ENABLE(QUEUE(I_RIVER, LKP(HERE, RIVER_SPEEDS)))
        	error(true)
      elseif NOT(EQUALQ(TMP, 2)) then 
        	__tmp = TELL("You can't launch it here.", CR)
        	error(true)
      elseif T then 
        	error(true)
      end

    elseif PASS(PASS(VERBQ(DROP) and FSETQ(PRSO, WEAPONBIT)) or PASS(VERBQ(PUT) and FSETQ(PRSO, WEAPONBIT) and EQUALQ(PRSI, INFLATED_BOAT)) or PASS(VERBQ(ATTACK, MUNG) and FSETQ(PRSI, WEAPONBIT))) then 
      	__tmp = REMOVE_CAREFULLY(INFLATED_BOAT)
      	__tmp = MOVE(PUNCTURED_BOAT, HERE)
      	__tmp = ROB(INFLATED_BOAT, HERE)
      	__tmp = MOVE(WINNER, HERE)
      	__tmp = TELL("It seems that the ")
      
      if VERBQ(DROP, PUT) then 
        	__tmp = TELL(D, PRSO)
      elseif T then 
        	__tmp = TELL(D, PRSI)
      end

      	__tmp = TELL(" didn't agree with the boat, as evidenced by the loud hissing noise issuing therefrom. With a pathetic sputter, the boat deflates, leaving you without.", CR)
      
      if FSETQ(HERE, NONLANDBIT) then 
        	__tmp = CRLF()
        
        if EQUALQ(HERE, RESERVOIR, IN_STREAM) then 
          	__tmp = JIGS_UP("Another pathetic sputter, this time from you, heralds your drowning.")
        elseif T then 
          	__tmp = JIGS_UP("In other words, fighting the fierce currents of the Frigid River. You manage to hold your own for a bit, but then you are carried over a waterfall and into some nasty rocks. Ouch!")
        end

      end

      	error(true)
    elseif VERBQ(LAUNCH) then 
      	__tmp = TELL("You're not in the boat!", CR)
    end

  elseif VERBQ(BOARD) then 
    
    if PASS(INQ(SCEPTRE, WINNER) or INQ(KNIFE, WINNER) or INQ(SWORD, WINNER) or INQ(RUSTY_KNIFE, WINNER) or INQ(AXE, WINNER) or INQ(STILETTO, WINNER)) then 
      	__tmp = TELL("Oops! Something sharp seems to have slipped and punctured the boat. The boat deflates to the sounds of hissing, sputtering, and cursing.", CR)
      	__tmp = REMOVE_CAREFULLY(INFLATED_BOAT)
      	__tmp = MOVE(PUNCTURED_BOAT, HERE)
      	__tmp = THIS_IS_IT(PUNCTURED_BOAT)
      	__tmp = T
    end

  elseif VERBQ(INFLATE, FILL) then 
    	__tmp = TELL("Inflating it further would probably burst it.", CR)
  elseif VERBQ(DEFLATE) then 
    
    if EQUALQ(LOC(WINNER), INFLATED_BOAT) then 
      	__tmp = TELL("You can't deflate the boat while you're in it.", CR)
    elseif NOT(INQ(INFLATED_BOAT, HERE)) then 
      	__tmp = TELL("The boat must be on the ground to be deflated.", CR)
    elseif T then 
      	__tmp = TELL("The boat deflates.", CR)
      	__tmp = APPLY(function() DEFLATE = T return DEFLATE end)
      	__tmp = REMOVE_CAREFULLY(INFLATED_BOAT)
      	__tmp = MOVE(INFLATABLE_BOAT, HERE)
      	__tmp = THIS_IS_IT(INFLATABLE_BOAT)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RBOAT_FUNCTION\n'..__res) end
end
BREATHE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQINFLATE, PRSO, LUNGS)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BREATHE\n'..__res) end
end
IBOAT_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(INFLATE, FILL) then 
    
    if NOT(INQ(INFLATABLE_BOAT, HERE)) then 
      	__tmp = TELL("The boat must be on the ground to be inflated.", CR)
    elseif EQUALQ(PRSI, PUMP) then 
      	__tmp = TELL("The boat inflates and appears seaworthy.", CR)
      
      if NOT(FSETQ(BOAT_LABEL, TOUCHBIT)) then 
        	__tmp = TELL("A tan label is lying inside the boat.", CR)
      end

      	__tmp = APPLY(function() DEFLATE = nil return DEFLATE end)
      	__tmp = REMOVE_CAREFULLY(INFLATABLE_BOAT)
      	__tmp = MOVE(INFLATED_BOAT, HERE)
      	__tmp = THIS_IS_IT(INFLATED_BOAT)
    elseif EQUALQ(PRSI, LUNGS) then 
      	__tmp = TELL("You don't have enough lung power to inflate it.", CR)
    elseif T then 
      	__tmp = TELL("With a ", D, PRSI, "? Surely you jest!", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('IBOAT_FUNCTION\n'..__res) end
end
BUOY_FLAG = T
RIVR4_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_END) then 
    
    if PASS(INQ(BUOY, WINNER) and BUOY_FLAG) then 
      	__tmp = TELL("You notice something funny about the feel of the buoy.", CR)
      	__tmp = APPLY(function() BUOY_FLAG = nil return BUOY_FLAG end)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RIVR4_ROOM\n'..__res) end
end
BEACH_DIG = -1
SAND_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(DIG) and EQUALQ(PRSI, SHOVEL)) then 
    	__tmp = APPLY(function() BEACH_DIG = ADD(1, BEACH_DIG) return BEACH_DIG end)
    
    if GQ(BEACH_DIG, 3) then 
      	__tmp = APPLY(function() BEACH_DIG = -1 return BEACH_DIG end)
      	__tmp = PASS(INQ(SCARAB, HERE) and FSET(SCARAB, INVISIBLE))
      	__tmp = JIGS_UP("The hole collapses, smothering you.")
    elseif EQUALQ(BEACH_DIG, 3) then 
      
      if FSETQ(SCARAB, INVISIBLE) then 
        	__tmp = TELL("You can see a scarab here in the sand.", CR)
        	__tmp = THIS_IS_IT(SCARAB)
        	__tmp = FCLEAR(SCARAB, INVISIBLE)
      end

    elseif T then 
      	__tmp = TELL(GET(BDIGS, BEACH_DIG), CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SAND_FUNCTION\n'..__res) end
end
BDIGS = TABLE("You seem to be digging a hole here.","The hole is getting deeper, but that's about it.","You are surrounded by a wall of sand on all sides.")
TREE_ROOM = function(...)
	local RARG = ...
	local F
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_LOOK) then 
    	__tmp = TELL("You are about 10 feet above the ground nestled among some large branches. The nearest branch above you is above your reach.", CR)
    
    if PASS(APPLY(function() F = FIRSTQ(PATH) return F end) and NEXTQ(F)) then 
      	__tmp = TELL("On the ground below you can see:  ")
      	__tmp = PRINT_CONTENTS(PATH)
      	__tmp = TELL(".", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_DOWN) and EQUALQ(PRSO, TREE, ROOMS)) then 
      	__tmp = DO_WALK(PQDOWN)
    elseif PASS(VERBQ(CLIMB_UP, CLIMB_FOO) and EQUALQ(PRSO, TREE)) then 
      	__tmp = DO_WALK(PQUP)
    elseif VERBQ(DROP) then 
      
      if NOT(IDROP()) then 
        	error(true)
      elseif PASS(EQUALQ(PRSO, NEST) and INQ(EGG, NEST)) then 
        	__tmp = TELL("The nest falls to the ground, and the egg spills out of it, seriously damaged.", CR)
        	__tmp = REMOVE_CAREFULLY(EGG)
        	__tmp = MOVE(BROKEN_EGG, PATH)
      elseif EQUALQ(PRSO, EGG) then 
        	__tmp = TELL("The egg falls to the ground and springs open, seriously damaged.")
        	__tmp = MOVE(EGG, PATH)
        	__tmp = BAD_EGG()
        	__tmp = CRLF()
      elseif NOT(EQUALQ(PRSO, WINNER, TREE)) then 
        	__tmp = MOVE(PRSO, PATH)
        	__tmp = TELL("The ", D, PRSO, " falls to the ground.", CR)
      elseif VERBQ(LEAP) then 
        	__tmp = JIGS_UP("That was just a bit too far down.")
      end

    end

  elseif EQUALQ(RARG, M_ENTER) then 
    	__tmp = ENABLE(QUEUE(I_FOREST_ROOM, -1))
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TREE_ROOM\n'..__res) end
end
EGG_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(OPEN, MUNG) and EQUALQ(PRSO, EGG)) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = TELL("The egg is already open.", CR)
    elseif NOT(PRSI) then 
      	__tmp = TELL("You have neither the tools nor the expertise.", CR)
    elseif EQUALQ(PRSI, HANDS) then 
      	__tmp = TELL("I doubt you could do that without damaging it.", CR)
    elseif PASS(FSETQ(PRSI, WEAPONBIT) or FSETQ(PRSI, TOOLBIT) or VERBQ(MUNG)) then 
      	__tmp = TELL("The egg is now open, but the clumsiness of your attempt has seriously compromised its esthetic appeal.")
      	__tmp = BAD_EGG()
      	__tmp = CRLF()
    elseif FSETQ(PRSO, FIGHTBIT) then 
      	__tmp = TELL("Not to say that using the ", D, PRSI, " isn't original too...", CR)
    elseif T then 
      	__tmp = TELL("The concept of using a ", D, PRSI, " is certainly original.", CR)
      	__tmp = FSET(PRSO, FIGHTBIT)
    end

  elseif VERBQ(CLIMB_ON, HATCH) then 
    	__tmp = TELL("There is a noticeable crunch from beneath you, and inspection reveals that the egg is lying open, badly damaged.")
    	__tmp = BAD_EGG()
    	__tmp = CRLF()
  elseif VERBQ(OPEN, MUNG, THROW) then 
    
    if VERBQ(THROW) then 
      	__tmp = MOVE(PRSO, HERE)
    end

    	__tmp = TELL("Your rather indelicate handling of the egg has caused it some damage, although you have succeeded in opening it.")
    	__tmp = BAD_EGG()
    	__tmp = CRLF()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('EGG_OBJECT\n'..__res) end
end
BAD_EGG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if INQ(CANARY, EGG) then 
    	__tmp = TELL(" ", GETP(BROKEN_CANARY, PQFDESC))
  elseif T then 
    	__tmp = REMOVE_CAREFULLY(BROKEN_CANARY)
  end

	__tmp =   MOVE(BROKEN_EGG, LOC(EGG))
	__tmp =   REMOVE_CAREFULLY(EGG)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BAD_EGG\n'..__res) end
end
SING_SONG = nil
CANARY_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(WIND) then 
    
    if EQUALQ(PRSO, CANARY) then 
      
      if PASS(NOT(SING_SONG) and FOREST_ROOMQ()) then 
        	__tmp = TELL("The canary chirps, slightly off-key, an aria from a forgotten opera. From out of the greenery flies a lovely songbird. It perches on a limb just over your head and opens its beak to sing. As it does so a beautiful brass bauble drops from its mouth, bounces off the top of your head, and lands glimmering in the grass. As the canary winds down, the songbird flies away.", CR)
        	__tmp = APPLY(function() SING_SONG = T return SING_SONG end)
        	__tmp = MOVE(BAUBLE, APPLY(function()
          if EQUALQ(HERE, UP_A_TREE) then 
            	__tmp = PATH
          elseif T then 
            	__tmp = HERE
          end
 end))
      elseif T then 
        	__tmp = TELL("The canary chirps blithely, if somewhat tinnily, for a short time.", CR)
      end

    elseif T then 
      	__tmp = TELL("There is an unpleasant grinding noise from inside the canary.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CANARY_OBJECT\n'..__res) end
end
FOREST_ROOMQ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PASS(EQUALQ(HERE, FOREST_1, FOREST_2, FOREST_3) or EQUALQ(HERE, PATH, UP_A_TREE))
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FOREST_ROOMQ\n'..__res) end
end
I_FOREST_ROOM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FOREST_ROOMQ()) then 
    	__tmp = DISABLE(INT(I_FOREST_ROOM))
    	error(false)
  elseif PROB(15) then 
    	__tmp = TELL("You hear in the distance the chirping of a song bird.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_FOREST_ROOM\n'..__res) end
end
FOREST_ROOM = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(RARG, M_ENTER) then 
    	__tmp = ENABLE(QUEUE(I_FOREST_ROOM, -1))
  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_FOO, CLIMB_UP) and EQUALQ(PRSO, TREE)) then 
      	__tmp = DO_WALK(PQUP)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FOREST_ROOM\n'..__res) end
end
WCLIF_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) then 
    	__tmp = TELL("The cliff is too steep for climbing.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WCLIF_OBJECT\n'..__res) end
end
CLIFF_OBJECT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(LEAP) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    	__tmp = TELL("That would be very unwise. Perhaps even fatal.", CR)
  elseif EQUALQ(PRSI, CLIMBABLE_CLIFF) then 
    
    if VERBQ(PUT, THROW_OFF) then 
      	__tmp = TELL("The ", D, PRSO, " tumbles into the river and is seen no more.", CR)
      	__tmp = REMOVE_CAREFULLY(PRSO)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CLIFF_OBJECT\n'..__res) end
end
ROPE_FUNCTION = function(...)
	local RLOC
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(EQUALQ(HERE, DOME_ROOM)) then 
    	__tmp = APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
    
    if VERBQ(TIE) then 
      	__tmp = TELL("You can't tie the rope to that.", CR)
    end

  elseif VERBQ(TIE) then 
    
    if EQUALQ(PRSI, RAILING) then 
      
      if DOME_FLAG then 
        	__tmp = TELL("The rope is already tied to it.", CR)
      elseif T then 
        	__tmp = TELL("The rope drops over the side and comes within ten feet of the floor.", CR)
        	__tmp = APPLY(function() DOME_FLAG = T return DOME_FLAG end)
        	__tmp = FSET(ROPE, NDESCBIT)
        	__tmp = APPLY(function() RLOC = LOC(ROPE) return RLOC end)
        
        if PASS(NOT(RLOC) or NOT(INQ(RLOC, ROOMS))) then 
          	__tmp = MOVE(ROPE, HERE)
        end

        	__tmp = T
      end

    end

  elseif PASS(VERBQ(CLIMB_DOWN) and EQUALQ(PRSO, ROPE, ROOMS) and DOME_FLAG) then 
    	__tmp = DO_WALK(PQDOWN)
  elseif PASS(VERBQ(TIE_UP) and EQUALQ(ROPE, PRSI)) then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      
      if LQ(GETP(PRSO, PQSTRENGTH), 0) then 
        	__tmp = TELL("Your attempt to tie up the ", D, PRSO, " awakens him.")
        	__tmp = AWAKEN(PRSO)
      elseif T then 
        	__tmp = TELL("The ", D, PRSO, " struggles and you cannot tie him up.", CR)
      end

    elseif T then 
      	__tmp = TELL("Why would you tie up a ", D, PRSO, "?", CR)
    end

  elseif VERBQ(UNTIE) then 
    
    if DOME_FLAG then 
      	__tmp = APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
      	__tmp = FCLEAR(ROPE, NDESCBIT)
      	__tmp = TELL("The rope is now untied.", CR)
    elseif T then 
      	__tmp = TELL("It is not tied to anything.", CR)
    end

  elseif PASS(VERBQ(DROP) and EQUALQ(HERE, DOME_ROOM) and NOT(DOME_FLAG)) then 
    	__tmp = MOVE(ROPE, TORCH_ROOM)
    	__tmp = TELL("The rope drops gently to the floor below.", CR)
  elseif VERBQ(TAKE) then 
    
    if DOME_FLAG then 
      	__tmp = TELL("The rope is tied to the railing.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ROPE_FUNCTION\n'..__res) end
end
UNTIE_FROM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(PRSO, ROPE) and PASS(DOME_FLAG and EQUALQ(PRSI, RAILING))) then 
    	__tmp = PERFORM(VQUNTIE, PRSO)
  elseif T then 
    	__tmp = TELL("It's not attached to that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('UNTIE_FROM\n'..__res) end
end
SLIDE_FUNCTION = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(THROUGH, CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    
    if EQUALQ(HERE, CELLAR) then 
      	__tmp = DO_WALK(PQWEST)
      	error(true)
    elseif T then 
      	__tmp = TELL("You tumble down the slide....", CR)
      	__tmp = GOTO(CELLAR)
    end

  elseif VERBQ(PUT) then 
    	__tmp = SLIDER(PRSO)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SLIDE_FUNCTION\n'..__res) end
end
SLIDER = function(...)
	local OBJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(OBJ, TAKEBIT) then 
    	__tmp = TELL("The ", D, OBJ, " falls into the slide and is gone.", CR)
    
    if EQUALQ(OBJ, WATER) then 
      	__tmp = REMOVE_CAREFULLY(OBJ)
    elseif T then 
      	__tmp = MOVE(OBJ, CELLAR)
    end

  elseif T then 
    	__tmp = TELL(PICK_ONE(YUKS), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SLIDER\n'..__res) end
end
SANDWICH_BAG_FCN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(SMELL) and INQ(LUNCH, PRSO)) then 
    	__tmp = TELL("It smells of hot peppers.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SANDWICH_BAG_FCN\n'..__res) end
end
DEAD_FUNCTION = function(...)
	local FOO = ...
	if select('#', ...) < 1 then FOO = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(WALK) then 
    
    if PASS(EQUALQ(HERE, TIMBER_ROOM) and EQUALQ(PRSO, PQWEST)) then 
      	__tmp = TELL("You cannot enter in your condition.", CR)
    end

  elseif VERBQ(BRIEF, VERBOSE, SUPER_BRIEF, VERSION, SAVE, RESTORE, QUIT, RESTART) then 
    	__tmp = nil
  elseif VERBQ(ATTACK, MUNG, ALARM, SWING) then 
    	__tmp = TELL("All such attacks are vain in your condition.", CR)
  elseif VERBQ(OPEN, CLOSE, EAT, DRINK, INFLATE, DEFLATE, TURN, BURN, TIE, UNTIE, RUB) then 
    	__tmp = TELL("Even such an action is beyond your capabilities.", CR)
  elseif VERBQ(WAIT) then 
    	__tmp = TELL("Might as well. You've got an eternity.", CR)
  elseif VERBQ(LAMP_ON) then 
    	__tmp = TELL("You need no light to guide you.", CR)
  elseif VERBQ(SCORE) then 
    	__tmp = TELL("You're dead! How can you think of your score?", CR)
  elseif VERBQ(TAKE, RUB) then 
    	__tmp = TELL("Your hand passes through its object.", CR)
  elseif VERBQ(DROP, THROW, INVENTORY) then 
    	__tmp = TELL("You have no possessions.", CR)
  elseif VERBQ(DIAGNOSE) then 
    	__tmp = TELL("You are dead.", CR)
  elseif VERBQ(LOOK) then 
    	__tmp = TELL("The room looks strange and unearthly")
    
    if NOT(FIRSTQ(HERE)) then 
      	__tmp = TELL(".")
    elseif T then 
      	__tmp = TELL(" and objects appear indistinct.")
    end

    	__tmp = CRLF()
    
    if NOT(FSETQ(HERE, ONBIT)) then 
      	__tmp = TELL("Although there is no light, the room seems dimly illuminated.", CR)
    end

    	__tmp = CRLF()
    	__tmp = nil
  elseif VERBQ(PRAY) then 
    
    if EQUALQ(HERE, SOUTH_TEMPLE) then 
      	__tmp = FCLEAR(LAMP, INVISIBLE)
      	__tmp = PUTP(WINNER, PQACTION, 0)
      	__tmp = APPLY(function() ALWAYS_LIT = nil return ALWAYS_LIT end)
      	__tmp = APPLY(function() DEAD = nil return DEAD end)
      
      if INQ(TROLL, TROLL_ROOM) then 
        	__tmp = APPLY(function() TROLL_FLAG = nil return TROLL_FLAG end)
      end

      	__tmp = TELL("From the distance the sound of a lone trumpet is heard. The room becomes very bright and you feel disembodied. In a moment, the brightness fades and you find yourself rising as if from a long sleep, deep in the woods. In the distance you can faintly hear a songbird and the sounds of the forest.", CR, CR)
      	__tmp = GOTO(FOREST_1)
    elseif T then 
      	__tmp = TELL("Your prayers are not heard.", CR)
    end

  elseif T then 
    	__tmp = TELL("You can't even do that.", CR)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DEAD_FUNCTION\n'..__res) end
end
LAKE_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if LOW_TIDE then 
    	__tmp = TELL("There's not much lake left....", CR)
  elseif VERBQ(CROSS) then 
    	__tmp = TELL("It's too wide to cross.", CR)
  elseif VERBQ(THROUGH) then 
    	__tmp = TELL("You can't swim in this lake.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LAKE_PSEUDO\n'..__res) end
end
STREAM_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(SWIM, THROUGH) then 
    	__tmp = TELL("You can't swim in the stream.", CR)
  elseif VERBQ(CROSS) then 
    	__tmp = TELL("The other side is a sheer rock cliff.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STREAM_PSEUDO\n'..__res) end
end
CHASM_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(VERBQ(LEAP) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    	__tmp = TELL("You look before leaping, and realize that you would never survive.", CR)
  elseif VERBQ(CROSS) then 
    	__tmp = TELL("It's too far to jump, and there's no bridge.", CR)
  elseif PASS(VERBQ(PUT, THROW_OFF) and EQUALQ(PRSI, PSEUDO_OBJECT)) then 
    	__tmp = TELL("The ", D, PRSO, " drops out of sight into the chasm.", CR)
    	__tmp = REMOVE_CAREFULLY(PRSO)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CHASM_PSEUDO\n'..__res) end
end
DOME_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(KISS) then 
    	__tmp = TELL("No.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DOME_PSEUDO\n'..__res) end
end
GATE_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(THROUGH) then 
    	__tmp = DO_WALK(PQIN)
    	error(true)
  elseif T then 
    	__tmp = TELL("The gate is protected by an invisible force. It makes your teeth ache to touch it.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GATE_PSEUDO\n'..__res) end
end
DOOR_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE) then 
    	__tmp = TELL("The door won't budge.", CR)
  elseif VERBQ(THROUGH) then 
    	__tmp = DO_WALK(PQSOUTH)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DOOR_PSEUDO\n'..__res) end
end
PAINT_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(MUNG) then 
    	__tmp = TELL("Some paint chips away, revealing more paint.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PAINT_PSEUDO\n'..__res) end
end
GAS_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(BREATHE) then 
    	__tmp = TELL("There is too much gas to blow away.", CR)
  elseif VERBQ(SMELL) then 
    	__tmp = TELL("It smells like coal gas in here.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GAS_PSEUDO\n'..__res) end
end
F_BUSYQ = 1
F_DEAD = 2
F_UNCONSCIOUS = 3
F_CONSCIOUS = 4
F_FIRSTQ = 5
MISSED = 1
UNCONSCIOUS = 2
KILLED = 3
LIGHT_WOUND = 4
SERIOUS_WOUND = 5
STAGGER = 6
LOSE_WEAPON = 7
HESITATE = 8
SITTING_DUCK = 9
DEF1 = TABLE(MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,UNCONSCIOUS,UNCONSCIOUS,KILLED,KILLED,KILLED,KILLED,KILLED)
DEF2A = TABLE(MISSED,MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,UNCONSCIOUS)
DEF2B = TABLE(MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,UNCONSCIOUS,KILLED,KILLED,KILLED)
DEF3A = TABLE(MISSED,MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND)
DEF3B = TABLE(MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND,SERIOUS_WOUND)
DEF3C = TABLE(MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND,SERIOUS_WOUND)
DEF1_RES = TABLE(DEF1,0,0)
DEF2_RES = TABLE(DEF2A,DEF2B,0,0)
DEF3_RES = TABLE(DEF3A,0,DEF3B,0,DEF3C)
STRENGTH_MAX = 7
STRENGTH_MIN = 2
CURE_WAIT = 30
DO_FIGHT = function(...)
	local LEN = ...
	local CNT
	local RES
	local O
	local OO
  local OUT = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog57 = function()
    APPLY(function() CNT = 0 return CNT end)
    
    local __prog58 = function()
      APPLY(function() CNT = ADD(CNT, 1) return CNT end)
      
      if EQUALQ(CNT, LEN) then 
        	__tmp = APPLY(function() RES = T return RES end)
        error(T)
      end

      APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
      APPLY(function() O = GET(OO, V_VILLAIN) return O end)
      
      if NOT(FSETQ(O, FIGHTBIT)) then 
        	__tmp = NOT(FSETQ(O, FIGHTBIT))
      elseif APPLY(GETP(O, PQACTION), F_BUSYQ) then 
        	__tmp = APPLY(GETP(O, PQACTION), F_BUSYQ)
      elseif NOT(APPLY(function() RES = VILLAIN_BLOW(OO, OUT) return RES end)) then 
        	__tmp = APPLY(function() RES = nil return RES end)
        return true
      elseif EQUALQ(RES, UNCONSCIOUS) then 
        	__tmp = APPLY(function() OUT = ADD(1, RANDOM(3)) return OUT end)
      end


error(123) end
local __ok58, __res58
repeat __ok58, __res58 = pcall(__prog58)
until __ok58 or __res58 ~= 123
if not __ok58 then error(__res58)
else __tmp = __res58 or true end

    
    if RES then 
      
      if NOT(OUT) then 
        return true
      elseif T then 
        	__tmp = APPLY(function() OUT = SUB(OUT, 1) return OUT end)
        
        if ZEROQ(OUT) then 
          return true
        end

      end

    elseif T then 
      return true
    end


error(123) end
local __ok57, __res57
repeat __ok57, __res57 = pcall(__prog57)
until __ok57 or __res57 ~= 123
if not __ok57 then error(__res57)
else __tmp = __res57 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DO_FIGHT\n'..__res) end
end
REMARK = function(...)
	local REMARK, D, W = ...
  local LEN = GET(REMARK, 0)
  local CNT = 0
	local STR
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog59 = function()
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), LEN) then 
      return true
    end

    APPLY(function() STR = GET(REMARK, CNT) return STR end)
    
    if EQUALQ(STR, F_WEP) then 
      	__tmp = PRINTD(W)
    elseif EQUALQ(STR, F_DEF) then 
      	__tmp = PRINTD(D)
    elseif T then 
      	__tmp = PRINT(STR)
    end


error(123) end
local __ok59, __res59
repeat __ok59, __res59 = pcall(__prog59)
until __ok59 or __res59 ~= 123
if not __ok59 then error(__res59)
else __tmp = __res59 or true end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('REMARK\n'..__res) end
end
FIGHT_STRENGTH = function(...)
	local ADJUSTQ = ...
	local S
	if select('#', ...) < 1 then ADJUSTQ = T end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() S = ADD(STRENGTH_MIN, DIV(SCORE, DIV(SCORE_MAX, SUB(STRENGTH_MAX, STRENGTH_MIN)))) return S end)

  if ADJUSTQ then 
    	__tmp = ADD(S, GETP(WINNER, PQSTRENGTH))
  elseif T then 
    	__tmp = S
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIGHT_STRENGTH\n'..__res) end
end
VILLAIN_STRENGTH = function(...)
	local OO = ...
  local VILLAIN = GET(OO, V_VILLAIN)
	local OD
	local TMP
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() OD = GETP(VILLAIN, PQSTRENGTH) return OD end)

  if NOT(LQ(OD, 0)) then 
    
    if PASS(EQUALQ(VILLAIN, THIEF) and THIEF_ENGROSSED) then 
      
      if GQ(OD, 2) then 
        	__tmp = APPLY(function() OD = 2 return OD end)
      end

      	__tmp = APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
    end

    
    if PASS(PRSI and FSETQ(PRSI, WEAPONBIT) and EQUALQ(GET(OO, V_BEST), PRSI)) then 
      	__tmp = APPLY(function() TMP = SUB(OD, GET(OO, V_BEST_ADV)) return TMP end)
      
      if LQ(TMP, 1) then 
        	__tmp = APPLY(function() TMP = 1 return TMP end)
      end

      	__tmp = APPLY(function() OD = TMP return OD end)
    end

  end

	__tmp = OD
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('VILLAIN_STRENGTH\n'..__res) end
end
FIND_WEAPON = function(...)
	local O = ...
	local W
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() W = FIRSTQ(O) return W end)

  if NOT(W) then 
    	error(false)
  end


  local __prog60 = function()
    
    if PASS(EQUALQ(W, STILETTO, AXE, SWORD) or EQUALQ(W, KNIFE, RUSTY_KNIFE)) then 
      error(W)
    elseif NOT(APPLY(function() W = NEXTQ(W) return W end)) then 
      	error(false)
    end


error(123) end
local __ok60, __res60
repeat __ok60, __res60 = pcall(__prog60)
until __ok60 or __res60 ~= 123
if not __ok60 then error(__res60)
else __tmp = __res60 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIND_WEAPON\n'..__res) end
end
VILLAIN_BLOW = function(...)
	local OO, OUTQ = ...
  local VILLAIN = GET(OO, V_VILLAIN)
  local REMARKS = GET(OO, V_MSGS)
	local DWEAPON
	local ATT
	local DEF
	local OA
	local OD
	local TBL
	local RES
	local NWEAPON
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   FCLEAR(WINNER, STAGGERED)

  if FSETQ(VILLAIN, STAGGERED) then 
    	__tmp = TELL("The ", D, VILLAIN, " slowly regains his feet.", CR)
    	__tmp = FCLEAR(VILLAIN, STAGGERED)
    	error(true)
  end

	__tmp = APPLY(function() OA = APPLY(function() ATT = VILLAIN_STRENGTH(OO) return ATT end) return OA end)

  if NOT(GQ(APPLY(function() DEF = FIGHT_STRENGTH() return DEF end), 0)) then 
    	error(true)
  end

	__tmp = APPLY(function() OD = FIGHT_STRENGTH(nil) return OD end)
	__tmp = APPLY(function() DWEAPON = FIND_WEAPON(WINNER) return DWEAPON end)

  if LQ(DEF, 0) then 
    	__tmp = APPLY(function() RES = KILLED return RES end)
  elseif T then 
    
    if ONEQ(DEF) then 
      
      if GQ(ATT, 2) then 
        	__tmp = APPLY(function() ATT = 3 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF1_RES, SUB(ATT, 1)) return TBL end)
    elseif EQUALQ(DEF, 2) then 
      
      if GQ(ATT, 3) then 
        	__tmp = APPLY(function() ATT = 4 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF2_RES, SUB(ATT, 1)) return TBL end)
    elseif GQ(DEF, 2) then 
      	__tmp = APPLY(function() ATT = SUB(ATT, DEF) return ATT end)
      
      if LQ(ATT, -1) then 
        	__tmp = APPLY(function() ATT = -2 return ATT end)
      elseif GQ(ATT, 1) then 
        	__tmp = APPLY(function() ATT = 2 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF3_RES, ADD(ATT, 2)) return TBL end)
    end

    	__tmp = APPLY(function() RES = GET(TBL, SUB(RANDOM(9), 1)) return RES end)
    
    if OUTQ then 
      
      if EQUALQ(RES, STAGGER) then 
        	__tmp = APPLY(function() RES = HESITATE return RES end)
      elseif T then 
        	__tmp = APPLY(function() RES = SITTING_DUCK return RES end)
      end

    end

    
    if PASS(EQUALQ(RES, STAGGER) and DWEAPON and PROB(25, APPLY(function()
          if HEROQ then 
            	__tmp = 10
          elseif T then 
            	__tmp = 50
          end
 end))) then 
      	__tmp = APPLY(function() RES = LOSE_WEAPON return RES end)
    end

    	__tmp = REMARK(RANDOM_ELEMENT(GET(REMARKS, SUB(RES, 1))), WINNER, DWEAPON)
  end


  if PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE)) then 
    	__tmp = PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE))
  elseif EQUALQ(RES, UNCONSCIOUS) then 
    	__tmp = EQUALQ(RES, UNCONSCIOUS)
  elseif PASS(EQUALQ(RES, KILLED) or EQUALQ(RES, SITTING_DUCK)) then 
    	__tmp = APPLY(function() DEF = 0 return DEF end)
  elseif EQUALQ(RES, LIGHT_WOUND) then 
    	__tmp = APPLY(function() DEF = SUB(DEF, 1) return DEF end)
    
    if LQ(DEF, 0) then 
      	__tmp = APPLY(function() DEF = 0 return DEF end)
    end

    
    if GQ(LOAD_ALLOWED, 50) then 
      	__tmp = APPLY(function() LOAD_ALLOWED = SUB(LOAD_ALLOWED, 10) return LOAD_ALLOWED end)
    end

  elseif EQUALQ(RES, SERIOUS_WOUND) then 
    	__tmp = APPLY(function() DEF = SUB(DEF, 2) return DEF end)
    
    if LQ(DEF, 0) then 
      	__tmp = APPLY(function() DEF = 0 return DEF end)
    end

    
    if GQ(LOAD_ALLOWED, 50) then 
      	__tmp = APPLY(function() LOAD_ALLOWED = SUB(LOAD_ALLOWED, 20) return LOAD_ALLOWED end)
    end

  elseif EQUALQ(RES, STAGGER) then 
    	__tmp = FSET(WINNER, STAGGERED)
  elseif T then 
    	__tmp = MOVE(DWEAPON, HERE)
    
    if APPLY(function() NWEAPON = FIND_WEAPON(WINNER) return NWEAPON end) then 
      	__tmp = TELL("Fortunately, you still have a ", D, NWEAPON, ".", CR)
    end

  end

	__tmp =   WINNER_RESULT(DEF, RES, OD)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('VILLAIN_BLOW\n'..__res) end
end
HERO_BLOW = function(...)
	local OO
	local VILLAIN
  local OUTQ = nil
	local DWEAPON
	local ATT
	local DEF
  local CNT = 0
	local OA
	local OD
	local TBL
	local RES
  local LEN = GET(VILLAINS, 0)
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog61 = function()
    APPLY(function() CNT = ADD(CNT, 1) return CNT end)
    
    if EQUALQ(CNT, LEN) then 
      return true
    end

    APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
    
    if EQUALQ(GET(OO, V_VILLAIN), PRSO) then 
      return true
    end


error(123) end
local __ok61, __res61
repeat __ok61, __res61 = pcall(__prog61)
until __ok61 or __res61 ~= 123
if not __ok61 then error(__res61)
else __tmp = __res61 or true end

	__tmp =   FSET(PRSO, FIGHTBIT)

  if FSETQ(WINNER, STAGGERED) then 
    	__tmp = TELL("You are still recovering from that last blow, so your attack is ineffective.", CR)
    	__tmp = FCLEAR(WINNER, STAGGERED)
    	error(true)
  end

	__tmp = APPLY(function() ATT = FIGHT_STRENGTH() return ATT end)

  if LQ(ATT, 1) then 
    	__tmp = APPLY(function() ATT = 1 return ATT end)
  end

	__tmp = APPLY(function() OA = ATT return OA end)
	__tmp = APPLY(function() VILLAIN = GET(OO, V_VILLAIN) return VILLAIN end)

  if ZEROQ(APPLY(function() OD = APPLY(function() DEF = VILLAIN_STRENGTH(OO) return DEF end) return OD end)) then 
    
    if EQUALQ(PRSO, WINNER) then 
      error(JIGS_UP("Well, you really did it that time. Is suicide painless?"))
    end

    	__tmp = TELL("Attacking the ", D, VILLAIN, " is pointless.", CR)
    	error(true)
  end

	__tmp = APPLY(function() DWEAPON = FIND_WEAPON(VILLAIN) return DWEAPON end)

  if PASS(NOT(DWEAPON) or LQ(DEF, 0)) then 
    	__tmp = TELL("The ")
    
    if LQ(DEF, 0) then 
      	__tmp = TELL("unconscious")
    elseif T then 
      	__tmp = TELL("unarmed")
    end

    	__tmp = TELL(" ", D, VILLAIN, " cannot defend himself: He dies.", CR)
    	__tmp = APPLY(function() RES = KILLED return RES end)
  elseif T then 
    
    if ONEQ(DEF) then 
      
      if GQ(ATT, 2) then 
        	__tmp = APPLY(function() ATT = 3 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF1_RES, SUB(ATT, 1)) return TBL end)
    elseif EQUALQ(DEF, 2) then 
      
      if GQ(ATT, 3) then 
        	__tmp = APPLY(function() ATT = 4 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF2_RES, SUB(ATT, 1)) return TBL end)
    elseif GQ(DEF, 2) then 
      	__tmp = APPLY(function() ATT = SUB(ATT, DEF) return ATT end)
      
      if LQ(ATT, -1) then 
        	__tmp = APPLY(function() ATT = -2 return ATT end)
      elseif GQ(ATT, 1) then 
        	__tmp = APPLY(function() ATT = 2 return ATT end)
      end

      	__tmp = APPLY(function() TBL = GET(DEF3_RES, ADD(ATT, 2)) return TBL end)
    end

    	__tmp = APPLY(function() RES = GET(TBL, SUB(RANDOM(9), 1)) return RES end)
    
    if OUTQ then 
      
      if EQUALQ(RES, STAGGER) then 
        	__tmp = APPLY(function() RES = HESITATE return RES end)
      elseif T then 
        	__tmp = APPLY(function() RES = SITTING_DUCK return RES end)
      end

    end

    
    if PASS(EQUALQ(RES, STAGGER) and DWEAPON and PROB(25)) then 
      	__tmp = APPLY(function() RES = LOSE_WEAPON return RES end)
    end

    	__tmp = REMARK(RANDOM_ELEMENT(GET(HERO_MELEE, SUB(RES, 1))), PRSO, PRSI)
  end


  if PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE)) then 
    	__tmp = PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE))
  elseif EQUALQ(RES, UNCONSCIOUS) then 
    	__tmp = APPLY(function() DEF = SUB(DEF) return DEF end)
  elseif PASS(EQUALQ(RES, KILLED) or EQUALQ(RES, SITTING_DUCK)) then 
    	__tmp = APPLY(function() DEF = 0 return DEF end)
  elseif EQUALQ(RES, LIGHT_WOUND) then 
    	__tmp = APPLY(function() DEF = SUB(DEF, 1) return DEF end)
    
    if LQ(DEF, 0) then 
      	__tmp = APPLY(function() DEF = 0 return DEF end)
    end

  elseif EQUALQ(RES, SERIOUS_WOUND) then 
    	__tmp = APPLY(function() DEF = SUB(DEF, 2) return DEF end)
    
    if LQ(DEF, 0) then 
      	__tmp = APPLY(function() DEF = 0 return DEF end)
    end

  elseif EQUALQ(RES, STAGGER) then 
    	__tmp = FSET(PRSO, STAGGERED)
  elseif T then 
    	__tmp = FCLEAR(DWEAPON, NDESCBIT)
    	__tmp = FSET(DWEAPON, WEAPONBIT)
    	__tmp = MOVE(DWEAPON, HERE)
    	__tmp = THIS_IS_IT(DWEAPON)
  end

	__tmp =   VILLAIN_RESULT(PRSO, DEF, RES)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HERO_BLOW\n'..__res) end
end
WINNER_RESULT = function(...)
	local DEF, RES, OD = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUTP(WINNER, PQSTRENGTH, APPLY(function()
    if ZEROQ(DEF) then 
      	__tmp = -10000
    elseif T then 
      	__tmp = SUB(DEF, OD)
    end
 end))

  if LQ(SUB(DEF, OD), 0) then 
    	__tmp = ENABLE(QUEUE(I_CURE, CURE_WAIT))
  end


  if NOT(GQ(FIGHT_STRENGTH(), 0)) then 
    	__tmp = PUTP(WINNER, PQSTRENGTH, ADD(1, SUB(FIGHT_STRENGTH(nil))))
    	__tmp = JIGS_UP("It appears that that last blow was too much for you. I'm afraid you are dead.")
    	__tmp = nil
  elseif T then 
    	__tmp = RES
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WINNER_RESULT\n'..__res) end
end
VILLAIN_RESULT = function(...)
	local VILLAIN, DEF, RES = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUTP(VILLAIN, PQSTRENGTH, DEF)

  if ZEROQ(DEF) then 
    	__tmp = FCLEAR(VILLAIN, FIGHTBIT)
    	__tmp = TELL("Almost as soon as the ", D, VILLAIN, " breathes his last breath, a cloud of sinister black fog envelops him, and when the fog lifts, the carcass has disappeared.", CR)
    	__tmp = REMOVE_CAREFULLY(VILLAIN)
    	__tmp = APPLY(GETP(VILLAIN, PQACTION), F_DEAD)
    	__tmp = RES
  elseif EQUALQ(RES, UNCONSCIOUS) then 
    	__tmp = APPLY(GETP(VILLAIN, PQACTION), F_UNCONSCIOUS)
    	__tmp = RES
  elseif T then 
    	__tmp = RES
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('VILLAIN_RESULT\n'..__res) end
end
WINNINGQ = function(...)
	local V = ...
	local VS
	local PS
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() VS = GETP(V, PQSTRENGTH) return VS end)
	__tmp = APPLY(function() PS = SUB(VS, FIGHT_STRENGTH()) return PS end)

  if GQ(PS, 3) then 
    	__tmp = PROB(90)
  elseif GQ(PS, 0) then 
    	__tmp = PROB(75)
  elseif ZEROQ(PS) then 
    	__tmp = PROB(50)
  elseif GQ(VS, 1) then 
    	__tmp = PROB(25)
  elseif T then 
    	__tmp = PROB(10)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WINNINGQ\n'..__res) end
end
I_CURE = function(...)
  local S = GETP(WINNER, PQSTRENGTH)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if GQ(S, 0) then 
    	__tmp = APPLY(function() S = 0 return S end)
    	__tmp = PUTP(WINNER, PQSTRENGTH, S)
  elseif LQ(S, 0) then 
    	__tmp = APPLY(function() S = ADD(S, 1) return S end)
    	__tmp = PUTP(WINNER, PQSTRENGTH, S)
  end


  if LQ(S, 0) then 
    
    if LQ(LOAD_ALLOWED, LOAD_MAX) then 
      	__tmp = APPLY(function() LOAD_ALLOWED = ADD(LOAD_ALLOWED, 10) return LOAD_ALLOWED end)
    end

    	__tmp = ENABLE(QUEUE(I_CURE, CURE_WAIT))
  elseif T then 
    	__tmp = APPLY(function() LOAD_ALLOWED = LOAD_MAX return LOAD_ALLOWED end)
    	__tmp = DISABLE(INT(I_CURE))
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_CURE\n'..__res) end
end
F_WEP = 0
F_DEF = 1
HERO_MELEE = TABLE(LTABLE(LTABLE("Your ",F_WEP," misses the ",F_DEF," by an inch."),LTABLE("A good slash, but it misses the ",F_DEF," by a mile."),LTABLE("You charge, but the ",F_DEF," jumps nimbly aside."),LTABLE("Clang! Crash! The ",F_DEF," parries."),LTABLE("A quick stroke, but the ",F_DEF," is on guard."),LTABLE("A good stroke, but it's too slow; the ",F_DEF," dodges.")),LTABLE(LTABLE("Your ",F_WEP," crashes down, knocking the ",F_DEF," into dreamland."),LTABLE("The ",F_DEF," is battered into unconsciousness."),LTABLE("A furious exchange, and the ",F_DEF," is knocked out!"),LTABLE("The haft of your ",F_WEP," knocks out the ",F_DEF,"."),LTABLE("The ",F_DEF," is knocked out!")),LTABLE(LTABLE("It's curtains for the ",F_DEF," as your ",F_WEP," removes his head."),LTABLE("The fatal blow strikes the ",F_DEF," square in the heart: He dies."),LTABLE("The ",F_DEF," takes a fatal blow and slumps to the floor dead.")),LTABLE(LTABLE("The ",F_DEF," is struck on the arm; blood begins to trickle down."),LTABLE("Your ",F_WEP," pinks the ",F_DEF," on the wrist, but it's not serious."),LTABLE("Your stroke lands, but it was only the flat of the blade."),LTABLE("The blow lands, making a shallow gash in the ",F_DEF,"'s arm!")),LTABLE(LTABLE("The ",F_DEF," receives a deep gash in his side."),LTABLE("A savage blow on the thigh! The ",F_DEF," is stunned but can still fight!"),LTABLE("Slash! Your blow lands! That one hit an artery, it could be serious!"),LTABLE("Slash! Your stroke connects! This could be serious!")),LTABLE(LTABLE("The ",F_DEF," is staggered, and drops to his knees."),LTABLE("The ",F_DEF," is momentarily disoriented and can't fight back."),LTABLE("The force of your blow knocks the ",F_DEF," back, stunned."),LTABLE("The ",F_DEF," is confused and can't fight back."),LTABLE("The quickness of your thrust knocks the ",F_DEF," back, stunned.")),LTABLE(LTABLE("The ",F_DEF,"'s weapon is knocked to the floor, leaving him unarmed."),LTABLE("The ",F_DEF," is disarmed by a subtle feint past his guard.")))
CYCLOPS_MELEE = TABLE(LTABLE(LTABLE("The Cyclops misses, but the backwash almost knocks you over."),LTABLE("The Cyclops rushes you, but runs into the wall.")),LTABLE(LTABLE("The Cyclops sends you crashing to the floor, unconscious.")),LTABLE(LTABLE("The Cyclops breaks your neck with a massive smash.")),LTABLE(LTABLE("A quick punch, but it was only a glancing blow."),LTABLE("A glancing blow from the Cyclops' fist.")),LTABLE(LTABLE("The monster smashes his huge fist into your chest, breaking several ribs."),LTABLE("The Cyclops almost knocks the wind out of you with a quick punch.")),LTABLE(LTABLE("The Cyclops lands a punch that knocks the wind out of you."),LTABLE("Heedless of your weapons, the Cyclops tosses you against the rock wall of the room.")),LTABLE(LTABLE("The Cyclops grabs your ",F_WEP,", tastes it, and throws it to the ground in disgust."),LTABLE("The monster grabs you on the wrist, squeezes, and you drop your ",F_WEP," in pain.")),LTABLE(LTABLE("The Cyclops seems unable to decide whether to broil or stew his dinner.")),LTABLE(LTABLE("The Cyclops, no sportsman, dispatches his unconscious victim.")))
TROLL_MELEE = TABLE(LTABLE(LTABLE("The troll swings his axe, but it misses."),LTABLE("The troll's axe barely misses your ear."),LTABLE("The axe sweeps past as you jump aside."),LTABLE("The axe crashes against the rock, throwing sparks!")),LTABLE(LTABLE("The flat of the troll's axe hits you delicately on the head, knocking you out.")),LTABLE(LTABLE("The troll neatly removes your head."),LTABLE("The troll's axe stroke cleaves you from the nave to the chops."),LTABLE("The troll's axe removes your head.")),LTABLE(LTABLE("The axe gets you right in the side. Ouch!"),LTABLE("The flat of the troll's axe skins across your forearm."),LTABLE("The troll's swing almost knocks you over as you barely parry in time."),LTABLE("The troll swings his axe, and it nicks your arm as you dodge.")),LTABLE(LTABLE("The troll charges, and his axe slashes you on your ",F_WEP," arm."),LTABLE("An axe stroke makes a deep wound in your leg."),LTABLE("The troll's axe swings down, gashing your shoulder.")),LTABLE(LTABLE("The troll hits you with a glancing blow, and you are momentarily stunned."),LTABLE("The troll swings; the blade turns on your armor but crashes broadside into your head."),LTABLE("You stagger back under a hail of axe strokes."),LTABLE("The troll's mighty blow drops you to your knees.")),LTABLE(LTABLE("The axe hits your ",F_WEP," and knocks it spinning."),LTABLE("The troll swings, you parry, but the force of his blow knocks your ",F_WEP," away."),LTABLE("The axe knocks your ",F_WEP," out of your hand. It falls to the floor.")),LTABLE(LTABLE("The troll hesitates, fingering his axe."),LTABLE("The troll scratches his head ruminatively:  Might you be magically protected, he wonders?")),LTABLE(LTABLE("Conquering his fears, the troll puts you to death.")))
THIEF_MELEE = TABLE(LTABLE(LTABLE("The thief stabs nonchalantly with his stiletto and misses."),LTABLE("You dodge as the thief comes in low."),LTABLE("You parry a lightning thrust, and the thief salutes you with a grim nod."),LTABLE("The thief tries to sneak past your guard, but you twist away.")),LTABLE(LTABLE("Shifting in the midst of a thrust, the thief knocks you unconscious with the haft of his stiletto."),LTABLE("The thief knocks you out.")),LTABLE(LTABLE("Finishing you off, the thief inserts his blade into your heart."),LTABLE("The thief comes in from the side, feints, and inserts the blade into your ribs."),LTABLE("The thief bows formally, raises his stiletto, and with a wry grin, ends the battle and your life.")),LTABLE(LTABLE("A quick thrust pinks your left arm, and blood starts to trickle down."),LTABLE("The thief draws blood, raking his stiletto across your arm."),LTABLE("The stiletto flashes faster than you can follow, and blood wells from your leg."),LTABLE("The thief slowly approaches, strikes like a snake, and leaves you wounded.")),LTABLE(LTABLE("The thief strikes like a snake! The resulting wound is serious."),LTABLE("The thief stabs a deep cut in your upper arm."),LTABLE("The stiletto touches your forehead, and the blood obscures your vision."),LTABLE("The thief strikes at your wrist, and suddenly your grip is slippery with blood.")),LTABLE(LTABLE("The butt of his stiletto cracks you on the skull, and you stagger back."),LTABLE("The thief rams the haft of his blade into your stomach, leaving you out of breath."),LTABLE("The thief attacks, and you fall back desperately.")),LTABLE(LTABLE("A long, theatrical slash. You catch it on your ",F_WEP,", but the thief twists his knife, and the ",F_WEP," goes flying."),LTABLE("The thief neatly flips your ",F_WEP," out of your hands, and it drops to the floor."),LTABLE("You parry a low thrust, and your ",F_WEP," slips out of your hand.")),LTABLE(LTABLE("The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off."),LTABLE("The thief amuses himself by searching your pockets."),LTABLE("The thief entertains himself by rifling your pack.")),LTABLE(LTABLE("The thief, forgetting his essentially genteel upbringing, cuts your throat."),LTABLE("The thief, a pragmatist, dispatches you as a threat to his livelihood.")))
V_VILLAIN = 0
V_BEST = 1
V_BEST_ADV = 2
V_PROB = 3
V_MSGS = 4
VILLAINS = LTABLE(TABLE(TROLL,SWORD,1,0,TROLL_MELEE),TABLE(THIEF,KNIFE,1,0,THIEF_MELEE),TABLE(CYCLOPS,nil,0,0,CYCLOPS_MELEE))
I_FIGHT = function(...)
  local FIGHTQ = nil
  local LEN = GET(VILLAINS, 0)
	local CNT
	local OO
	local O
	local P
	local __ok, __res = pcall(function()
	local __tmp = nil

  if DEAD then 
    	error(false)
  end

	__tmp = APPLY(function() CNT = 0 return CNT end)

  local __prog62 = function()
    APPLY(function() CNT = ADD(CNT, 1) return CNT end)
    
    if EQUALQ(CNT, LEN) then 
      return true
    end

    APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
    
    if PASS(INQ(APPLY(function() O = GET(OO, V_VILLAIN) return O end), HERE) and NOT(FSETQ(O, INVISIBLE))) then 
      
      if PASS(EQUALQ(O, THIEF) and THIEF_ENGROSSED) then 
        	__tmp = APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
      elseif LQ(GETP(O, PQSTRENGTH), 0) then 
        	__tmp = APPLY(function() P = GET(OO, V_PROB) return P end)
        
        if PASS(NOT(ZEROQ(P)) and PROB(P)) then 
          	__tmp = PUT(OO, V_PROB, 0)
          	__tmp = AWAKEN(O)
        elseif T then 
          	__tmp = PUT(OO, V_PROB, ADD(P, 25))
        end

      elseif PASS(FSETQ(O, FIGHTBIT) or APPLY(GETP(O, PQACTION), F_FIRSTQ)) then 
        	__tmp = APPLY(function() FIGHTQ = T return FIGHTQ end)
      end

    elseif T then 
      
      if FSETQ(O, FIGHTBIT) then 
        	__tmp = APPLY(GETP(O, PQACTION), F_BUSYQ)
      end

      
      if EQUALQ(O, THIEF) then 
        	__tmp = APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
      end

      	__tmp = FCLEAR(WINNER, STAGGERED)
      	__tmp = FCLEAR(O, STAGGERED)
      	__tmp = FCLEAR(O, FIGHTBIT)
      	__tmp = AWAKEN(O)
    end


error(123) end
local __ok62, __res62
repeat __ok62, __res62 = pcall(__prog62)
until __ok62 or __res62 ~= 123
if not __ok62 then error(__res62)
else __tmp = __res62 or true end


  if NOT(FIGHTQ) then 
    	error(false)
  end

	__tmp =   DO_FIGHT(LEN)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_FIGHT\n'..__res) end
end
AWAKEN = function(...)
	local O = ...
  local S = GETP(O, PQSTRENGTH)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if LQ(S, 0) then 
    	__tmp = PUTP(O, PQSTRENGTH, SUB(0, S))
    	__tmp = APPLY(GETP(O, PQACTION), F_CONSCIOUS)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('AWAKEN\n'..__res) end
end
I_SWORD = function(...)
  local DEM = INT(I_SWORD)
  local G = GETP(SWORD, PQTVALUE)
  local NG = 0
	local P
	local T
	local L
	local __ok, __res = pcall(function()
	local __tmp = nil

  if INQ(SWORD, ADVENTURER) then 
    
    if INFESTEDQ(HERE) then 
      	__tmp = APPLY(function() NG = 2 return NG end)
    elseif T then 
      	__tmp = APPLY(function() P = 0 return P end)
      
      local __prog63 = function()
        
        if ZEROQ(APPLY(function() P = NEXTP(HERE, P) return P end)) then 
          return true
        elseif NOT(LQ(P, LOW_DIRECTION)) then 
          	__tmp = APPLY(function() T = GETPT(HERE, P) return T end)
          	__tmp = APPLY(function() L = PTSIZE(T) return L end)
          
          if EQUALQ(L, UEXIT, CEXIT, DEXIT) then 
            
            if INFESTEDQ(GETB(T, 0)) then 
              	__tmp = APPLY(function() NG = 1 return NG end)
              return true
            end

          end

        end


error(123) end
local __ok63, __res63
repeat __ok63, __res63 = pcall(__prog63)
until __ok63 or __res63 ~= 123
if not __ok63 then error(__res63)
else __tmp = __res63 or true end

    end

    
    if EQUALQ(NG, G) then 
      	error(false)
    elseif EQUALQ(NG, 2) then 
      	__tmp = TELL("Your sword has begun to glow very brightly.", CR)
    elseif ONEQ(NG) then 
      	__tmp = TELL("Your sword is glowing with a faint blue glow.", CR)
    elseif ZEROQ(NG) then 
      	__tmp = TELL("Your sword is no longer glowing.", CR)
    end

    	__tmp = PUTP(SWORD, PQTVALUE, NG)
    	error(true)
  elseif T then 
    	__tmp = PUT(DEM, C_ENABLEDQ, 0)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_SWORD\n'..__res) end
end
INFESTEDQ = function(...)
	local R = ...
  local F = FIRSTQ(R)
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog64 = function()
    
    if NOT(F) then 
      	error(false)
    elseif PASS(FSETQ(F, ACTORBIT) and NOT(FSETQ(F, INVISIBLE))) then 
      	error(true)
    elseif NOT(APPLY(function() F = NEXTQ(F) return F end)) then 
      	error(false)
    end


error(123) end
local __ok64, __res64
repeat __ok64, __res64 = pcall(__prog64)
until __ok64 or __res64 ~= 123
if not __ok64 then error(__res64)
else __tmp = __res64 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('INFESTEDQ\n'..__res) end
end
I_THIEF = function(...)
  local RM = LOC(THIEF)
	local HEREQ
  local ONCE = nil
  local FLG = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog65 = function()
    
    if APPLY(function() HEREQ = NOT(FSETQ(THIEF, INVISIBLE)) return HEREQ end) then 
      	__tmp = APPLY(function() RM = LOC(THIEF) return RM end)
    end
    
    if PASS(EQUALQ(RM, TREASURE_ROOM) and NOT(EQUALQ(RM, HERE))) then 
      
      if HEREQ then 
        	__tmp = HACK_TREASURES()
        	__tmp = APPLY(function() HEREQ = nil return HEREQ end)
      end

      	__tmp = DEPOSIT_BOOTY(TREASURE_ROOM)
    elseif PASS(EQUALQ(RM, HERE) and NOT(FSETQ(RM, ONBIT)) and NOT(INQ(TROLL, HERE))) then 
      
      if THIEF_VS_ADVENTURER(HEREQ) then 
        	error(true)
      end

      
      if FSETQ(THIEF, INVISIBLE) then 
        	__tmp = APPLY(function() HEREQ = nil return HEREQ end)
      end

    elseif T then 
      
      if PASS(INQ(THIEF, RM) and NOT(FSETQ(THIEF, INVISIBLE))) then 
        	__tmp = FSET(THIEF, INVISIBLE)
        	__tmp = APPLY(function() HEREQ = nil return HEREQ end)
      end

      
      if FSETQ(RM, TOUCHBIT) then 
        	__tmp = ROB(RM, THIEF, 75)
        	__tmp = APPLY(function() FLG = APPLY(function()
          if PASS(FSETQ(RM, MAZEBIT) and FSETQ(HERE, MAZEBIT)) then 
            	__tmp = ROB_MAZE(RM)
          elseif T then 
            	__tmp = STEAL_JUNK(RM)
          end
 return __tmp end) return FLG end)
      end

    end
    
    if PASS(APPLY(function() ONCE = NOT(ONCE) return ONCE end) and NOT(HEREQ)) then 
      	__tmp = RECOVER_STILETTO()
      
      local __prog66 = function()
        
        if PASS(RM and APPLY(function() RM = NEXTQ(RM) return RM end)) then 
          	__tmp = PASS(RM and APPLY(function() RM = NEXTQ(RM) return RM end))
        elseif T then 
          	__tmp = APPLY(function() RM = FIRSTQ(ROOMS) return RM end)
        end

        
        if PASS(NOT(FSETQ(RM, SACREDBIT)) and FSETQ(RM, RLANDBIT)) then 
          	__tmp = MOVE(THIEF, RM)
          	__tmp = FCLEAR(THIEF, FIGHTBIT)
          	__tmp = FSET(THIEF, INVISIBLE)
          	__tmp = APPLY(function() THIEF_HERE = nil return THIEF_HERE end)
          return true
        end


error(123) end
local __ok66, __res66
repeat __ok66, __res66 = pcall(__prog66)
until __ok66 or __res66 ~= 123
if not __ok66 then error(__res66)
else __tmp = __res66 or true end

      	error(123)
    end
end
local __ok65, __res65
repeat __ok65, __res65 = pcall(__prog65)
until __ok65 or __res65 ~= 123
if not __ok65 then error(__res65)
else __tmp = __res65 or true end


  if NOT(EQUALQ(RM, TREASURE_ROOM)) then 
    	__tmp = DROP_JUNK(RM)
  end

	__tmp = FLG
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('I_THIEF\n'..__res) end
end
DROP_JUNK = function(...)
	local RM = ...
	local X
	local N
  local FLG = nil
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() X = FIRSTQ(THIEF) return X end)

  local __prog67 = function()
    
    if NOT(X) then 
      error(FLG)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if EQUALQ(X, STILETTO, LARGE_BAG) then 
      	__tmp = EQUALQ(X, STILETTO, LARGE_BAG)
    elseif PASS(ZEROQ(GETP(X, PQTVALUE)) and PROB(30, T)) then 
      	__tmp = FCLEAR(X, INVISIBLE)
      	__tmp = MOVE(X, RM)
      
      if PASS(NOT(FLG) and EQUALQ(RM, HERE)) then 
        	__tmp = TELL("The robber, rummaging through his bag, dropped a few items he found valueless.", CR)
        	__tmp = APPLY(function() FLG = T return FLG end)
      end

    end

    APPLY(function() X = N return X end)

error(123) end
local __ok67, __res67
repeat __ok67, __res67 = pcall(__prog67)
until __ok67 or __res67 ~= 123
if not __ok67 then error(__res67)
else __tmp = __res67 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DROP_JUNK\n'..__res) end
end
RECOVER_STILETTO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if INQ(STILETTO, LOC(THIEF)) then 
    	__tmp = FSET(STILETTO, NDESCBIT)
    	__tmp = MOVE(STILETTO, THIEF)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RECOVER_STILETTO\n'..__res) end
end
STEAL_JUNK = function(...)
	local RM = ...
	local X
	local N
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() X = FIRSTQ(RM) return X end)

  local __prog68 = function()
    
    if NOT(X) then 
      	error(false)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(ZEROQ(GETP(X, PQTVALUE)) and FSETQ(X, TAKEBIT) and NOT(FSETQ(X, SACREDBIT)) and NOT(FSETQ(X, INVISIBLE)) and PASS(EQUALQ(X, STILETTO) or PROB(10, T))) then 
      	__tmp = MOVE(X, THIEF)
      	__tmp = FSET(X, TOUCHBIT)
      	__tmp = FSET(X, INVISIBLE)
      
      if EQUALQ(X, ROPE) then 
        	__tmp = APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
      end

      
      if EQUALQ(RM, HERE) then 
        	__tmp = TELL("You suddenly notice that the ", D, X, " vanished.", CR)
        	error(true)
      else 
        	error(false)
      end

    end

    APPLY(function() X = N return X end)

error(123) end
local __ok68, __res68
repeat __ok68, __res68 = pcall(__prog68)
until __ok68 or __res68 ~= 123
if not __ok68 then error(__res68)
else __tmp = __res68 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STEAL_JUNK\n'..__res) end
end
ROB = function(...)
	local WHAT, WHERE, PROB = ...
	local N
	local X
  local ROBBEDQ = nil
	if select('#', ...) < 3 then PROB = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() X = FIRSTQ(WHAT) return X end)

  local __prog69 = function()
    
    if NOT(X) then 
      error(ROBBEDQ)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(NOT(FSETQ(X, INVISIBLE)) and NOT(FSETQ(X, SACREDBIT)) and GQ(GETP(X, PQTVALUE), 0) and PASS(NOT(PROB) or PROB(PROB))) then 
      	__tmp = MOVE(X, WHERE)
      	__tmp = FSET(X, TOUCHBIT)
      
      if EQUALQ(WHERE, THIEF) then 
        	__tmp = FSET(X, INVISIBLE)
      end

      	__tmp = APPLY(function() ROBBEDQ = T return ROBBEDQ end)
    end

    APPLY(function() X = N return X end)

error(123) end
local __ok69, __res69
repeat __ok69, __res69 = pcall(__prog69)
until __ok69 or __res69 ~= 123
if not __ok69 then error(__res69)
else __tmp = __res69 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ROB\n'..__res) end
end
V_DIAGNOSE = function(...)
  local MS = FIGHT_STRENGTH(nil)
  local WD = GETP(WINNER, PQSTRENGTH)
  local RS = ADD(MS, WD)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if ZEROQ(GET(INT(I_CURE), C_ENABLEDQ)) then 
    	__tmp = APPLY(function() WD = 0 return WD end)
  else 
    	__tmp = APPLY(function() WD = SUB(WD) return WD end)
  end


  if ZEROQ(WD) then 
    	__tmp = TELL("You are in perfect health.")
  elseif T then 
    	__tmp = TELL("You have ")
    
    if ONEQ(WD) then 
      	__tmp = TELL("a light wound,")
    elseif EQUALQ(WD, 2) then 
      	__tmp = TELL("a serious wound,")
    elseif EQUALQ(WD, 3) then 
      	__tmp = TELL("several wounds,")
    elseif GQ(WD, 3) then 
      	__tmp = TELL("serious wounds,")
    end

  end


  if NOT(ZEROQ(WD)) then 
    	__tmp = TELL(" which will be cured after ")
    	__tmp = PRINTN(ADD(MULL(CURE_WAIT, SUB(WD, 1)), GET(INT(I_CURE), C_TICK)))
    	__tmp = TELL(" moves.")
  end

	__tmp =   CRLF()
	__tmp =   TELL("You can ")

  if ZEROQ(RS) then 
    	__tmp = TELL("expect death soon")
  elseif ONEQ(RS) then 
    	__tmp = TELL("be killed by one more light wound")
  elseif EQUALQ(RS, 2) then 
    	__tmp = TELL("be killed by a serious wound")
  elseif EQUALQ(RS, 3) then 
    	__tmp = TELL("survive one serious wound")
  elseif GQ(RS, 3) then 
    	__tmp = TELL("survive several wounds")
  end

	__tmp =   TELL(".", CR)

  if NOT(ZEROQ(DEATHS)) then 
    	__tmp = TELL("You have been killed ")
    
    if ONEQ(DEATHS) then 
      	__tmp = TELL("once")
    elseif T then 
      	__tmp = TELL("twice")
    end

    	__tmp = TELL(".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DIAGNOSE\n'..__res) end
end
V_SCORE = function(...)
	local ASKQ = ...
	if select('#', ...) < 1 then ASKQ = T end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Your score is ")
	__tmp =   TELL(N, SCORE)
	__tmp =   TELL(" (total of 350 points), in ")
	__tmp =   TELL(N, MOVES)

  if ONEQ(MOVES) then 
    	__tmp = TELL(" move.")
  else 
    	__tmp = TELL(" moves.")
  end

	__tmp =   CRLF()
	__tmp =   TELL("This gives you the rank of ")

  if EQUALQ(SCORE, 350) then 
    	__tmp = TELL("Master Adventurer")
  elseif GQ(SCORE, 330) then 
    	__tmp = TELL("Wizard")
  elseif GQ(SCORE, 300) then 
    	__tmp = TELL("Master")
  elseif GQ(SCORE, 200) then 
    	__tmp = TELL("Adventurer")
  elseif GQ(SCORE, 100) then 
    	__tmp = TELL("Junior Adventurer")
  elseif GQ(SCORE, 50) then 
    	__tmp = TELL("Novice Adventurer")
  elseif GQ(SCORE, 25) then 
    	__tmp = TELL("Amateur Adventurer")
  elseif T then 
    	__tmp = TELL("Beginner")
  end

	__tmp =   TELL(".", CR)
	__tmp = SCORE
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SCORE\n'..__res) end
end
JIGS_UP = function(...)
	local DESC, PLAYERQ = ...
	if select('#', ...) < 2 then PLAYERQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() WINNER = ADVENTURER return WINNER end)

  if DEAD then 
    	__tmp = TELL("| It takes a talented person to be killed while already dead. YOU are such a talent. Unfortunately, it takes a talented person to deal with it. I am not such a talent. Sorry.", CR)
    	__tmp = FINISH()
  end

	__tmp =   TELL(DESC, CR)

  if NOT(LUCKY) then 
    	__tmp = TELL("Bad luck, huh?", CR)
  end


  local __prog70 = function()
    SCORE_UPD(-10)    TELL(" |    ****  You have died  **** | |")    
    if FSETQ(LOC(WINNER), VEHBIT) then 
      	__tmp = MOVE(WINNER, HERE)
    end
    
    if NOT(LQ(DEATHS, 2)) then 
      	__tmp = TELL("You clearly are a suicidal maniac.  We don't allow psychotics in the cave, since they may harm other adventurers.  Your remains will be installed in the Land of the Living Dead, where your fellow adventurers may gloat over them.", CR)
      	__tmp = FINISH()
    elseif T then 
      	__tmp = APPLY(function() DEATHS = ADD(DEATHS, 1) return DEATHS end)
      	__tmp = MOVE(WINNER, HERE)
      
      if FSETQ(SOUTH_TEMPLE, TOUCHBIT) then 
        	__tmp = TELL("As you take your last breath, you feel relieved of your burdens. The feeling passes as you find yourself before the gates of Hell, where the spirits jeer at you and deny you entry.  Your senses are disturbed.  The objects in the dungeon appear indistinct, bleached of color, even unreal.", CR, CR)
        	__tmp = APPLY(function() DEAD = T return DEAD end)
        	__tmp = APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
        	__tmp = APPLY(function() ALWAYS_LIT = T return ALWAYS_LIT end)
        	__tmp = PUTP(WINNER, PQACTION, DEAD_FUNCTION)
        	__tmp = GOTO(ENTRANCE_TO_HADES)
      elseif T then 
        	__tmp = TELL("Now, let's take a look here... Well, you probably deserve another chance.  I can't quite fix you up completely, but you can't have everything.", CR, CR)
        	__tmp = GOTO(FOREST_1)
      end

      	__tmp = FCLEAR(TRAP_DOOR, TOUCHBIT)
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
      	__tmp = RANDOMIZE_OBJECTS()
      	__tmp = KILL_INTERRUPTS()
      	__tmp = 	error(2)
    end
end
local __ok70, __res70
repeat __ok70, __res70 = pcall(__prog70)
until __ok70 or __res70 ~= 123
if not __ok70 then error(__res70)
else __tmp = __res70 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('JIGS_UP\n'..__res) end
end
RANDOMIZE_OBJECTS = function(...)
  local R = nil
	local F
	local N
	local L
	local __ok, __res = pcall(function()
	local __tmp = nil

  if INQ(LAMP, WINNER) then 
    	__tmp = MOVE(LAMP, LIVING_ROOM)
  end


  if INQ(COFFIN, WINNER) then 
    	__tmp = MOVE(COFFIN, EGYPT_ROOM)
  end

	__tmp =   PUTP(SWORD, PQTVALUE, 0)
	__tmp = APPLY(function() N = FIRSTQ(WINNER) return N end)
	__tmp = APPLY(function() L = GET(ABOVE_GROUND, 0) return L end)

  local __prog71 = function()
    APPLY(function() F = N return F end)
    
    if NOT(F) then 
      return true
    end

    APPLY(function() N = NEXTQ(F) return N end)
    
    if GQ(GETP(F, PQTVALUE), 0) then 
      
      local __prog72 = function()
        
        if NOT(R) then 
          	__tmp = APPLY(function() R = FIRSTQ(ROOMS) return R end)
        end

        
        if PASS(FSETQ(R, RLANDBIT) and NOT(FSETQ(R, ONBIT)) and PROB(50)) then 
          	__tmp = MOVE(F, R)
          return true
        else 
          	__tmp = APPLY(function() R = NEXTQ(R) return R end)
        end


error(123) end
local __ok72, __res72
repeat __ok72, __res72 = pcall(__prog72)
until __ok72 or __res72 ~= 123
if not __ok72 then error(__res72)
else __tmp = __res72 or true end

    else 
      	__tmp = MOVE(F, GET(ABOVE_GROUND, RANDOM(L)))
    end


error(123) end
local __ok71, __res71
repeat __ok71, __res71 = pcall(__prog71)
until __ok71 or __res71 ~= 123
if not __ok71 then error(__res71)
else __tmp = __res71 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('RANDOMIZE_OBJECTS\n'..__res) end
end
KILL_INTERRUPTS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DISABLE(INT(I_XB))
	__tmp =   DISABLE(INT(I_XC))
	__tmp =   DISABLE(INT(I_CYCLOPS))
	__tmp =   DISABLE(INT(I_LANTERN))
	__tmp =   DISABLE(INT(I_CANDLES))
	__tmp =   DISABLE(INT(I_SWORD))
	__tmp =   DISABLE(INT(I_FOREST_ROOM))
	__tmp =   DISABLE(INT(I_MATCH))
	__tmp =   FCLEAR(MATCH, ONBIT)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('KILL_INTERRUPTS\n'..__res) end
end
BAG_OF_COINS_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   STUPID_CONTAINER(BAG_OF_COINS, "coins")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BAG_OF_COINS_F\n'..__res) end
end
TRUNK_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   STUPID_CONTAINER(TRUNK, "jewels")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TRUNK_F\n'..__res) end
end
STUPID_CONTAINER = function(...)
	local OBJ, STR = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE) then 
    	__tmp = TELL("The ", STR, " are safely inside; there's no need to do that.", CR)
  elseif VERBQ(LOOK_INSIDE, EXAMINE) then 
    	__tmp = TELL("There are lots of ", STR, " in there.", CR)
  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, OBJ)) then 
    	__tmp = TELL("Don't be silly. It wouldn't be a ", D, OBJ, " anymore.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STUPID_CONTAINER\n'..__res) end
end
DUMB_CONTAINER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(OPEN, CLOSE, LOOK_INSIDE) then 
    	__tmp = TELL("You can't do that.", CR)
  elseif VERBQ(EXAMINE) then 
    	__tmp = TELL("It looks pretty much like a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DUMB_CONTAINER\n'..__res) end
end
GARLIC_F = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(EAT) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = TELL("What the heck! You won't make friends this way, but nobody around here is too friendly anyhow. Gulp!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GARLIC_F\n'..__res) end
end
CHAIN_PSEUDO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(TAKE, MOVE) then 
    	__tmp = TELL("The chain is secure.", CR)
  elseif VERBQ(RAISE, LOWER) then 
    	__tmp = TELL("Perhaps you should do that to the basket.", CR)
  elseif VERBQ(EXAMINE) then 
    	__tmp = TELL("The chain secures a basket within the shaft.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CHAIN_PSEUDO\n'..__res) end
end
TROLL_ROOM_F = function(...)
	local RARG = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(RARG, M_ENTER) and INQ(TROLL, HERE)) then 
    	__tmp = THIS_IS_IT(TROLL)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TROLL_ROOM_F\n'..__res) end
end
