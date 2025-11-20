
VERBOSE = nil
SUPER_BRIEF = nil
V_VERBOSE = function()
	local __ok, __res = pcall(function()
APPLY(function() VERBOSE = T return VERBOSE end)
APPLY(function() SUPER_BRIEF = nil return SUPER_BRIEF end)
	return   TELL("Maximum verbosity.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_VERBOSE\n'..__res) end
end
V_BRIEF = function()
	local __ok, __res = pcall(function()
APPLY(function() VERBOSE = nil return VERBOSE end)
APPLY(function() SUPER_BRIEF = nil return SUPER_BRIEF end)
	return   TELL("Brief descriptions.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BRIEF\n'..__res) end
end
V_SUPER_BRIEF = function()
	local __ok, __res = pcall(function()
APPLY(function() SUPER_BRIEF = T return SUPER_BRIEF end)
	return   TELL("Superbrief descriptions.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SUPER_BRIEF\n'..__res) end
end
V_INVENTORY = function()
	local __ok, __res = pcall(function()

  if FIRSTQ(WINNER) then 
    	return PRINT_CONT(WINNER)
  elseif T then 
    	return TELL("You are empty-handed.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_INVENTORY\n'..__res) end
end
FINISH = function()
	local WRD
	local __ok, __res = pcall(function()
  V_SCORE()

  APPLY(function() while true do
    CRLF()
    TELL("Would you like to restart the game from the beginning, restore a saved\ngame position, or end this session of the game?|\n(Type RESTART, RESTORE, or QUIT):|\n>")
    READ(P_INBUF, P_LEXV)
    APPLY(function() WRD = GET(P_LEXV, 1) return WRD end)
    
    if EQUALQ(WRD, WQRESTART) then 
      RESTART()
      TELL("Failed.", CR)
    elseif EQUALQ(WRD, WQRESTORE) then 
      
      if RESTORE() then 
        TELL("Ok.", CR)
      elseif T then 
        TELL("Failed.", CR)
      end

    elseif EQUALQ(WRD, WQQUIT, WQQ) then 
      QUIT()
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FINISH\n'..__res) end
end
V_QUIT = function()
	local SCOR
	local __ok, __res = pcall(function()
  V_SCORE()
  TELL("Do you wish to leave the game? (Y is affirmative): ")

  if YESQ() then 
    	return QUIT()
  else 
    	return TELL("Ok.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_QUIT\n'..__res) end
end
V_RESTART = function()
	local __ok, __res = pcall(function()
  V_SCORE(T)
  TELL("Do you wish to restart? (Y is affirmative): ")

  if YESQ() then 
    TELL("Restarting.", CR)
    RESTART()
    	return TELL("Failed.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RESTART\n'..__res) end
end
V_RESTORE = function()
	local __ok, __res = pcall(function()

  if RESTORE() then 
    TELL("Ok.", CR)
    	return V_FIRST_LOOK()
  elseif T then 
    	return TELL("Failed.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RESTORE\n'..__res) end
end
V_SAVE = function()
	local __ok, __res = pcall(function()

  if SAVE() then 
    	return TELL("Ok.", CR)
  elseif T then 
    	return TELL("Failed.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SAVE\n'..__res) end
end
V_SCRIPT = function()
	local __ok, __res = pcall(function()
  PUT(0, 8, BOR(GET(0, 8), 1))
  TELL("Here begins a transcript of interaction with", CR)
  V_VERSION()
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SCRIPT\n'..__res) end
end
V_UNSCRIPT = function()
	local __ok, __res = pcall(function()
  TELL("Here ends a transcript of interaction with", CR)
  V_VERSION()
  PUT(0, 8, BAND(GET(0, 8), -2))
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_UNSCRIPT\n'..__res) end
end
V_VERSION = function()
  local CNT = 17
	local __ok, __res = pcall(function()
  TELL("ZORK I: The Great Underground Empire|\nInfocom interactive fiction - a fantasy story|\nCopyright (c) 1981, 1982, 1983, 1984, 1985, 1986")
  TELL(" Infocom, Inc. All rights reserved.", CR)
  TELL("ZORK is a registered trademark of Infocom, Inc.|\nRelease ")
  PRINTN(BAND(GET(0, 1), 2047))
  TELL(" / Serial number ")

  APPLY(function() while true do
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), 23) then 
      return 
    elseif T then 
      PRINTC(GETB(0, CNT))
    end


  end end)

	return   CRLF()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_VERSION\n'..__res) end
end
V_VERIFY = function()
	local __ok, __res = pcall(function()
  TELL("Verifying disk...", CR)

  if VERIFY() then 
    	return TELL("The disk is correct.", CR)
  elseif T then 
    	return TELL(CR, "** Disk Failure **", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_VERIFY\n'..__res) end
end
V_COMMAND_FILE = function()
	local __ok, __res = pcall(function()
  DIRIN(1)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_COMMAND_FILE\n'..__res) end
end
V_RANDOM = function()
	local __ok, __res = pcall(function()

  if NOT(EQUALQ(PRSO, INTNUM)) then 
    	return TELL("Illegal call to #RND.", CR)
  elseif T then 
    RANDOM(SUB(0, P_NUMBER))
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RANDOM\n'..__res) end
end
V_RECORD = function()
	local __ok, __res = pcall(function()
  DIROUT(4)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RECORD\n'..__res) end
end
V_UNRECORD = function()
	local __ok, __res = pcall(function()
  DIROUT(-4)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_UNRECORD\n'..__res) end
end
V_ADVENT = function()
	local __ok, __res = pcall(function()
	return   TELL("A hollow voice says \"Fool.\"", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ADVENT\n'..__res) end
end
V_ALARM = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    
    if LQ(GETP(PRSO, PQSTRENGTH), 0) then 
      TELL("The ", D, PRSO, " is rudely awakened.", CR)
      	return AWAKEN(PRSO)
    elseif T then 
      	return TELL("He's wide awake, or haven't you noticed...", CR)
    end

  elseif T then 
    	return TELL("The ", D, PRSO, " isn't sleeping.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ALARM\n'..__res) end
end
V_ANSWER = function()
	local __ok, __res = pcall(function()
  TELL("Nobody seems to be awaiting your answer.", CR)
APPLY(function() P_CONT = nil return P_CONT end)
APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ANSWER\n'..__res) end
end
V_ATTACK = function()
	local __ok, __res = pcall(function()

  if NOT(FSETQ(PRSO, ACTORBIT)) then 
    	return TELL("I've known strange people, but fighting a ", D, PRSO, "?", CR)
  elseif PASS(NOT(PRSI) or EQUALQ(PRSI, HANDS)) then 
    	return TELL("Trying to attack a ", D, PRSO, " with your bare hands is suicidal.", CR)
  elseif NOT(INQ(PRSI, WINNER)) then 
    	return TELL("You aren't even holding the ", D, PRSI, ".", CR)
  elseif NOT(FSETQ(PRSI, WEAPONBIT)) then 
    	return TELL("Trying to attack the ", D, PRSO, " with a ", D, PRSI, " is suicidal.", CR)
  elseif T then 
    	return HERO_BLOW()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ATTACK\n'..__res) end
end
V_BACK = function()
	local __ok, __res = pcall(function()
	return   TELL("Sorry, my memory is poor. Please give a direction.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BACK\n'..__res) end
end
V_BLAST = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't blast anything by using words.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BLAST\n'..__res) end
end
PRE_BOARD = function()
	local AV
	local __ok, __res = pcall(function()
APPLY(function() AV = LOC(WINNER) return AV end)

  if NULL_F() then 
    	error(true)
  elseif FSETQ(PRSO, VEHBIT) then 
    
    if NOT(INQ(PRSO, HERE)) then 
      TELL("The ", D, PRSO, " must be on the ground to be boarded.", CR)
    elseif FSETQ(AV, VEHBIT) then 
      TELL("You are already in the ", D, AV, "!", CR)
    elseif T then 
      	error(false)
    end

  elseif EQUALQ(PRSO, WATER, GLOBAL_WATER) then 
    PERFORM(VQSWIM, PRSO)
    	error(true)
  elseif T then 
    TELL("You have a theory on how to board a ", D, PRSO, ", perhaps?", CR)
  end

	return   RFATAL()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_BOARD\n'..__res) end
end
V_BOARD = function()
	local AV
	local __ok, __res = pcall(function()
  TELL("You are now in the ", D, PRSO, ".", CR)
  MOVE(WINNER, PRSO)
  APPLY(GETP(PRSO, PQACTION), M_ENTER)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BOARD\n'..__res) end
end
V_BREATHE = function()
	local __ok, __res = pcall(function()
	return   PERFORM(VQINFLATE, PRSO, LUNGS)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BREATHE\n'..__res) end
end
V_BRUSH = function()
	local __ok, __res = pcall(function()
	return   TELL("If you wish, but heaven only knows why.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BRUSH\n'..__res) end
end
V_BUG = function()
	local __ok, __res = pcall(function()
	return   TELL("Bug? Not in a flawless program like this! (Cough, cough).", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BUG\n'..__res) end
end
TELL_NO_PRSI = function()
	local __ok, __res = pcall(function()
	return   TELL("You didn't say with what!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TELL_NO_PRSI\n'..__res) end
end
PRE_BURN = function()
	local __ok, __res = pcall(function()

  if NOT(PRSI) then 
    	return TELL_NO_PRSI()
  elseif FLAMINGQ(PRSI) then 
    	error(false)
  elseif T then 
    	return TELL("With a ", D, PRSI, "??!?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_BURN\n'..__res) end
end
V_BURN = function()
	local __ok, __res = pcall(function()

  if NULL_F() then 
    	error(false)
  elseif FSETQ(PRSO, BURNBIT) then 
    
    if PASS(INQ(PRSO, WINNER) or INQ(WINNER, PRSO)) then 
      REMOVE_CAREFULLY(PRSO)
      TELL("The ", D, PRSO)
      TELL(" catches fire. Unfortunately, you were ")
      
      if INQ(WINNER, PRSO) then 
        TELL("in")
      elseif T then 
        TELL("holding")
      end

      	return JIGS_UP(" it at the time.")
    elseif T then 
      REMOVE_CAREFULLY(PRSO)
      	return TELL("The ", D, PRSO, " catches fire and is consumed.", CR)
    end

  elseif T then 
    	return TELL("You can't burn a ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_BURN\n'..__res) end
end
V_CHOMP = function()
	local __ok, __res = pcall(function()
	return   TELL("Preposterous!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CHOMP\n'..__res) end
end
V_CLIMB_DOWN = function()
	local __ok, __res = pcall(function()
	return   V_CLIMB_UP(PQDOWN, PRSO)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CLIMB_DOWN\n'..__res) end
end
V_CLIMB_FOO = function()
	local __ok, __res = pcall(function()
	return   V_CLIMB_UP(PQUP, PRSO)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CLIMB_FOO\n'..__res) end
end
V_CLIMB_ON = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, VEHBIT) then 
    PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif T then 
    	return TELL("You can't climb onto the ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CLIMB_ON\n'..__res) end
end
V_CLIMB_UP = function(DIR, OBJ)
	local X
	local TX
  DIR = DIR or PQUP
  OBJ = OBJ or nil
	local __ok, __res = pcall(function()

  if PASS(OBJ and NOT(EQUALQ(PRSO, ROOMS))) then 
    APPLY(function() OBJ = PRSO return OBJ end)
  end


  if APPLY(function() TX = GETPT(HERE, DIR) return TX end) then 
    
    if OBJ then 
      APPLY(function() X = PTSIZE(TX) return X end)
      
      if PASS(EQUALQ(X, NEXIT) or PASS(EQUALQ(X, CEXIT, DEXIT, UEXIT) and NOT(GLOBAL_INQ(PRSO, GETB(TX, 0))))) then 
        TELL("The ", D, OBJ, " do")
        
        if NOT(EQUALQ(OBJ, STAIRS)) then 
          TELL("es")
        end

        TELL("n't lead ")
        
        if EQUALQ(DIR, PQUP) then 
          TELL("up")
        elseif T then 
          TELL("down")
        end

        TELL("ward.", CR)
        	error(true)
      end

    end

    DO_WALK(DIR)
    	error(true)
  elseif PASS(OBJ and ZMEMQ(WQWALL, APPLY(function() X = GETPT(PRSO, PQSYNONYM) return X end), PTSIZE(X))) then 
    	return TELL("Climbing the walls is to no avail.", CR)
  elseif PASS(NOT(EQUALQ(HERE, PATH)) and EQUALQ(OBJ, nil, TREE) and GLOBAL_INQ(TREE, HERE)) then 
    TELL("There are no climbable trees here.", CR)
    	error(true)
  elseif EQUALQ(OBJ, nil, ROOMS) then 
    	return TELL("You can't go that way.", CR)
  elseif T then 
    	return TELL("You can't do that!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CLIMB_UP\n'..__res) end
end
V_CLOSE = function()
	local __ok, __res = pcall(function()

  if PASS(NOT(FSETQ(PRSO, CONTBIT)) and NOT(FSETQ(PRSO, DOORBIT))) then 
    	return TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  elseif PASS(NOT(FSETQ(PRSO, SURFACEBIT)) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      FCLEAR(PRSO, OPENBIT)
      TELL("Closed.", CR)
      
      if PASS(LIT and NOT(APPLY(function() LIT = LITQ(HERE) return LIT end))) then 
        TELL("It is now pitch black.", CR)
      end

      	error(true)
    elseif T then 
      	return TELL("It is already closed.", CR)
    end

  elseif FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      FCLEAR(PRSO, OPENBIT)
      	return TELL("The ", D, PRSO, " is now closed.", CR)
    elseif T then 
      	return TELL("It is already closed.", CR)
    end

  elseif T then 
    	return TELL("You cannot close that.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CLOSE\n'..__res) end
end
V_COMMAND = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    	return TELL("The ", D, PRSO, " pays no attention.", CR)
  elseif T then 
    	return TELL("You cannot talk to that!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_COMMAND\n'..__res) end
end
V_COUNT = function()
	local __ok, __res = pcall(function()

  if EQUALQ(PRSO, BLESSINGS) then 
    	return TELL("Well, for one, you are playing Zork...", CR)
  elseif T then 
    	return TELL("You have lost your mind.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_COUNT\n'..__res) end
end
V_CROSS = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't cross that!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CROSS\n'..__res) end
end
V_CURSES = function()
	local __ok, __res = pcall(function()

  if PRSO then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	return TELL("Insults of this nature won't help you.", CR)
    elseif T then 
      	return TELL("What a loony!", CR)
    end

  elseif T then 
    	return TELL("Such language in a high-class establishment like this!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CURSES\n'..__res) end
end
V_CUT = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    	return PERFORM(VQATTACK, PRSO, PRSI)
  elseif PASS(FSETQ(PRSO, BURNBIT) and FSETQ(PRSI, WEAPONBIT)) then 
    
    if INQ(WINNER, PRSO) then 
      TELL("Not a bright idea, especially since you're in it.", CR)
      	error(true)
    end

    REMOVE_CAREFULLY(PRSO)
    	return TELL("Your skillful ", D, PRSI, "smanship slices the ", D, PRSO, " into innumerable slivers which blow away.", CR)
  elseif NOT(FSETQ(PRSI, WEAPONBIT)) then 
    	return TELL("The \"cutting edge\" of a ", D, PRSI, " is hardly adequate.", CR)
  elseif T then 
    	return TELL("Strange concept, cutting the ", D, PRSO, "....", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_CUT\n'..__res) end
end
V_DEFLATE = function()
	local __ok, __res = pcall(function()
	return   TELL("Come on, now!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DEFLATE\n'..__res) end
end
V_DIG = function()
	local __ok, __res = pcall(function()

  if NOT(PRSI) then 
    APPLY(function() PRSI = HANDS return PRSI end)
  end


  if EQUALQ(PRSI, SHOVEL) then 
    TELL("There's no reason to be digging here.", CR)
    	error(true)
  end


  if FSETQ(PRSI, TOOLBIT) then 
    	return TELL("Digging with the ", D, PRSI, " is slow and tedious.", CR)
  elseif T then 
    	return TELL("Digging with a ", D, PRSI, " is silly.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DIG\n'..__res) end
end
V_DISEMBARK = function()
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(PRSO, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) then 
    PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif NOT(EQUALQ(LOC(WINNER), PRSO)) then 
    TELL("You're not in that!", CR)
    	return RFATAL()
  elseif FSETQ(HERE, RLANDBIT) then 
    TELL("You are on your own feet again.", CR)
    	return MOVE(WINNER, HERE)
  elseif T then 
    TELL("You realize that getting out here would be fatal.", CR)
    	return RFATAL()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DISEMBARK\n'..__res) end
end
V_DISENCHANT = function()
	local __ok, __res = pcall(function()
	return   TELL("Nothing happens.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DISENCHANT\n'..__res) end
end
V_DRINK = function()
	local __ok, __res = pcall(function()
	return   V_EAT()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DRINK\n'..__res) end
end
V_DRINK_FROM = function()
	local __ok, __res = pcall(function()
	return   TELL("How peculiar!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DRINK_FROM\n'..__res) end
end
PRE_DROP = function()
	local __ok, __res = pcall(function()

  if EQUALQ(PRSO, LOC(WINNER)) then 
    PERFORM(VQDISEMBARK, PRSO)
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_DROP\n'..__res) end
end
V_DROP = function()
	local __ok, __res = pcall(function()

  if IDROP() then 
    	return TELL("Dropped.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_DROP\n'..__res) end
end
V_EAT = function()
  local EATQ = nil
  local DRINKQ = nil
  local NOBJ = nil
	local __ok, __res = pcall(function()

  if APPLY(function() EATQ = FSETQ(PRSO, FOODBIT) return EATQ end) then 
    
    if PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) then 
      TELL("You're not holding that.", CR)
    elseif VERBQ(DRINK) then 
      TELL("How can you drink that?")
    elseif T then 
      TELL("Thank you very much. It really hit the spot.")
      REMOVE_CAREFULLY(PRSO)
    end

    	return CRLF()
  elseif FSETQ(PRSO, DRINKBIT) then 
    APPLY(function() DRINKQ = T return DRINKQ end)
    APPLY(function() NOBJ = LOC(PRSO) return NOBJ end)
    
    if PASS(INQ(PRSO, GLOBAL_OBJECTS) or GLOBAL_INQ(GLOBAL_WATER, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) then 
      	return HIT_SPOT()
    elseif PASS(NOT(NOBJ) or NOT(ACCESSIBLEQ(NOBJ))) then 
      	return TELL("There isn't any water here.", CR)
    elseif PASS(ACCESSIBLEQ(NOBJ) and NOT(INQ(NOBJ, WINNER))) then 
      	return TELL("You have to be holding the ", D, NOBJ, " first.", CR)
    elseif NOT(FSETQ(NOBJ, OPENBIT)) then 
      	return TELL("You'll have to open the ", D, NOBJ, " first.", CR)
    elseif T then 
      	return HIT_SPOT()
    end

  elseif NOT(PASS(EATQ or DRINKQ)) then 
    	return TELL("I don't think that the ", D, PRSO, " would agree with you.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_EAT\n'..__res) end
end
HIT_SPOT = function()
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(PRSO, WATER) and NOT(GLOBAL_INQ(GLOBAL_WATER, HERE))) then 
    REMOVE_CAREFULLY(PRSO)
  end

	return   TELL("Thank you very much. I was rather thirsty (from all this talking,\nprobably).", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HIT_SPOT\n'..__res) end
end
V_ECHO = function()
	local LST
	local MAX
  local ECH = 0
	local CNT
	local __ok, __res = pcall(function()

  if GQ(GETB(P_LEXV, P_LEXWORDS), 0) then 
    APPLY(function() LST = REST(P_LEXV, MULL(GETB(P_LEXV, P_LEXWORDS), P_WORDLEN)) return LST end)
    APPLY(function() MAX = SUB(ADD(GETB(LST, 0), GETB(LST, 1)), 1) return MAX end)
    
    APPLY(function() while true do
      
      if GQ(APPLY(function() ECH = ADD(ECH, 1) return ECH end), 2) then 
        TELL("...", CR)
        return 
      elseif T then 
        APPLY(function() CNT = SUB(GETB(LST, 1), 1) return CNT end)
        
        APPLY(function() while true do
          
          if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), MAX) then 
            return 
          elseif T then 
            PRINTC(GETB(P_INBUF, CNT))
          end


        end end)

        TELL(" ")
      end


    end end)

  elseif T then 
    	return TELL("echo echo ...", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ECHO\n'..__res) end
end
V_ENCHANT = function()
	local __ok, __res = pcall(function()
  NULL_F()
	return   V_DISENCHANT()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ENCHANT\n'..__res) end
end
REMOVE_CAREFULLY = function(OBJ)
	local OLIT
	local __ok, __res = pcall(function()

  if EQUALQ(OBJ, P_IT_OBJECT) then 
    APPLY(function() P_IT_OBJECT = nil return P_IT_OBJECT end)
  end

APPLY(function() OLIT = LIT return OLIT end)
  REMOVE(OBJ)
APPLY(function() LIT = LITQ(HERE) return LIT end)

  if PASS(OLIT and NOT(EQUALQ(OLIT, LIT))) then 
    TELL("You are left in the dark...", CR)
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('REMOVE_CAREFULLY\n'..__res) end
end
V_ENTER = function()
	local __ok, __res = pcall(function()
	return   DO_WALK(PQIN)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ENTER\n'..__res) end
end
V_EXAMINE = function()
	local __ok, __res = pcall(function()

  if GETP(PRSO, PQTEXT) then 
    	return TELL(GETP(PRSO, PQTEXT), CR)
  elseif PASS(FSETQ(PRSO, CONTBIT) or FSETQ(PRSO, DOORBIT)) then 
    	return V_LOOK_INSIDE()
  elseif T then 
    	return TELL("There's nothing special about the ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_EXAMINE\n'..__res) end
end
V_EXIT = function()
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(PRSO, nil, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) then 
    PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif PASS(PRSO and INQ(WINNER, PRSO)) then 
    PERFORM(VQDISEMBARK, PRSO)
    	error(true)
  else 
    	return DO_WALK(PQOUT)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_EXIT\n'..__res) end
end
V_EXORCISE = function()
	local __ok, __res = pcall(function()
	return   TELL("What a bizarre concept!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_EXORCISE\n'..__res) end
end
PRE_FILL = function()
	local TX
	local __ok, __res = pcall(function()

  if NOT(PRSI) then 
    APPLY(function() TX = GETPT(HERE, PQGLOBAL) return TX end)
    
    if PASS(TX and ZMEMQB(GLOBAL_WATER, TX, SUB(PTSIZE(TX), 1))) then 
      PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif INQ(WATER, LOC(WINNER)) then 
      PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif T then 
      TELL("There is nothing to fill it with.", CR)
      	error(true)
    end

  end


  if EQUALQ(PRSI, WATER) then 
    	error(false)
  elseif NOT(EQUALQ(PRSI, GLOBAL_WATER)) then 
    PERFORM(VQPUT, PRSI, PRSO)
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_FILL\n'..__res) end
end
V_FILL = function()
	local __ok, __res = pcall(function()

  if NOT(PRSI) then 
    
    if GLOBAL_INQ(GLOBAL_WATER, HERE) then 
      PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif INQ(WATER, LOC(WINNER)) then 
      PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif T then 
      	return TELL("There's nothing to fill it with.", CR)
    end

  elseif T then 
    	return TELL("You may know how to do that, but I don't.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_FILL\n'..__res) end
end
V_FIND = function()
  local L = LOC(PRSO)
	local __ok, __res = pcall(function()

  if EQUALQ(PRSO, HANDS, LUNGS) then 
    	return TELL("Within six feet of your head, assuming you haven't left that\nsomewhere.", CR)
  elseif EQUALQ(PRSO, ME) then 
    	return TELL("You're around here somewhere...", CR)
  elseif EQUALQ(L, GLOBAL_OBJECTS) then 
    	return TELL("You find it.", CR)
  elseif INQ(PRSO, WINNER) then 
    	return TELL("You have it.", CR)
  elseif PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) then 
    	return TELL("It's right here.", CR)
  elseif FSETQ(L, ACTORBIT) then 
    	return TELL("The ", D, L, " has it.", CR)
  elseif FSETQ(L, SURFACEBIT) then 
    	return TELL("It's on the ", D, L, ".", CR)
  elseif FSETQ(L, CONTBIT) then 
    	return TELL("It's in the ", D, L, ".", CR)
  elseif T then 
    	return TELL("Beats me.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_FIND\n'..__res) end
end
V_FOLLOW = function()
	local __ok, __res = pcall(function()
	return   TELL("You're nuts!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_FOLLOW\n'..__res) end
end
V_FROBOZZ = function()
	local __ok, __res = pcall(function()
	return   TELL("The FROBOZZ Corporation created, owns, and operates this dungeon.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_FROBOZZ\n'..__res) end
end
PRE_GIVE = function()
	local __ok, __res = pcall(function()

  if NOT(HELDQ(PRSO)) then 
    	return TELL("That's easy for you to say since you don't even have the ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_GIVE\n'..__res) end
end
V_GIVE = function()
	local __ok, __res = pcall(function()

  if NOT(FSETQ(PRSI, ACTORBIT)) then 
    	return TELL("You can't give a ", D, PRSO, " to a ", D, PRSI, "!", CR)
  elseif T then 
    	return TELL("The ", D, PRSI, " refuses it politely.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_GIVE\n'..__res) end
end
V_HATCH = function()
	local __ok, __res = pcall(function()
	return   TELL("Bizarre!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_HATCH\n'..__res) end
end
HS = 0
V_HELLO = function()
	local __ok, __res = pcall(function()

  if PRSO then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	return TELL("The ", D, PRSO, " bows his head to you in greeting.", CR)
    elseif T then 
      	return TELL("It's a well known fact that only schizophrenics say \"Hello\" to a ", D, PRSO, ".", CR)
    end

  elseif T then 
    	return TELL(PICK_ONE(HELLOS), CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_HELLO\n'..__res) end
end
V_INCANT = function()
	local __ok, __res = pcall(function()
  TELL("The incantation echoes back faintly, but nothing else happens.", CR)
APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
APPLY(function() P_CONT = nil return P_CONT end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_INCANT\n'..__res) end
end
V_INFLATE = function()
	local __ok, __res = pcall(function()
	return   TELL("How can you inflate that?", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_INFLATE\n'..__res) end
end
V_KICK = function()
	local __ok, __res = pcall(function()
	return   HACK_HACK("Kicking the ")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_KICK\n'..__res) end
end
V_KISS = function()
	local __ok, __res = pcall(function()
	return   TELL("I'd sooner kiss a pig.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_KISS\n'..__res) end
end
V_KNOCK = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, DOORBIT) then 
    	return TELL("Nobody's home.", CR)
  elseif T then 
    	return TELL("Why knock on a ", D, PRSO, "?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_KNOCK\n'..__res) end
end
V_LAMP_OFF = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, LIGHTBIT) then 
    
    if NOT(FSETQ(PRSO, ONBIT)) then 
      TELL("It is already off.", CR)
    elseif T then 
      FCLEAR(PRSO, ONBIT)
      
      if LIT then 
        APPLY(function() LIT = LITQ(HERE) return LIT end)
      end

      TELL("The ", D, PRSO, " is now off.", CR)
      
      if NOT(LIT) then 
        TELL("It is now pitch black.", CR)
      end

    end

  elseif T then 
    TELL("You can't turn that off.", CR)
  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LAMP_OFF\n'..__res) end
end
V_LAMP_ON = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, LIGHTBIT) then 
    
    if FSETQ(PRSO, ONBIT) then 
      TELL("It is already on.", CR)
    elseif T then 
      FSET(PRSO, ONBIT)
      TELL("The ", D, PRSO, " is now on.", CR)
      
      if NOT(LIT) then 
        APPLY(function() LIT = LITQ(HERE) return LIT end)
        CRLF()
        V_LOOK()
      end

    end

  elseif FSETQ(PRSO, BURNBIT) then 
    TELL("If you wish to burn the ", D, PRSO, ", you should say so.", CR)
  elseif T then 
    TELL("You can't turn that on.", CR)
  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LAMP_ON\n'..__res) end
end
V_LAUNCH = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, VEHBIT) then 
    	return TELL("You can't launch that by saying \"launch\"!", CR)
  elseif T then 
    	return TELL("That's pretty weird.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LAUNCH\n'..__res) end
end
V_LEAN_ON = function()
	local __ok, __res = pcall(function()
	return   TELL("Getting tired?", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LEAN_ON\n'..__res) end
end
V_LEAP = function()
	local TX
	local S
	local __ok, __res = pcall(function()

  if PRSO then 
    
    if INQ(PRSO, HERE) then 
      
      if FSETQ(PRSO, ACTORBIT) then 
        	return TELL("The ", D, PRSO, " is too big to jump over.", CR)
      elseif T then 
        	return V_SKIP()
      end

    elseif T then 
      	return TELL("That would be a good trick.", CR)
    end

  elseif APPLY(function() TX = GETPT(HERE, PQDOWN) return TX end) then 
    APPLY(function() S = PTSIZE(TX) return S end)
    
    if PASS(EQUALQ(S, 2) or PASS(EQUALQ(S, 4) and NOT(VALUE(GETB(TX, 1))))) then 
      TELL("This was not a very safe place to try jumping.", CR)
      	return JIGS_UP(PICK_ONE(JUMPLOSS))
    elseif EQUALQ(HERE, UP_A_TREE) then 
      TELL("In a feat of unaccustomed daring, you manage to land on your feet without\nkilling yourself.", CR, CR)
      DO_WALK(PQDOWN)
      	error(true)
    elseif T then 
      	return V_SKIP()
    end

  elseif T then 
    	return V_SKIP()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LEAP\n'..__res) end
end
JUMPLOSS = LTABLE(0,"You should have looked before you leaped.","In the movies, your life would be passing before your eyes.","Geronimo...")
V_LEAVE = function()
	local __ok, __res = pcall(function()
	return   DO_WALK(PQOUT)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LEAVE\n'..__res) end
end
V_LISTEN = function()
	local __ok, __res = pcall(function()
	return   TELL("The ", D, PRSO, " makes no sound.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LISTEN\n'..__res) end
end
V_LOCK = function()
	local __ok, __res = pcall(function()
	return   TELL("It doesn't seem to work.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOCK\n'..__res) end
end
V_LOOK = function()
	local __ok, __res = pcall(function()

  if DESCRIBE_ROOM(T) then 
    	return DESCRIBE_OBJECTS(T)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOOK\n'..__res) end
end
V_LOOK_BEHIND = function()
	local __ok, __res = pcall(function()
	return   TELL("There is nothing behind the ", D, PRSO, ".", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOOK_BEHIND\n'..__res) end
end
V_LOOK_INSIDE = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      TELL("The ", D, PRSO, " is open, but I can't tell what's beyond it.")
    elseif T then 
      TELL("The ", D, PRSO, " is closed.")
    end

    	return CRLF()
  elseif FSETQ(PRSO, CONTBIT) then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	return TELL("There is nothing special to be seen.", CR)
    elseif SEE_INSIDEQ(PRSO) then 
      
      if PASS(FIRSTQ(PRSO) and PRINT_CONT(PRSO)) then 
        	error(true)
      elseif NULL_F() then 
        	error(true)
      elseif T then 
        	return TELL("The ", D, PRSO, " is empty.", CR)
      end

    elseif T then 
      	return TELL("The ", D, PRSO, " is closed.", CR)
    end

  elseif T then 
    	return TELL("You can't look inside a ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOOK_INSIDE\n'..__res) end
end
V_LOOK_ON = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, SURFACEBIT) then 
    PERFORM(VQLOOK_INSIDE, PRSO)
    	error(true)
  elseif T then 
    	return TELL("Look on a ", D, PRSO, "???", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOOK_ON\n'..__res) end
end
V_LOOK_UNDER = function()
	local __ok, __res = pcall(function()
	return   TELL("There is nothing but dust there.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOOK_UNDER\n'..__res) end
end
V_LOWER = function()
	local __ok, __res = pcall(function()
	return   HACK_HACK("Playing in this way with the ")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_LOWER\n'..__res) end
end
V_MAKE = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't do that.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_MAKE\n'..__res) end
end
V_MELT = function()
	local __ok, __res = pcall(function()
	return   TELL("It's not clear that a ", D, PRSO, " can be melted.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_MELT\n'..__res) end
end
PRE_MOVE = function()
	local __ok, __res = pcall(function()

  if HELDQ(PRSO) then 
    	return TELL("You aren't an accomplished enough juggler.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_MOVE\n'..__res) end
end
V_MOVE = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, TAKEBIT) then 
    	return TELL("Moving the ", D, PRSO, " reveals nothing.", CR)
  elseif T then 
    	return TELL("You can't move the ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_MOVE\n'..__res) end
end
V_MUMBLE = function()
	local __ok, __res = pcall(function()
	return   TELL("You'll have to speak up if you expect me to hear you!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_MUMBLE\n'..__res) end
end
PRE_MUNG = function()
	local __ok, __res = pcall(function()

  if NULL_F() then 
    	error(true)
  elseif PASS(NOT(PRSI) or NOT(FSETQ(PRSI, WEAPONBIT))) then 
    TELL("Trying to destroy the ", D, PRSO, " with ")
    
    if NOT(PRSI) then 
      TELL("your bare hands")
    elseif T then 
      TELL("a ", D, PRSI)
    end

    	return TELL(" is futile.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_MUNG\n'..__res) end
end
V_MUNG = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    PERFORM(VQATTACK, PRSO, PRSI)
    	error(true)
  elseif T then 
    	return TELL("Nice try.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_MUNG\n'..__res) end
end
V_ODYSSEUS = function()
	local __ok, __res = pcall(function()

  if PASS(EQUALQ(HERE, CYCLOPS_ROOM) and INQ(CYCLOPS, HERE) and NOT(CYCLOPS_FLAG)) then 
    DISABLE(INT(I_CYCLOPS))
    APPLY(function() CYCLOPS_FLAG = T return CYCLOPS_FLAG end)
    TELL("The cyclops, hearing the name of his father's deadly nemesis, flees the room\nby knocking down the wall on the east of the room.", CR)
    APPLY(function() MAGIC_FLAG = T return MAGIC_FLAG end)
    FCLEAR(CYCLOPS, FIGHTBIT)
    	return REMOVE_CAREFULLY(CYCLOPS)
  elseif T then 
    	return TELL("Wasn't he a sailor?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ODYSSEUS\n'..__res) end
end
V_OIL = function()
	local __ok, __res = pcall(function()
	return   TELL("You probably put spinach in your gas tank, too.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_OIL\n'..__res) end
end
V_OPEN = function()
	local F
	local STR
	local __ok, __res = pcall(function()

  if PASS(FSETQ(PRSO, CONTBIT) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	return TELL("It is already open.", CR)
    elseif T then 
      FSET(PRSO, OPENBIT)
      FSET(PRSO, TOUCHBIT)
      
      if PASS(NOT(FIRSTQ(PRSO)) or FSETQ(PRSO, TRANSBIT)) then 
        	return TELL("Opened.", CR)
      elseif PASS(APPLY(function() F = FIRSTQ(PRSO) return F end) and NOT(NEXTQ(F)) and NOT(FSETQ(F, TOUCHBIT)) and APPLY(function() STR = GETP(F, PQFDESC) return STR end)) then 
        TELL("The ", D, PRSO, " opens.", CR)
        	return TELL(STR, CR)
      elseif T then 
        TELL("Opening the ", D, PRSO, " reveals ")
        PRINT_CONTENTS(PRSO)
        	return TELL(".", CR)
      end

    end

  elseif FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	return TELL("It is already open.", CR)
    elseif T then 
      TELL("The ", D, PRSO, " opens.", CR)
      	return FSET(PRSO, OPENBIT)
    end

  elseif T then 
    	return TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_OPEN\n'..__res) end
end
V_OVERBOARD = function()
	local LOCN
	local __ok, __res = pcall(function()

  if EQUALQ(PRSI, TEETH) then 
    
    if FSETQ(APPLY(function() LOCN = LOC(WINNER) return LOCN end), VEHBIT) then 
      MOVE(PRSO, LOC(LOCN))
      	return TELL("Ahoy -- ", D, PRSO, " overboard!", CR)
    elseif T then 
      	return TELL("You're not in anything!", CR)
    end

  elseif FSETQ(LOC(WINNER), VEHBIT) then 
    PERFORM(VQTHROW, PRSO)
    	error(true)
  elseif T then 
    	return TELL("Huh?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_OVERBOARD\n'..__res) end
end
V_PICK = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't pick that.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PICK\n'..__res) end
end
V_PLAY = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    TELL("You become so engrossed in the role of the ", D, PRSO, " that\nyou kill yourself, just as he might have done!", CR)
    	return JIGS_UP("")
  else 
    	return TELL("That's silly!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PLAY\n'..__res) end
end
V_PLUG = function()
	local __ok, __res = pcall(function()
	return   TELL("This has no effect.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PLUG\n'..__res) end
end
V_POUR_ON = function()
	local __ok, __res = pcall(function()

  if EQUALQ(PRSO, WATER) then 
    REMOVE_CAREFULLY(PRSO)
    
    if FLAMINGQ(PRSI) then 
      TELL("The ", D, PRSI, " is extinguished.", CR)
      NULL_F()
      FCLEAR(PRSI, ONBIT)
      	return FCLEAR(PRSI, FLAMEBIT)
    elseif T then 
      	return TELL("The water spills over the ", D, PRSI, ", to the floor, and evaporates.", CR)
    end

  elseif EQUALQ(PRSO, PUTTY) then 
    	return PERFORM(VQPUT, PUTTY, PRSI)
  elseif T then 
    	return TELL("You can't pour that.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_POUR_ON\n'..__res) end
end
V_PRAY = function()
	local __ok, __res = pcall(function()

  if EQUALQ(HERE, SOUTH_TEMPLE) then 
    	return GOTO(FOREST_1)
  elseif T then 
    	return TELL("If you pray enough, your prayers may be answered.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PRAY\n'..__res) end
end
V_PUMP = function()
	local __ok, __res = pcall(function()

  if PASS(PRSI and NOT(EQUALQ(PRSI, PUMP))) then 
    	return TELL("Pump it up with a ", D, PRSI, "?", CR)
  elseif INQ(PUMP, WINNER) then 
    	return PERFORM(VQINFLATE, PRSO, PUMP)
  elseif T then 
    	return TELL("It's really not clear how.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUMP\n'..__res) end
end
V_PUSH = function()
	local __ok, __res = pcall(function()
	return   HACK_HACK("Pushing the ")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUSH\n'..__res) end
end
V_PUSH_TO = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't push things to that.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUSH_TO\n'..__res) end
end
PRE_PUT = function()
	local __ok, __res = pcall(function()

  if NULL_F() then 
    	error(false)
  elseif T then 
    	return PRE_GIVE()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_PUT\n'..__res) end
end
V_PUT = function()
	local __ok, __res = pcall(function()

  if PASS(FSETQ(PRSI, OPENBIT) or OPENABLEQ(PRSI) or FSETQ(PRSI, VEHBIT)) then 
  elseif T then 
    TELL("You can't do that.", CR)
    	error(true)
  end


  if NOT(FSETQ(PRSI, OPENBIT)) then 
    TELL("The ", D, PRSI, " isn't open.", CR)
    	return THIS_IS_IT(PRSI)
  elseif EQUALQ(PRSI, PRSO) then 
    	return TELL("How can you do that?", CR)
  elseif INQ(PRSO, PRSI) then 
    	return TELL("The ", D, PRSO, " is already in the ", D, PRSI, ".", CR)
  elseif GQ(SUB(ADD(WEIGHT(PRSI), WEIGHT(PRSO)), GETP(PRSI, PQSIZE)), GETP(PRSI, PQCAPACITY)) then 
    	return TELL("There's no room.", CR)
  elseif PASS(NOT(HELDQ(PRSO)) and FSETQ(PRSO, TRYTAKEBIT)) then 
    TELL("You don't have the ", D, PRSO, ".", CR)
    	error(true)
  elseif PASS(NOT(HELDQ(PRSO)) and NOT(ITAKE())) then 
    	error(true)
  elseif T then 
    MOVE(PRSO, PRSI)
    FSET(PRSO, TOUCHBIT)
    SCORE_OBJ(PRSO)
    	return TELL("Done.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUT\n'..__res) end
end
V_PUT_BEHIND = function()
	local __ok, __res = pcall(function()
	return   TELL("That hiding place is too obvious.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUT_BEHIND\n'..__res) end
end
V_PUT_ON = function()
	local __ok, __res = pcall(function()

  if EQUALQ(PRSI, GROUND) then 
    PERFORM(VQDROP, PRSO)
    	error(true)
  elseif FSETQ(PRSI, SURFACEBIT) then 
    	return V_PUT()
  elseif T then 
    	return TELL("There's no good surface on the ", D, PRSI, ".", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUT_ON\n'..__res) end
end
V_PUT_UNDER = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't do that.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_PUT_UNDER\n'..__res) end
end
V_RAISE = function()
	local __ok, __res = pcall(function()
	return   V_LOWER()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RAISE\n'..__res) end
end
V_RAPE = function()
	local __ok, __res = pcall(function()
	return   TELL("What a (ahem!) strange idea.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RAPE\n'..__res) end
end
PRE_READ = function()
	local __ok, __res = pcall(function()

  if NOT(LIT) then 
    	return TELL("It is impossible to read in the dark.", CR)
  elseif PASS(PRSI and NOT(FSETQ(PRSI, TRANSBIT))) then 
    	return TELL("How does one look through a ", D, PRSI, "?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_READ\n'..__res) end
end
V_READ = function()
	local __ok, __res = pcall(function()

  if NOT(FSETQ(PRSO, READBIT)) then 
    	return TELL("How does one read a ", D, PRSO, "?", CR)
  elseif T then 
    	return TELL(GETP(PRSO, PQTEXT), CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_READ\n'..__res) end
end
V_READ_PAGE = function()
	local __ok, __res = pcall(function()
  PERFORM(VQREAD, PRSO)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_READ_PAGE\n'..__res) end
end
V_REPENT = function()
	local __ok, __res = pcall(function()
	return   TELL("It could very well be too late!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_REPENT\n'..__res) end
end
V_REPLY = function()
	local __ok, __res = pcall(function()
  TELL("It is hardly likely that the ", D, PRSO, " is interested.", CR)
APPLY(function() P_CONT = nil return P_CONT end)
APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_REPLY\n'..__res) end
end
V_RING = function()
	local __ok, __res = pcall(function()
	return   TELL("How, exactly, can you ring that?", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RING\n'..__res) end
end
V_RUB = function()
	local __ok, __res = pcall(function()
	return   HACK_HACK("Fiddling with the ")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_RUB\n'..__res) end
end
V_SAY = function()
	local V
	local __ok, __res = pcall(function()

  if NOT(P_CONT) then 
    TELL("Say what?", CR)
    	error(true)
  end

APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)

  if APPLY(function() V = FIND_IN(HERE, ACTORBIT) return V end) then 
    TELL("You must address the ", D, V, " directly.", CR)
    APPLY(function() P_CONT = nil return P_CONT end)
  elseif NOT(EQUALQ(GET(P_LEXV, P_CONT), WQHELLO)) then 
    APPLY(function() P_CONT = nil return P_CONT end)
    TELL("Talking to yourself is a sign of impending mental collapse.", CR)
  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SAY\n'..__res) end
end
V_SEARCH = function()
	local __ok, __res = pcall(function()
	return   TELL("You find nothing unusual.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SEARCH\n'..__res) end
end
V_SEND = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    	return TELL("Why would you send for the ", D, PRSO, "?", CR)
  elseif T then 
    	return TELL("That doesn't make sends.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SEND\n'..__res) end
end
PRE_SGIVE = function()
	local __ok, __res = pcall(function()
  PERFORM(VQGIVE, PRSI, PRSO)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_SGIVE\n'..__res) end
end
V_SGIVE = function()
	local __ok, __res = pcall(function()
	return   TELL("Foo!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SGIVE\n'..__res) end
end
V_SHAKE = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    	return TELL("This seems to have no effect.", CR)
  elseif NOT(FSETQ(PRSO, TAKEBIT)) then 
    	return TELL("You can't take it; thus, you can't shake it!", CR)
  elseif FSETQ(PRSO, CONTBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      
      if FIRSTQ(PRSO) then 
        SHAKE_LOOP()
        TELL("The contents of the ", D, PRSO, " spill ")
        
        if NOT(FSETQ(HERE, RLANDBIT)) then 
          TELL("out and disappear")
        elseif T then 
          TELL("to the ground")
        end

        	return TELL(".", CR)
      elseif T then 
        	return TELL("Shaken.", CR)
      end

    elseif T then 
      
      if FIRSTQ(PRSO) then 
        	return TELL("It sounds like there is something inside the ", D, PRSO, ".", CR)
      elseif T then 
        	return TELL("The ", D, PRSO, " sounds empty.", CR)
      end

    end

  elseif T then 
    	return TELL("Shaken.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SHAKE\n'..__res) end
end
SHAKE_LOOP = function()
	local X
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if APPLY(function() X = FIRSTQ(PRSO) return X end) then 
      FSET(X, TOUCHBIT)
      MOVE(X, APPLY(function()
        if EQUALQ(HERE, UP_A_TREE) then 
          -- 	return PATH
        elseif NOT(FSETQ(HERE, RLANDBIT)) then 
          -- 	return PSEUDO_OBJECT
        elseif T then 
          -- 	return HERE
        end
 end))
    elseif T then 
      return 
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SHAKE_LOOP\n'..__res) end
end
V_SKIP = function()
	local __ok, __res = pcall(function()
	return   TELL(PICK_ONE(WHEEEEE), CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SKIP\n'..__res) end
end
WHEEEEE = LTABLE(0,"Very good. Now you can go to the second grade.","Are you enjoying yourself?","Wheeeeeeeeee!!!!!","Do you expect me to applaud?")
V_SMELL = function()
	local __ok, __res = pcall(function()
	return   TELL("It smells like a ", D, PRSO, ".", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SMELL\n'..__res) end
end
V_SPIN = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't spin that!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SPIN\n'..__res) end
end
V_SPRAY = function()
	local __ok, __res = pcall(function()
	return   V_SQUEEZE()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SPRAY\n'..__res) end
end
V_SQUEEZE = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    TELL("The ", D, PRSO, " does not understand this.")
  elseif T then 
    TELL("How singularly useless.")
  end

	return   CRLF()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SQUEEZE\n'..__res) end
end
V_SSPRAY = function()
	local __ok, __res = pcall(function()
	return   PERFORM(VQSPRAY, PRSI, PRSO)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SSPRAY\n'..__res) end
end
V_STAB = function()
	local W
	local __ok, __res = pcall(function()

  if APPLY(function() W = FIND_WEAPON(WINNER) return W end) then 
    PERFORM(VQATTACK, PRSO, W)
    	error(true)
  elseif T then 
    	return TELL("No doubt you propose to stab the ", D, PRSO, " with your pinky?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_STAB\n'..__res) end
end
V_STAND = function()
	local __ok, __res = pcall(function()

  if FSETQ(LOC(WINNER), VEHBIT) then 
    PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif T then 
    	return TELL("You are already standing, I think.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_STAND\n'..__res) end
end
V_STAY = function()
	local __ok, __res = pcall(function()
	return   TELL("You will be lost without me!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_STAY\n'..__res) end
end
V_STRIKE = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    	return TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", D, PRSO, " with a weapon.", CR)
  elseif T then 
    PERFORM(VQLAMP_ON, PRSO)
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_STRIKE\n'..__res) end
end
V_SWIM = function()
	local __ok, __res = pcall(function()

  if EQUALQ(HERE, ON_LAKE, IN_LAKE) then 
    	return TELL("What do you think you're doing?", CR)
  elseif NULL_F() then 
    	error(false)
  elseif T then 
    	return TELL("Go jump in a lake!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SWIM\n'..__res) end
end
V_SWING = function()
	local __ok, __res = pcall(function()

  if NOT(PRSI) then 
    	return TELL("Whoosh!", CR)
  elseif T then 
    	return PERFORM(VQATTACK, PRSI, PRSO)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_SWING\n'..__res) end
end
PRE_TAKE = function()
	local __ok, __res = pcall(function()

  if INQ(PRSO, WINNER) then 
    
    if FSETQ(PRSO, WEARBIT) then 
      	return TELL("You are already wearing it.", CR)
    elseif T then 
      	return TELL("You already have that!", CR)
    end

  elseif PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    TELL("You can't reach something that's inside a closed container.", CR)
    	error(true)
  elseif PRSI then 
    
    if EQUALQ(PRSI, GROUND) then 
      APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

    NULL_F()
    
    if NOT(EQUALQ(PRSI, LOC(PRSO))) then 
      	return TELL("The ", D, PRSO, " isn't in the ", D, PRSI, ".", CR)
    elseif T then 
      APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

  elseif EQUALQ(PRSO, LOC(WINNER)) then 
    	return TELL("You're inside of it!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_TAKE\n'..__res) end
end
V_TAKE = function()
	local __ok, __res = pcall(function()

  if EQUALQ(ITAKE(), T) then 
    
    if FSETQ(PRSO, WEARBIT) then 
      	return TELL("You are now wearing the ", D, PRSO, ".", CR)
    elseif T then 
      	return TELL("Taken.", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TAKE\n'..__res) end
end
V_TELL = function()
	local __ok, __res = pcall(function()

  if FSETQ(PRSO, ACTORBIT) then 
    
    if P_CONT then 
      APPLY(function() WINNER = PRSO return WINNER end)
      	return APPLY(function() HERE = LOC(WINNER) return HERE end)
    elseif T then 
      	return TELL("The ", D, PRSO, " pauses for a moment, perhaps thinking that you should reread\nthe manual.", CR)
    end

  elseif T then 
    TELL("You can't talk to the ", D, PRSO, "!", CR)
    APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    APPLY(function() P_CONT = nil return P_CONT end)
    	return RFATAL()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TELL\n'..__res) end
end
V_THROUGH = function(OBJ)
	local M
  OBJ = OBJ or nil
	local __ok, __res = pcall(function()

  if PASS(FSETQ(PRSO, DOORBIT) and APPLY(function() M = OTHER_SIDE(PRSO) return M end)) then 
    DO_WALK(M)
    	error(true)
  elseif PASS(NOT(OBJ) and FSETQ(PRSO, VEHBIT)) then 
    PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif PASS(OBJ or NOT(FSETQ(PRSO, TAKEBIT))) then 
    NULL_F()
    	return TELL("You hit your head against the ", D, PRSO, " as you attempt this feat.", CR)
  elseif INQ(PRSO, WINNER) then 
    	return TELL("That would involve quite a contortion!", CR)
  elseif T then 
    	return TELL(PICK_ONE(YUKS), CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_THROUGH\n'..__res) end
end
V_THROW = function()
	local __ok, __res = pcall(function()

  if IDROP() then 
    
    if EQUALQ(PRSI, ME) then 
      TELL("A terrific throw! The ", D, PRSO)
      APPLY(function() WINNER = PLAYER return WINNER end)
      	return JIGS_UP(" hits you squarely in the head. Normally,\nthis wouldn't do much damage, but by incredible mischance, you fall over\nbackwards trying to duck, and break your neck, justice being swift and\nmerciful in the Great Underground Empire.")
    elseif PASS(PRSI and FSETQ(PRSI, ACTORBIT)) then 
      	return TELL("The ", D, PRSI, " ducks as the ", D, PRSO, " flies by and crashes to the ground.", CR)
    elseif T then 
      	return TELL("Thrown.", CR)
    end

  else 
    	return TELL("Huh?", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_THROW\n'..__res) end
end
V_THROW_OFF = function()
	local __ok, __res = pcall(function()
	return   TELL("You can't throw anything off of that!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_THROW_OFF\n'..__res) end
end
V_TIE = function()
	local __ok, __res = pcall(function()

  if EQUALQ(PRSI, WINNER) then 
    	return TELL("You can't tie anything to yourself.", CR)
  elseif T then 
    	return TELL("You can't tie the ", D, PRSO, " to that.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TIE\n'..__res) end
end
V_TIE_UP = function()
	local __ok, __res = pcall(function()
	return   TELL("You could certainly never tie it with that!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TIE_UP\n'..__res) end
end
V_TREASURE = function()
	local __ok, __res = pcall(function()

  if EQUALQ(HERE, NORTH_TEMPLE) then 
    	return GOTO(TREASURE_ROOM)
  elseif EQUALQ(HERE, TREASURE_ROOM) then 
    	return GOTO(NORTH_TEMPLE)
  elseif T then 
    	return TELL("Nothing happens.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TREASURE\n'..__res) end
end
PRE_TURN = function()
	local __ok, __res = pcall(function()


  if PASS(EQUALQ(PRSI, nil, ROOMS) and NOT(EQUALQ(PRSO, BOOK))) then 
    	return TELL("Your bare hands don't appear to be enough.", CR)
  elseif NOT(FSETQ(PRSO, TURNBIT)) then 
    	return TELL("You can't turn that!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRE_TURN\n'..__res) end
end
V_TURN = function()
	local __ok, __res = pcall(function()
	return   TELL("This has no effect.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_TURN\n'..__res) end
end
V_UNLOCK = function()
	local __ok, __res = pcall(function()
	return   V_LOCK()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_UNLOCK\n'..__res) end
end
V_UNTIE = function()
	local __ok, __res = pcall(function()
	return   TELL("This cannot be tied, so it cannot be untied!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_UNTIE\n'..__res) end
end
V_WAIT = function(NUM)
  NUM = NUM or 3
	local __ok, __res = pcall(function()
  TELL("Time passes...", CR)

  APPLY(function() while true do
    
    if LQ(APPLY(function() NUM = SUB(NUM, 1) return NUM end), 0) then 
      return 
    elseif CLOCKER() then 
      return 
    end


  end end)

	return APPLY(function() CLOCK_WAIT = T return CLOCK_WAIT end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WAIT\n'..__res) end
end
V_WALK = function()
	local PT
	local PTS
	local STR
	local OBJ
	local RM
	local __ok, __res = pcall(function()

  if NOT(P_WALK_DIR) then 
    PERFORM(VQWALK_TO, PRSO)
    	error(true)
  elseif APPLY(function() PT = GETPT(HERE, PRSO) return PT end) then 
    
    if EQUALQ(APPLY(function() PTS = PTSIZE(PT) return PTS end), UEXIT) then 
      	return GOTO(GETB(PT, REXIT))
    elseif EQUALQ(PTS, NEXIT) then 
      TELL(GET(PT, NEXITSTR), CR)
      	return RFATAL()
    elseif EQUALQ(PTS, FEXIT) then 
      
      if APPLY(function() RM = APPLY(GET(PT, FEXITFCN)) return RM end) then 
        	return GOTO(RM)
      elseif NULL_F() then 
        	error(false)
      elseif T then 
        	return RFATAL()
      end

    elseif EQUALQ(PTS, CEXIT) then 
      
      if VALUE(GETB(PT, CEXITFLAG)) then 
        	return GOTO(GETB(PT, REXIT))
      elseif APPLY(function() STR = GET(PT, CEXITSTR) return STR end) then 
        TELL(STR, CR)
        	return RFATAL()
      elseif T then 
        TELL("You can't go that way.", CR)
        	return RFATAL()
      end

    elseif EQUALQ(PTS, DEXIT) then 
      
      if FSETQ(APPLY(function() OBJ = GETB(PT, DEXITOBJ) return OBJ end), OPENBIT) then 
        	return GOTO(GETB(PT, REXIT))
      elseif APPLY(function() STR = GET(PT, DEXITSTR) return STR end) then 
        TELL(STR, CR)
        	return RFATAL()
      elseif T then 
        TELL("The ", D, OBJ, " is closed.", CR)
        THIS_IS_IT(OBJ)
        	return RFATAL()
      end

    end

  elseif PASS(NOT(LIT) and PROB(80) and EQUALQ(WINNER, ADVENTURER) and NOT(FSETQ(HERE, NONLANDBIT))) then 
    
    if SPRAYEDQ then 
      TELL("There are odd noises in the darkness, and there is no exit in that\ndirection.", CR)
      	return RFATAL()
    elseif NULL_F() then 
      	error(false)
    elseif T then 
      	return JIGS_UP("Oh, no! You have walked into the slavering fangs of a lurking grue!")
    end

  elseif T then 
    TELL("You can't go that way.", CR)
    	return RFATAL()
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WALK\n'..__res) end
end
V_WALK_AROUND = function()
	local __ok, __res = pcall(function()
	return   TELL("Use compass directions for movement.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WALK_AROUND\n'..__res) end
end
V_WALK_TO = function()
	local __ok, __res = pcall(function()

  if PASS(PRSO and PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE))) then 
    	return TELL("It's here!", CR)
  elseif T then 
    	return TELL("You should supply a direction!", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WALK_TO\n'..__res) end
end
V_WAVE = function()
	local __ok, __res = pcall(function()
	return   HACK_HACK("Waving the ")
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WAVE\n'..__res) end
end
V_WEAR = function()
	local __ok, __res = pcall(function()

  if NOT(FSETQ(PRSO, WEARBIT)) then 
    	return TELL("You can't wear the ", D, PRSO, ".", CR)
  elseif T then 
    PERFORM(VQTAKE, PRSO)
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WEAR\n'..__res) end
end
V_WIN = function()
	local __ok, __res = pcall(function()
	return   TELL("Naturally!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WIN\n'..__res) end
end
V_WIND = function()
	local __ok, __res = pcall(function()
	return   TELL("You cannot wind up a ", D, PRSO, ".", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WIND\n'..__res) end
end
V_WISH = function()
	local __ok, __res = pcall(function()
	return   TELL("With luck, your wish will come true.", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_WISH\n'..__res) end
end
V_YELL = function()
	local __ok, __res = pcall(function()
	return   TELL("Aaaarrrrgggghhhh!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_YELL\n'..__res) end
end
V_ZORK = function()
	local __ok, __res = pcall(function()
	return   TELL("At your service!", CR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_ZORK\n'..__res) end
end
LIT = nil
SPRAYEDQ = nil
V_FIRST_LOOK = function()
	local __ok, __res = pcall(function()

  if DESCRIBE_ROOM() then 
    
    if NOT(SUPER_BRIEF) then 
      	return DESCRIBE_OBJECTS()
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('V_FIRST_LOOK\n'..__res) end
end
DESCRIBE_ROOM = function(LOOKQ)
	local VQ
	local STR
	local AV
  LOOKQ = LOOKQ or nil
	local __ok, __res = pcall(function()
APPLY(function() VQ = PASS(LOOKQ or VERBOSE) return VQ end)

  if NOT(LIT) then 
    TELL("It is pitch black.")
    
    if NOT(SPRAYEDQ) then 
      TELL(" You are likely to be eaten by a grue.")
    end

    CRLF()
    NULL_F()
    	error(false)
  end


  if NOT(FSETQ(HERE, TOUCHBIT)) then 
    FSET(HERE, TOUCHBIT)
    APPLY(function() VQ = T return VQ end)
  end


  if FSETQ(HERE, MAZEBIT) then 
    FCLEAR(HERE, TOUCHBIT)
  end


  if INQ(HERE, ROOMS) then 
    TELL(D, HERE)
    
    if FSETQ(APPLY(function() AV = LOC(WINNER) return AV end), VEHBIT) then 
      TELL(", in the ", D, AV)
    end

    CRLF()
  end


  if PASS(LOOKQ or NOT(SUPER_BRIEF)) then 
    APPLY(function() AV = LOC(WINNER) return AV end)
    
    if PASS(VQ and APPLY(GETP(HERE, PQACTION), M_LOOK)) then 
      	error(true)
    elseif PASS(VQ and APPLY(function() STR = GETP(HERE, PQLDESC) return STR end)) then 
      TELL(STR, CR)
    elseif T then 
      APPLY(GETP(HERE, PQACTION), M_FLASH)
    end

    
    if PASS(NOT(EQUALQ(HERE, AV)) and FSETQ(AV, VEHBIT)) then 
      APPLY(GETP(AV, PQACTION), M_LOOK)
    end

  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DESCRIBE_ROOM\n'..__res) end
end
DESCRIBE_OBJECTS = function(VQ)
  VQ = VQ or nil
	local __ok, __res = pcall(function()

  if LIT then 
    
    if FIRSTQ(HERE) then 
      	return PRINT_CONT(HERE, APPLY(function() VQ = PASS(VQ or VERBOSE) return VQ end), -1)
    end

  elseif T then 
    	return TELL("Only bats can see in the dark. And you're not one.", CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DESCRIBE_OBJECTS\n'..__res) end
end
DESC_OBJECT = nil
DESCRIBE_OBJECT = function(OBJ, VQ, LEVEL)
  local STR = nil
	local AV
	local __ok, __res = pcall(function()
APPLY(function() DESC_OBJECT = OBJ return DESC_OBJECT end)

  if PASS(ZEROQ(LEVEL) and APPLY(GETP(OBJ, PQDESCFCN), M_OBJDESC)) then 
    	error(true)
  elseif PASS(ZEROQ(LEVEL) and PASS(PASS(NOT(FSETQ(OBJ, TOUCHBIT)) and APPLY(function() STR = GETP(OBJ, PQFDESC) return STR end)) or APPLY(function() STR = GETP(OBJ, PQLDESC) return STR end))) then 
    TELL(STR)
  elseif ZEROQ(LEVEL) then 
    TELL("There is a ", D, OBJ, " here")
    
    if FSETQ(OBJ, ONBIT) then 
      TELL(" (providing light)")
    end

    TELL(".")
  elseif T then 
    TELL(GET(INDENTS, LEVEL))
    TELL("A ", D, OBJ)
    
    if FSETQ(OBJ, ONBIT) then 
      TELL(" (providing light)")
    elseif PASS(FSETQ(OBJ, WEARBIT) and INQ(OBJ, WINNER)) then 
      TELL(" (being worn)")
    end

  end

  NULL_F()

  if PASS(ZEROQ(LEVEL) and APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) then 
    TELL(" (outside the ", D, AV, ")")
  end

  CRLF()

  if PASS(SEE_INSIDEQ(OBJ) and FIRSTQ(OBJ)) then 
    	return PRINT_CONT(OBJ, VQ, LEVEL)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DESCRIBE_OBJECT\n'..__res) end
end
PRINT_CONTENTS = function(OBJ)
	local F
	local N
  local bSTQ = T
  local ITQ = nil
  local TWOQ = nil
	local __ok, __res = pcall(function()

  if APPLY(function() F = FIRSTQ(OBJ) return F end) then 
    
    APPLY(function() while true do
      APPLY(function() N = NEXTQ(F) return N end)
      
      if bSTQ then 
        APPLY(function() bSTQ = nil return bSTQ end)
      else 
        TELL(", ")
        
        if NOT(N) then 
          TELL("and ")
        end

      end

      TELL("a ", D, F)
      
      if PASS(NOT(ITQ) and NOT(TWOQ)) then 
        APPLY(function() ITQ = F return ITQ end)
      else 
        APPLY(function() TWOQ = T return TWOQ end)
        APPLY(function() ITQ = nil return ITQ end)
      end

      APPLY(function() F = N return F end)
      
      if NOT(F) then 
        
        if PASS(ITQ and NOT(TWOQ)) then 
          THIS_IS_IT(ITQ)
        end

        	error(true)
      end


    end end)

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRINT_CONTENTS\n'..__res) end
end
PRINT_CONT = function(OBJ, VQ, LEVEL)
	local Y
	local bSTQ
	local SHIT
	local AV
	local STR
  local PVQ = nil
  local INVQ = nil
  VQ = VQ or nil
  LEVEL = LEVEL or 0
	local __ok, __res = pcall(function()

  if NOT(APPLY(function() Y = FIRSTQ(OBJ) return Y end)) then 
    	error(true)
  end


  if PASS(APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) then 
    -- T
  else 
    APPLY(function() AV = nil return AV end)
  end

APPLY(function() bSTQ = T return bSTQ end)
APPLY(function() SHIT = T return SHIT end)

  if EQUALQ(WINNER, OBJ, LOC(OBJ)) then 
    APPLY(function() INVQ = T return INVQ end)
  else 
    
    APPLY(function() while true do
      
      if NOT(Y) then 
        return 
      elseif EQUALQ(Y, AV) then 
        APPLY(function() PVQ = T return PVQ end)
      elseif EQUALQ(Y, WINNER) then 
      elseif PASS(NOT(FSETQ(Y, INVISIBLE)) and NOT(FSETQ(Y, TOUCHBIT)) and APPLY(function() STR = GETP(Y, PQFDESC) return STR end)) then 
        
        if NOT(FSETQ(Y, NDESCBIT)) then 
          TELL(STR, CR)
          APPLY(function() SHIT = nil return SHIT end)
        end

        
        if PASS(SEE_INSIDEQ(Y) and NOT(GETP(LOC(Y), PQDESCFCN)) and FIRSTQ(Y)) then 
          
          if PRINT_CONT(Y, VQ, 0) then 
            APPLY(function() bSTQ = nil return bSTQ end)
          end

        end

      end

      APPLY(function() Y = NEXTQ(Y) return Y end)

    end end)

  end

APPLY(function() Y = FIRSTQ(OBJ) return Y end)

  APPLY(function() while true do
    
    if NOT(Y) then 
      
      if PASS(PVQ and AV and FIRSTQ(AV)) then 
        APPLY(function() LEVEL = ADD(LEVEL, 1) return LEVEL end)
        PRINT_CONT(AV, VQ, LEVEL)
      end

      return 
    elseif EQUALQ(Y, AV, ADVENTURER) then 
    elseif PASS(NOT(FSETQ(Y, INVISIBLE)) and PASS(INVQ or FSETQ(Y, TOUCHBIT) or NOT(GETP(Y, PQFDESC)))) then 
      
      if NOT(FSETQ(Y, NDESCBIT)) then 
        
        if bSTQ then 
          
          if FIRSTER(OBJ, LEVEL) then 
            
            if LQ(LEVEL, 0) then 
              APPLY(function() LEVEL = 0 return LEVEL end)
            end

          end

          APPLY(function() LEVEL = ADD(1, LEVEL) return LEVEL end)
          APPLY(function() bSTQ = nil return bSTQ end)
        end

        
        if LQ(LEVEL, 0) then 
          APPLY(function() LEVEL = 0 return LEVEL end)
        end

        DESCRIBE_OBJECT(Y, VQ, LEVEL)
      elseif PASS(FIRSTQ(Y) and SEE_INSIDEQ(Y)) then 
        APPLY(function() LEVEL = ADD(LEVEL, 1) return LEVEL end)
        PRINT_CONT(Y, VQ, LEVEL)
        APPLY(function() LEVEL = SUB(LEVEL, 1) return LEVEL end)
      end

    end

    APPLY(function() Y = NEXTQ(Y) return Y end)

  end end)


  if PASS(bSTQ and SHIT) then 
    	error(false)
  elseif T then 
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PRINT_CONT\n'..__res) end
end
FIRSTER = function(OBJ, LEVEL)
	local __ok, __res = pcall(function()

  if EQUALQ(OBJ, TROPHY_CASE) then 
    	return TELL("Your collection of treasures consists of:", CR)
  elseif EQUALQ(OBJ, WINNER) then 
    	return TELL("You are carrying:", CR)
  elseif NOT(INQ(OBJ, ROOMS)) then 
    
    if GQ(LEVEL, 0) then 
      TELL(GET(INDENTS, LEVEL))
    end

    
    if FSETQ(OBJ, SURFACEBIT) then 
      	return TELL("Sitting on the ", D, OBJ, " is: ", CR)
    elseif FSETQ(OBJ, ACTORBIT) then 
      	return TELL("The ", D, OBJ, " is holding: ", CR)
    elseif T then 
      	return TELL("The ", D, OBJ, " contains:", CR)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIRSTER\n'..__res) end
end
SEE_INSIDEQ = function(OBJ)
	local __ok, __res = pcall(function()
	return   PASS(NOT(FSETQ(OBJ, INVISIBLE)) and PASS(FSETQ(OBJ, TRANSBIT) or FSETQ(OBJ, OPENBIT)))
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SEE_INSIDEQ\n'..__res) end
end
MOVES = 0
SCORE = 0
BASE_SCORE = 0
WON_FLAG = nil
SCORE_UPD = function(NUM)
	local __ok, __res = pcall(function()
APPLY(function() BASE_SCORE = ADD(BASE_SCORE, NUM) return BASE_SCORE end)
APPLY(function() SCORE = ADD(SCORE, NUM) return SCORE end)

  if PASS(EQUALQ(SCORE, 350) and NOT(WON_FLAG)) then 
    APPLY(function() WON_FLAG = T return WON_FLAG end)
    FCLEAR(MAP, INVISIBLE)
    FCLEAR(WEST_OF_HOUSE, TOUCHBIT)
    TELL("An almost inaudible voice whispers in your ear, \"Look to your treasures\nfor the final secret.\"", CR)
  end

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SCORE_UPD\n'..__res) end
end
SCORE_OBJ = function(OBJ)
	local TEMP
	local __ok, __res = pcall(function()

  if GQ(APPLY(function() TEMP = GETP(OBJ, PQVALUE) return TEMP end), 0) then 
    SCORE_UPD(TEMP)
    	return PUTP(OBJ, PQVALUE, 0)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SCORE_OBJ\n'..__res) end
end
YESQ = function()
	local __ok, __res = pcall(function()
  PRINTI(">")
  READ(P_INBUF, P_LEXV)

  if EQUALQ(GET(P_LEXV, 1), WQYES, WQY) then 
    	error(true)
  elseif T then 
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('YESQ\n'..__res) end
end
DEAD = nil
DEATHS = 0
LUCKY = 1
FUMBLE_NUMBER = 7
FUMBLE_PROB = 8
ITAKE = function(VB)
	local CNT
	local OBJ
  VB = VB or T
	local __ok, __res = pcall(function()

  if DEAD then 
    
    if VB then 
      TELL("Your hand passes through its object.", CR)
    end

    	error(false)
  elseif NOT(FSETQ(PRSO, TAKEBIT)) then 
    
    if VB then 
      TELL(PICK_ONE(YUKS), CR)
    end

    	error(false)
  elseif NULL_F() then 
    	error(false)
  elseif PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    	error(false)
  elseif PASS(NOT(INQ(LOC(PRSO), WINNER)) and GQ(ADD(WEIGHT(PRSO), WEIGHT(WINNER)), LOAD_ALLOWED)) then 
    
    if VB then 
      TELL("Your load is too heavy")
      
      if LQ(LOAD_ALLOWED, LOAD_MAX) then 
        TELL(", especially in light of your condition.")
      elseif T then 
        TELL(".")
      end

      CRLF()
    end

    	return RFATAL()
  elseif PASS(VERBQ(TAKE) and GQ(APPLY(function() CNT = CCOUNT(WINNER) return CNT end), FUMBLE_NUMBER) and PROB(MULL(CNT, FUMBLE_PROB))) then 
    TELL("You're holding too many things already!", CR)
    	error(false)
  elseif T then 
    MOVE(PRSO, WINNER)
    FCLEAR(PRSO, NDESCBIT)
    FSET(PRSO, TOUCHBIT)
    NULL_F()
    NULL_F()
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ITAKE\n'..__res) end
end
IDROP = function()
	local __ok, __res = pcall(function()

  if PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) then 
    TELL("You're not carrying the ", D, PRSO, ".", CR)
    	error(false)
  elseif PASS(NOT(INQ(PRSO, WINNER)) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    TELL("The ", D, PRSO, " is closed.", CR)
    	error(false)
  elseif T then 
    MOVE(PRSO, LOC(WINNER))
    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('IDROP\n'..__res) end
end
CCOUNT = function(OBJ)
  local CNT = 0
	local X
	local __ok, __res = pcall(function()

  if APPLY(function() X = FIRSTQ(OBJ) return X end) then 
    
    APPLY(function() while true do
      
      if NOT(FSETQ(X, WEARBIT)) then 
        APPLY(function() CNT = ADD(CNT, 1) return CNT end)
      end

      
      if NOT(APPLY(function() X = NEXTQ(X) return X end)) then 
        return 
      end


    end end)

  end

	return CNT
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CCOUNT\n'..__res) end
end
WEIGHT = function(OBJ)
	local CONT
  local WT = 0
	local __ok, __res = pcall(function()

  if APPLY(function() CONT = FIRSTQ(OBJ) return CONT end) then 
    
    APPLY(function() while true do
      
      if PASS(EQUALQ(OBJ, PLAYER) and FSETQ(CONT, WEARBIT)) then 
        APPLY(function() WT = ADD(WT, 1) return WT end)
      elseif T then 
        APPLY(function() WT = ADD(WT, WEIGHT(CONT)) return WT end)
      end

      
      if NOT(APPLY(function() CONT = NEXTQ(CONT) return CONT end)) then 
        return 
      end


    end end)

  end

	return   ADD(WT, GETP(OBJ, PQSIZE))
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WEIGHT\n'..__res) end
end
REXIT = 0
UEXIT = 1
NEXIT = 2
FEXIT = 3
CEXIT = 4
DEXIT = 5
NEXITSTR = 0
FEXITFCN = 0
CEXITFLAG = 1
CEXITSTR = 1
DEXITOBJ = 1
DEXITSTR = 1
INDENTS = LTABLE("","  ","    ","      ","        ","          ")
HACK_HACK = function(STR)
	local __ok, __res = pcall(function()

  if PASS(INQ(PRSO, GLOBAL_OBJECTS) and VERBQ(WAVE, RAISE, LOWER)) then 
    	return TELL("The ", D, PRSO, " isn't here!", CR)
  elseif T then 
    	return TELL(STR, D, PRSO, PICK_ONE(HO_HUM), CR)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HACK_HACK\n'..__res) end
end
HO_HUM = LTABLE(0," doesn't seem to work."," isn't notably helpful."," has no effect.")
NO_GO_TELL = function(AV, WLOC)
	local __ok, __res = pcall(function()

  if AV then 
    TELL("You can't go there in a ", D, WLOC, ".")
  elseif T then 
    TELL("You can't go there without a vehicle.")
  end

	return   CRLF()
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('NO_GO_TELL\n'..__res) end
end
GOTO = function(RM, VQ)
  local LB = FSETQ(RM, RLANDBIT)
  local WLOC = LOC(WINNER)
  local AV = nil
	local OLIT
	local OHERE
  VQ = VQ or T
	local __ok, __res = pcall(function()
APPLY(function() OLIT = LIT return OLIT end)
APPLY(function() OHERE = HERE return OHERE end)

  if FSETQ(WLOC, VEHBIT) then 
    APPLY(function() AV = GETP(WLOC, PQVTYPE) return AV end)
  end


  if PASS(NOT(LB) and NOT(AV)) then 
    NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif PASS(NOT(LB) and NOT(FSETQ(RM, AV))) then 
    NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif PASS(FSETQ(HERE, RLANDBIT) and LB and AV and NOT(EQUALQ(AV, RLANDBIT)) and NOT(FSETQ(RM, AV))) then 
    NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif FSETQ(RM, RMUNGBIT) then 
    TELL(GETP(RM, PQLDESC), CR)
    	error(false)
  elseif T then 
    
    if PASS(LB and NOT(FSETQ(HERE, RLANDBIT)) and NOT(DEAD) and FSETQ(WLOC, VEHBIT)) then 
      TELL("The ", D, WLOC, " comes to a rest on the shore.", CR, CR)
    end

    
    if AV then 
      MOVE(WLOC, RM)
    elseif T then 
      MOVE(WINNER, RM)
    end

    APPLY(function() HERE = RM return HERE end)
    APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if PASS(NOT(OLIT) and NOT(LIT) and PROB(80)) then 
      
      if SPRAYEDQ then 
        TELL("There are sinister gurgling noises in the darkness all around you!", CR)
      elseif NULL_F() then 
        	error(false)
      elseif T then 
        TELL("Oh, no! A lurking grue slithered into the ")
        
        if FSETQ(LOC(WINNER), VEHBIT) then 
          TELL(D, LOC(WINNER))
        elseif T then 
          TELL("room")
        end

        JIGS_UP(" and devoured you!")
        	error(true)
      end

    end

    
    if PASS(NOT(LIT) and EQUALQ(WINNER, ADVENTURER)) then 
      TELL("You have moved into a dark place.", CR)
      APPLY(function() P_CONT = nil return P_CONT end)
    end

    APPLY(GETP(HERE, PQACTION), M_ENTER)
    SCORE_OBJ(RM)
    
    if NOT(EQUALQ(HERE, RM)) then 
      	error(true)
    elseif PASS(NOT(EQUALQ(ADVENTURER, WINNER)) and INQ(ADVENTURER, OHERE)) then 
      TELL("The ", D, WINNER, " leaves the room.", CR)
    elseif PASS(EQUALQ(HERE, OHERE) and EQUALQ(HERE, ENTRANCE_TO_HADES)) then 
      	error(true)
    elseif PASS(VQ and EQUALQ(WINNER, ADVENTURER)) then 
      V_FIRST_LOOK()
    end

    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GOTO\n'..__res) end
end
LKP = function(ITM, TBL)
  local CNT = 0
  local LEN = GET(TBL, 0)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), LEN) then 
      	error(false)
    elseif EQUALQ(GET(TBL, CNT), ITM) then 
      
      if EQUALQ(CNT, LEN) then 
        	error(false)
      elseif T then 
        return GET(TBL, ADD(CNT, 1))
      end

    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LKP\n'..__res) end
end
DO_WALK = function(DIR)
	local __ok, __res = pcall(function()
APPLY(function() P_WALK_DIR = DIR return P_WALK_DIR end)
	return   PERFORM(VQWALK, DIR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DO_WALK\n'..__res) end
end
GLOBAL_INQ = function(OBJ1, OBJ2)
	local TX
	local __ok, __res = pcall(function()

  if APPLY(function() TX = GETPT(OBJ2, PQGLOBAL) return TX end) then 
    	return ZMEMQB(OBJ1, TX, SUB(PTSIZE(TX), 1))
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GLOBAL_INQ\n'..__res) end
end
FIND_IN = function(WHERE, WHAT)
	local W
	local __ok, __res = pcall(function()
APPLY(function() W = FIRSTQ(WHERE) return W end)

  if NOT(W) then 
    	error(false)
  end


  APPLY(function() while true do
    
    if PASS(FSETQ(W, WHAT) and NOT(EQUALQ(W, ADVENTURER))) then 
      return W
    elseif NOT(APPLY(function() W = NEXTQ(W) return W end)) then 
      return nil
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('FIND_IN\n'..__res) end
end
HELDQ = function(CAN)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    APPLY(function() CAN = LOC(CAN) return CAN end)
    
    if NOT(CAN) then 
      	error(false)
    elseif EQUALQ(CAN, WINNER) then 
      	error(true)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('HELDQ\n'..__res) end
end
OTHER_SIDE = function(DOBJ)
  local P = 0
	local TX
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if LQ(APPLY(function() P = NEXTP(HERE, P) return P end), LOW_DIRECTION) then 
      return nil
    else 
      APPLY(function() TX = GETPT(HERE, P) return TX end)
      
      if PASS(EQUALQ(PTSIZE(TX), DEXIT) and EQUALQ(GETB(TX, DEXITOBJ), DOBJ)) then 
        return P
      end

    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('OTHER_SIDE\n'..__res) end
end
MUNG_ROOM = function(RM, STR)
	local __ok, __res = pcall(function()

  FSET(RM, RMUNGBIT)
	return   PUTP(RM, PQLDESC, STR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MUNG_ROOM\n'..__res) end
end
THIS_IS_IT = function(OBJ)
	local __ok, __res = pcall(function()
	return APPLY(function() P_IT_OBJECT = OBJ return P_IT_OBJECT end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('THIS_IS_IT\n'..__res) end
end

if   NEQUALQ(ZORK_NUMBER, 3) then 
  SWIMYUKS = LTABLE(0,"You can't swim in the dungeon.")

end
HELLOS = LTABLE(0,"Hello.","Good day.","Nice weather we've been having lately.","Goodbye.")
YUKS = LTABLE(0,"A valiant attempt.","You can't be serious.","An interesting idea...","What a concept!")
DUMMY = LTABLE(0,"Look around.","Too late for that.","Have your eyes checked.")
