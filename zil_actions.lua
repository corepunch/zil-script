
WEST_HOUSE = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are standing in an open field west of a white house, with a boarded\nfront door.")
    
    if WON_FLAG then 
      TELL(" A secret path leads southwest into the forest.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WEST_HOUSE\n'..__res) end
end
EAST_HOUSE = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are behind the white house. A path leads into the forest\nto the east. In one corner of the house there is a small window\nwhich is ")
    
    if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
      TELL("open.")
    elseif T then 
      TELL("slightly ajar.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('EAST_HOUSE\n'..__res) end
end
OPEN_CLOSE = function(OBJ, STROPN, STRCLS)
	local __ok, __res = pcall(function()

  if VERBQ(OPEN) then 
    
    if FSETQ(OBJ, OPENBIT) then 
      TELL(PICK_ONE(DUMMY))
    elseif T then 
      TELL(STROPN)
      FSET(OBJ, OPENBIT)
    end

    	return CRLF()
  elseif VERBQ(CLOSE) then 
    
    if FSETQ(OBJ, OPENBIT) then 
      TELL(STRCLS)
      FCLEAR(OBJ, OPENBIT)
      -- T
    elseif T then 
      TELL(PICK_ONE(DUMMY))
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('OPEN_CLOSE\n'..__res) end
end
BOARD_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE, EXAMINE) then 
    	return TELL("The boards are securely fastened.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BOARD_F\n'..__res) end
end
TEETH_F = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(BRUSH) and EQUALQ(PRSO, TEETH)) then 
    
    if PASS(EQUALQ(PRSI, PUTTY) and INQ(PRSI, WINNER)) then 
      	return JIGS_UP("Well, you seem to have been brushing your teeth with some sort of\nglue. As a result, your mouth gets glued together (with your nose)\nand you die of respiratory failure.")
    elseif NOT(PRSI) then 
      	return TELL("Dental hygiene is highly recommended, but I'm not sure what you want\nto brush them with.", CR)
    elseif T then 
      	return TELL("A nice idea, but with a ", D, PRSI, "?", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TEETH_F\n'..__res) end
end
GRANITE_WALL_F = function()
	local __ok, __res = pcall(function()

  if EQUALQ(HERE, NORTH_TEMPLE) then 
    
    if VERBQ(FIND) then 
      	return TELL("The west wall is solid granite here.", CR)
    elseif VERBQ(TAKE, RAISE, LOWER) then 
      	return TELL("It's solid granite.", CR)
    end

  elseif EQUALQ(HERE, TREASURE_ROOM) then 
    
    if VERBQ(FIND) then 
      	return TELL("The east wall is solid granite here.", CR)
    elseif VERBQ(TAKE, RAISE, LOWER) then 
      	return TELL("It's solid granite.", CR)
    end

  elseif EQUALQ(HERE, SLIDE_ROOM) then 
    
    if VERBQ(FIND, READ) then 
      	return TELL("It only SAYS \"Granite Wall\".", CR)
    elseif T then 
      	return TELL("The wall isn't granite.", CR)
    end

  elseif T then 
    	return TELL("There is no granite wall here.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GRANITE_WALL_F\n'..__res) end
end
SONGBIRD_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(FIND, TAKE) then 
    	return TELL("The songbird is not here but is probably nearby.", CR)
  elseif VERBQ(LISTEN) then 
    	return TELL("You can't hear the songbird now.", CR)
  elseif VERBQ(FOLLOW) then 
    	return TELL("It can't be followed.", CR)
  elseif T then 
    	return TELL("You can't see any songbird here.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SONGBIRD_F\n'..__res) end
end
WHITE_HOUSE_F = function()
	local __ok, __res = pcall(function()

  if EQUALQ(HERE, KITCHEN, LIVING_ROOM, ATTIC) then 
    
    if VERBQ(FIND) then 
      	return TELL("Why not find your brains?", CR)
    elseif VERBQ(WALK_AROUND) then 
      GO_NEXT(IN_HOUSE_AROUND)
      -- 	return T
    end

  elseif NOT(PASS(EQUALQ(HERE, EAST_OF_HOUSE, WEST_OF_HOUSE) or EQUALQ(HERE, NORTH_OF_HOUSE, SOUTH_OF_HOUSE))) then 
    
    if VERBQ(FIND) then 
      
      if EQUALQ(HERE, CLEARING) then 
        	return TELL("It seems to be to the west.", CR)
      elseif T then 
        	return TELL("It was here just a minute ago....", CR)
      end

    elseif T then 
      	return TELL("You're not at the house.", CR)
    end

  elseif VERBQ(FIND) then 
    	return TELL("It's right here! Are you blind or something?", CR)
  elseif VERBQ(WALK_AROUND) then 
    GO_NEXT(HOUSE_AROUND)
    -- 	return T
  elseif VERBQ(EXAMINE) then 
    	return TELL("The house is a beautiful colonial house which is painted white.\nIt is clear that the owners must have been extremely wealthy.", CR)
  elseif VERBQ(THROUGH, OPEN) then 
    
    if EQUALQ(HERE, EAST_OF_HOUSE) then 
      
      if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
        	return GOTO(KITCHEN)
      elseif T then 
        TELL("The window is closed.", CR)
        	return THIS_IS_IT(KITCHEN_WINDOW)
      end

    elseif T then 
      	return TELL("I can't see how to get in from here.", CR)
    end

  elseif VERBQ(BURN) then 
    	return TELL("You must be joking.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WHITE_HOUSE_F\n'..__res) end
end
GO_NEXT = function(TBL)
	local VAL
	local __ok, __res = pcall(function()

  if APPLY(function() VAL = LKP(HERE, TBL) return VAL end) then 
    
    if NOT(GOTO(VAL)) then 
      -- 	return 2
    elseif T then 
      -- 	return 1
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GO_NEXT\n'..__res) end
end
FOREST_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(WALK_AROUND) then 
    
    if PASS(EQUALQ(HERE, WEST_OF_HOUSE, NORTH_OF_HOUSE, SOUTH_OF_HOUSE) or EQUALQ(HERE, EAST_OF_HOUSE)) then 
      TELL("You aren't even in the forest.", CR)
    end

    	return GO_NEXT(FOREST_AROUND)
  elseif VERBQ(DISEMBARK) then 
    	return TELL("You will have to specify a direction.", CR)
  elseif VERBQ(FIND) then 
    	return TELL("You cannot see the forest for the trees.", CR)
  elseif VERBQ(LISTEN) then 
    	return TELL("The pines and the hemlocks seem to be murmuring.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FOREST_F\n'..__res) end
end
MOUNTAIN_RANGE_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) then 
    	return TELL("Don't you believe me? The mountains are impassable!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MOUNTAIN_RANGE_F\n'..__res) end
end
WATER_F = function()
	local AV
	local W
	local PIQ
	local __ok, __res = pcall(function()

  if VERBQ(SGIVE) then 
    	error(false)
  elseif VERBQ(THROUGH, BOARD) then 
    TELL(PICK_ONE(SWIMYUKS), CR)
    	error(true)
  elseif VERBQ(FILL) then 
    APPLY(function() W = PRSI return W end)
    APPLY(function() PRSA = VQPUT return PRSA end)
    APPLY(function() PRSI = PRSO return PRSI end)
    APPLY(function() PRSO = W return PRSO end)
    APPLY(function() PIQ = nil return PIQ end)
  elseif PASS(EQUALQ(PRSO, GLOBAL_WATER) or EQUALQ(PRSO, WATER)) then 
    APPLY(function() W = PRSO return W end)
    APPLY(function() PIQ = nil return PIQ end)
  else 
    APPLY(function() W = PRSI return W end)
    
    if W then 
      APPLY(function() PIQ = T return PIQ end)
    end

  end


  if EQUALQ(W, GLOBAL_WATER) then 
    APPLY(function() W = WATER return W end)
    
    if VERBQ(TAKE, PUT) then 
      REMOVE_CAREFULLY(W)
    end

  end


  if PIQ then 
    APPLY(function() PRSI = W return PRSI end)
  elseif T then 
    APPLY(function() PRSO = W return PRSO end)
  end

APPLY(function() AV = LOC(WINNER) return AV end)

  if NOT(FSETQ(AV, VEHBIT)) then 
    APPLY(function() AV = nil return AV end)
  end


  if PASS(VERBQ(TAKE, PUT) and NOT(PIQ)) then 
    
    if PASS(AV and PASS(EQUALQ(AV, PRSI) or PASS(NOT(PRSI) and NOT(INQ(W, AV))))) then 
      TELL("There is now a puddle in the bottom of the ", D, AV, ".", CR)
      REMOVE_CAREFULLY(PRSO)
      	return MOVE(PRSO, AV)
    elseif PASS(PRSI and NOT(EQUALQ(PRSI, BOTTLE))) then 
      TELL("The water leaks out of the ", D, PRSI, " and evaporates immediately.", CR)
      	return REMOVE_CAREFULLY(W)
    elseif INQ(BOTTLE, WINNER) then 
      
      if NOT(FSETQ(BOTTLE, OPENBIT)) then 
        TELL("The bottle is closed.", CR)
        	return THIS_IS_IT(BOTTLE)
      elseif NOT(FIRSTQ(BOTTLE)) then 
        MOVE(WATER, BOTTLE)
        	return TELL("The bottle is now full of water.", CR)
      elseif T then 
        TELL("The water slips through your fingers.", CR)
        	error(true)
      end

    elseif PASS(INQ(PRSO, BOTTLE) and VERBQ(TAKE) and NOT(PRSI)) then 
      	return TELL("It's in the bottle. Perhaps you should take that instead.", CR)
    elseif T then 
      	return TELL("The water slips through your fingers.", CR)
    end

  elseif PIQ then 
    
    if PASS(VERBQ(PUT) and GLOBAL_INQ(RIVER, HERE)) then 
      PERFORM(VQPUT, PRSO, RIVER)
    else 
      TELL("Nice try.", CR)
    end

    	error(true)
  elseif VERBQ(DROP, GIVE) then 
    
    if PASS(VERBQ(DROP) and INQ(WATER, BOTTLE) and NOT(FSETQ(BOTTLE, OPENBIT))) then 
      TELL("The bottle is closed.", CR)
      	error(true)
    end

    REMOVE_CAREFULLY(WATER)
    
    if AV then 
      TELL("There is now a puddle in the bottom of the ", D, AV, ".", CR)
      	return MOVE(WATER, AV)
    elseif T then 
      TELL("The water spills to the floor and evaporates immediately.", CR)
      	return REMOVE_CAREFULLY(WATER)
    end

  elseif VERBQ(THROW) then 
    TELL("The water splashes on the walls and evaporates immediately.", CR)
    	return REMOVE_CAREFULLY(WATER)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WATER_F\n'..__res) end
end
KITCHEN_WINDOW_FLAG = nil
KITCHEN_WINDOW_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE) then 
    APPLY(function() KITCHEN_WINDOW_FLAG = T return KITCHEN_WINDOW_FLAG end)
    	return OPEN_CLOSE(KITCHEN_WINDOW, "With great effort, you open the window far enough to allow entry.", "The window closes (more easily than it opened).")
  elseif PASS(VERBQ(EXAMINE) and NOT(KITCHEN_WINDOW_FLAG)) then 
    	return TELL("The window is slightly ajar, but not enough to allow entry.", CR)
  elseif VERBQ(WALK, BOARD, THROUGH) then 
    
    if EQUALQ(HERE, KITCHEN) then 
      DO_WALK(PQEAST)
    elseif T then 
      DO_WALK(PQWEST)
    end

    	error(true)
  elseif VERBQ(LOOK_INSIDE) then 
    TELL("You can see ")
    
    if EQUALQ(HERE, KITCHEN) then 
      	return TELL("a clear area leading towards a forest.", CR)
    elseif T then 
      	return TELL("what appears to be a kitchen.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('KITCHEN_WINDOW_F\n'..__res) end
end
GHOSTS_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TELL) then 
    TELL("The spirits jeer loudly and ignore you.", CR)
    	return APPLY(function() P_CONT = nil return P_CONT end)
  elseif VERBQ(EXORCISE) then 
    	return TELL("Only the ceremony itself has any effect.", CR)
  elseif PASS(VERBQ(ATTACK, MUNG) and EQUALQ(PRSO, GHOSTS)) then 
    	return TELL("How can you attack a spirit with material objects?", CR)
  elseif T then 
    	return TELL("You seem unable to interact with these spirits.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GHOSTS_F\n'..__res) end
end
CAGE_TOP = T
BASKET_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(RAISE) then 
    
    if CAGE_TOP then 
      	return TELL(PICK_ONE(DUMMY), CR)
    elseif T then 
      MOVE(RAISED_BASKET, SHAFT_ROOM)
      MOVE(LOWERED_BASKET, LOWER_SHAFT)
      APPLY(function() CAGE_TOP = T return CAGE_TOP end)
      THIS_IS_IT(RAISED_BASKET)
      	return TELL("The basket is raised to the top of the shaft.", CR)
    end

  elseif VERBQ(LOWER) then 
    
    if NOT(CAGE_TOP) then 
      	return TELL(PICK_ONE(DUMMY), CR)
    elseif T then 
      MOVE(RAISED_BASKET, LOWER_SHAFT)
      MOVE(LOWERED_BASKET, SHAFT_ROOM)
      THIS_IS_IT(LOWERED_BASKET)
      TELL("The basket is lowered to the bottom of the shaft.", CR)
      APPLY(function() CAGE_TOP = nil return CAGE_TOP end)
      
      if PASS(LIT and NOT(APPLY(function() LIT = LITQ(HERE) return LIT end))) then 
        TELL("It is now pitch black.", CR)
      end

      -- 	return T
    end

  elseif PASS(EQUALQ(PRSO, LOWERED_BASKET) or EQUALQ(PRSI, LOWERED_BASKET)) then 
    	return TELL("The basket is at the other end of the chain.", CR)
  elseif PASS(VERBQ(TAKE) and EQUALQ(PRSO, RAISED_BASKET, LOWERED_BASKET)) then 
    	return TELL("The cage is securely fastened to the iron chain.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BASKET_F\n'..__res) end
end
BAT_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TELL) then 
    FWEEP(6)
    	return APPLY(function() P_CONT = nil return P_CONT end)
  elseif VERBQ(TAKE, ATTACK, MUNG) then 
    
    if EQUALQ(LOC(GARLIC), WINNER, HERE) then 
      	return TELL("You can't reach him; he's on the ceiling.", CR)
    elseif T then 
      	return FLY_ME()
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BAT_F\n'..__res) end
end
FLY_ME = function()
	local __ok, __res = pcall(function()
  FWEEP(4)
  TELL("The bat grabs you by the scruff of your neck and lifts you away....", CR, CR)
  GOTO(PICK_ONE(BAT_DROPS), nil)

  if NOT(EQUALQ(HERE, ENTRANCE_TO_HADES)) then 
    V_FIRST_LOOK()
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FLY_ME\n'..__res) end
end
FWEEP = function(N)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if LQ(APPLY(function() N = SUB(N, 1) return N end), 1) then 
      return 
    elseif T then 
      TELL("    Fweep!", CR)
    end


  end end)

	return   CRLF()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FWEEP\n'..__res) end
end
BAT_DROPS = {0,MINE_1,MINE_2,MINE_3,MINE_4,LADDER_TOP,LADDER_BOTTOM,SQUEEKY_ROOM,MINE_ENTRANCE}

BELL_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(RING) then 
    
    if PASS(EQUALQ(HERE, LLD_ROOM) and NOT(LLD_FLAG)) then 
      	error(false)
    elseif T then 
      	return TELL("Ding, dong.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BELL_F\n'..__res) end
end
HOT_BELL_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    	return TELL("The bell is very hot and cannot be taken.", CR)
  elseif PASS(VERBQ(RUB) or PASS(VERBQ(RING) and PRSI)) then 
    
    if FSETQ(PRSI, BURNBIT) then 
      TELL("The ", D, PRSI, " burns and is consumed.", CR)
      	return REMOVE_CAREFULLY(PRSI)
    elseif EQUALQ(PRSI, HANDS) then 
      	return TELL("The bell is too hot to touch.", CR)
    elseif T then 
      	return TELL("The heat from the bell is too intense.", CR)
    end

  elseif VERBQ(POUR_ON) then 
    REMOVE_CAREFULLY(PRSO)
    TELL("The water cools the bell and is evaporated.", CR)
    QUEUE(I_XBH, 0)
    	return I_XBH()
  elseif VERBQ(RING) then 
    	return TELL("The bell is too hot to reach.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HOT_BELL_F\n'..__res) end
end
BOARDED_WINDOW_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN) then 
    	return TELL("The windows are boarded and can't be opened.", CR)
  elseif VERBQ(MUNG) then 
    	return TELL("You can't break the windows open.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BOARDED_WINDOW_FCN\n'..__res) end
end
NAILS_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    	return TELL("The nails, deeply imbedded in the door, cannot be removed.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('NAILS_PSEUDO\n'..__res) end
end
CRACK_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(THROUGH) then 
    	return TELL("You can't fit through the crack.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CRACK_FCN\n'..__res) end
end
KITCHEN_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are in the kitchen of the white house. A table seems to\nhave been used recently for the preparation of food. A passage\nleads to the west and a dark staircase can be seen leading\nupward. A dark chimney leads down and to the east is a small\nwindow which is ")
    
    if FSETQ(KITCHEN_WINDOW, OPENBIT) then 
      	return TELL("open.", CR)
    elseif T then 
      	return TELL("slightly ajar.", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_UP) and EQUALQ(PRSO, STAIRS)) then 
      	return DO_WALK(PQUP)
    elseif PASS(VERBQ(CLIMB_UP) and EQUALQ(PRSO, STAIRS)) then 
      	return TELL("There are no stairs leading down.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('KITCHEN_FCN\n'..__res) end
end
STONE_BARROW_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(RARG, M_BEG) and PASS(VERBQ(ENTER) or PASS(VERBQ(WALK) and EQUALQ(PRSO, PQWEST, PQIN)) or PASS(VERBQ(THROUGH) and EQUALQ(PRSO, BARROW)))) then 
    TELL("Inside the Barrow|\nAs you enter the barrow, the door closes inexorably behind you. Around\nyou it is dark, but ahead is an enormous cavern, brightly lit. Through\nits center runs a wide stream. Spanning the stream is a small wooden\nfootbridge, and beyond a path leads into a dark tunnel. Above the\nbridge, floating in the air, is a large sign. It reads:  All ye who\nstand before this bridge have completed a great and perilous adventure\nwhich has tested your wit and courage. You have mastered")
    
    if EQUALQ(BAND(GETB(0, 1), 8), 0) then 
      TELL("\nthe first part of the ZORK trilogy. Those who pass over this bridge must be\nprepared to undertake an even greater adventure that will severely test your\nskill and bravery!|\n|\nThe ZORK trilogy continues with \"ZORK II: The Wizard of Frobozz\" and\nis completed in \"ZORK III: The Dungeon Master.\"", CR)
    elseif T then 
      TELL("\nZORK: The Great Underground Empire.|", CR)
    end

    	return FINISH()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STONE_BARROW_FCN\n'..__res) end
end
BARROW_DOOR_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE) then 
    	return TELL("The door is too heavy.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BARROW_DOOR_FCN\n'..__res) end
end
BARROW_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(THROUGH) then 
    	return DO_WALK(PQWEST)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BARROW_FCN\n'..__res) end
end
TROPHY_CASE_FCN = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, TROPHY_CASE)) then 
    	return TELL("The trophy case is securely fastened to the wall.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TROPHY_CASE_FCN\n'..__res) end
end
RUG_MOVED = nil
LIVING_ROOM_FCN = function(RARG)
	local RUGQ
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are in the living room. There is a doorway to the east")
    
    if MAGIC_FLAG then 
      TELL(". To the\nwest is a cyclops-shaped opening in an old wooden door, above which is\nsome strange gothic lettering, ")
    elseif T then 
      TELL(", a wooden\ndoor with strange gothic lettering to the west, which appears to be\nnailed shut, ")
    end

    TELL("a trophy case, ")
    APPLY(function() RUGQ = RUG_MOVED return RUGQ end)
    
    if PASS(RUGQ and FSETQ(TRAP_DOOR, OPENBIT)) then 
      TELL("and a rug lying beside an open trap door.")
    elseif RUGQ then 
      TELL("and a closed trap door at your feet.")
    elseif FSETQ(TRAP_DOOR, OPENBIT) then 
      TELL("and an open trap door at your feet.")
    elseif T then 
      TELL("and a large oriental rug in the center of the room.")
    end

    CRLF()
    -- 	return T
  elseif EQUALQ(RARG, M_END) then 
    
    if PASS(VERBQ(TAKE) or PASS(VERBQ(PUT) and EQUALQ(PRSI, TROPHY_CASE))) then 
      
      if INQ(PRSO, TROPHY_CASE) then 
        TOUCH_ALL(PRSO)
      end

      APPLY(function() SCORE = ADD(BASE_SCORE, OTVAL_FROB()) return SCORE end)
      SCORE_UPD(0)
      	error(false)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LIVING_ROOM_FCN\n'..__res) end
end
TOUCH_ALL = function(OBJ)
	local F
	local __ok, __res = pcall(function()
APPLY(function() F = FIRSTQ(OBJ) return F end)

  APPLY(function() while true do
    
    if NOT(F) then 
      return 
    elseif T then 
      FSET(F, TOUCHBIT)
      
      if FIRSTQ(F) then 
        TOUCH_ALL(F)
      end

    end

    APPLY(function() F = NEXTQ(F) return F end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TOUCH_ALL\n'..__res) end
end
OTVAL_FROB = function(O)
	local F
  local SCORE = 0
  O = O or TROPHY_CASE
	local __ok, __res = pcall(function()
APPLY(function() F = FIRSTQ(O) return F end)

  APPLY(function() while true do
    
    if NOT(F) then 
      return SCORE
    end

    APPLY(function() SCORE = ADD(SCORE, GETP(F, PQTVALUE)) return SCORE end)
    
    if FIRSTQ(F) then 
      OTVAL_FROB(F)
    end

    APPLY(function() F = NEXTQ(F) return F end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('OTVAL_FROB\n'..__res) end
end
TRAP_DOOR_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(RAISE) then 
    PERFORM(VQOPEN, TRAP_DOOR)
    	error(true)
  elseif PASS(VERBQ(OPEN, CLOSE) and EQUALQ(HERE, LIVING_ROOM)) then 
    	return OPEN_CLOSE(PRSO, "The door reluctantly opens to reveal a rickety staircase descending into\ndarkness.", "The door swings shut and closes.")
  elseif PASS(VERBQ(LOOK_UNDER) and EQUALQ(HERE, LIVING_ROOM)) then 
    
    if FSETQ(TRAP_DOOR, OPENBIT) then 
      	return TELL("You see a rickety staircase descending into darkness.", CR)
    elseif T then 
      	return TELL("It's closed.", CR)
    end

  elseif EQUALQ(HERE, CELLAR) then 
    
    if PASS(VERBQ(OPEN, UNLOCK) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      	return TELL("The door is locked from above.", CR)
    elseif PASS(VERBQ(CLOSE) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      FCLEAR(TRAP_DOOR, TOUCHBIT)
      FCLEAR(TRAP_DOOR, OPENBIT)
      	return TELL("The door closes and locks.", CR)
    elseif VERBQ(OPEN, CLOSE) then 
      	return TELL(PICK_ONE(DUMMY), CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TRAP_DOOR_FCN\n'..__res) end
end
CELLAR_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    	return TELL("You are in a dark and damp cellar with a narrow passageway leading\nnorth, and a crawlway to the south. On the west is the bottom of a\nsteep metal ramp which is unclimbable.", CR)
  elseif EQUALQ(RARG, M_ENTER) then 
    
    if PASS(FSETQ(TRAP_DOOR, OPENBIT) and NOT(FSETQ(TRAP_DOOR, TOUCHBIT))) then 
      FCLEAR(TRAP_DOOR, OPENBIT)
      FSET(TRAP_DOOR, TOUCHBIT)
      	return TELL("The trap door crashes shut, and you hear someone barring it.", CR, CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CELLAR_FCN\n'..__res) end
end
CHIMNEY_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(EXAMINE) then 
    TELL("The chimney leads ")
    
    if EQUALQ(HERE, KITCHEN) then 
      TELL("down")
    elseif T then 
      TELL("up")
    end

    	return TELL("ward, and looks climbable.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CHIMNEY_F\n'..__res) end
end
UP_CHIMNEY_FUNCTION = function()
	local F
	local __ok, __res = pcall(function()

  if NOT(APPLY(function() F = FIRSTQ(WINNER) return F end)) then 
    TELL("Going up empty-handed is a bad idea.", CR)
    	error(false)
  elseif PASS(PASS(NOT(APPLY(function() F = NEXTQ(F) return F end)) or NOT(NEXTQ(F))) and INQ(LAMP, WINNER)) then 
    
    if NOT(FSETQ(TRAP_DOOR, OPENBIT)) then 
      FCLEAR(TRAP_DOOR, TOUCHBIT)
    end

    return KITCHEN
  elseif T then 
    TELL("You can't get up there with what you're carrying.", CR)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('UP_CHIMNEY_FUNCTION\n'..__res) end
end
TRAP_DOOR_EXIT = function()
	local __ok, __res = pcall(function()

  if RUG_MOVED then 
    
    if FSETQ(TRAP_DOOR, OPENBIT) then 
      return CELLAR
    elseif T then 
      TELL("The trap door is closed.", CR)
      THIS_IS_IT(TRAP_DOOR)
      	error(false)
    end

  elseif T then 
    TELL("You can't go that way.", CR)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TRAP_DOOR_EXIT\n'..__res) end
end
RUG_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(RAISE) then 
    TELL("The rug is too heavy to lift")
    
    if RUG_MOVED then 
      	return TELL(".", CR)
    elseif T then 
      	return TELL(", but in trying to take it you have\nnoticed an irregularity beneath it.", CR)
    end

  elseif VERBQ(MOVE, PUSH) then 
    
    if RUG_MOVED then 
      	return TELL("Having moved the carpet previously, you find it impossible to move\nit again.", CR)
    elseif T then 
      TELL("With a great effort, the rug is moved to one side of the room, revealing\nthe dusty cover of a closed trap door.", CR)
      FCLEAR(TRAP_DOOR, INVISIBLE)
      THIS_IS_IT(TRAP_DOOR)
      	return APPLY(function() RUG_MOVED = T return RUG_MOVED end)
    end

  elseif VERBQ(TAKE) then 
    	return TELL("The rug is extremely heavy and cannot be carried.", CR)
  elseif PASS(VERBQ(LOOK_UNDER) and NOT(RUG_MOVED) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
    	return TELL("Underneath the rug is a closed trap door. As you drop the corner of the\nrug, the trap door is once again concealed from view.", CR)
  elseif VERBQ(CLIMB_ON) then 
    
    if PASS(NOT(RUG_MOVED) and NOT(FSETQ(TRAP_DOOR, OPENBIT))) then 
      	return TELL("As you sit, you notice an irregularity underneath it. Rather than be\nuncomfortable, you stand up again.", CR)
    else 
      	return TELL("I suppose you think it's a magic carpet?", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RUG_FCN\n'..__res) end
end
AXE_F = function()
	local __ok, __res = pcall(function()

  if TROLL_FLAG then 
    	return nil
  elseif T then 
    	return WEAPON_FUNCTION(AXE, TROLL)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('AXE_F\n'..__res) end
end
STILETTO_FUNCTION = function()
	local __ok, __res = pcall(function()
	return   WEAPON_FUNCTION(STILETTO, THIEF)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STILETTO_FUNCTION\n'..__res) end
end
WEAPON_FUNCTION = function(W, V)
	local __ok, __res = pcall(function()

  if NOT(INQ(V, HERE)) then 
    	error(false)
  elseif VERBQ(TAKE) then 
    
    if INQ(W, V) then 
      TELL("The ", D, V, " swings it out of your reach.", CR)
    elseif T then 
      TELL("The ", D, W, " seems white-hot. You can't hold on to it.", CR)
    end

    -- 	return T
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WEAPON_FUNCTION\n'..__res) end
end
TROLL_FCN = function(MODE)
  MODE = MODE or nil
	local __ok, __res = pcall(function()

  if VERBQ(TELL) then 
    APPLY(function() P_CONT = nil return P_CONT end)
    	return TELL("The troll isn't much of a conversationalist.", CR)
  elseif EQUALQ(MODE, F_BUSYQ) then 
    
    if INQ(AXE, TROLL) then 
      	return nil
    elseif PASS(INQ(AXE, HERE) and PROB(75, 90)) then 
      FSET(AXE, NDESCBIT)
      FCLEAR(AXE, WEAPONBIT)
      MOVE(AXE, TROLL)
      PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks all passages out\nof the room.")
      PASS(INQ(TROLL, HERE) and TELL("The troll, angered and humiliated, recovers his weapon. He appears to have\nan axe to grind with you.", CR))
      -- 	return T
    elseif INQ(TROLL, HERE) then 
      PUTP(TROLL, PQLDESC, "A pathetically babbling troll is here.")
      TELL("The troll, disarmed, cowers in terror, pleading for his life in\nthe guttural tongue of the trolls.", CR)
      -- 	return T
    end

  elseif EQUALQ(MODE, F_DEAD) then 
    
    if INQ(AXE, TROLL) then 
      MOVE(AXE, HERE)
      FCLEAR(AXE, NDESCBIT)
      FSET(AXE, WEAPONBIT)
    end

    	return APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_UNCONSCIOUS) then 
    FCLEAR(TROLL, FIGHTBIT)
    
    if INQ(AXE, TROLL) then 
      MOVE(AXE, HERE)
      FCLEAR(AXE, NDESCBIT)
      FSET(AXE, WEAPONBIT)
    end

    PUTP(TROLL, PQLDESC, "An unconscious troll is sprawled on the floor. All passages\nout of the room are open.")
    	return APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_CONSCIOUS) then 
    
    if INQ(TROLL, HERE) then 
      FSET(TROLL, FIGHTBIT)
      TELL("The troll stirs, quickly resuming a fighting stance.", CR)
    end

    
    if INQ(AXE, TROLL) then 
      PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.")
    elseif INQ(AXE, TROLL_ROOM) then 
      FSET(AXE, NDESCBIT)
      FCLEAR(AXE, WEAPONBIT)
      MOVE(AXE, TROLL)
      PUTP(TROLL, PQLDESC, "A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.")
    elseif T then 
      PUTP(TROLL, PQLDESC, "A troll is here.")
    end

    	return APPLY(function() TROLL_FLAG = nil return TROLL_FLAG end)
  elseif EQUALQ(MODE, F_FIRSTQ) then 
    
    if PROB(33) then 
      FSET(TROLL, FIGHTBIT)
      APPLY(function() P_CONT = nil return P_CONT end)
      -- 	return T
    end

  elseif NOT(MODE) then 
    
    if VERBQ(EXAMINE) then 
      	return TELL(GETP(TROLL, PQLDESC), CR)
    elseif PASS(PASS(VERBQ(THROW, GIVE) and PRSO and EQUALQ(PRSI, TROLL)) or VERBQ(TAKE, MOVE, MUNG)) then 
      AWAKEN(TROLL)
      
      if VERBQ(THROW, GIVE) then 
        
        if PASS(EQUALQ(PRSO, AXE) and INQ(AXE, WINNER)) then 
          TELL("The troll scratches his head in confusion, then takes the axe.", CR)
          FSET(TROLL, FIGHTBIT)
          MOVE(AXE, TROLL)
          	error(true)
        elseif EQUALQ(PRSO, TROLL, AXE) then 
          TELL("You would have to get the ", D, PRSO, " first, and that seems unlikely.", CR)
          	error(true)
        end

        
        if VERBQ(THROW) then 
          TELL("The troll, who is remarkably coordinated, catches the ", D, PRSO)
        elseif T then 
          TELL("The troll, who is not overly proud, graciously accepts the gift")
        end

        
        if PASS(PROB(20) and EQUALQ(PRSO, KNIFE, SWORD, AXE)) then 
          REMOVE_CAREFULLY(PRSO)
          TELL(" and eats it hungrily. Poor troll, he dies from an internal hemorrhage\nand his carcass disappears in a sinister black fog.", CR)
          REMOVE_CAREFULLY(TROLL)
          APPLY(GETP(TROLL, PQACTION), F_DEAD)
          	return APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
        elseif EQUALQ(PRSO, KNIFE, SWORD, AXE) then 
          MOVE(PRSO, HERE)
          TELL(" and, being for the moment sated, throws it back. Fortunately, the\ntroll has poor control, and the ", D, PRSO, " falls to the floor. He does\nnot look pleased.", CR)
          	return FSET(TROLL, FIGHTBIT)
        elseif T then 
          TELL(" and not having the most discriminating tastes, gleefully eats it.", CR)
          	return REMOVE_CAREFULLY(PRSO)
        end

      elseif VERBQ(TAKE, MOVE) then 
        	return TELL("The troll spits in your face, grunting \"Better luck next time\" in a\nrather barbarous accent.", CR)
      elseif VERBQ(MUNG) then 
        	return TELL("The troll laughs at your puny gesture.", CR)
      end

    elseif VERBQ(LISTEN) then 
      	return TELL("Every so often the troll says something, probably uncomplimentary, in\nhis guttural tongue.", CR)
    elseif PASS(TROLL_FLAG and VERBQ(HELLO)) then 
      	return TELL("Unfortunately, the troll can't hear you.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TROLL_FCN\n'..__res) end
end
GRATE_REVEALED = nil
GRUNLOCK = nil
LEAVES_APPEAR = function()
	local __ok, __res = pcall(function()

  if PASS(NOT(FSETQ(GRATE, OPENBIT)) and NOT(GRATE_REVEALED)) then 
    
    if VERBQ(MOVE, TAKE) then 
      TELL("In disturbing the pile of leaves, a grating is revealed.", CR)
    elseif T then 
      TELL("With the leaves moved, a grating is revealed.", CR)
    end

    FCLEAR(GRATE, INVISIBLE)
    APPLY(function() GRATE_REVEALED = T return GRATE_REVEALED end)
  end

	return nil
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LEAVES_APPEAR\n'..__res) end
end
LEAF_PILE = function()
	local __ok, __res = pcall(function()

  if VERBQ(COUNT) then 
    	return TELL("There are 69,105 leaves here.", CR)
  elseif VERBQ(BURN) then 
    LEAVES_APPEAR()
    REMOVE_CAREFULLY(PRSO)
    
    if INQ(PRSO, HERE) then 
      	return TELL("The leaves burn.", CR)
    elseif T then 
      	return JIGS_UP("The leaves burn, and so do you.")
    end

  elseif VERBQ(CUT) then 
    TELL("You rustle the leaves around, making quite a mess.", CR)
    LEAVES_APPEAR()
    	error(true)
  elseif VERBQ(MOVE, TAKE) then 
    
    if VERBQ(MOVE) then 
      TELL("Done.", CR)
    end

    
    if GRATE_REVEALED then 
      	error(false)
    end

    LEAVES_APPEAR()
    
    if VERBQ(TAKE) then 
      	error(false)
    elseif T then 
      	error(true)
    end

  elseif PASS(VERBQ(LOOK_UNDER) and NOT(GRATE_REVEALED)) then 
    	return TELL("Underneath the pile of leaves is a grating. As you release the leaves,\nthe grating is once again concealed from view.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LEAF_PILE\n'..__res) end
end
CLEARING_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_ENTER) then 
    
    if NOT(GRATE_REVEALED) then 
      	return FSET(GRATE, INVISIBLE)
    end

  elseif EQUALQ(RARG, M_LOOK) then 
    TELL("You are in a clearing, with a forest surrounding you on all sides. A\npath leads south.")
    
    if FSETQ(GRATE, OPENBIT) then 
      CRLF()
      TELL("There is an open grating, descending into darkness.")
    elseif GRATE_REVEALED then 
      CRLF()
      TELL("There is a grating securely fastened into the ground.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CLEARING_FCN\n'..__res) end
end
MAZE_11_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_ENTER) then 
    	return FCLEAR(GRATE, INVISIBLE)
  elseif EQUALQ(RARG, M_LOOK) then 
    TELL("You are in a small room near the maze. There are twisty passages\nin the immediate vicinity.", CR)
    
    if FSETQ(GRATE, OPENBIT) then 
      TELL("Above you is an open grating with sunlight pouring in.")
    elseif GRUNLOCK then 
      TELL("Above you is a grating.")
    elseif T then 
      TELL("Above you is a grating locked with a skull-and-crossbones lock.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MAZE_11_FCN\n'..__res) end
end
GRATE_FUNCTION = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(OPEN) and EQUALQ(PRSI, KEYS)) then 
    PERFORM(VQUNLOCK, GRATE, KEYS)
    	error(true)
  elseif VERBQ(LOCK) then 
    
    if EQUALQ(HERE, GRATING_ROOM) then 
      APPLY(function() GRUNLOCK = nil return GRUNLOCK end)
      	return TELL("The grate is locked.", CR)
    elseif EQUALQ(HERE, GRATING_CLEARING) then 
      	return TELL("You can't lock it from this side.", CR)
    end

  elseif PASS(VERBQ(UNLOCK) and EQUALQ(PRSO, GRATE)) then 
    
    if PASS(EQUALQ(HERE, GRATING_ROOM) and EQUALQ(PRSI, KEYS)) then 
      APPLY(function() GRUNLOCK = T return GRUNLOCK end)
      	return TELL("The grate is unlocked.", CR)
    elseif PASS(EQUALQ(HERE, GRATING_CLEARING) and EQUALQ(PRSI, KEYS)) then 
      	return TELL("You can't reach the lock from here.", CR)
    elseif T then 
      	return TELL("Can you unlock a grating with a ", D, PRSI, "?", CR)
    end

  elseif VERBQ(PICK) then 
    	return TELL("You can't pick the lock.", CR)
  elseif VERBQ(OPEN, CLOSE) then 
    
    if GRUNLOCK then 
      OPEN_CLOSE(GRATE, APPLY(function()
        if EQUALQ(HERE, CLEARING) then 
          -- 	return "The grating opens."
        elseif T then 
          -- 	return "The grating opens to reveal trees above you."
        end
 end), "The grating is closed.")
      
      if FSETQ(GRATE, OPENBIT) then 
        
        if PASS(NOT(EQUALQ(HERE, CLEARING)) and NOT(GRATE_REVEALED)) then 
          TELL("A pile of leaves falls onto your head and to the ground.", CR)
          APPLY(function() GRATE_REVEALED = T return GRATE_REVEALED end)
          MOVE(LEAVES, HERE)
        end

        	return FSET(GRATING_ROOM, ONBIT)
      elseif T then 
        	return FCLEAR(GRATING_ROOM, ONBIT)
      end

    elseif T then 
      	return TELL("The grating is locked.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, GRATE)) then 
    
    if GQ(GETP(PRSO, PQSIZE), 20) then 
      	return TELL("It won't fit through the grating.", CR)
    elseif T then 
      MOVE(PRSO, GRATING_ROOM)
      	return TELL("The ", D, PRSO, " goes through the grating into the darkness below.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GRATE_FUNCTION\n'..__res) end
end
MAZE_DIODES = function()
	local __ok, __res = pcall(function()
  TELL("You won't be able to get back up to the tunnel you are going through\nwhen it gets to the next room.", CR, CR)

  if EQUALQ(HERE, MAZE_2) then 
    -- 	return MAZE_4
  elseif EQUALQ(HERE, MAZE_7) then 
    -- 	return DEAD_END_1
  elseif EQUALQ(HERE, MAZE_9) then 
    -- 	return MAZE_11
  elseif EQUALQ(HERE, MAZE_12) then 
    -- 	return MAZE_5
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MAZE_DIODES\n'..__res) end
end
RUSTY_KNIFE_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    PASS(INQ(SWORD, WINNER) and TELL("As you touch the rusty knife, your sword gives a single pulse of blinding\nblue light.", CR))
    	return nil
  elseif PASS(PASS(EQUALQ(PRSI, RUSTY_KNIFE) and VERBQ(ATTACK)) or PASS(VERBQ(SWING) and EQUALQ(PRSO, RUSTY_KNIFE) and PRSI)) then 
    REMOVE_CAREFULLY(RUSTY_KNIFE)
    	return JIGS_UP("As the knife approaches its victim, your mind is submerged by an\novermastering will. Slowly, your hand turns, until the rusty blade\nis an inch from your neck. The knife seems to sing as it savagely\nslits your throat.")
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RUSTY_KNIFE_FCN\n'..__res) end
end
KNIFE_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    FCLEAR(ATTIC_TABLE, NDESCBIT)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('KNIFE_F\n'..__res) end
end
SKELETON = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE, RUB, MOVE, PUSH, RAISE, LOWER, ATTACK, KICK, KISS) then 
    TELL("A ghost appears in the room and is appalled at your desecration of\nthe remains of a fellow adventurer. He casts a curse on your valuables\nand banishes them to the Land of the Living Dead. The ghost leaves,\nmuttering obscenities.", CR)
    ROB(HERE, LAND_OF_LIVING_DEAD, 100)
    ROB(ADVENTURER, LAND_OF_LIVING_DEAD)
    -- 	return T
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SKELETON\n'..__res) end
end
TORCH_OBJECT = function()
	local __ok, __res = pcall(function()

  if VERBQ(EXAMINE) then 
    	return TELL("The torch is burning.", CR)
  elseif PASS(VERBQ(POUR_ON) and EQUALQ(PRSI, TORCH)) then 
    	return TELL("The water evaporates before it gets close.", CR)
  elseif PASS(VERBQ(LAMP_OFF) and FSETQ(PRSO, ONBIT)) then 
    	return TELL("You nearly burn your hand trying to extinguish the flame.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TORCH_OBJECT\n'..__res) end
end
MIRROR_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are in a large square room with tall ceilings. On the south wall\nis an enormous mirror which fills the entire wall. There are exits\non the other three sides of the room.", CR)
    
    if MIRROR_MUNG then 
      	return TELL("Unfortunately, the mirror has been destroyed by your recklessness.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MIRROR_ROOM\n'..__res) end
end
MIRROR_MUNG = nil
MIRROR_MIRROR = function()
  local RM2 = MIRROR_ROOM_2
	local L1
	local L2
	local N
	local __ok, __res = pcall(function()

  if PASS(NOT(MIRROR_MUNG) and VERBQ(RUB)) then 
    
    if PASS(PRSI and NOT(EQUALQ(PRSI, HANDS))) then 
      TELL("You feel a faint tingling transmitted through the ", D, PRSI, ".", CR)
      	error(true)
    end

    
    if EQUALQ(HERE, RM2) then 
      APPLY(function() RM2 = MIRROR_ROOM_1 return RM2 end)
    end

    APPLY(function() L1 = FIRSTQ(HERE) return L1 end)
    APPLY(function() L2 = FIRSTQ(RM2) return L2 end)
    
    APPLY(function() while true do
      
      if NOT(L1) then 
        return 
      end

      APPLY(function() N = NEXTQ(L1) return N end)
      MOVE(L1, RM2)
      APPLY(function() L1 = N return L1 end)

    end end)

    
    APPLY(function() while true do
      
      if NOT(L2) then 
        return 
      end

      APPLY(function() N = NEXTQ(L2) return N end)
      MOVE(L2, HERE)
      APPLY(function() L2 = N return L2 end)

    end end)

    GOTO(RM2, nil)
    	return TELL("There is a rumble from deep within the earth and the room shakes.", CR)
  elseif VERBQ(LOOK_INSIDE, EXAMINE) then 
    
    if MIRROR_MUNG then 
      TELL("The mirror is broken into many pieces.")
    elseif T then 
      TELL("There is an ugly person staring back at you.")
    end

    	return CRLF()
  elseif VERBQ(TAKE) then 
    	return TELL("The mirror is many times your size. Give up.", CR)
  elseif VERBQ(MUNG, THROW, ATTACK) then 
    
    if MIRROR_MUNG then 
      	return TELL("Haven't you done enough damage already?", CR)
    elseif T then 
      APPLY(function() MIRROR_MUNG = T return MIRROR_MUNG end)
      APPLY(function() LUCKY = nil return LUCKY end)
      	return TELL("You have broken the mirror. I hope you have a seven years' supply of\ngood luck handy.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MIRROR_MIRROR\n'..__res) end
end
TORCH_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("This is a large room with a prominent doorway leading to a down\nstaircase. Above you is a large dome. Up around the edge of the\ndome (20 feet up) is a wooden railing. In the center of the room\nsits a white marble pedestal.", CR)
    
    if DOME_FLAG then 
      	return TELL("A piece of rope descends from the railing above, ending some\nfive feet above your head.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TORCH_ROOM_FCN\n'..__res) end
end
DOME_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are at the periphery of a large dome, which forms the ceiling\nof another room below. Protecting you from a precipitous drop is a\nwooden railing which circles the dome.", CR)
    
    if DOME_FLAG then 
      	return TELL("Hanging down from the railing is a rope which ends about ten feet\nfrom the floor below.", CR)
    end

  elseif EQUALQ(RARG, M_ENTER) then 
    
    if DEAD then 
      TELL("As you enter the dome you feel a strong pull as if from a wind\ndrawing you over the railing and down.", CR)
      MOVE(WINNER, TORCH_ROOM)
      APPLY(function() HERE = TORCH_ROOM return HERE end)
      	error(true)
    elseif VERBQ(LEAP) then 
      	return JIGS_UP("I'm afraid that the leap you attempted has done you in.")
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DOME_ROOM_FCN\n'..__res) end
end
LLD_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are outside a large gateway, on which is inscribed||\n  Abandon every hope\nall ye who enter here!||\nThe gate is open; through it you can see a desolation, with a pile of\nmangled bodies in one corner. Thousands of voices, lamenting some\nhideous fate, can be heard.", CR)
    
    if PASS(NOT(LLD_FLAG) and NOT(DEAD)) then 
      	return TELL("The way through the gate is barred by evil spirits, who jeer at your\nattempts to pass.", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if VERBQ(EXORCISE) then 
      
      if NOT(LLD_FLAG) then 
        
        if PASS(INQ(BELL, WINNER) and INQ(BOOK, WINNER) and INQ(CANDLES, WINNER)) then 
          	return TELL("You must perform the ceremony.", CR)
        elseif T then 
          	return TELL("You aren't equipped for an exorcism.", CR)
        end

      end

    elseif PASS(NOT(LLD_FLAG) and VERBQ(RING) and EQUALQ(PRSO, BELL)) then 
      APPLY(function() XB = T return XB end)
      REMOVE_CAREFULLY(BELL)
      THIS_IS_IT(HOT_BELL)
      MOVE(HOT_BELL, HERE)
      TELL("The bell suddenly becomes red hot and falls to the ground. The\nwraiths, as if paralyzed, stop their jeering and slowly turn to face\nyou. On their ashen faces, the expression of a long-forgotten terror\ntakes shape.", CR)
      
      if INQ(CANDLES, WINNER) then 
        TELL("In your confusion, the candles drop to the ground (and they are out).", CR)
        MOVE(CANDLES, HERE)
        FCLEAR(CANDLES, ONBIT)
        DISABLE(INT(I_CANDLES))
      end

      ENABLE(QUEUE(I_XB, 6))
      	return ENABLE(QUEUE(I_XBH, 20))
    elseif PASS(XC and VERBQ(READ) and EQUALQ(PRSO, BOOK) and NOT(LLD_FLAG)) then 
      TELL("Each word of the prayer reverberates through the hall in a deafening\nconfusion. As the last word fades, a voice, loud and commanding,\nspeaks: \"Begone, fiends!\" A heart-stopping scream fills the cavern,\nand the spirits, sensing a greater power, flee through the walls.", CR)
      REMOVE_CAREFULLY(GHOSTS)
      APPLY(function() LLD_FLAG = T return LLD_FLAG end)
      	return DISABLE(INT(I_XC))
    end

  elseif EQUALQ(RARG, M_END) then 
    
    if PASS(XB and INQ(CANDLES, WINNER) and FSETQ(CANDLES, ONBIT) and NOT(XC)) then 
      APPLY(function() XC = T return XC end)
      TELL("The flames flicker wildly and appear to dance. The earth beneath\nyour feet trembles, and your legs nearly buckle beneath you.\nThe spirits cower at your unearthly power.", CR)
      DISABLE(INT(I_XB))
      	return ENABLE(QUEUE(I_XC, 3))
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LLD_ROOM\n'..__res) end
end
XB = nil
XC = nil
I_XB = function()
	local __ok, __res = pcall(function()
  PASS(XC or PASS(EQUALQ(HERE, ENTRANCE_TO_HADES) and TELL("The tension of this ceremony is broken, and the wraiths, amused but\nshaken at your clumsy attempt, resume their hideous jeering.", CR)))
	return APPLY(function() XB = nil return XB end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_XB\n'..__res) end
end
I_XC = function()
	local __ok, __res = pcall(function()
APPLY(function() XC = nil return XC end)
	return   I_XB()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_XC\n'..__res) end
end
I_XBH = function()
	local __ok, __res = pcall(function()
  REMOVE_CAREFULLY(HOT_BELL)
  MOVE(BELL, ENTRANCE_TO_HADES)

  if EQUALQ(HERE, ENTRANCE_TO_HADES) then 
    	return TELL("The bell appears to have cooled down.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_XBH\n'..__res) end
end
GATE_FLAG = nil
GATES_OPEN = nil
DAM_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are standing on the top of the Flood Control Dam #3, which was\nquite a tourist attraction in times far distant. There are paths to\nthe north, south, and west, and a scramble down.", CR)
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      TELL("The water level behind the dam is low: The sluice gates have been\nopened. Water rushes through the dam and downstream.", CR)
    elseif GATES_OPEN then 
      TELL("The sluice gates are open, and water rushes through the dam. The\nwater level behind the dam is still high.", CR)
    elseif LOW_TIDE then 
      TELL("The sluice gates are closed. The water level in the reservoir is\nquite low, but the level is rising quickly.", CR)
    elseif T then 
      TELL("The sluice gates on the dam are closed. Behind the dam, there can be\nseen a wide reservoir. Water is pouring over the top of the now\nabandoned dam.", CR)
    end

    TELL("There is a control panel here, on which a large metal bolt is mounted.\nDirectly above the bolt is a small green plastic bubble")
    
    if GATE_FLAG then 
      TELL(" which is\nglowing serenely")
    end

    	return TELL(".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DAM_ROOM_FCN\n'..__res) end
end
BOLT_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TURN) then 
    
    if EQUALQ(PRSI, WRENCH) then 
      
      if GATE_FLAG then 
        FCLEAR(RESERVOIR_SOUTH, TOUCHBIT)
        
        if GATES_OPEN then 
          APPLY(function() GATES_OPEN = nil return GATES_OPEN end)
          FCLEAR(LOUD_ROOM, TOUCHBIT)
          TELL("The sluice gates close and water starts to collect behind the dam.", CR)
          ENABLE(QUEUE(I_RFILL, 8))
          QUEUE(I_REMPTY, 0)
          -- 	return T
        elseif T then 
          APPLY(function() GATES_OPEN = T return GATES_OPEN end)
          TELL("The sluice gates open and water pours through the dam.", CR)
          ENABLE(QUEUE(I_REMPTY, 8))
          QUEUE(I_RFILL, 0)
          -- 	return T
        end

      elseif T then 
        	return TELL("The bolt won't turn with your best effort.", CR)
      end

    elseif NOT(EQUALQ(PRSI, nil, HANDS, ROOMS)) then 
      	return TELL("The bolt won't turn using the ", D, PRSI, ".", CR)
    end

  elseif VERBQ(TAKE) then 
    	return INTEGRAL_PART()
  elseif VERBQ(OIL) then 
    	return TELL("Hmm. It appears the tube contained glue, not oil. Turning the bolt\nwon't get any easier....", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BOLT_F\n'..__res) end
end
BUBBLE_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    	return INTEGRAL_PART()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BUBBLE_F\n'..__res) end
end
INTEGRAL_PART = function()
	local __ok, __res = pcall(function()
	return   TELL("It is an integral part of the control panel.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('INTEGRAL_PART\n'..__res) end
end
I_RFILL = function()
	local __ok, __res = pcall(function()
  FSET(RESERVOIR, NONLANDBIT)
  FCLEAR(RESERVOIR, RLANDBIT)
  FCLEAR(DEEP_CANYON, TOUCHBIT)
  FCLEAR(LOUD_ROOM, TOUCHBIT)
  PASS(INQ(TRUNK, RESERVOIR) and FSET(TRUNK, INVISIBLE))
APPLY(function() LOW_TIDE = nil return LOW_TIDE end)

  if EQUALQ(HERE, RESERVOIR) then 
    
    if FSETQ(LOC(WINNER), VEHBIT) then 
      TELL("The boat lifts gently out of the mud and is now floating on\nthe reservoir.", CR)
    elseif T then 
      JIGS_UP("You are lifted up by the rising river! You try to swim, but the\ncurrents are too strong. You come closer, closer to the awesome\nstructure of Flood Control Dam #3. The dam beckons to you.\nThe roar of the water nearly deafens you, but you remain conscious\nas you tumble over the dam toward your certain doom among the rocks\nat its base.")
    end

  elseif EQUALQ(HERE, DEEP_CANYON) then 
    TELL("A sound, like that of flowing water, starts to come from below.", CR)
  elseif EQUALQ(HERE, LOUD_ROOM) then 
    TELL("All of a sudden, an alarmingly loud roaring sound fills the room.\nFilled with fear, you scramble away.", CR)
    GOTO(PICK_ONE(LOUD_RUNS))
  elseif EQUALQ(HERE, RESERVOIR_NORTH, RESERVOIR_SOUTH) then 
    TELL("You notice that the water level has risen to the point that it\nis impossible to cross.", CR)
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_RFILL\n'..__res) end
end
LOUD_RUNS = {0,DAMP_CAVE,ROUND_ROOM,DEEP_CANYON}

I_REMPTY = function()
	local __ok, __res = pcall(function()
  FSET(RESERVOIR, RLANDBIT)
  FCLEAR(RESERVOIR, NONLANDBIT)
  FCLEAR(DEEP_CANYON, TOUCHBIT)
  FCLEAR(LOUD_ROOM, TOUCHBIT)
  FCLEAR(TRUNK, INVISIBLE)
APPLY(function() LOW_TIDE = T return LOW_TIDE end)

  if PASS(EQUALQ(HERE, RESERVOIR) and FSETQ(LOC(WINNER), VEHBIT)) then 
    TELL("The water level has dropped to the point at which the boat can no\nlonger stay afloat. It sinks into the mud.", CR)
  elseif EQUALQ(HERE, DEEP_CANYON) then 
    TELL("The roar of rushing water is quieter now.", CR)
  elseif EQUALQ(HERE, RESERVOIR_NORTH, RESERVOIR_SOUTH) then 
    TELL("The water level is now quite low here and you could easily cross over\nto the other side.", CR)
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_REMPTY\n'..__res) end
end
DROWNINGS = {"up to your ankles.","up to your shin.","up to your knees.","up to your hips.","up to your waist.","up to your chest.","up to your neck.","over your head.","high in your lungs."}

WATER_LEVEL = 0
BUTTON_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(READ) then 
    	return TELL("They're greek to you.", CR)
  elseif VERBQ(PUSH) then 
    
    if EQUALQ(PRSO, BLUE_BUTTON) then 
      
      if ZEROQ(WATER_LEVEL) then 
        FCLEAR(LEAK, INVISIBLE)
        TELL("There is a rumbling sound and a stream of water appears to burst\nfrom the east wall of the room (apparently, a leak has occurred in a\npipe).", CR)
        APPLY(function() WATER_LEVEL = 1 return WATER_LEVEL end)
        ENABLE(QUEUE(I_MAINT_ROOM, -1))
        -- 	return T
      elseif T then 
        	return TELL("The blue button appears to be jammed.", CR)
      end

    elseif EQUALQ(PRSO, RED_BUTTON) then 
      TELL("The lights within the room ")
      
      if FSETQ(HERE, ONBIT) then 
        FCLEAR(HERE, ONBIT)
        	return TELL("shut off.", CR)
      elseif T then 
        FSET(HERE, ONBIT)
        	return TELL("come on.", CR)
      end

    elseif EQUALQ(PRSO, BROWN_BUTTON) then 
      FCLEAR(DAM_ROOM, TOUCHBIT)
      APPLY(function() GATE_FLAG = nil return GATE_FLAG end)
      	return TELL("Click.", CR)
    elseif EQUALQ(PRSO, YELLOW_BUTTON) then 
      FCLEAR(DAM_ROOM, TOUCHBIT)
      APPLY(function() GATE_FLAG = T return GATE_FLAG end)
      	return TELL("Click.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BUTTON_F\n'..__res) end
end
TOOL_CHEST_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(EXAMINE) then 
    	return TELL("The chests are all empty.", CR)
  elseif VERBQ(TAKE, OPEN, PUT) then 
    REMOVE_CAREFULLY(TOOL_CHEST)
    	return TELL("The chests are so rusty and corroded that they crumble when you\ntouch them.", CR)
  elseif VERBQ(OPEN) then 
    	return TELL("The chests are already open.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TOOL_CHEST_FCN\n'..__res) end
end
I_MAINT_ROOM = function()
	local HEREQ
	local __ok, __res = pcall(function()
APPLY(function() HEREQ = EQUALQ(HERE, MAINTENANCE_ROOM) return HEREQ end)

  if HEREQ then 
    TELL("The water level here is now ")
    TELL(GET(DROWNINGS, DIV(WATER_LEVEL, 2)))
    CRLF()
  end

APPLY(function() WATER_LEVEL = ADD(1, WATER_LEVEL) return WATER_LEVEL end)

  if NOT(LQ(WATER_LEVEL, 14)) then 
    MUNG_ROOM(MAINTENANCE_ROOM, "The room is full of water and cannot be entered.")
    QUEUE(I_MAINT_ROOM, 0)
    
    if HEREQ then 
      JIGS_UP("I'm afraid you have done drowned yourself.")
    end

  elseif PASS(INQ(WINNER, INFLATED_BOAT) and EQUALQ(HERE, MAINTENANCE_ROOM, DAM_ROOM, DAM_LOBBY)) then 
    JIGS_UP("The rising water carries the boat over the dam, down the river, and over\nthe falls. Tsk, tsk.")
  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_MAINT_ROOM\n'..__res) end
end
LEAK_FUNCTION = function()
	local __ok, __res = pcall(function()

  if GQ(WATER_LEVEL, 0) then 
    
    if PASS(VERBQ(PUT, PUT_ON) and EQUALQ(PRSO, PUTTY)) then 
      	return FIX_MAINT_LEAK()
    elseif VERBQ(PLUG) then 
      
      if EQUALQ(PRSI, PUTTY) then 
        	return FIX_MAINT_LEAK()
      elseif T then 
        	return WITH_TELL(PRSI)
      end

    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LEAK_FUNCTION\n'..__res) end
end
FIX_MAINT_LEAK = function()
	local __ok, __res = pcall(function()
APPLY(function() WATER_LEVEL = -1 return WATER_LEVEL end)
  QUEUE(I_MAINT_ROOM, 0)
	return   TELL("By some miracle of Zorkian technology, you have managed to stop the\nleak in the dam.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIX_MAINT_LEAK\n'..__res) end
end
PUTTY_FCN = function()
	local __ok, __res = pcall(function()

  if PASS(PASS(VERBQ(OIL) and EQUALQ(PRSI, PUTTY)) or PASS(VERBQ(PUT) and EQUALQ(PRSO, PUTTY))) then 
    	return TELL("The all-purpose gunk isn't a lubricant.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PUTTY_FCN\n'..__res) end
end
TUBE_FUNCTION = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(PUT) and EQUALQ(PRSI, TUBE)) then 
    	return TELL("The tube refuses to accept anything.", CR)
  elseif VERBQ(SQUEEZE) then 
    
    if PASS(FSETQ(PRSO, OPENBIT) and INQ(PUTTY, PRSO)) then 
      MOVE(PUTTY, WINNER)
      	return TELL("The viscous material oozes into your hand.", CR)
    elseif FSETQ(PRSO, OPENBIT) then 
      	return TELL("The tube is apparently empty.", CR)
    elseif T then 
      	return TELL("The tube is closed.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TUBE_FUNCTION\n'..__res) end
end
DAM_FUNCTION = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE) then 
    	return TELL("Sounds reasonable, but this isn't how.", CR)
  elseif VERBQ(PLUG) then 
    
    if EQUALQ(PRSI, HANDS) then 
      	return TELL("Are you the little Dutch boy, then? Sorry, this is a big dam.", CR)
    elseif T then 
      	return TELL("With a ", D, PRSI, "? Do you know how big this dam is? You could only\nstop a tiny leak with that.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DAM_FUNCTION\n'..__res) end
end
WITH_TELL = function(OBJ)
	local __ok, __res = pcall(function()
	return   TELL("With a ", D, OBJ, "?", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WITH_TELL\n'..__res) end
end
RESERVOIR_SOUTH_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      TELL("You are in a long room, to the north of which was formerly a lake.\nHowever, with the water level lowered, there is merely a wide stream\nrunning through the center of the room.")
    elseif GATES_OPEN then 
      TELL("You are in a long room. To the north is a large lake, too deep\nto cross. You notice, however, that the water level appears to be\ndropping at a rapid rate. Before long, it might be possible to cross\nto the other side from here.")
    elseif LOW_TIDE then 
      TELL("You are in a long room, to the north of which is a wide area which\nwas formerly a reservoir, but now is merely a stream. You notice,\nhowever, that the level of the stream is rising quickly and that\nbefore long it will be impossible to cross here.")
    elseif T then 
      TELL("You are in a long room on the south shore of a large lake, far\ntoo deep and wide for crossing.")
    end

    CRLF()
    	return TELL("There is a path along the stream to the east or west, a steep pathway\nclimbing southwest along the edge of a chasm, and a path leading into a\ncanyon to the southeast.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RESERVOIR_SOUTH_FCN\n'..__res) end
end
RESERVOIR_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(RARG, M_END) and NOT(FSETQ(LOC(WINNER), VEHBIT)) and NOT(GATES_OPEN) and LOW_TIDE) then 
    	return TELL("You notice that the water level here is rising rapidly. The currents\nare also becoming stronger. Staying here seems quite perilous!", CR)
  elseif EQUALQ(RARG, M_LOOK) then 
    
    if LOW_TIDE then 
      TELL("You are on what used to be a large lake, but which is now a large\nmud pile. There are \"shores\" to the north and south.")
    elseif T then 
      TELL("You are on the lake. Beaches can be seen north and south.\nUpstream a small stream enters the lake through a narrow cleft\nin the rocks. The dam can be seen downstream.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RESERVOIR_FCN\n'..__res) end
end
RESERVOIR_NORTH_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    
    if PASS(LOW_TIDE and GATES_OPEN) then 
      TELL("You are in a large cavernous room, the south of which was formerly\na lake. However, with the water level lowered, there is merely\na wide stream running through there.")
    elseif GATES_OPEN then 
      TELL("You are in a large cavernous area. To the south is a wide lake,\nwhose water level appears to be falling rapidly.")
    elseif LOW_TIDE then 
      TELL("You are in a cavernous area, to the south of which is a very wide\nstream. The level of the stream is rising rapidly, and it appears\nthat before long it will be impossible to cross to the other side.")
    elseif T then 
      TELL("You are in a large cavernous room, north of a large lake.")
    end

    CRLF()
    	return TELL("There is a slimy stairway leaving the room to the north.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RESERVOIR_NORTH_FCN\n'..__res) end
end
BOTTLE_FUNCTION = function()
  local EQ = nil
	local __ok, __res = pcall(function()

  if PASS(VERBQ(THROW) and EQUALQ(PRSO, BOTTLE)) then 
    REMOVE_CAREFULLY(PRSO)
    APPLY(function() EQ = T return EQ end)
    TELL("The bottle hits the far wall and shatters.", CR)
  elseif VERBQ(MUNG) then 
    APPLY(function() EQ = T return EQ end)
    REMOVE_CAREFULLY(PRSO)
    TELL("A brilliant maneuver destroys the bottle.", CR)
  elseif VERBQ(SHAKE) then 
    
    if PASS(FSETQ(PRSO, OPENBIT) and INQ(WATER, PRSO)) then 
      APPLY(function() EQ = T return EQ end)
    end

  end


  if PASS(EQ and INQ(WATER, PRSO)) then 
    TELL("The water spills to the floor and evaporates.", CR)
    REMOVE_CAREFULLY(WATER)
    -- 	return T
  elseif EQ then 
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BOTTLE_FUNCTION\n'..__res) end
end
CYCLOWRATH = 0
CYCLOPS_FCN = function()
	local COUNT
	local __ok, __res = pcall(function()
APPLY(function() COUNT = CYCLOWRATH return COUNT end)

  if EQUALQ(WINNER, CYCLOPS) then 
    
    if CYCLOPS_FLAG then 
      	return TELL("No use talking to him. He's fast asleep.", CR)
    elseif VERBQ(ODYSSEUS) then 
      APPLY(function() WINNER = ADVENTURER return WINNER end)
      PERFORM(VQODYSSEUS)
      	error(true)
    else 
      	return TELL("The cyclops prefers eating to making conversation.", CR)
    end

  elseif CYCLOPS_FLAG then 
    
    if VERBQ(EXAMINE) then 
      	return TELL("The cyclops is sleeping like a baby, albeit a very ugly one.", CR)
    elseif VERBQ(ALARM, KICK, ATTACK, BURN, MUNG) then 
      TELL("The cyclops yawns and stares at the thing that woke him up.", CR)
      APPLY(function() CYCLOPS_FLAG = nil return CYCLOPS_FLAG end)
      FSET(CYCLOPS, FIGHTBIT)
      
      if LQ(COUNT, 0) then 
        	return APPLY(function() CYCLOWRATH = SUB(COUNT) return CYCLOWRATH end)
      elseif T then 
        	return APPLY(function() CYCLOWRATH = COUNT return CYCLOWRATH end)
      end

    end

  elseif VERBQ(EXAMINE) then 
    	return TELL("A hungry cyclops is standing at the foot of the stairs.", CR)
  elseif PASS(VERBQ(GIVE) and EQUALQ(PRSI, CYCLOPS)) then 
    
    if EQUALQ(PRSO, LUNCH) then 
      
      if NOT(LQ(COUNT, 0)) then 
        REMOVE_CAREFULLY(LUNCH)
        TELL("The cyclops says \"Mmm Mmm. I love hot peppers! But oh, could I use\na drink. Perhaps I could drink the blood of that thing.\"  From the\ngleam in his eye, it could be surmised that you are \"that thing\".", CR)
        APPLY(function() CYCLOWRATH = MIN(-1, SUB(COUNT)) return CYCLOWRATH end)
      end

      	return ENABLE(QUEUE(I_CYCLOPS, -1))
    elseif PASS(EQUALQ(PRSO, WATER) or PASS(EQUALQ(PRSO, BOTTLE) and INQ(WATER, BOTTLE))) then 
      
      if LQ(COUNT, 0) then 
        REMOVE_CAREFULLY(WATER)
        MOVE(BOTTLE, HERE)
        FSET(BOTTLE, OPENBIT)
        FCLEAR(CYCLOPS, FIGHTBIT)
        TELL("The cyclops takes the bottle, checks that it's open, and drinks the water.\nA moment later, he lets out a yawn that nearly blows you over, and then\nfalls fast asleep (what did you put in that drink, anyway?).", CR)
        	return APPLY(function() CYCLOPS_FLAG = T return CYCLOPS_FLAG end)
      elseif T then 
        	return TELL("The cyclops apparently is not thirsty and refuses your generous offer.", CR)
      end

    elseif EQUALQ(PRSO, GARLIC) then 
      	return TELL("The cyclops may be hungry, but there is a limit.", CR)
    elseif T then 
      	return TELL("The cyclops is not so stupid as to eat THAT!", CR)
    end

  elseif VERBQ(THROW, ATTACK, MUNG) then 
    ENABLE(QUEUE(I_CYCLOPS, -1))
    
    if VERBQ(MUNG) then 
      	return TELL("\"Do you think I'm as stupid as my father was?\", he says, dodging.", CR)
    elseif T then 
      TELL("The cyclops shrugs but otherwise ignores your pitiful attempt.", CR)
      
      if VERBQ(THROW) then 
        MOVE(PRSO, HERE)
      end

      	error(true)
    end

  elseif VERBQ(TAKE) then 
    	return TELL("The cyclops doesn't take kindly to being grabbed.", CR)
  elseif VERBQ(TIE) then 
    	return TELL("You cannot tie the cyclops, though he is fit to be tied.", CR)
  elseif VERBQ(LISTEN) then 
    	return TELL("You can hear his stomach rumbling.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CYCLOPS_FCN\n'..__res) end
end
I_CYCLOPS = function()
	local __ok, __res = pcall(function()

  if PASS(CYCLOPS_FLAG or DEAD) then 
    	error(true)
  elseif NOT(EQUALQ(HERE, CYCLOPS_ROOM)) then 
    	return DISABLE(INT(I_CYCLOPS))
  elseif T then 
    
    if GQ(ABS(CYCLOWRATH), 5) then 
      DISABLE(INT(I_CYCLOPS))
      	return JIGS_UP("The cyclops, tired of all of your games and trickery, grabs you firmly.\nAs he licks his chops, he says \"Mmm. Just like Mom used to make 'em.\"\nIt's nice to be appreciated.")
    elseif T then 
      
      if LQ(CYCLOWRATH, 0) then 
        APPLY(function() CYCLOWRATH = SUB(CYCLOWRATH, 1) return CYCLOWRATH end)
      elseif T then 
        APPLY(function() CYCLOWRATH = ADD(CYCLOWRATH, 1) return CYCLOWRATH end)
      end

      
      if NOT(CYCLOPS_FLAG) then 
        	return TELL(NTH(CYCLOMAD, SUB(ABS(CYCLOWRATH), 1)), CR)
      end

    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_CYCLOPS\n'..__res) end
end
CYCLOPS_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("This room has an exit on the northwest, and a staircase leading up.", CR)
    
    if PASS(CYCLOPS_FLAG and NOT(MAGIC_FLAG)) then 
      	return TELL("The cyclops is sleeping blissfully at the foot of the stairs.", CR)
    elseif MAGIC_FLAG then 
      	return TELL("The east wall, previously solid, now has a cyclops-sized opening in it.", CR)
    elseif ZEROQ(CYCLOWRATH) then 
      	return TELL("A cyclops, who looks prepared to eat horses (much less mere\nadventurers), blocks the staircase. From his state of health, and\nthe bloodstains on the walls, you gather that he is not very\nfriendly, though he likes people.", CR)
    elseif GQ(CYCLOWRATH, 0) then 
      	return TELL("The cyclops is standing in the corner, eyeing you closely. I don't\nthink he likes you very much. He looks extremely hungry, even for a\ncyclops.", CR)
    elseif LQ(CYCLOWRATH, 0) then 
      	return TELL("The cyclops, having eaten the hot peppers, appears to be gasping.\nHis enflamed tongue protrudes from his man-sized mouth.", CR)
    end

  elseif EQUALQ(RARG, M_ENTER) then 
    	return PASS(ZEROQ(CYCLOWRATH) or ENABLE(INT(I_CYCLOPS)))
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CYCLOPS_ROOM_FCN\n'..__res) end
end
CYCLOMAD = {"The cyclops seems somewhat agitated.","The cyclops appears to be getting more agitated.","The cyclops is moving about the room, looking for something.","The cyclops was looking for salt and pepper. No doubt they are\ncondiments for his upcoming snack.","The cyclops is moving toward you in an unfriendly manner.","You have two choices: 1. Leave  2. Become dinner."}

LOUD_FLAG = nil
LOUD_ROOM_FCN = function(RARG)
	local WRD
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("This is a large room with a ceiling which cannot be detected from\nthe ground. There is a narrow passage from east to west and a stone\nstairway leading upward.")
    
    if PASS(LOUD_FLAG or PASS(NOT(GATES_OPEN) and LOW_TIDE)) then 
      TELL(" The room is eerie in its quietness.")
    elseif T then 
      TELL(" The room is deafeningly loud with an\nundetermined rushing sound. The sound seems to reverberate from all\nof the walls, making it difficult even to think.")
    end

    	return CRLF()
  elseif PASS(EQUALQ(RARG, M_END) and GATES_OPEN and NOT(LOW_TIDE)) then 
    TELL("It is unbearably loud here, with an ear-splitting roar seeming to\ncome from all around you. There is a pounding in your head which won't\nstop. With a tremendous effort, you scramble out of the room.", CR, CR)
    GOTO(PICK_ONE(LOUD_RUNS))
    	error(false)
  elseif EQUALQ(RARG, M_ENTER) then 
    
    if PASS(LOUD_FLAG or PASS(NOT(GATES_OPEN) and LOW_TIDE)) then 
      	error(false)
    elseif PASS(GATES_OPEN and NOT(LOW_TIDE)) then 
      	error(false)
    elseif T then 
      V_FIRST_LOOK()
      
      if P_CONT then 
        TELL("The rest of your commands have been lost in the noise.", CR)
        APPLY(function() P_CONT = nil return P_CONT end)
      end

      
      APPLY(function() while true do
        
        if NOT(SUPER_BRIEF) then 
          CRLF()
        end

        TELL(">")
        READ(P_INBUF, P_LEXV)
        
        if ZEROQ(GETB(P_LEXV, P_LEXWORDS)) then 
          TELL("I beg your pardon?", CR)
          AGAIN()
        end

        APPLY(function() WRD = GET(P_LEXV, 1) return WRD end)
        
        if EQUALQ(WRD, WQGO, WQWALK, WQRUN) then 
          APPLY(function() WRD = GET(P_LEXV, 3) return WRD end)
        elseif EQUALQ(WRD, WQSAY) then 
          APPLY(function() WRD = GET(P_LEXV, 5) return WRD end)
        end

        
        if EQUALQ(WRD, WQSAVE) then 
          V_SAVE()
        elseif EQUALQ(WRD, WQRESTORE) then 
          V_RESTORE()
        elseif EQUALQ(WRD, WQQ, WQQUIT) then 
          V_QUIT()
        elseif EQUALQ(WRD, WQW, WQWEST) then 
          return GOTO(ROUND_ROOM)
        elseif EQUALQ(WRD, WQE, WQEAST) then 
          return GOTO(DAMP_CAVE)
        elseif EQUALQ(WRD, WQU, WQUP) then 
          return GOTO(DEEP_CANYON)
        elseif EQUALQ(WRD, WQBUG) then 
          TELL("That's only your opinion.", CR)
        elseif EQUALQ(WRD, WQECHO) then 
          APPLY(function() LOUD_FLAG = T return LOUD_FLAG end)
          FCLEAR(BAR, SACREDBIT)
          TELL("The acoustics of the room change subtly.", CR)
          
          if NOT(SUPER_BRIEF) then 
            CRLF()
          end

          return 
        elseif T then 
          V_ECHO()
        end


      end end)

    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LOUD_ROOM_FCN\n'..__res) end
end
DEEP_CANYON_F = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are on the south edge of a deep canyon. Passages lead off to the\neast, northwest and southwest. A stairway leads down.")
    
    if PASS(GATES_OPEN and NOT(LOW_TIDE)) then 
      TELL(" You can hear a loud roaring sound, like that of rushing water, from\nbelow.")
    elseif PASS(NOT(GATES_OPEN) and LOW_TIDE) then 
      CRLF()
      	error(true)
    elseif T then 
      TELL(" You can hear the sound of flowing water from below.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DEEP_CANYON_F\n'..__res) end
end
EGG_SOLVE = nil
THIEF_HERE = nil
THIEF_VS_ADVENTURER = function(HEREQ)
	local ROBBEDQ
  local WINNER_ROBBEDQ = nil
	local __ok, __res = pcall(function()

  if PASS(NOT(DEAD) and EQUALQ(HERE, TREASURE_ROOM)) then 
  elseif NOT(THIEF_HERE) then 
    
    if PASS(NOT(DEAD) and NOT(HEREQ) and PROB(30)) then 
      
      if INQ(STILETTO, THIEF) then 
        FCLEAR(THIEF, INVISIBLE)
        TELL("Someone carrying a large bag is casually leaning against one of the\nwalls here. He does not speak, but it is clear from his aspect that\nthe bag will be taken only over his dead body.", CR)
        APPLY(function() THIEF_HERE = T return THIEF_HERE end)
        	error(true)
      end

    elseif PASS(HEREQ and FSETQ(THIEF, FIGHTBIT) and NOT(WINNINGQ(THIEF))) then 
      TELL("Your opponent, determining discretion to be the better part of\nvalor, decides to terminate this little contretemps. With a rueful\nnod of his head, he steps backward into the gloom and disappears.", CR)
      FSET(THIEF, INVISIBLE)
      FCLEAR(THIEF, FIGHTBIT)
      RECOVER_STILETTO()
      	error(true)
    elseif PASS(HEREQ and FSETQ(THIEF, FIGHTBIT) and PROB(90)) then 
      	error(false)
    elseif PASS(HEREQ and PROB(30)) then 
      TELL("The holder of the large bag just left, looking disgusted.\nFortunately, he took nothing.", CR)
      FSET(THIEF, INVISIBLE)
      RECOVER_STILETTO()
      	error(true)
    elseif PROB(70) then 
      	error(false)
    elseif NOT(DEAD) then 
      
      if ROB(HERE, THIEF, 100) then 
        APPLY(function() ROBBEDQ = HERE return ROBBEDQ end)
      elseif ROB(WINNER, THIEF) then 
        APPLY(function() ROBBEDQ = PLAYER return ROBBEDQ end)
      end

      APPLY(function() THIEF_HERE = T return THIEF_HERE end)
      
      if PASS(ROBBEDQ and NOT(HEREQ)) then 
        TELL("A seedy-looking individual with a large bag just wandered through\nthe room. On the way through, he quietly abstracted some valuables from ")
        
        if EQUALQ(ROBBEDQ, HERE) then 
          TELL("the room")
        else 
          TELL("your possession")
        end

        TELL(", mumbling something about\n\"Doing unto others before...\"", CR)
        STOLE_LIGHTQ()
      elseif HEREQ then 
        RECOVER_STILETTO()
        
        if ROBBEDQ then 
          TELL("The thief just left, still carrying his large bag. You may\nnot have noticed that he ")
          
          if EQUALQ(ROBBEDQ, PLAYER) then 
            TELL("robbed you blind first.")
          elseif T then 
            TELL("appropriated the valuables in the room.")
          end

          CRLF()
          STOLE_LIGHTQ()
        elseif T then 
          TELL("The thief, finding nothing of value, left disgusted.", CR)
        end

        FSET(THIEF, INVISIBLE)
        APPLY(function() HEREQ = nil return HEREQ end)
        	error(true)
      elseif T then 
        TELL("A \"lean and hungry\" gentleman just wandered through, carrying a\nlarge bag. Finding nothing of value, he left disgruntled.", CR)
        	error(true)
      end

    end

  elseif T then 
    
    if HEREQ then 
      
      if PROB(30) then 
        
        if ROB(HERE, THIEF, 100) then 
          APPLY(function() ROBBEDQ = HERE return ROBBEDQ end)
        elseif ROB(WINNER, THIEF) then 
          APPLY(function() ROBBEDQ = PLAYER return ROBBEDQ end)
        end

        
        if ROBBEDQ then 
          TELL("The thief just left, still carrying his large bag. You may\nnot have noticed that he ")
          
          if EQUALQ(ROBBEDQ, PLAYER) then 
            TELL("robbed you blind first.")
          elseif T then 
            TELL("appropriated the valuables in the room.")
          end

          CRLF()
          STOLE_LIGHTQ()
        elseif T then 
          TELL("The thief, finding nothing of value, left disgusted.", CR)
        end

        FSET(THIEF, INVISIBLE)
        APPLY(function() HEREQ = nil return HEREQ end)
        RECOVER_STILETTO()
      end

    end

  end

	error(false)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('THIEF_VS_ADVENTURER\n'..__res) end
end
STOLE_LIGHTQ = function()
	local OLD_LIT
	local __ok, __res = pcall(function()
APPLY(function() OLD_LIT = LIT return OLD_LIT end)
APPLY(function() LIT = LITQ(HERE) return LIT end)

  if PASS(NOT(LIT) and OLD_LIT) then 
    TELL("The thief seems to have left you in the dark.", CR)
  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STOLE_LIGHTQ\n'..__res) end
end
HACK_TREASURES = function()
	local X
	local __ok, __res = pcall(function()
  RECOVER_STILETTO()
  FSET(THIEF, INVISIBLE)
APPLY(function() X = FIRSTQ(TREASURE_ROOM) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      return 
    elseif T then 
      FCLEAR(X, INVISIBLE)
    end

    APPLY(function() X = NEXTQ(X) return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HACK_TREASURES\n'..__res) end
end
DEPOSIT_BOOTY = function(RM)
	local X
	local N
  local FLG = nil
	local __ok, __res = pcall(function()
APPLY(function() X = FIRSTQ(THIEF) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      return FLG
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if EQUALQ(X, STILETTO, LARGE_BAG) then 
    elseif GQ(GETP(X, PQTVALUE), 0) then 
      MOVE(X, RM)
      APPLY(function() FLG = T return FLG end)
      
      if EQUALQ(X, EGG) then 
        APPLY(function() EGG_SOLVE = T return EGG_SOLVE end)
        FSET(EGG, OPENBIT)
      end

    end

    APPLY(function() X = N return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DEPOSIT_BOOTY\n'..__res) end
end
ROB_MAZE = function(RM)
	local X
	local N
	local __ok, __res = pcall(function()
APPLY(function() X = FIRSTQ(RM) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      	error(false)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(FSETQ(X, TAKEBIT) and NOT(FSETQ(X, INVISIBLE)) and PROB(40)) then 
      TELL("You hear, off in the distance, someone saying \"My, I wonder what\nthis fine ", D, X, " is doing here.\"", CR)
      
      if PROB(60, 80) then 
        MOVE(X, THIEF)
        FSET(X, TOUCHBIT)
        FSET(X, INVISIBLE)
      end

      return 
    end

    APPLY(function() X = N return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ROB_MAZE\n'..__res) end
end
THIEF_ENGROSSED = nil
ROBBER_FUNCTION = function(MODE)
  local FLG = nil
	local X
  MODE = MODE or nil
	local __ok, __res = pcall(function()

  if VERBQ(TELL) then 
    TELL("The thief is a strong, silent type.", CR)
    	return APPLY(function() P_CONT = nil return P_CONT end)
  elseif NOT(MODE) then 
    
    if PASS(VERBQ(HELLO) and EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC)) then 
      	return TELL("The thief, being temporarily incapacitated, is unable to acknowledge\nyour greeting with his usual graciousness.", CR)
    elseif PASS(EQUALQ(PRSO, KNIFE) and VERBQ(THROW) and NOT(FSETQ(THIEF, FIGHTBIT))) then 
      MOVE(PRSO, HERE)
      
      if PROB(10, 0) then 
        TELL("You evidently frightened the robber, though you didn't hit him. He\nflees")
        REMOVE(LARGE_BAG)
        APPLY(function() X = nil return X end)
        
        if INQ(STILETTO, THIEF) then 
          REMOVE(STILETTO)
          APPLY(function() X = T return X end)
        end

        
        if FIRSTQ(THIEF) then 
          MOVE_ALL(THIEF, HERE)
          TELL(", but the contents of his bag fall on the floor.")
        elseif T then 
          TELL(".")
        end

        MOVE(LARGE_BAG, THIEF)
        
        if X then 
          MOVE(STILETTO, THIEF)
        end

        CRLF()
        	return FSET(THIEF, INVISIBLE)
      elseif T then 
        TELL("You missed. The thief makes no attempt to take the knife, though it\nwould be a fine addition to the collection in his bag. He does seem\nangered by your attempt.", CR)
        	return FSET(THIEF, FIGHTBIT)
      end

    elseif PASS(VERBQ(THROW, GIVE) and PRSO and NOT(EQUALQ(PRSO, THIEF)) and EQUALQ(PRSI, THIEF)) then 
      
      if LQ(GETP(THIEF, PQSTRENGTH), 0) then 
        PUTP(THIEF, PQSTRENGTH, SUB(GETP(THIEF, PQSTRENGTH)))
        ENABLE(INT(I_THIEF))
        RECOVER_STILETTO()
        PUTP(THIEF, PQLDESC, ROBBER_C_DESC)
        TELL("Your proposed victim suddenly recovers consciousness.", CR)
      end

      MOVE(PRSO, THIEF)
      
      if GQ(GETP(PRSO, PQTVALUE), 0) then 
        APPLY(function() THIEF_ENGROSSED = T return THIEF_ENGROSSED end)
        	return TELL("The thief is taken aback by your unexpected generosity, but accepts\nthe ", D, PRSO, " and stops to admire its beauty.", CR)
      elseif T then 
        	return TELL("The thief places the ", D, PRSO, " in his bag and thanks\nyou politely.", CR)
      end

    elseif VERBQ(TAKE) then 
      	return TELL("Once you got him, what would you do with him?", CR)
    elseif VERBQ(EXAMINE, LOOK_INSIDE) then 
      	return TELL("The thief is a slippery character with beady eyes that flit back\nand forth. He carries, along with an unmistakable arrogance, a large bag\nover his shoulder and a vicious stiletto, whose blade is aimed\nmenacingly in your direction. I'd watch out if I were you.", CR)
    elseif VERBQ(LISTEN) then 
      	return TELL("The thief says nothing, as you have not been formally introduced.", CR)
    end

  elseif EQUALQ(MODE, F_BUSYQ) then 
    
    if INQ(STILETTO, THIEF) then 
      	return nil
    elseif INQ(STILETTO, LOC(THIEF)) then 
      MOVE(STILETTO, THIEF)
      FSET(STILETTO, NDESCBIT)
      
      if INQ(THIEF, HERE) then 
        TELL("The robber, somewhat surprised at this turn of events, nimbly\nretrieves his stiletto.", CR)
      end

      -- 	return T
    end

  elseif EQUALQ(MODE, F_DEAD) then 
    MOVE(STILETTO, HERE)
    FCLEAR(STILETTO, NDESCBIT)
    APPLY(function() X = DEPOSIT_BOOTY(HERE) return X end)
    
    if EQUALQ(HERE, TREASURE_ROOM) then 
      APPLY(function() X = FIRSTQ(HERE) return X end)
      
      APPLY(function() while true do
        
        if NOT(X) then 
          TELL("The chalice is now safe to take.", CR)
          return 
        elseif NOT(EQUALQ(X, CHALICE, THIEF, ADVENTURER)) then 
          FCLEAR(X, INVISIBLE)
          
          if NOT(FLG) then 
            APPLY(function() FLG = T return FLG end)
            TELL("As the thief dies, the power of his magic decreases, and his\ntreasures reappear:", CR)
          end

          TELL("  A ", D, X)
          
          if PASS(FIRSTQ(X) and SEE_INSIDEQ(X)) then 
            TELL(", with ")
            PRINT_CONTENTS(X)
          end

          CRLF()
        end

        APPLY(function() X = NEXTQ(X) return X end)

      end end)

    elseif X then 
      TELL("His booty remains.", CR)
    end

    	return DISABLE(INT(I_THIEF))
  elseif EQUALQ(MODE, F_FIRSTQ) then 
    
    if PASS(THIEF_HERE and NOT(FSETQ(THIEF, INVISIBLE)) and PROB(20)) then 
      FSET(THIEF, FIGHTBIT)
      APPLY(function() P_CONT = nil return P_CONT end)
      -- 	return T
    end

  elseif EQUALQ(MODE, F_UNCONSCIOUS) then 
    DISABLE(INT(I_THIEF))
    FCLEAR(THIEF, FIGHTBIT)
    MOVE(STILETTO, HERE)
    FCLEAR(STILETTO, NDESCBIT)
    	return PUTP(THIEF, PQLDESC, ROBBER_U_DESC)
  elseif EQUALQ(MODE, F_CONSCIOUS) then 
    
    if EQUALQ(LOC(THIEF), HERE) then 
      FSET(THIEF, FIGHTBIT)
      TELL("The robber revives, briefly feigning continued unconsciousness, and,\nwhen he sees his moment, scrambles away from you.", CR)
    end

    ENABLE(INT(I_THIEF))
    PUTP(THIEF, PQLDESC, ROBBER_C_DESC)
    	return RECOVER_STILETTO()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ROBBER_FUNCTION\n'..__res) end
end
ROBBER_C_DESC = "There is a suspicious-looking individual, holding a bag, leaning\nagainst one wall. He is armed with a vicious-looking stiletto."
ROBBER_U_DESC = "There is a suspicious-looking individual lying unconscious on the\nground."
LARGE_BAG_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    
    if EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC) then 
      	return TELL("Sadly for you, the robber collapsed on top of the bag. Trying to take\nit would wake him.", CR)
    elseif T then 
      	return TELL("The bag will be taken over his dead body.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, LARGE_BAG)) then 
    	return TELL("It would be a good trick.", CR)
  elseif VERBQ(OPEN, CLOSE) then 
    	return TELL("Getting close enough would be a good trick.", CR)
  elseif VERBQ(EXAMINE, LOOK_INSIDE) then 
    	return TELL("The bag is underneath the thief, so one can't say what, if anything, is\ninside.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LARGE_BAG_F\n'..__res) end
end
MOVE_ALL = function(FROM, TO)
	local X
	local N
	local __ok, __res = pcall(function()

  if APPLY(function() X = FIRSTQ(FROM) return X end) then 
    
    APPLY(function() while true do
      
      if NOT(X) then 
        return 
      end

      APPLY(function() N = NEXTQ(X) return N end)
      FCLEAR(X, INVISIBLE)
      MOVE(X, TO)
      APPLY(function() X = N return X end)

    end end)

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MOVE_ALL\n'..__res) end
end
CHALICE_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    
    if PASS(INQ(PRSO, TREASURE_ROOM) and INQ(THIEF, TREASURE_ROOM) and FSETQ(THIEF, FIGHTBIT) and NOT(FSETQ(THIEF, INVISIBLE)) and NOT(EQUALQ(GETP(THIEF, PQLDESC), ROBBER_U_DESC))) then 
      	return TELL("You'd be stabbed in the back first.", CR)
    end

  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, CHALICE)) then 
    	return TELL("You can't. It's not a very good chalice, is it?", CR)
  elseif T then 
    	return DUMB_CONTAINER()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CHALICE_FCN\n'..__res) end
end
TREASURE_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(RARG, M_ENTER) and ONEQ(GET(INT(I_THIEF), C_ENABLEDQ)) and NOT(DEAD)) then 
    
    if NOT(INQ(THIEF, HERE)) then 
      TELL("You hear a scream of anguish as you violate the robber's hideaway.\nUsing passages unknown to you, he rushes to its defense.", CR)
      MOVE(THIEF, HERE)
    end

    FSET(THIEF, FIGHTBIT)
    FCLEAR(THIEF, INVISIBLE)
    	return THIEF_IN_TREASURE()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TREASURE_ROOM_FCN\n'..__res) end
end
THIEF_IN_TREASURE = function()
	local F
	local __ok, __res = pcall(function()
APPLY(function() F = FIRSTQ(HERE) return F end)

  if PASS(F and NEXTQ(F)) then 
    TELL("The thief gestures mysteriously, and the treasures in the room\nsuddenly vanish.", CR, CR)
  end


  APPLY(function() while true do
    
    if NOT(F) then 
      return 
    elseif NOT(EQUALQ(F, CHALICE, THIEF)) then 
      FSET(F, INVISIBLE)
    end

    APPLY(function() F = NEXTQ(F) return F end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('THIEF_IN_TREASURE\n'..__res) end
end
FRONT_DOOR_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN) then 
    	return TELL("The door cannot be opened.", CR)
  elseif VERBQ(BURN) then 
    	return TELL("You cannot burn this door.", CR)
  elseif VERBQ(MUNG) then 
    	return TELL("You can't seem to damage the door.", CR)
  elseif VERBQ(LOOK_BEHIND) then 
    	return TELL("It won't open.", CR)
  elseif VERBQ(READ) then 
    
    if EQUALQ(HERE, LIVING_ROOM) then 
      TELL("The engravings translate to \"This space intentionally left blank.\"")
    elseif TELL("There is no writing on this side.") then 
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FRONT_DOOR_FCN\n'..__res) end
end
BODY_FUNCTION = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE) then 
    	return TELL("A force keeps you from taking the bodies.", CR)
  elseif VERBQ(MUNG, BURN) then 
    	return JIGS_UP("The voice of the guardian of the dungeon booms out from the darkness,\n\"Your disrespect costs you your life!\" and places your head on a sharp\npole.")
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BODY_FUNCTION\n'..__res) end
end
BLACK_BOOK = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN) then 
    	return TELL("The book is already open to page 569.", CR)
  elseif VERBQ(CLOSE) then 
    	return TELL("As hard as you try, the book cannot be closed.", CR)
  elseif PASS(VERBQ(TURN) or PASS(VERBQ(READ_PAGE) and EQUALQ(PRSI, INTNUM) and NOT(EQUALQ(P_NUMBER, 569)))) then 
    	return TELL("Beside page 569, there is only one other page with any legible printing on\nit. Most of it is unreadable, but the subject seems to be the banishment of\nevil. Apparently, certain noises, lights, and prayers are efficacious in this\nregard.", CR)
  elseif VERBQ(BURN) then 
    REMOVE_CAREFULLY(PRSO)
    	return JIGS_UP("A booming voice says \"Wrong, cretin!\" and you notice that you have\nturned into a pile of dust. How, I can't imagine.")
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BLACK_BOOK\n'..__res) end
end
PAINTING_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(MUNG) then 
    PUTP(PRSO, PQTVALUE, 0)
    PUTP(PRSO, PQLDESC, "There is a worthless piece of canvas here.")
    	return TELL("Congratulations! Unlike the other vandals, who merely stole the\nartist's masterpieces, you have destroyed one.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PAINTING_FCN\n'..__res) end
end
LAMP_TABLE = {100,"The lamp appears a bit dimmer.",70,"The lamp is definitely dimmer now.",15,"The lamp is nearly out.",0}

LANTERN = function()
	local __ok, __res = pcall(function()

  if VERBQ(THROW) then 
    TELL("The lamp has smashed into the floor, and the light has gone out.", CR)
    DISABLE(INT(I_LANTERN))
    REMOVE_CAREFULLY(LAMP)
    	return MOVE(BROKEN_LAMP, HERE)
  elseif VERBQ(LAMP_ON) then 
    
    if FSETQ(LAMP, RMUNGBIT) then 
      	return TELL("A burned-out lamp won't light.", CR)
    elseif T then 
      ENABLE(INT(I_LANTERN))
      	return nil
    end

  elseif VERBQ(LAMP_OFF) then 
    
    if FSETQ(LAMP, RMUNGBIT) then 
      	return TELL("The lamp has already burned out.", CR)
    elseif T then 
      DISABLE(INT(I_LANTERN))
      	return nil
    end

  elseif VERBQ(EXAMINE) then 
    TELL("The lamp ")
    
    if FSETQ(LAMP, RMUNGBIT) then 
      TELL("has burned out.")
    elseif FSETQ(LAMP, ONBIT) then 
      TELL("is on.")
    elseif T then 
      TELL("is turned off.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LANTERN\n'..__res) end
end
MAILBOX_F = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, MAILBOX)) then 
    	return TELL("It is securely anchored.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MAILBOX_F\n'..__res) end
end
MATCH_COUNT = 6
MATCH_FUNCTION = function()
	local CNT
	local __ok, __res = pcall(function()

  if PASS(VERBQ(LAMP_ON, BURN) and EQUALQ(PRSO, MATCH)) then 
    
    if GQ(MATCH_COUNT, 0) then 
      APPLY(function() MATCH_COUNT = SUB(MATCH_COUNT, 1) return MATCH_COUNT end)
    end

    
    if NOT(GQ(MATCH_COUNT, 0)) then 
      	return TELL("I'm afraid that you have run out of matches.", CR)
    elseif EQUALQ(HERE, LOWER_SHAFT, TIMBER_ROOM) then 
      	return TELL("This room is drafty, and the match goes out instantly.", CR)
    elseif T then 
      FSET(MATCH, FLAMEBIT)
      FSET(MATCH, ONBIT)
      ENABLE(QUEUE(I_MATCH, 2))
      TELL("One of the matches starts to burn.", CR)
      
      if NOT(LIT) then 
        APPLY(function() LIT = T return LIT end)
        V_LOOK()
      end

      	error(true)
    end

  elseif PASS(VERBQ(LAMP_OFF) and FSETQ(MATCH, FLAMEBIT)) then 
    TELL("The match is out.", CR)
    FCLEAR(MATCH, FLAMEBIT)
    FCLEAR(MATCH, ONBIT)
    APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if NOT(LIT) then 
      TELL("It's pitch black in here!", CR)
    end

    QUEUE(I_MATCH, 0)
    	error(true)
  elseif VERBQ(COUNT, OPEN) then 
    TELL("You have ")
    APPLY(function() CNT = SUB(MATCH_COUNT, 1) return CNT end)
    
    if NOT(GQ(CNT, 0)) then 
      TELL("no")
    elseif T then 
      TELL(N, CNT)
    end

    TELL(" match")
    
    if NOT(ONEQ(CNT)) then 
      TELL("es.")
    elseif T then 
      TELL(".")
    end

    	return CRLF()
  elseif VERBQ(EXAMINE) then 
    
    if FSETQ(MATCH, ONBIT) then 
      TELL("The match is burning.")
    elseif T then 
      TELL("The matchbook isn't very interesting, except for what's written on it.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MATCH_FUNCTION\n'..__res) end
end
I_MATCH = function()
	local __ok, __res = pcall(function()
  TELL("The match has gone out.", CR)
  FCLEAR(MATCH, FLAMEBIT)
  FCLEAR(MATCH, ONBIT)
APPLY(function() LIT = LITQ(HERE) return LIT end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_MATCH\n'..__res) end
end
I_LANTERN = function()
	local TICK
  local TBL = VALUE(LAMP_TABLE)
	local __ok, __res = pcall(function()
  ENABLE(QUEUE(I_LANTERN, APPLY(function() TICK = GET(TBL, 0) return TICK end)))
  LIGHT_INT(LAMP, TBL, TICK)

  if NOT(ZEROQ(TICK)) then 
    	return APPLY(function() LAMP_TABLE = REST(TBL, 4) return LAMP_TABLE end)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_LANTERN\n'..__res) end
end
I_CANDLES = function()
	local TICK
  local TBL = VALUE(CANDLE_TABLE)
	local __ok, __res = pcall(function()
  FSET(CANDLES, TOUCHBIT)
  ENABLE(QUEUE(I_CANDLES, APPLY(function() TICK = GET(TBL, 0) return TICK end)))
  LIGHT_INT(CANDLES, TBL, TICK)

  if NOT(ZEROQ(TICK)) then 
    	return APPLY(function() CANDLE_TABLE = REST(TBL, 4) return CANDLE_TABLE end)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_CANDLES\n'..__res) end
end
LIGHT_INT = function(OBJ, TBL, TICK)
	local __ok, __res = pcall(function()

  if ZEROQ(TICK) then 
    FCLEAR(OBJ, ONBIT)
    FSET(OBJ, RMUNGBIT)
  end


  if PASS(HELDQ(OBJ) or INQ(OBJ, HERE)) then 
    
    if ZEROQ(TICK) then 
      	return TELL("You'd better have more light than from the ", D, OBJ, ".", CR)
    elseif T then 
      	return TELL(GET(TBL, 1), CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LIGHT_INT\n'..__res) end
end
MIN = function(N1, N2)
	local __ok, __res = pcall(function()

  if LQ(N1, N2) then 
    -- 	return N1
  elseif T then 
    -- 	return N2
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MIN\n'..__res) end
end
CANDLES_FCN = function()
	local __ok, __res = pcall(function()

  if NOT(FSETQ(CANDLES, TOUCHBIT)) then 
    ENABLE(INT(I_CANDLES))
  end


  if EQUALQ(CANDLES, PRSI) then 
    	error(false)
  elseif T then 
    
    if VERBQ(LAMP_ON, BURN) then 
      
      if FSETQ(CANDLES, RMUNGBIT) then 
        	return TELL("Alas, there's not much left of the candles. Certainly not enough to\nburn.", CR)
      elseif NOT(PRSI) then 
        
        if FSETQ(MATCH, FLAMEBIT) then 
          TELL("(with the match)", CR)
          PERFORM(VQLAMP_ON, CANDLES, MATCH)
          	error(true)
        elseif T then 
          TELL("You should say what to light them with.", CR)
          	return RFATAL()
        end

      elseif PASS(EQUALQ(PRSI, MATCH) and FSETQ(MATCH, ONBIT)) then 
        TELL("The candles are ")
        
        if FSETQ(CANDLES, ONBIT) then 
          	return TELL("already lit.", CR)
        elseif T then 
          FSET(CANDLES, ONBIT)
          TELL("lit.", CR)
          	return ENABLE(INT(I_CANDLES))
        end

      elseif EQUALQ(PRSI, TORCH) then 
        
        if FSETQ(CANDLES, ONBIT) then 
          	return TELL("You realize, just in time, that the candles are already lighted.", CR)
        elseif T then 
          TELL("The heat from the torch is so intense that the candles are vaporized.", CR)
          	return REMOVE_CAREFULLY(CANDLES)
        end

      elseif T then 
        	return TELL("You have to light them with something that's burning, you know.", CR)
      end

    elseif VERBQ(COUNT) then 
      	return TELL("Let's see, how many objects in a pair? Don't tell me, I'll get it.", CR)
    elseif VERBQ(LAMP_OFF) then 
      DISABLE(INT(I_CANDLES))
      
      if FSETQ(CANDLES, ONBIT) then 
        TELL("The flame is extinguished.")
        FCLEAR(CANDLES, ONBIT)
        FSET(CANDLES, TOUCHBIT)
        APPLY(function() LIT = LITQ(HERE) return LIT end)
        
        if NOT(LIT) then 
          TELL(" It's really dark in here....")
        end

        CRLF()
        	error(true)
      elseif T then 
        	return TELL("The candles are not lighted.", CR)
      end

    elseif PASS(VERBQ(PUT) and FSETQ(PRSI, BURNBIT)) then 
      	return TELL("That wouldn't be smart.", CR)
    elseif VERBQ(EXAMINE) then 
      TELL("The candles are ")
      
      if FSETQ(CANDLES, ONBIT) then 
        TELL("burning.")
      elseif T then 
        TELL("out.")
      end

      	return CRLF()
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CANDLES_FCN\n'..__res) end
end
CANDLE_TABLE = {20,"The candles grow shorter.",10,"The candles are becoming quite short.",5,"The candles won't last long now.",0}

CAVE2_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_END) then 
    
    if PASS(INQ(CANDLES, WINNER) and PROB(50, 80) and FSETQ(CANDLES, ONBIT)) then 
      DISABLE(INT(I_CANDLES))
      FCLEAR(CANDLES, ONBIT)
      TELL("A gust of wind blows out your candles!", CR)
      
      if NOT(APPLY(function() LIT = LITQ(HERE) return LIT end)) then 
        	return TELL("It is now completely dark.", CR)
      end

    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CAVE2_ROOM\n'..__res) end
end
SWORD_FCN = function()
	local G
	local __ok, __res = pcall(function()

  if PASS(VERBQ(TAKE) and EQUALQ(WINNER, ADVENTURER)) then 
    ENABLE(QUEUE(I_SWORD, -1))
    	return nil
  elseif VERBQ(EXAMINE) then 
    
    if EQUALQ(APPLY(function() G = GETP(SWORD, PQTVALUE) return G end), 1) then 
      	return TELL("Your sword is glowing with a faint blue glow.", CR)
    elseif EQUALQ(G, 2) then 
      	return TELL("Your sword is glowing very brightly.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SWORD_FCN\n'..__res) end
end
BOOM_ROOM = function(RARG)
  local DUMMYQ = nil
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_END) then 
    
    if PASS(EQUALQ(RARG, M_END) and VERBQ(LAMP_ON, BURN) and EQUALQ(PRSO, CANDLES, TORCH, MATCH)) then 
      APPLY(function() DUMMYQ = T return DUMMYQ end)
    end

    
    if PASS(PASS(HELDQ(CANDLES) and FSETQ(CANDLES, ONBIT)) or PASS(HELDQ(TORCH) and FSETQ(TORCH, ONBIT)) or PASS(HELDQ(MATCH) and FSETQ(MATCH, ONBIT))) then 
      
      if DUMMYQ then 
        TELL("How sad for an aspiring adventurer to light a ", D, PRSO, " in a room which\nreeks of gas. Fortunately, there is justice in the world.", CR)
      elseif T then 
        TELL("Oh dear. It appears that the smell coming from this room was coal gas.\nI would have thought twice about carrying flaming objects in here.", CR)
      end

      	return JIGS_UP("|\n      ** BOOOOOOOOOOOM **")
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BOOM_ROOM\n'..__res) end
end
BAT_D = function()
	local __ok, __res = pcall(function()

  if EQUALQ(LOC(GARLIC), WINNER, HERE) then 
    	return TELL("In the corner of the room on the ceiling is a large vampire bat who\nis obviously deranged and holding his nose.", CR)
  elseif T then 
    	return TELL("A large vampire bat, hanging from the ceiling, swoops down at you!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BAT_D\n'..__res) end
end
BATS_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    	return TELL("You are in a small room which has doors only to the east and south.", CR)
  elseif PASS(EQUALQ(RARG, M_ENTER) and NOT(DEAD)) then 
    
    if NOT(EQUALQ(LOC(GARLIC), WINNER, HERE)) then 
      V_LOOK()
      CRLF()
      	return FLY_ME()
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BATS_ROOM\n'..__res) end
end
MACHINE_ROOM_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("This is a large, cold room whose sole exit is to the north. In one\ncorner there is a machine which is reminiscent of a clothes\ndryer. On its face is a switch which is labelled \"START\".\nThe switch does not appear to be manipulable by any human hand (unless the\nfingers are about 1/16 by 1/4 inch). On the front of the machine is a large\nlid, which is ")
    
    if FSETQ(MACHINE, OPENBIT) then 
      TELL("open.")
    elseif T then 
      TELL("closed.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MACHINE_ROOM_FCN\n'..__res) end
end
MACHINE_F = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(TAKE) and EQUALQ(PRSO, MACHINE)) then 
    	return TELL("It is far too large to carry.", CR)
  elseif VERBQ(OPEN) then 
    
    if FSETQ(MACHINE, OPENBIT) then 
      	return TELL(PICK_ONE(DUMMY), CR)
    elseif FIRSTQ(MACHINE) then 
      TELL("The lid opens, revealing ")
      PRINT_CONTENTS(MACHINE)
      TELL(".", CR)
      	return FSET(MACHINE, OPENBIT)
    elseif T then 
      TELL("The lid opens.", CR)
      	return FSET(MACHINE, OPENBIT)
    end

  elseif VERBQ(CLOSE) then 
    
    if FSETQ(MACHINE, OPENBIT) then 
      TELL("The lid closes.", CR)
      FCLEAR(MACHINE, OPENBIT)
      -- 	return T
    elseif T then 
      	return TELL(PICK_ONE(DUMMY), CR)
    end

  elseif VERBQ(LAMP_ON) then 
    
    if NOT(PRSI) then 
      	return TELL("It's not clear how to turn it on with your bare hands.", CR)
    elseif T then 
      PERFORM(VQTURN, MACHINE_SWITCH, PRSI)
      	error(true)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MACHINE_F\n'..__res) end
end
MSWITCH_FUNCTION = function()
	local O
	local __ok, __res = pcall(function()

  if VERBQ(TURN) then 
    
    if EQUALQ(PRSI, SCREWDRIVER) then 
      
      if FSETQ(MACHINE, OPENBIT) then 
        	return TELL("The machine doesn't seem to want to do anything.", CR)
      elseif T then 
        TELL("The machine comes to life (figuratively) with a dazzling display of\ncolored lights and bizarre noises. After a few moments, the\nexcitement abates.", CR)
        
        if INQ(COAL, MACHINE) then 
          REMOVE_CAREFULLY(COAL)
          	return MOVE(DIAMOND, MACHINE)
        elseif T then 
          
          APPLY(function() while true do
            
            if APPLY(function() O = FIRSTQ(MACHINE) return O end) then 
              REMOVE_CAREFULLY(O)
            elseif T then 
              return 
            end


          end end)

          	return MOVE(GUNK, MACHINE)
        end

      end

    elseif NOT(EQUALQ(PRSI, nil, HANDS, ROOMS)) then 
      	return TELL("It seems that a ", D, PRSI, " won't do.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MSWITCH_FUNCTION\n'..__res) end
end
GUNK_FUNCTION = function()
	local __ok, __res = pcall(function()
  REMOVE_CAREFULLY(GUNK)
	return   TELL("The slag was rather insubstantial, and crumbles into dust at your touch.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GUNK_FUNCTION\n'..__res) end
end
NO_OBJS = function(RARG)
	local F
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_BEG) then 
    APPLY(function() F = FIRSTQ(WINNER) return F end)
    APPLY(function() EMPTY_HANDED = T return EMPTY_HANDED end)
    
    APPLY(function() while true do
      
      if NOT(F) then 
        return 
      elseif GQ(WEIGHT(F), 4) then 
        APPLY(function() EMPTY_HANDED = nil return EMPTY_HANDED end)
        return 
      end

      APPLY(function() F = NEXTQ(F) return F end)

    end end)

    
    if PASS(EQUALQ(HERE, LOWER_SHAFT) and LIT) then 
      SCORE_UPD(LIGHT_SHAFT)
      APPLY(function() LIGHT_SHAFT = 0 return LIGHT_SHAFT end)
    end

    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('NO_OBJS\n'..__res) end
end
SOUTH_TEMPLE_FCN = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_BEG) then 
    APPLY(function() COFFIN_CURE = NOT(INQ(COFFIN, WINNER)) return COFFIN_CURE end)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SOUTH_TEMPLE_FCN\n'..__res) end
end
LIGHT_SHAFT = 13
WHITE_CLIFFS_FUNCTION = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_END) then 
    
    if INQ(INFLATED_BOAT, WINNER) then 
      	return APPLY(function() DEFLATE = nil return DEFLATE end)
    elseif T then 
      	return APPLY(function() DEFLATE = T return DEFLATE end)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WHITE_CLIFFS_FUNCTION\n'..__res) end
end
SCEPTRE_FUNCTION = function()
	local __ok, __res = pcall(function()

  if VERBQ(WAVE, RAISE) then 
    
    if PASS(EQUALQ(HERE, ARAGAIN_FALLS) or EQUALQ(HERE, END_OF_RAINBOW)) then 
      
      if NOT(RAINBOW_FLAG) then 
        FCLEAR(POT_OF_GOLD, INVISIBLE)
        TELL("Suddenly, the rainbow appears to become solid and, I venture,\nwalkable (I think the giveaway was the stairs and bannister).", CR)
        
        if PASS(EQUALQ(HERE, END_OF_RAINBOW) and INQ(POT_OF_GOLD, END_OF_RAINBOW)) then 
          TELL("A shimmering pot of gold appears at the end of the rainbow.", CR)
        end

        	return APPLY(function() RAINBOW_FLAG = T return RAINBOW_FLAG end)
      elseif T then 
        ROB(ON_RAINBOW, WALL)
        TELL("The rainbow seems to have become somewhat run-of-the-mill.", CR)
        APPLY(function() RAINBOW_FLAG = nil return RAINBOW_FLAG end)
        	error(true)
      end

    elseif EQUALQ(HERE, ON_RAINBOW) then 
      APPLY(function() RAINBOW_FLAG = nil return RAINBOW_FLAG end)
      	return JIGS_UP("The structural integrity of the rainbow is severely compromised,\nleaving you hanging in midair, supported only by water vapor. Bye.")
    elseif T then 
      	return TELL("A dazzling display of color briefly emanates from the sceptre.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SCEPTRE_FUNCTION\n'..__res) end
end
FALLS_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are at the top of Aragain Falls, an enormous waterfall with a\ndrop of about 450 feet. The only path here is on the north end.", CR)
    
    if RAINBOW_FLAG then 
      TELL("A solid rainbow spans the falls.")
    elseif T then 
      TELL("A beautiful rainbow can be seen over the falls and to the west.")
    end

    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FALLS_ROOM\n'..__res) end
end
RAINBOW_FCN = function()
	local __ok, __res = pcall(function()

  if VERBQ(CROSS, THROUGH) then 
    
    if EQUALQ(HERE, CANYON_VIEW) then 
      TELL("From here?!?", CR)
      	error(true)
    end

    
    if RAINBOW_FLAG then 
      
      if EQUALQ(HERE, ARAGAIN_FALLS) then 
        	return GOTO(END_OF_RAINBOW)
      elseif EQUALQ(HERE, END_OF_RAINBOW) then 
        	return GOTO(ARAGAIN_FALLS)
      elseif T then 
        	return TELL("You'll have to say which way...", CR)
      end

    elseif T then 
      	return TELL("Can you walk on water vapor?", CR)
    end

  elseif VERBQ(LOOK_UNDER) then 
    	return TELL("The Frigid River flows under the rainbow.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RAINBOW_FCN\n'..__res) end
end
DBOAT_FUNCTION = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(PUT, PUT_ON) and EQUALQ(PRSO, PUTTY)) then 
    	return FIX_BOAT()
  elseif VERBQ(INFLATE, FILL) then 
    	return TELL("No chance. Some moron punctured it.", CR)
  elseif VERBQ(PLUG) then 
    
    if EQUALQ(PRSI, PUTTY) then 
      	return FIX_BOAT()
    elseif T then 
      	return WITH_TELL(PRSI)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DBOAT_FUNCTION\n'..__res) end
end
FIX_BOAT = function()
	local __ok, __res = pcall(function()
  TELL("Well done. The boat is repaired.", CR)
  MOVE(INFLATABLE_BOAT, LOC(PUNCTURED_BOAT))
	return   REMOVE_CAREFULLY(PUNCTURED_BOAT)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIX_BOAT\n'..__res) end
end
RIVER_FUNCTION = function()
	local __ok, __res = pcall(function()

  if VERBQ(PUT) then 
    
    if EQUALQ(PRSI, RIVER) then 
      
      if EQUALQ(PRSO, ME) then 
        	return JIGS_UP("You splash around for a while, fighting the current, then you drown.")
      elseif EQUALQ(PRSO, INFLATED_BOAT) then 
        	return TELL("You should get in the boat then launch it.", CR)
      elseif FSETQ(PRSO, BURNBIT) then 
        REMOVE_CAREFULLY(PRSO)
        	return TELL("The ", D, PRSO, " floats for a moment, then sinks.", CR)
      elseif T then 
        REMOVE_CAREFULLY(PRSO)
        	return TELL("The ", D, PRSO, " splashes into the water and is gone forever.", CR)
      end

    end

  elseif VERBQ(LEAP, THROUGH) then 
    	return TELL("A look before leaping reveals that the river is wide and dangerous,\nwith swift currents and large, half-hidden rocks. You decide to forgo your\nswim.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RIVER_FUNCTION\n'..__res) end
end
RIVER_SPEEDS = {RIVER_1,4,RIVER_2,4,RIVER_3,3,RIVER_4,2,RIVER_5,1}

RIVER_NEXT = {RIVER_1,RIVER_2,RIVER_3,RIVER_4,RIVER_5}

RIVER_LAUNCH = {DAM_BASE,RIVER_1,WHITE_CLIFFS_NORTH,RIVER_3,WHITE_CLIFFS_SOUTH,RIVER_4,SHORE,RIVER_5,SANDY_BEACH,RIVER_4,RESERVOIR_SOUTH,RESERVOIR,RESERVOIR_NORTH,RESERVOIR,STREAM_VIEW,IN_STREAM}

I_RIVER = function()
	local RM
	local __ok, __res = pcall(function()

  if PASS(NOT(EQUALQ(HERE, RIVER_1, RIVER_2, RIVER_3)) and NOT(EQUALQ(HERE, RIVER_4, RIVER_5))) then 
    	return DISABLE(INT(I_RIVER))
  elseif APPLY(function() RM = LKP(HERE, RIVER_NEXT) return RM end) then 
    TELL("The flow of the river carries you downstream.", CR, CR)
    GOTO(RM)
    	return ENABLE(QUEUE(I_RIVER, LKP(HERE, RIVER_SPEEDS)))
  elseif T then 
    	return JIGS_UP("Unfortunately, the magic boat doesn't provide protection from\nthe rocks and boulders one meets at the bottom of waterfalls.\nIncluding this one.")
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_RIVER\n'..__res) end
end
RBOAT_FUNCTION = function(RARG)
	local TMP
  RARG = RARG or nil
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_ENTER, M_END, M_LOOK) then 
    	return nil
  elseif EQUALQ(RARG, M_BEG) then 
    
    if VERBQ(WALK) then 
      
      if EQUALQ(PRSO, PQLAND, PQEAST, PQWEST) then 
        	error(false)
      elseif PASS(EQUALQ(HERE, RESERVOIR) and EQUALQ(PRSO, PQNORTH, PQSOUTH)) then 
        	error(false)
      elseif PASS(EQUALQ(HERE, IN_STREAM) and EQUALQ(PRSO, PQSOUTH)) then 
        	error(false)
      elseif T then 
        TELL("Read the label for the boat's instructions.", CR)
        	error(true)
      end

    elseif VERBQ(LAUNCH) then 
      
      if PASS(EQUALQ(HERE, RIVER_1, RIVER_2, RIVER_3) or EQUALQ(HERE, RIVER_4, RESERVOIR, IN_STREAM)) then 
        TELL("You are on the ")
        
        if EQUALQ(HERE, RESERVOIR) then 
          TELL("reservoir")
        elseif EQUALQ(HERE, IN_STREAM) then 
          TELL("stream")
        elseif T then 
          TELL("river")
        end

        	return TELL(", or have you forgotten?", CR)
      elseif EQUALQ(APPLY(function() TMP = GO_NEXT(RIVER_LAUNCH) return TMP end), 1) then 
        ENABLE(QUEUE(I_RIVER, LKP(HERE, RIVER_SPEEDS)))
        	error(true)
      elseif NOT(EQUALQ(TMP, 2)) then 
        TELL("You can't launch it here.", CR)
        	error(true)
      elseif T then 
        	error(true)
      end

    elseif PASS(PASS(VERBQ(DROP) and FSETQ(PRSO, WEAPONBIT)) or PASS(VERBQ(PUT) and FSETQ(PRSO, WEAPONBIT) and EQUALQ(PRSI, INFLATED_BOAT)) or PASS(VERBQ(ATTACK, MUNG) and FSETQ(PRSI, WEAPONBIT))) then 
      REMOVE_CAREFULLY(INFLATED_BOAT)
      MOVE(PUNCTURED_BOAT, HERE)
      ROB(INFLATED_BOAT, HERE)
      MOVE(WINNER, HERE)
      TELL("It seems that the ")
      
      if VERBQ(DROP, PUT) then 
        TELL(D, PRSO)
      elseif T then 
        TELL(D, PRSI)
      end

      TELL(" didn't agree with the boat, as evidenced\nby the loud hissing noise issuing therefrom. With a pathetic sputter, the\nboat deflates, leaving you without.", CR)
      
      if FSETQ(HERE, NONLANDBIT) then 
        CRLF()
        
        if EQUALQ(HERE, RESERVOIR, IN_STREAM) then 
          JIGS_UP("Another pathetic sputter, this time from you, heralds your drowning.")
        elseif T then 
          JIGS_UP("In other words, fighting the fierce currents of the Frigid River. You\nmanage to hold your own for a bit, but then you are carried over a\nwaterfall and into some nasty rocks. Ouch!")
        end

      end

      	error(true)
    elseif VERBQ(LAUNCH) then 
      	return TELL("You're not in the boat!", CR)
    end

  elseif VERBQ(BOARD) then 
    
    if PASS(INQ(SCEPTRE, WINNER) or INQ(KNIFE, WINNER) or INQ(SWORD, WINNER) or INQ(RUSTY_KNIFE, WINNER) or INQ(AXE, WINNER) or INQ(STILETTO, WINNER)) then 
      TELL("Oops! Something sharp seems to have slipped and punctured the boat.\nThe boat deflates to the sounds of hissing, sputtering, and cursing.", CR)
      REMOVE_CAREFULLY(INFLATED_BOAT)
      MOVE(PUNCTURED_BOAT, HERE)
      THIS_IS_IT(PUNCTURED_BOAT)
      -- 	return T
    end

  elseif VERBQ(INFLATE, FILL) then 
    	return TELL("Inflating it further would probably burst it.", CR)
  elseif VERBQ(DEFLATE) then 
    
    if EQUALQ(LOC(WINNER), INFLATED_BOAT) then 
      	return TELL("You can't deflate the boat while you're in it.", CR)
    elseif NOT(INQ(INFLATED_BOAT, HERE)) then 
      	return TELL("The boat must be on the ground to be deflated.", CR)
    elseif T then 
      TELL("The boat deflates.", CR)
      APPLY(function() DEFLATE = T return DEFLATE end)
      REMOVE_CAREFULLY(INFLATED_BOAT)
      MOVE(INFLATABLE_BOAT, HERE)
      	return THIS_IS_IT(INFLATABLE_BOAT)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RBOAT_FUNCTION\n'..__res) end
end
BREATHE = function()
	local __ok, __res = pcall(function()
	return   PERFORM(VQINFLATE, PRSO, LUNGS)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BREATHE\n'..__res) end
end
IBOAT_FUNCTION = function()
	local __ok, __res = pcall(function()

  if VERBQ(INFLATE, FILL) then 
    
    if NOT(INQ(INFLATABLE_BOAT, HERE)) then 
      	return TELL("The boat must be on the ground to be inflated.", CR)
    elseif EQUALQ(PRSI, PUMP) then 
      TELL("The boat inflates and appears seaworthy.", CR)
      
      if NOT(FSETQ(BOAT_LABEL, TOUCHBIT)) then 
        TELL("A tan label is lying inside the boat.", CR)
      end

      APPLY(function() DEFLATE = nil return DEFLATE end)
      REMOVE_CAREFULLY(INFLATABLE_BOAT)
      MOVE(INFLATED_BOAT, HERE)
      	return THIS_IS_IT(INFLATED_BOAT)
    elseif EQUALQ(PRSI, LUNGS) then 
      	return TELL("You don't have enough lung power to inflate it.", CR)
    elseif T then 
      	return TELL("With a ", D, PRSI, "? Surely you jest!", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('IBOAT_FUNCTION\n'..__res) end
end
BUOY_FLAG = T
RIVR4_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_END) then 
    
    if PASS(INQ(BUOY, WINNER) and BUOY_FLAG) then 
      TELL("You notice something funny about the feel of the buoy.", CR)
      	return APPLY(function() BUOY_FLAG = nil return BUOY_FLAG end)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RIVR4_ROOM\n'..__res) end
end
BEACH_DIG = -1
SAND_FUNCTION = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(DIG) and EQUALQ(PRSI, SHOVEL)) then 
    APPLY(function() BEACH_DIG = ADD(1, BEACH_DIG) return BEACH_DIG end)
    
    if GQ(BEACH_DIG, 3) then 
      APPLY(function() BEACH_DIG = -1 return BEACH_DIG end)
      PASS(INQ(SCARAB, HERE) and FSET(SCARAB, INVISIBLE))
      	return JIGS_UP("The hole collapses, smothering you.")
    elseif EQUALQ(BEACH_DIG, 3) then 
      
      if FSETQ(SCARAB, INVISIBLE) then 
        TELL("You can see a scarab here in the sand.", CR)
        THIS_IS_IT(SCARAB)
        	return FCLEAR(SCARAB, INVISIBLE)
      end

    elseif T then 
      	return TELL(GET(BDIGS, BEACH_DIG), CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SAND_FUNCTION\n'..__res) end
end
BDIGS = {"You seem to be digging a hole here.","The hole is getting deeper, but that's about it.","You are surrounded by a wall of sand on all sides."}

TREE_ROOM = function(RARG)
	local F
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_LOOK) then 
    TELL("You are about 10 feet above the ground nestled among some large\nbranches. The nearest branch above you is above your reach.", CR)
    
    if PASS(APPLY(function() F = FIRSTQ(PATH) return F end) and NEXTQ(F)) then 
      TELL("On the ground below you can see:  ")
      PRINT_CONTENTS(PATH)
      	return TELL(".", CR)
    end

  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_DOWN) and EQUALQ(PRSO, TREE, ROOMS)) then 
      	return DO_WALK(PQDOWN)
    elseif PASS(VERBQ(CLIMB_UP, CLIMB_FOO) and EQUALQ(PRSO, TREE)) then 
      	return DO_WALK(PQUP)
    elseif VERBQ(DROP) then 
      
      if NOT(IDROP()) then 
        	error(true)
      elseif PASS(EQUALQ(PRSO, NEST) and INQ(EGG, NEST)) then 
        TELL("The nest falls to the ground, and the egg spills out of it, seriously\ndamaged.", CR)
        REMOVE_CAREFULLY(EGG)
        	return MOVE(BROKEN_EGG, PATH)
      elseif EQUALQ(PRSO, EGG) then 
        TELL("The egg falls to the ground and springs open, seriously damaged.")
        MOVE(EGG, PATH)
        BAD_EGG()
        	return CRLF()
      elseif NOT(EQUALQ(PRSO, WINNER, TREE)) then 
        MOVE(PRSO, PATH)
        	return TELL("The ", D, PRSO, " falls to the ground.", CR)
      elseif VERBQ(LEAP) then 
        	return JIGS_UP("That was just a bit too far down.")
      end

    end

  elseif EQUALQ(RARG, M_ENTER) then 
    	return ENABLE(QUEUE(I_FOREST_ROOM, -1))
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TREE_ROOM\n'..__res) end
end
EGG_OBJECT = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(OPEN, MUNG) and EQUALQ(PRSO, EGG)) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	return TELL("The egg is already open.", CR)
    elseif NOT(PRSI) then 
      	return TELL("You have neither the tools nor the expertise.", CR)
    elseif EQUALQ(PRSI, HANDS) then 
      	return TELL("I doubt you could do that without damaging it.", CR)
    elseif PASS(FSETQ(PRSI, WEAPONBIT) or FSETQ(PRSI, TOOLBIT) or VERBQ(MUNG)) then 
      TELL("The egg is now open, but the clumsiness of your attempt has seriously\ncompromised its esthetic appeal.")
      BAD_EGG()
      	return CRLF()
    elseif FSETQ(PRSO, FIGHTBIT) then 
      	return TELL("Not to say that using the ", D, PRSI, " isn't original too...", CR)
    elseif T then 
      TELL("The concept of using a ", D, PRSI, " is certainly original.", CR)
      	return FSET(PRSO, FIGHTBIT)
    end

  elseif VERBQ(CLIMB_ON, HATCH) then 
    TELL("There is a noticeable crunch from beneath you, and inspection reveals\nthat the egg is lying open, badly damaged.")
    BAD_EGG()
    	return CRLF()
  elseif VERBQ(OPEN, MUNG, THROW) then 
    
    if VERBQ(THROW) then 
      MOVE(PRSO, HERE)
    end

    TELL("Your rather indelicate handling of the egg has caused it some damage,\nalthough you have succeeded in opening it.")
    BAD_EGG()
    	return CRLF()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('EGG_OBJECT\n'..__res) end
end
BAD_EGG = function()
	local __ok, __res = pcall(function()

  if INQ(CANARY, EGG) then 
    TELL(" ", GETP(BROKEN_CANARY, PQFDESC))
  elseif T then 
    REMOVE_CAREFULLY(BROKEN_CANARY)
  end

  MOVE(BROKEN_EGG, LOC(EGG))
  REMOVE_CAREFULLY(EGG)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BAD_EGG\n'..__res) end
end
SING_SONG = nil
CANARY_OBJECT = function()
	local __ok, __res = pcall(function()

  if VERBQ(WIND) then 
    
    if EQUALQ(PRSO, CANARY) then 
      
      if PASS(NOT(SING_SONG) and FOREST_ROOMQ()) then 
        TELL("The canary chirps, slightly off-key, an aria from a forgotten opera.\nFrom out of the greenery flies a lovely songbird. It perches on a\nlimb just over your head and opens its beak to sing. As it does so\na beautiful brass bauble drops from its mouth, bounces off the top of\nyour head, and lands glimmering in the grass. As the canary winds\ndown, the songbird flies away.", CR)
        APPLY(function() SING_SONG = T return SING_SONG end)
        	return MOVE(BAUBLE, APPLY(function()
          if EQUALQ(HERE, UP_A_TREE) then 
            -- 	return PATH
          elseif T then 
            -- 	return HERE
          end
 end))
      elseif T then 
        	return TELL("The canary chirps blithely, if somewhat tinnily, for a short time.", CR)
      end

    elseif T then 
      	return TELL("There is an unpleasant grinding noise from inside the canary.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CANARY_OBJECT\n'..__res) end
end
FOREST_ROOMQ = function()
	local __ok, __res = pcall(function()
	return   PASS(EQUALQ(HERE, FOREST_1, FOREST_2, FOREST_3) or EQUALQ(HERE, PATH, UP_A_TREE))
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FOREST_ROOMQ\n'..__res) end
end
I_FOREST_ROOM = function()
	local __ok, __res = pcall(function()

  if NOT(FOREST_ROOMQ()) then 
    DISABLE(INT(I_FOREST_ROOM))
    	error(false)
  elseif PROB(15) then 
    	return TELL("You hear in the distance the chirping of a song bird.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_FOREST_ROOM\n'..__res) end
end
FOREST_ROOM = function(RARG)
	local __ok, __res = pcall(function()

  if EQUALQ(RARG, M_ENTER) then 
    	return ENABLE(QUEUE(I_FOREST_ROOM, -1))
  elseif EQUALQ(RARG, M_BEG) then 
    
    if PASS(VERBQ(CLIMB_FOO, CLIMB_UP) and EQUALQ(PRSO, TREE)) then 
      	return DO_WALK(PQUP)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FOREST_ROOM\n'..__res) end
end
WCLIF_OBJECT = function()
	local __ok, __res = pcall(function()

  if VERBQ(CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) then 
    	return TELL("The cliff is too steep for climbing.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WCLIF_OBJECT\n'..__res) end
end
CLIFF_OBJECT = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(LEAP) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    	return TELL("That would be very unwise. Perhaps even fatal.", CR)
  elseif EQUALQ(PRSI, CLIMBABLE_CLIFF) then 
    
    if VERBQ(PUT, THROW_OFF) then 
      TELL("The ", D, PRSO, " tumbles into the river and is seen no more.", CR)
      	return REMOVE_CAREFULLY(PRSO)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CLIFF_OBJECT\n'..__res) end
end
ROPE_FUNCTION = function()
	local RLOC
	local __ok, __res = pcall(function()

  if NOT(EQUALQ(HERE, DOME_ROOM)) then 
    APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
    
    if VERBQ(TIE) then 
      	return TELL("You can't tie the rope to that.", CR)
    end

  elseif VERBQ(TIE) then 
    
    if EQUALQ(PRSI, RAILING) then 
      
      if DOME_FLAG then 
        	return TELL("The rope is already tied to it.", CR)
      elseif T then 
        TELL("The rope drops over the side and comes within ten feet of the floor.", CR)
        APPLY(function() DOME_FLAG = T return DOME_FLAG end)
        FSET(ROPE, NDESCBIT)
        APPLY(function() RLOC = LOC(ROPE) return RLOC end)
        
        if PASS(NOT(RLOC) or NOT(INQ(RLOC, ROOMS))) then 
          MOVE(ROPE, HERE)
        end

        -- 	return T
      end

    end

  elseif PASS(VERBQ(CLIMB_DOWN) and EQUALQ(PRSO, ROPE, ROOMS) and DOME_FLAG) then 
    	return DO_WALK(PQDOWN)
  elseif PASS(VERBQ(TIE_UP) and EQUALQ(ROPE, PRSI)) then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      
      if LQ(GETP(PRSO, PQSTRENGTH), 0) then 
        TELL("Your attempt to tie up the ", D, PRSO, " awakens him.")
        	return AWAKEN(PRSO)
      elseif T then 
        	return TELL("The ", D, PRSO, " struggles and you cannot tie him up.", CR)
      end

    elseif T then 
      	return TELL("Why would you tie up a ", D, PRSO, "?", CR)
    end

  elseif VERBQ(UNTIE) then 
    
    if DOME_FLAG then 
      APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
      FCLEAR(ROPE, NDESCBIT)
      	return TELL("The rope is now untied.", CR)
    elseif T then 
      	return TELL("It is not tied to anything.", CR)
    end

  elseif PASS(VERBQ(DROP) and EQUALQ(HERE, DOME_ROOM) and NOT(DOME_FLAG)) then 
    MOVE(ROPE, TORCH_ROOM)
    	return TELL("The rope drops gently to the floor below.", CR)
  elseif VERBQ(TAKE) then 
    
    if DOME_FLAG then 
      	return TELL("The rope is tied to the railing.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ROPE_FUNCTION\n'..__res) end
end
UNTIE_FROM = function()
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(PRSO, ROPE) and PASS(DOME_FLAG and EQUALQ(PRSI, RAILING))) then 
    	return PERFORM(VQUNTIE, PRSO)
  elseif T then 
    	return TELL("It's not attached to that!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('UNTIE_FROM\n'..__res) end
end
SLIDE_FUNCTION = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(THROUGH, CLIMB_UP, CLIMB_DOWN, CLIMB_FOO) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    
    if EQUALQ(HERE, CELLAR) then 
      DO_WALK(PQWEST)
      	error(true)
    elseif T then 
      TELL("You tumble down the slide....", CR)
      	return GOTO(CELLAR)
    end

  elseif VERBQ(PUT) then 
    	return SLIDER(PRSO)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SLIDE_FUNCTION\n'..__res) end
end
SLIDER = function(OBJ)
	local __ok, __res = pcall(function()

  if FSETQ(OBJ, TAKEBIT) then 
    TELL("The ", D, OBJ, " falls into the slide and is gone.", CR)
    
    if EQUALQ(OBJ, WATER) then 
      	return REMOVE_CAREFULLY(OBJ)
    elseif T then 
      	return MOVE(OBJ, CELLAR)
    end

  elseif T then 
    	return TELL(PICK_ONE(YUKS), CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SLIDER\n'..__res) end
end
SANDWICH_BAG_FCN = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(SMELL) and INQ(LUNCH, PRSO)) then 
    	return TELL("It smells of hot peppers.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SANDWICH_BAG_FCN\n'..__res) end
end
DEAD_FUNCTION = function(FOO)
  FOO = FOO or nil
	local __ok, __res = pcall(function()

  if VERBQ(WALK) then 
    
    if PASS(EQUALQ(HERE, TIMBER_ROOM) and EQUALQ(PRSO, PQWEST)) then 
      	return TELL("You cannot enter in your condition.", CR)
    end

  elseif VERBQ(BRIEF, VERBOSE, SUPER_BRIEF, VERSION, SAVE, RESTORE, QUIT, RESTART) then 
    	return nil
  elseif VERBQ(ATTACK, MUNG, ALARM, SWING) then 
    	return TELL("All such attacks are vain in your condition.", CR)
  elseif VERBQ(OPEN, CLOSE, EAT, DRINK, INFLATE, DEFLATE, TURN, BURN, TIE, UNTIE, RUB) then 
    	return TELL("Even such an action is beyond your capabilities.", CR)
  elseif VERBQ(WAIT) then 
    	return TELL("Might as well. You've got an eternity.", CR)
  elseif VERBQ(LAMP_ON) then 
    	return TELL("You need no light to guide you.", CR)
  elseif VERBQ(SCORE) then 
    	return TELL("You're dead! How can you think of your score?", CR)
  elseif VERBQ(TAKE, RUB) then 
    	return TELL("Your hand passes through its object.", CR)
  elseif VERBQ(DROP, THROW, INVENTORY) then 
    	return TELL("You have no possessions.", CR)
  elseif VERBQ(DIAGNOSE) then 
    	return TELL("You are dead.", CR)
  elseif VERBQ(LOOK) then 
    TELL("The room looks strange and unearthly")
    
    if NOT(FIRSTQ(HERE)) then 
      TELL(".")
    elseif T then 
      TELL(" and objects appear indistinct.")
    end

    CRLF()
    
    if NOT(FSETQ(HERE, ONBIT)) then 
      TELL("Although there is no light, the room seems dimly illuminated.", CR)
    end

    CRLF()
    	return nil
  elseif VERBQ(PRAY) then 
    
    if EQUALQ(HERE, SOUTH_TEMPLE) then 
      FCLEAR(LAMP, INVISIBLE)
      PUTP(WINNER, PQACTION, 0)
      APPLY(function() ALWAYS_LIT = nil return ALWAYS_LIT end)
      APPLY(function() DEAD = nil return DEAD end)
      
      if INQ(TROLL, TROLL_ROOM) then 
        APPLY(function() TROLL_FLAG = nil return TROLL_FLAG end)
      end

      TELL("From the distance the sound of a lone trumpet is heard. The room\nbecomes very bright and you feel disembodied. In a moment, the\nbrightness fades and you find yourself rising as if from a long\nsleep, deep in the woods. In the distance you can faintly hear a\nsongbird and the sounds of the forest.", CR, CR)
      	return GOTO(FOREST_1)
    elseif T then 
      	return TELL("Your prayers are not heard.", CR)
    end

  elseif T then 
    TELL("You can't even do that.", CR)
    APPLY(function() P_CONT = nil return P_CONT end)
    	return RFATAL()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DEAD_FUNCTION\n'..__res) end
end
LAKE_PSEUDO = function()
	local __ok, __res = pcall(function()

  if LOW_TIDE then 
    	return TELL("There's not much lake left....", CR)
  elseif VERBQ(CROSS) then 
    	return TELL("It's too wide to cross.", CR)
  elseif VERBQ(THROUGH) then 
    	return TELL("You can't swim in this lake.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LAKE_PSEUDO\n'..__res) end
end
STREAM_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(SWIM, THROUGH) then 
    	return TELL("You can't swim in the stream.", CR)
  elseif VERBQ(CROSS) then 
    	return TELL("The other side is a sheer rock cliff.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STREAM_PSEUDO\n'..__res) end
end
CHASM_PSEUDO = function()
	local __ok, __res = pcall(function()

  if PASS(VERBQ(LEAP) or PASS(VERBQ(PUT) and EQUALQ(PRSO, ME))) then 
    	return TELL("You look before leaping, and realize that you would never survive.", CR)
  elseif VERBQ(CROSS) then 
    	return TELL("It's too far to jump, and there's no bridge.", CR)
  elseif PASS(VERBQ(PUT, THROW_OFF) and EQUALQ(PRSI, PSEUDO_OBJECT)) then 
    TELL("The ", D, PRSO, " drops out of sight into the chasm.", CR)
    	return REMOVE_CAREFULLY(PRSO)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CHASM_PSEUDO\n'..__res) end
end
DOME_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(KISS) then 
    	return TELL("No.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DOME_PSEUDO\n'..__res) end
end
GATE_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(THROUGH) then 
    DO_WALK(PQIN)
    	error(true)
  elseif T then 
    	return TELL("The gate is protected by an invisible force. It makes your\nteeth ache to touch it.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GATE_PSEUDO\n'..__res) end
end
DOOR_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE) then 
    	return TELL("The door won't budge.", CR)
  elseif VERBQ(THROUGH) then 
    	return DO_WALK(PQSOUTH)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DOOR_PSEUDO\n'..__res) end
end
PAINT_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(MUNG) then 
    	return TELL("Some paint chips away, revealing more paint.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PAINT_PSEUDO\n'..__res) end
end
GAS_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(BREATHE) then 
    	return TELL("There is too much gas to blow away.", CR)
  elseif VERBQ(SMELL) then 
    	return TELL("It smells like coal gas in here.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
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
DEF1 = {MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,UNCONSCIOUS,UNCONSCIOUS,KILLED,KILLED,KILLED,KILLED,KILLED}

DEF2A = {MISSED,MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,UNCONSCIOUS}

DEF2B = {MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,UNCONSCIOUS,KILLED,KILLED,KILLED}

DEF3A = {MISSED,MISSED,MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND}

DEF3B = {MISSED,MISSED,MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND,SERIOUS_WOUND}

DEF3C = {MISSED,STAGGER,STAGGER,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,LIGHT_WOUND,SERIOUS_WOUND,SERIOUS_WOUND,SERIOUS_WOUND}

DEF1_RES = {DEF1,0,0}

DEF2_RES = {DEF2A,DEF2B,0,0}

DEF3_RES = {DEF3A,0,DEF3B,0,DEF3C}

STRENGTH_MAX = 7
STRENGTH_MIN = 2
CURE_WAIT = 30
DO_FIGHT = function(LEN)
	local CNT
	local RES
	local O
	local OO
  local OUT = nil
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    APPLY(function() CNT = 0 return CNT end)
    
    APPLY(function() while true do
      APPLY(function() CNT = ADD(CNT, 1) return CNT end)
      
      if EQUALQ(CNT, LEN) then 
        APPLY(function() RES = T return RES end)
        return T
      end

      APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
      APPLY(function() O = GET(OO, V_VILLAIN) return O end)
      
      if NOT(FSETQ(O, FIGHTBIT)) then 
      elseif APPLY(GETP(O, PQACTION), F_BUSYQ) then 
      elseif NOT(APPLY(function() RES = VILLAIN_BLOW(OO, OUT) return RES end)) then 
        APPLY(function() RES = nil return RES end)
        return 
      elseif EQUALQ(RES, UNCONSCIOUS) then 
        APPLY(function() OUT = ADD(1, RANDOM(3)) return OUT end)
      end


    end end)

    
    if RES then 
      
      if NOT(OUT) then 
        return 
      elseif T then 
        APPLY(function() OUT = SUB(OUT, 1) return OUT end)
        
        if ZEROQ(OUT) then 
          return 
        end

      end

    elseif T then 
      return 
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DO_FIGHT\n'..__res) end
end
REMARK = function(REMARK, D, W)
  local LEN = GET(REMARK, 0)
  local CNT = 0
	local STR
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), LEN) then 
      return 
    end

    APPLY(function() STR = GET(REMARK, CNT) return STR end)
    
    if EQUALQ(STR, F_WEP) then 
      PRINTD(W)
    elseif EQUALQ(STR, F_DEF) then 
      PRINTD(D)
    elseif T then 
      PRINT(STR)
    end


  end end)

	return   CRLF()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('REMARK\n'..__res) end
end
FIGHT_STRENGTH = function(ADJUSTQ)
	local S
  ADJUSTQ = ADJUSTQ or T
	local __ok, __res = pcall(function()
APPLY(function() S = ADD(STRENGTH_MIN, DIV(SCORE, DIV(SCORE_MAX, SUB(STRENGTH_MAX, STRENGTH_MIN)))) return S end)

  if ADJUSTQ then 
    	return ADD(S, GETP(WINNER, PQSTRENGTH))
  elseif T then 
    -- 	return S
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIGHT_STRENGTH\n'..__res) end
end
VILLAIN_STRENGTH = function(OO)
  local VILLAIN = GET(OO, V_VILLAIN)
	local OD
	local TMP
	local __ok, __res = pcall(function()
APPLY(function() OD = GETP(VILLAIN, PQSTRENGTH) return OD end)

  if NOT(LQ(OD, 0)) then 
    
    if PASS(EQUALQ(VILLAIN, THIEF) and THIEF_ENGROSSED) then 
      
      if GQ(OD, 2) then 
        APPLY(function() OD = 2 return OD end)
      end

      APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
    end

    
    if PASS(PRSI and FSETQ(PRSI, WEAPONBIT) and EQUALQ(GET(OO, V_BEST), PRSI)) then 
      APPLY(function() TMP = SUB(OD, GET(OO, V_BEST_ADV)) return TMP end)
      
      if LQ(TMP, 1) then 
        APPLY(function() TMP = 1 return TMP end)
      end

      APPLY(function() OD = TMP return OD end)
    end

  end

	return OD
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('VILLAIN_STRENGTH\n'..__res) end
end
FIND_WEAPON = function(O)
	local W
	local __ok, __res = pcall(function()
APPLY(function() W = FIRSTQ(O) return W end)

  if NOT(W) then 
    	error(false)
  end


  APPLY(function() while true do
    
    if PASS(EQUALQ(W, STILETTO, AXE, SWORD) or EQUALQ(W, KNIFE, RUSTY_KNIFE)) then 
      return W
    elseif NOT(APPLY(function() W = NEXTQ(W) return W end)) then 
      	error(false)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIND_WEAPON\n'..__res) end
end
VILLAIN_BLOW = function(OO, OUTQ)
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
  FCLEAR(WINNER, STAGGERED)

  if FSETQ(VILLAIN, STAGGERED) then 
    TELL("The ", D, VILLAIN, " slowly regains his feet.", CR)
    FCLEAR(VILLAIN, STAGGERED)
    	error(true)
  end

APPLY(function() OA = APPLY(function() ATT = VILLAIN_STRENGTH(OO) return ATT end) return OA end)

  if NOT(GQ(APPLY(function() DEF = FIGHT_STRENGTH() return DEF end), 0)) then 
    	error(true)
  end

APPLY(function() OD = FIGHT_STRENGTH(nil) return OD end)
APPLY(function() DWEAPON = FIND_WEAPON(WINNER) return DWEAPON end)

  if LQ(DEF, 0) then 
    APPLY(function() RES = KILLED return RES end)
  elseif T then 
    
    if ONEQ(DEF) then 
      
      if GQ(ATT, 2) then 
        APPLY(function() ATT = 3 return ATT end)
      end

      APPLY(function() TBL = GET(DEF1_RES, SUB(ATT, 1)) return TBL end)
    elseif EQUALQ(DEF, 2) then 
      
      if GQ(ATT, 3) then 
        APPLY(function() ATT = 4 return ATT end)
      end

      APPLY(function() TBL = GET(DEF2_RES, SUB(ATT, 1)) return TBL end)
    elseif GQ(DEF, 2) then 
      APPLY(function() ATT = SUB(ATT, DEF) return ATT end)
      
      if LQ(ATT, -1) then 
        APPLY(function() ATT = -2 return ATT end)
      elseif GQ(ATT, 1) then 
        APPLY(function() ATT = 2 return ATT end)
      end

      APPLY(function() TBL = GET(DEF3_RES, ADD(ATT, 2)) return TBL end)
    end

    APPLY(function() RES = GET(TBL, SUB(RANDOM(9), 1)) return RES end)
    
    if OUTQ then 
      
      if EQUALQ(RES, STAGGER) then 
        APPLY(function() RES = HESITATE return RES end)
      elseif T then 
        APPLY(function() RES = SITTING_DUCK return RES end)
      end

    end

    
    if PASS(EQUALQ(RES, STAGGER) and DWEAPON and PROB(25, APPLY(function()
          if HEROQ then 
            -- 	return 10
          elseif T then 
            -- 	return 50
          end
 end))) then 
      APPLY(function() RES = LOSE_WEAPON return RES end)
    end

    REMARK(RANDOM_ELEMENT(GET(REMARKS, SUB(RES, 1))), WINNER, DWEAPON)
  end


  if PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE)) then 
  elseif EQUALQ(RES, UNCONSCIOUS) then 
  elseif PASS(EQUALQ(RES, KILLED) or EQUALQ(RES, SITTING_DUCK)) then 
    APPLY(function() DEF = 0 return DEF end)
  elseif EQUALQ(RES, LIGHT_WOUND) then 
    APPLY(function() DEF = SUB(DEF, 1) return DEF end)
    
    if LQ(DEF, 0) then 
      APPLY(function() DEF = 0 return DEF end)
    end

    
    if GQ(LOAD_ALLOWED, 50) then 
      APPLY(function() LOAD_ALLOWED = SUB(LOAD_ALLOWED, 10) return LOAD_ALLOWED end)
    end

  elseif EQUALQ(RES, SERIOUS_WOUND) then 
    APPLY(function() DEF = SUB(DEF, 2) return DEF end)
    
    if LQ(DEF, 0) then 
      APPLY(function() DEF = 0 return DEF end)
    end

    
    if GQ(LOAD_ALLOWED, 50) then 
      APPLY(function() LOAD_ALLOWED = SUB(LOAD_ALLOWED, 20) return LOAD_ALLOWED end)
    end

  elseif EQUALQ(RES, STAGGER) then 
    FSET(WINNER, STAGGERED)
  elseif T then 
    MOVE(DWEAPON, HERE)
    
    if APPLY(function() NWEAPON = FIND_WEAPON(WINNER) return NWEAPON end) then 
      TELL("Fortunately, you still have a ", D, NWEAPON, ".", CR)
    end

  end

	return   WINNER_RESULT(DEF, RES, OD)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('VILLAIN_BLOW\n'..__res) end
end
HERO_BLOW = function()
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

  APPLY(function() while true do
    APPLY(function() CNT = ADD(CNT, 1) return CNT end)
    
    if EQUALQ(CNT, LEN) then 
      return 
    end

    APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
    
    if EQUALQ(GET(OO, V_VILLAIN), PRSO) then 
      return 
    end


  end end)

  FSET(PRSO, FIGHTBIT)

  if FSETQ(WINNER, STAGGERED) then 
    TELL("You are still recovering from that last blow, so your attack is\nineffective.", CR)
    FCLEAR(WINNER, STAGGERED)
    	error(true)
  end

APPLY(function() ATT = FIGHT_STRENGTH() return ATT end)

  if LQ(ATT, 1) then 
    APPLY(function() ATT = 1 return ATT end)
  end

APPLY(function() OA = ATT return OA end)
APPLY(function() VILLAIN = GET(OO, V_VILLAIN) return VILLAIN end)

  if ZEROQ(APPLY(function() OD = APPLY(function() DEF = VILLAIN_STRENGTH(OO) return DEF end) return OD end)) then 
    
    if EQUALQ(PRSO, WINNER) then 
      return JIGS_UP("Well, you really did it that time. Is suicide painless?")
    end

    TELL("Attacking the ", D, VILLAIN, " is pointless.", CR)
    	error(true)
  end

APPLY(function() DWEAPON = FIND_WEAPON(VILLAIN) return DWEAPON end)

  if PASS(NOT(DWEAPON) or LQ(DEF, 0)) then 
    TELL("The ")
    
    if LQ(DEF, 0) then 
      TELL("unconscious")
    elseif T then 
      TELL("unarmed")
    end

    TELL(" ", D, VILLAIN, " cannot defend himself: He dies.", CR)
    APPLY(function() RES = KILLED return RES end)
  elseif T then 
    
    if ONEQ(DEF) then 
      
      if GQ(ATT, 2) then 
        APPLY(function() ATT = 3 return ATT end)
      end

      APPLY(function() TBL = GET(DEF1_RES, SUB(ATT, 1)) return TBL end)
    elseif EQUALQ(DEF, 2) then 
      
      if GQ(ATT, 3) then 
        APPLY(function() ATT = 4 return ATT end)
      end

      APPLY(function() TBL = GET(DEF2_RES, SUB(ATT, 1)) return TBL end)
    elseif GQ(DEF, 2) then 
      APPLY(function() ATT = SUB(ATT, DEF) return ATT end)
      
      if LQ(ATT, -1) then 
        APPLY(function() ATT = -2 return ATT end)
      elseif GQ(ATT, 1) then 
        APPLY(function() ATT = 2 return ATT end)
      end

      APPLY(function() TBL = GET(DEF3_RES, ADD(ATT, 2)) return TBL end)
    end

    APPLY(function() RES = GET(TBL, SUB(RANDOM(9), 1)) return RES end)
    
    if OUTQ then 
      
      if EQUALQ(RES, STAGGER) then 
        APPLY(function() RES = HESITATE return RES end)
      elseif T then 
        APPLY(function() RES = SITTING_DUCK return RES end)
      end

    end

    
    if PASS(EQUALQ(RES, STAGGER) and DWEAPON and PROB(25)) then 
      APPLY(function() RES = LOSE_WEAPON return RES end)
    end

    REMARK(RANDOM_ELEMENT(GET(HERO_MELEE, SUB(RES, 1))), PRSO, PRSI)
  end


  if PASS(EQUALQ(RES, MISSED) or EQUALQ(RES, HESITATE)) then 
  elseif EQUALQ(RES, UNCONSCIOUS) then 
    APPLY(function() DEF = SUB(DEF) return DEF end)
  elseif PASS(EQUALQ(RES, KILLED) or EQUALQ(RES, SITTING_DUCK)) then 
    APPLY(function() DEF = 0 return DEF end)
  elseif EQUALQ(RES, LIGHT_WOUND) then 
    APPLY(function() DEF = SUB(DEF, 1) return DEF end)
    
    if LQ(DEF, 0) then 
      APPLY(function() DEF = 0 return DEF end)
    end

  elseif EQUALQ(RES, SERIOUS_WOUND) then 
    APPLY(function() DEF = SUB(DEF, 2) return DEF end)
    
    if LQ(DEF, 0) then 
      APPLY(function() DEF = 0 return DEF end)
    end

  elseif EQUALQ(RES, STAGGER) then 
    FSET(PRSO, STAGGERED)
  elseif T then 
    FCLEAR(DWEAPON, NDESCBIT)
    FSET(DWEAPON, WEAPONBIT)
    MOVE(DWEAPON, HERE)
    THIS_IS_IT(DWEAPON)
  end

	return   VILLAIN_RESULT(PRSO, DEF, RES)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HERO_BLOW\n'..__res) end
end
WINNER_RESULT = function(DEF, RES, OD)
	local __ok, __res = pcall(function()
  PUTP(WINNER, PQSTRENGTH, APPLY(function()
    if ZEROQ(DEF) then 
      -- 	return -10000
    elseif T then 
      	return SUB(DEF, OD)
    end
 end))

  if LQ(SUB(DEF, OD), 0) then 
    ENABLE(QUEUE(I_CURE, CURE_WAIT))
  end


  if NOT(GQ(FIGHT_STRENGTH(), 0)) then 
    PUTP(WINNER, PQSTRENGTH, ADD(1, SUB(FIGHT_STRENGTH(nil))))
    JIGS_UP("It appears that that last blow was too much for you. I'm afraid you\nare dead.")
    	return nil
  elseif T then 
    -- 	return RES
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WINNER_RESULT\n'..__res) end
end
VILLAIN_RESULT = function(VILLAIN, DEF, RES)
	local __ok, __res = pcall(function()
  PUTP(VILLAIN, PQSTRENGTH, DEF)

  if ZEROQ(DEF) then 
    FCLEAR(VILLAIN, FIGHTBIT)
    TELL("Almost as soon as the ", D, VILLAIN, " breathes his last breath, a cloud\nof sinister black fog envelops him, and when the fog lifts, the\ncarcass has disappeared.", CR)
    REMOVE_CAREFULLY(VILLAIN)
    APPLY(GETP(VILLAIN, PQACTION), F_DEAD)
    -- 	return RES
  elseif EQUALQ(RES, UNCONSCIOUS) then 
    APPLY(GETP(VILLAIN, PQACTION), F_UNCONSCIOUS)
    -- 	return RES
  elseif T then 
    -- 	return RES
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('VILLAIN_RESULT\n'..__res) end
end
WINNINGQ = function(V)
	local VS
	local PS
	local __ok, __res = pcall(function()
APPLY(function() VS = GETP(V, PQSTRENGTH) return VS end)
APPLY(function() PS = SUB(VS, FIGHT_STRENGTH()) return PS end)

  if GQ(PS, 3) then 
    	return PROB(90)
  elseif GQ(PS, 0) then 
    	return PROB(75)
  elseif ZEROQ(PS) then 
    	return PROB(50)
  elseif GQ(VS, 1) then 
    	return PROB(25)
  elseif T then 
    	return PROB(10)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WINNINGQ\n'..__res) end
end
I_CURE = function()
  local S = GETP(WINNER, PQSTRENGTH)
	local __ok, __res = pcall(function()

  if GQ(S, 0) then 
    APPLY(function() S = 0 return S end)
    PUTP(WINNER, PQSTRENGTH, S)
  elseif LQ(S, 0) then 
    APPLY(function() S = ADD(S, 1) return S end)
    PUTP(WINNER, PQSTRENGTH, S)
  end


  if LQ(S, 0) then 
    
    if LQ(LOAD_ALLOWED, LOAD_MAX) then 
      APPLY(function() LOAD_ALLOWED = ADD(LOAD_ALLOWED, 10) return LOAD_ALLOWED end)
    end

    	return ENABLE(QUEUE(I_CURE, CURE_WAIT))
  elseif T then 
    APPLY(function() LOAD_ALLOWED = LOAD_MAX return LOAD_ALLOWED end)
    	return DISABLE(INT(I_CURE))
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_CURE\n'..__res) end
end
F_WEP = 0
F_DEF = 1
HERO_MELEE = {{{"Your ",F_WEP," misses the ",F_DEF," by an inch."}
,{"A good slash, but it misses the ",F_DEF," by a mile."}
,{"You charge, but the ",F_DEF," jumps nimbly aside."}
,{"Clang! Crash! The ",F_DEF," parries."}
,{"A quick stroke, but the ",F_DEF," is on guard."}
,{"A good stroke, but it's too slow; the ",F_DEF," dodges."}
}
,{{"Your ",F_WEP," crashes down, knocking the ",F_DEF," into dreamland."}
,{"The ",F_DEF," is battered into unconsciousness."}
,{"A furious exchange, and the ",F_DEF," is knocked out!"}
,{"The haft of your ",F_WEP," knocks out the ",F_DEF,"."}
,{"The ",F_DEF," is knocked out!"}
}
,{{"It's curtains for the ",F_DEF," as your ",F_WEP," removes his head."}
,{"The fatal blow strikes the ",F_DEF," square in the heart: He dies."}
,{"The ",F_DEF," takes a fatal blow and slumps to the floor dead."}
}
,{{"The ",F_DEF," is struck on the arm; blood begins to trickle down."}
,{"Your ",F_WEP," pinks the ",F_DEF," on the wrist, but it's not serious."}
,{"Your stroke lands, but it was only the flat of the blade."}
,{"The blow lands, making a shallow gash in the ",F_DEF,"'s arm!"}
}
,{{"The ",F_DEF," receives a deep gash in his side."}
,{"A savage blow on the thigh! The ",F_DEF," is stunned but can still fight!"}
,{"Slash! Your blow lands! That one hit an artery, it could be serious!"}
,{"Slash! Your stroke connects! This could be serious!"}
}
,{{"The ",F_DEF," is staggered, and drops to his knees."}
,{"The ",F_DEF," is momentarily disoriented and can't fight back."}
,{"The force of your blow knocks the ",F_DEF," back, stunned."}
,{"The ",F_DEF," is confused and can't fight back."}
,{"The quickness of your thrust knocks the ",F_DEF," back, stunned."}
}
,{{"The ",F_DEF,"'s weapon is knocked to the floor, leaving him unarmed."}
,{"The ",F_DEF," is disarmed by a subtle feint past his guard."}
}
}

CYCLOPS_MELEE = {{{"The Cyclops misses, but the backwash almost knocks you over."}
,{"The Cyclops rushes you, but runs into the wall."}
}
,{{"The Cyclops sends you crashing to the floor, unconscious."}
}
,{{"The Cyclops breaks your neck with a massive smash."}
}
,{{"A quick punch, but it was only a glancing blow."}
,{"A glancing blow from the Cyclops' fist."}
}
,{{"The monster smashes his huge fist into your chest, breaking several\nribs."}
,{"The Cyclops almost knocks the wind out of you with a quick punch."}
}
,{{"The Cyclops lands a punch that knocks the wind out of you."}
,{"Heedless of your weapons, the Cyclops tosses you against the rock\nwall of the room."}
}
,{{"The Cyclops grabs your ",F_WEP,", tastes it, and throws it to the\nground in disgust."}
,{"The monster grabs you on the wrist, squeezes, and you drop your\n",F_WEP," in pain."}
}
,{{"The Cyclops seems unable to decide whether to broil or stew his\ndinner."}
}
,{{"The Cyclops, no sportsman, dispatches his unconscious victim."}
}
}

TROLL_MELEE = {{{"The troll swings his axe, but it misses."}
,{"The troll's axe barely misses your ear."}
,{"The axe sweeps past as you jump aside."}
,{"The axe crashes against the rock, throwing sparks!"}
}
,{{"The flat of the troll's axe hits you delicately on the head, knocking\nyou out."}
}
,{{"The troll neatly removes your head."}
,{"The troll's axe stroke cleaves you from the nave to the chops."}
,{"The troll's axe removes your head."}
}
,{{"The axe gets you right in the side. Ouch!"}
,{"The flat of the troll's axe skins across your forearm."}
,{"The troll's swing almost knocks you over as you barely parry\nin time."}
,{"The troll swings his axe, and it nicks your arm as you dodge."}
}
,{{"The troll charges, and his axe slashes you on your ",F_WEP," arm."}
,{"An axe stroke makes a deep wound in your leg."}
,{"The troll's axe swings down, gashing your shoulder."}
}
,{{"The troll hits you with a glancing blow, and you are momentarily\nstunned."}
,{"The troll swings; the blade turns on your armor but crashes\nbroadside into your head."}
,{"You stagger back under a hail of axe strokes."}
,{"The troll's mighty blow drops you to your knees."}
}
,{{"The axe hits your ",F_WEP," and knocks it spinning."}
,{"The troll swings, you parry, but the force of his blow knocks your ",F_WEP," away."}
,{"The axe knocks your ",F_WEP," out of your hand. It falls to the floor."}
}
,{{"The troll hesitates, fingering his axe."}
,{"The troll scratches his head ruminatively:  Might you be magically\nprotected, he wonders?"}
}
,{{"Conquering his fears, the troll puts you to death."}
}
}

THIEF_MELEE = {{{"The thief stabs nonchalantly with his stiletto and misses."}
,{"You dodge as the thief comes in low."}
,{"You parry a lightning thrust, and the thief salutes you with\na grim nod."}
,{"The thief tries to sneak past your guard, but you twist away."}
}
,{{"Shifting in the midst of a thrust, the thief knocks you unconscious\nwith the haft of his stiletto."}
,{"The thief knocks you out."}
}
,{{"Finishing you off, the thief inserts his blade into your heart."}
,{"The thief comes in from the side, feints, and inserts the blade\ninto your ribs."}
,{"The thief bows formally, raises his stiletto, and with a wry grin,\nends the battle and your life."}
}
,{{"A quick thrust pinks your left arm, and blood starts to\ntrickle down."}
,{"The thief draws blood, raking his stiletto across your arm."}
,{"The stiletto flashes faster than you can follow, and blood wells\nfrom your leg."}
,{"The thief slowly approaches, strikes like a snake, and leaves\nyou wounded."}
}
,{{"The thief strikes like a snake! The resulting wound is serious."}
,{"The thief stabs a deep cut in your upper arm."}
,{"The stiletto touches your forehead, and the blood obscures your\nvision."}
,{"The thief strikes at your wrist, and suddenly your grip is slippery\nwith blood."}
}
,{{"The butt of his stiletto cracks you on the skull, and you stagger\nback."}
,{"The thief rams the haft of his blade into your stomach, leaving\nyou out of breath."}
,{"The thief attacks, and you fall back desperately."}
}
,{{"A long, theatrical slash. You catch it on your ",F_WEP,", but the\nthief twists his knife, and the ",F_WEP," goes flying."}
,{"The thief neatly flips your ",F_WEP," out of your hands, and it drops\nto the floor."}
,{"You parry a low thrust, and your ",F_WEP," slips out of your hand."}
}
,{{"The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off."}
,{"The thief amuses himself by searching your pockets."}
,{"The thief entertains himself by rifling your pack."}
}
,{{"The thief, forgetting his essentially genteel upbringing, cuts your\nthroat."}
,{"The thief, a pragmatist, dispatches you as a threat to his\nlivelihood."}
}
}

V_VILLAIN = 0
V_BEST = 1
V_BEST_ADV = 2
V_PROB = 3
V_MSGS = 4
VILLAINS = {{TROLL,SWORD,1,0,TROLL_MELEE}
,{THIEF,KNIFE,1,0,THIEF_MELEE}
,{CYCLOPS,nil,0,0,CYCLOPS_MELEE}
}

I_FIGHT = function()
  local FIGHTQ = nil
  local LEN = GET(VILLAINS, 0)
	local CNT
	local OO
	local O
	local P
	local __ok, __res = pcall(function()

  if DEAD then 
    	error(false)
  end

APPLY(function() CNT = 0 return CNT end)

  APPLY(function() while true do
    APPLY(function() CNT = ADD(CNT, 1) return CNT end)
    
    if EQUALQ(CNT, LEN) then 
      return 
    end

    APPLY(function() OO = GET(VILLAINS, CNT) return OO end)
    
    if PASS(INQ(APPLY(function() O = GET(OO, V_VILLAIN) return O end), HERE) and NOT(FSETQ(O, INVISIBLE))) then 
      
      if PASS(EQUALQ(O, THIEF) and THIEF_ENGROSSED) then 
        APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
      elseif LQ(GETP(O, PQSTRENGTH), 0) then 
        APPLY(function() P = GET(OO, V_PROB) return P end)
        
        if PASS(NOT(ZEROQ(P)) and PROB(P)) then 
          PUT(OO, V_PROB, 0)
          AWAKEN(O)
        elseif T then 
          PUT(OO, V_PROB, ADD(P, 25))
        end

      elseif PASS(FSETQ(O, FIGHTBIT) or APPLY(GETP(O, PQACTION), F_FIRSTQ)) then 
        APPLY(function() FIGHTQ = T return FIGHTQ end)
      end

    elseif T then 
      
      if FSETQ(O, FIGHTBIT) then 
        APPLY(GETP(O, PQACTION), F_BUSYQ)
      end

      
      if EQUALQ(O, THIEF) then 
        APPLY(function() THIEF_ENGROSSED = nil return THIEF_ENGROSSED end)
      end

      FCLEAR(WINNER, STAGGERED)
      FCLEAR(O, STAGGERED)
      FCLEAR(O, FIGHTBIT)
      AWAKEN(O)
    end


  end end)


  if NOT(FIGHTQ) then 
    	error(false)
  end

	return   DO_FIGHT(LEN)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_FIGHT\n'..__res) end
end
AWAKEN = function(O)
  local S = GETP(O, PQSTRENGTH)
	local __ok, __res = pcall(function()

  if LQ(S, 0) then 
    PUTP(O, PQSTRENGTH, SUB(0, S))
    APPLY(GETP(O, PQACTION), F_CONSCIOUS)
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('AWAKEN\n'..__res) end
end
I_SWORD = function()
  local DEM = INT(I_SWORD)
  local G = GETP(SWORD, PQTVALUE)
  local NG = 0
	local P
	local T
	local L
	local __ok, __res = pcall(function()

  if INQ(SWORD, ADVENTURER) then 
    
    if INFESTEDQ(HERE) then 
      APPLY(function() NG = 2 return NG end)
    elseif T then 
      APPLY(function() P = 0 return P end)
      
      APPLY(function() while true do
        
        if ZEROQ(APPLY(function() P = NEXTP(HERE, P) return P end)) then 
          return 
        elseif NOT(LQ(P, LOW_DIRECTION)) then 
          APPLY(function() T = GETPT(HERE, P) return T end)
          APPLY(function() L = PTSIZE(T) return L end)
          
          if EQUALQ(L, UEXIT, CEXIT, DEXIT) then 
            
            if INFESTEDQ(GETB(T, 0)) then 
              APPLY(function() NG = 1 return NG end)
              return 
            end

          end

        end


      end end)

    end

    
    if EQUALQ(NG, G) then 
      	error(false)
    elseif EQUALQ(NG, 2) then 
      TELL("Your sword has begun to glow very brightly.", CR)
    elseif ONEQ(NG) then 
      TELL("Your sword is glowing with a faint blue glow.", CR)
    elseif ZEROQ(NG) then 
      TELL("Your sword is no longer glowing.", CR)
    end

    PUTP(SWORD, PQTVALUE, NG)
    	error(true)
  elseif T then 
    PUT(DEM, C_ENABLEDQ, 0)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_SWORD\n'..__res) end
end
INFESTEDQ = function(R)
  local F = FIRSTQ(R)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if NOT(F) then 
      	error(false)
    elseif PASS(FSETQ(F, ACTORBIT) and NOT(FSETQ(F, INVISIBLE))) then 
      	error(true)
    elseif NOT(APPLY(function() F = NEXTQ(F) return F end)) then 
      	error(false)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('INFESTEDQ\n'..__res) end
end
I_THIEF = function()
  local RM = LOC(THIEF)
	local HEREQ
  local ONCE = nil
  local FLG = nil
	local __ok, __res = pcall(function()

  do
    
    if APPLY(function() HEREQ = NOT(FSETQ(THIEF, INVISIBLE)) return HEREQ end) then 
      APPLY(function() RM = LOC(THIEF) return RM end)
    end
    
    if PASS(EQUALQ(RM, TREASURE_ROOM) and NOT(EQUALQ(RM, HERE))) then 
      
      if HEREQ then 
        HACK_TREASURES()
        APPLY(function() HEREQ = nil return HEREQ end)
      end

      DEPOSIT_BOOTY(TREASURE_ROOM)
    elseif PASS(EQUALQ(RM, HERE) and NOT(FSETQ(RM, ONBIT)) and NOT(INQ(TROLL, HERE))) then 
      
      if THIEF_VS_ADVENTURER(HEREQ) then 
        	error(true)
      end

      
      if FSETQ(THIEF, INVISIBLE) then 
        APPLY(function() HEREQ = nil return HEREQ end)
      end

    elseif T then 
      
      if PASS(INQ(THIEF, RM) and NOT(FSETQ(THIEF, INVISIBLE))) then 
        FSET(THIEF, INVISIBLE)
        APPLY(function() HEREQ = nil return HEREQ end)
      end

      
      if FSETQ(RM, TOUCHBIT) then 
        ROB(RM, THIEF, 75)
        APPLY(function() FLG = APPLY(function()
          if PASS(FSETQ(RM, MAZEBIT) and FSETQ(HERE, MAZEBIT)) then 
            	return ROB_MAZE(RM)
          elseif T then 
            	return STEAL_JUNK(RM)
          end
 end) return FLG end)
      end

    end
    
    if PASS(APPLY(function() ONCE = NOT(ONCE) return ONCE end) and NOT(HEREQ)) then 
      RECOVER_STILETTO()
      
      APPLY(function() while true do
        
        if PASS(RM and APPLY(function() RM = NEXTQ(RM) return RM end)) then 
        elseif T then 
          APPLY(function() RM = FIRSTQ(ROOMS) return RM end)
        end

        
        if PASS(NOT(FSETQ(RM, SACREDBIT)) and FSETQ(RM, RLANDBIT)) then 
          MOVE(THIEF, RM)
          FCLEAR(THIEF, FIGHTBIT)
          FSET(THIEF, INVISIBLE)
          APPLY(function() THIEF_HERE = nil return THIEF_HERE end)
          return 
        end


      end end)

      AGAIN()
    end

  end


  if NOT(EQUALQ(RM, TREASURE_ROOM)) then 
    DROP_JUNK(RM)
  end

	return FLG
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('I_THIEF\n'..__res) end
end
DROP_JUNK = function(RM)
	local X
	local N
  local FLG = nil
	local __ok, __res = pcall(function()
APPLY(function() X = FIRSTQ(THIEF) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      return FLG
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if EQUALQ(X, STILETTO, LARGE_BAG) then 
    elseif PASS(ZEROQ(GETP(X, PQTVALUE)) and PROB(30, T)) then 
      FCLEAR(X, INVISIBLE)
      MOVE(X, RM)
      
      if PASS(NOT(FLG) and EQUALQ(RM, HERE)) then 
        TELL("The robber, rummaging through his bag, dropped a few items he found\nvalueless.", CR)
        APPLY(function() FLG = T return FLG end)
      end

    end

    APPLY(function() X = N return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DROP_JUNK\n'..__res) end
end
RECOVER_STILETTO = function()
	local __ok, __res = pcall(function()

  if INQ(STILETTO, LOC(THIEF)) then 
    FSET(STILETTO, NDESCBIT)
    	return MOVE(STILETTO, THIEF)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RECOVER_STILETTO\n'..__res) end
end
STEAL_JUNK = function(RM)
	local X
	local N
	local __ok, __res = pcall(function()
APPLY(function() X = FIRSTQ(RM) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      	error(false)
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(ZEROQ(GETP(X, PQTVALUE)) and FSETQ(X, TAKEBIT) and NOT(FSETQ(X, SACREDBIT)) and NOT(FSETQ(X, INVISIBLE)) and PASS(EQUALQ(X, STILETTO) or PROB(10, T))) then 
      MOVE(X, THIEF)
      FSET(X, TOUCHBIT)
      FSET(X, INVISIBLE)
      
      if EQUALQ(X, ROPE) then 
        APPLY(function() DOME_FLAG = nil return DOME_FLAG end)
      end

      
      if EQUALQ(RM, HERE) then 
        TELL("You suddenly notice that the ", D, X, " vanished.", CR)
        	error(true)
      else 
        	error(false)
      end

    end

    APPLY(function() X = N return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STEAL_JUNK\n'..__res) end
end
ROB = function(WHAT, WHERE, PROB)
	local N
	local X
  local ROBBEDQ = nil
  PROB = PROB or nil
	local __ok, __res = pcall(function()
APPLY(function() X = FIRSTQ(WHAT) return X end)

  APPLY(function() while true do
    
    if NOT(X) then 
      return ROBBEDQ
    end

    APPLY(function() N = NEXTQ(X) return N end)
    
    if PASS(NOT(FSETQ(X, INVISIBLE)) and NOT(FSETQ(X, SACREDBIT)) and GQ(GETP(X, PQTVALUE), 0) and PASS(NOT(PROB) or PROB(PROB))) then 
      MOVE(X, WHERE)
      FSET(X, TOUCHBIT)
      
      if EQUALQ(WHERE, THIEF) then 
        FSET(X, INVISIBLE)
      end

      APPLY(function() ROBBEDQ = T return ROBBEDQ end)
    end

    APPLY(function() X = N return X end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ROB\n'..__res) end
end
V_DIAGNOSE = function()
  local MS = FIGHT_STRENGTH(nil)
  local WD = GETP(WINNER, PQSTRENGTH)
  local RS = ADD(MS, WD)
	local __ok, __res = pcall(function()

  if ZEROQ(GET(INT(I_CURE), C_ENABLEDQ)) then 
    APPLY(function() WD = 0 return WD end)
  else 
    APPLY(function() WD = SUB(WD) return WD end)
  end


  if ZEROQ(WD) then 
    TELL("You are in perfect health.")
  elseif T then 
    TELL("You have ")
    
    if ONEQ(WD) then 
      TELL("a light wound,")
    elseif EQUALQ(WD, 2) then 
      TELL("a serious wound,")
    elseif EQUALQ(WD, 3) then 
      TELL("several wounds,")
    elseif GQ(WD, 3) then 
      TELL("serious wounds,")
    end

  end


  if NOT(ZEROQ(WD)) then 
    TELL(" which will be cured after ")
    PRINTN(ADD(MULL(CURE_WAIT, SUB(WD, 1)), GET(INT(I_CURE), C_TICK)))
    TELL(" moves.")
  end

  CRLF()
  TELL("You can ")

  if ZEROQ(RS) then 
    TELL("expect death soon")
  elseif ONEQ(RS) then 
    TELL("be killed by one more light wound")
  elseif EQUALQ(RS, 2) then 
    TELL("be killed by a serious wound")
  elseif EQUALQ(RS, 3) then 
    TELL("survive one serious wound")
  elseif GQ(RS, 3) then 
    TELL("survive several wounds")
  end

  TELL(".", CR)

  if NOT(ZEROQ(DEATHS)) then 
    TELL("You have been killed ")
    
    if ONEQ(DEATHS) then 
      TELL("once")
    elseif T then 
      TELL("twice")
    end

    	return TELL(".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DIAGNOSE\n'..__res) end
end
V_SCORE = function(ASKQ)
  ASKQ = ASKQ or T
	local __ok, __res = pcall(function()
  TELL("Your score is ")
  TELL(N, SCORE)
  TELL(" (total of 350 points), in ")
  TELL(N, MOVES)

  if ONEQ(MOVES) then 
    TELL(" move.")
  else 
    TELL(" moves.")
  end

  CRLF()
  TELL("This gives you the rank of ")

  if EQUALQ(SCORE, 350) then 
    TELL("Master Adventurer")
  elseif GQ(SCORE, 330) then 
    TELL("Wizard")
  elseif GQ(SCORE, 300) then 
    TELL("Master")
  elseif GQ(SCORE, 200) then 
    TELL("Adventurer")
  elseif GQ(SCORE, 100) then 
    TELL("Junior Adventurer")
  elseif GQ(SCORE, 50) then 
    TELL("Novice Adventurer")
  elseif GQ(SCORE, 25) then 
    TELL("Amateur Adventurer")
  elseif T then 
    TELL("Beginner")
  end

  TELL(".", CR)
	return SCORE
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SCORE\n'..__res) end
end
JIGS_UP = function(DESC, PLAYERQ)
  PLAYERQ = PLAYERQ or nil
	local __ok, __res = pcall(function()
APPLY(function() WINNER = ADVENTURER return WINNER end)

  if DEAD then 
    TELL("|\nIt takes a talented person to be killed while already dead. YOU are such\na talent. Unfortunately, it takes a talented person to deal with it.\nI am not such a talent. Sorry.", CR)
    FINISH()
  end

  TELL(DESC, CR)

  if NOT(LUCKY) then 
    TELL("Bad luck, huh?", CR)
  end


  do
    SCORE_UPD(-10)    TELL("\n|    ****  You have died  ****\n|\n|")    
    if FSETQ(LOC(WINNER), VEHBIT) then 
      MOVE(WINNER, HERE)
    end
    
    if NOT(LQ(DEATHS, 2)) then 
      TELL("You clearly are a suicidal maniac.  We don't allow psychotics in the\ncave, since they may harm other adventurers.  Your remains will be\ninstalled in the Land of the Living Dead, where your fellow\nadventurers may gloat over them.", CR)
      	return FINISH()
    elseif T then 
      APPLY(function() DEATHS = ADD(DEATHS, 1) return DEATHS end)
      MOVE(WINNER, HERE)
      
      if FSETQ(SOUTH_TEMPLE, TOUCHBIT) then 
        TELL("As you take your last breath, you feel relieved of your burdens. The\nfeeling passes as you find yourself before the gates of Hell, where\nthe spirits jeer at you and deny you entry.  Your senses are\ndisturbed.  The objects in the dungeon appear indistinct, bleached of\ncolor, even unreal.", CR, CR)
        APPLY(function() DEAD = T return DEAD end)
        APPLY(function() TROLL_FLAG = T return TROLL_FLAG end)
        APPLY(function() ALWAYS_LIT = T return ALWAYS_LIT end)
        PUTP(WINNER, PQACTION, DEAD_FUNCTION)
        GOTO(ENTRANCE_TO_HADES)
      elseif T then 
        TELL("Now, let's take a look here...\nWell, you probably deserve another chance.  I can't quite fix you\nup completely, but you can't have everything.", CR, CR)
        GOTO(FOREST_1)
      end

      FCLEAR(TRAP_DOOR, TOUCHBIT)
      APPLY(function() P_CONT = nil return P_CONT end)
      RANDOMIZE_OBJECTS()
      KILL_INTERRUPTS()
      	return RFATAL()
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('JIGS_UP\n'..__res) end
end
RANDOMIZE_OBJECTS = function()
  local R = nil
	local F
	local N
	local L
	local __ok, __res = pcall(function()

  if INQ(LAMP, WINNER) then 
    MOVE(LAMP, LIVING_ROOM)
  end


  if INQ(COFFIN, WINNER) then 
    MOVE(COFFIN, EGYPT_ROOM)
  end

  PUTP(SWORD, PQTVALUE, 0)
APPLY(function() N = FIRSTQ(WINNER) return N end)
APPLY(function() L = GET(ABOVE_GROUND, 0) return L end)

  APPLY(function() while true do
    APPLY(function() F = N return F end)
    
    if NOT(F) then 
      return 
    end

    APPLY(function() N = NEXTQ(F) return N end)
    
    if GQ(GETP(F, PQTVALUE), 0) then 
      
      APPLY(function() while true do
        
        if NOT(R) then 
          APPLY(function() R = FIRSTQ(ROOMS) return R end)
        end

        
        if PASS(FSETQ(R, RLANDBIT) and NOT(FSETQ(R, ONBIT)) and PROB(50)) then 
          MOVE(F, R)
          return 
        else 
          APPLY(function() R = NEXTQ(R) return R end)
        end


      end end)

    else 
      MOVE(F, GET(ABOVE_GROUND, RANDOM(L)))
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('RANDOMIZE_OBJECTS\n'..__res) end
end
KILL_INTERRUPTS = function()
	local __ok, __res = pcall(function()
  DISABLE(INT(I_XB))
  DISABLE(INT(I_XC))
  DISABLE(INT(I_CYCLOPS))
  DISABLE(INT(I_LANTERN))
  DISABLE(INT(I_CANDLES))
  DISABLE(INT(I_SWORD))
  DISABLE(INT(I_FOREST_ROOM))
  DISABLE(INT(I_MATCH))
  FCLEAR(MATCH, ONBIT)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('KILL_INTERRUPTS\n'..__res) end
end
BAG_OF_COINS_F = function()
	local __ok, __res = pcall(function()
	return   STUPID_CONTAINER(BAG_OF_COINS, "coins")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BAG_OF_COINS_F\n'..__res) end
end
TRUNK_F = function()
	local __ok, __res = pcall(function()
	return   STUPID_CONTAINER(TRUNK, "jewels")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TRUNK_F\n'..__res) end
end
STUPID_CONTAINER = function(OBJ, STR)
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE) then 
    	return TELL("The ", STR, " are safely inside; there's no need to do that.", CR)
  elseif VERBQ(LOOK_INSIDE, EXAMINE) then 
    	return TELL("There are lots of ", STR, " in there.", CR)
  elseif PASS(VERBQ(PUT) and EQUALQ(PRSI, OBJ)) then 
    	return TELL("Don't be silly. It wouldn't be a ", D, OBJ, " anymore.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STUPID_CONTAINER\n'..__res) end
end
DUMB_CONTAINER = function()
	local __ok, __res = pcall(function()

  if VERBQ(OPEN, CLOSE, LOOK_INSIDE) then 
    	return TELL("You can't do that.", CR)
  elseif VERBQ(EXAMINE) then 
    	return TELL("It looks pretty much like a ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DUMB_CONTAINER\n'..__res) end
end
GARLIC_F = function()
	local __ok, __res = pcall(function()

  if VERBQ(EAT) then 
    REMOVE_CAREFULLY(PRSO)
    	return TELL("What the heck! You won't make friends this way, but nobody around\nhere is too friendly anyhow. Gulp!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GARLIC_F\n'..__res) end
end
CHAIN_PSEUDO = function()
	local __ok, __res = pcall(function()

  if VERBQ(TAKE, MOVE) then 
    	return TELL("The chain is secure.", CR)
  elseif VERBQ(RAISE, LOWER) then 
    	return TELL("Perhaps you should do that to the basket.", CR)
  elseif VERBQ(EXAMINE) then 
    	return TELL("The chain secures a basket within the shaft.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CHAIN_PSEUDO\n'..__res) end
end
TROLL_ROOM_F = function(RARG)
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(RARG, M_ENTER) and INQ(TROLL, HERE)) then 
    	return THIS_IS_IT(TROLL)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TROLL_ROOM_F\n'..__res) end
end
