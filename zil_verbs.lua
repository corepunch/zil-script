
VERBOSE = nil
SUPER_BRIEF = nil
V_VERBOSE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() VERBOSE = T return VERBOSE end)
	__tmp = APPLY(function() SUPER_BRIEF = nil return SUPER_BRIEF end)
	__tmp =   TELL("Maximum verbosity.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_VERBOSE\n'..__res) end
end
V_BRIEF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() VERBOSE = nil return VERBOSE end)
	__tmp = APPLY(function() SUPER_BRIEF = nil return SUPER_BRIEF end)
	__tmp =   TELL("Brief descriptions.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BRIEF\n'..__res) end
end
V_SUPER_BRIEF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() SUPER_BRIEF = T return SUPER_BRIEF end)
	__tmp =   TELL("Superbrief descriptions.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SUPER_BRIEF\n'..__res) end
end
V_INVENTORY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FIRSTQ(WINNER) then 
    	__tmp = PRINT_CONT(WINNER)
  elseif T then 
    	__tmp = TELL("You are empty-handed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_INVENTORY\n'..__res) end
end
FINISH = function(...)
	local WRD
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE()

  local __prog28 = function()
    CRLF()
    TELL("Would you like to restart the game from the beginning, restore a saved game position, or end this session of the game?| (Type RESTART, RESTORE, or QUIT):| >")
    READ(P_INBUF, P_LEXV)
    APPLY(function() WRD = GET(P_LEXV, 1) return WRD end)
    
    if EQUALQ(WRD, WQRESTART) then 
      	__tmp = RESTART()
      	__tmp = TELL("Failed.", CR)
    elseif EQUALQ(WRD, WQRESTORE) then 
      
      if RESTORE() then 
        	__tmp = TELL("Ok.", CR)
      elseif T then 
        	__tmp = TELL("Failed.", CR)
      end

    elseif EQUALQ(WRD, WQQUIT, WQQ) then 
      	__tmp = QUIT()
    end


error(123) end
local __ok28, __res28
repeat __ok28, __res28 = pcall(__prog28)
until __ok28 or __res28 ~= 123
if not __ok28 then error(__res28)
else __tmp = __res28 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FINISH\n'..__res) end
end
V_QUIT = function(...)
	local SCOR
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE()
	__tmp =   TELL("Do you wish to leave the game? (Y is affirmative): ")

  if YESQ() then 
    	__tmp = QUIT()
  else 
    	__tmp = TELL("Ok.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_QUIT\n'..__res) end
end
V_RESTART = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE(T)
	__tmp =   TELL("Do you wish to restart? (Y is affirmative): ")

  if YESQ() then 
    	__tmp = TELL("Restarting.", CR)
    	__tmp = RESTART()
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RESTART\n'..__res) end
end
V_RESTORE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if RESTORE() then 
    	__tmp = TELL("Ok.", CR)
    	__tmp = V_FIRST_LOOK()
  elseif T then 
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RESTORE\n'..__res) end
end
V_SAVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if SAVE() then 
    	__tmp = TELL("Ok.", CR)
  elseif T then 
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SAVE\n'..__res) end
end
V_SCRIPT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUT(0, 8, BOR(GET(0, 8), 1))
	__tmp =   TELL("Here begins a transcript of interaction with", CR)
	__tmp =   V_VERSION()
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SCRIPT\n'..__res) end
end
V_UNSCRIPT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Here ends a transcript of interaction with", CR)
	__tmp =   V_VERSION()
	__tmp =   PUT(0, 8, BAND(GET(0, 8), -2))
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNSCRIPT\n'..__res) end
end
V_VERSION = function(...)
  local CNT = 17
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("ZORK I: The Great Underground Empire| Infocom interactive fiction - a fantasy story| Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986")
	__tmp =   TELL(" Infocom, Inc. All rights reserved.", CR)
	__tmp =   TELL("ZORK is a registered trademark of Infocom, Inc.| Release ")
	__tmp =   PRINTN(BAND(GET(0, 1), 2047))
	__tmp =   TELL(" / Serial number ")

  local __prog29 = function()
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), 23) then 
      return true
    elseif T then 
      	__tmp = PRINTC(GETB(0, CNT))
    end


error(123) end
local __ok29, __res29
repeat __ok29, __res29 = pcall(__prog29)
until __ok29 or __res29 ~= 123
if not __ok29 then error(__res29)
else __tmp = __res29 or true end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_VERSION\n'..__res) end
end
V_VERIFY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Verifying disk...", CR)

  if VERIFY() then 
    	__tmp = TELL("The disk is correct.", CR)
  elseif T then 
    	__tmp = TELL(CR, "** Disk Failure **", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_VERIFY\n'..__res) end
end
V_COMMAND_FILE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DIRIN(1)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_COMMAND_FILE\n'..__res) end
end
V_RANDOM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(EQUALQ(PRSO, INTNUM)) then 
    	__tmp = TELL("Illegal call to #RND.", CR)
  elseif T then 
    	__tmp = RANDOM(SUB(0, P_NUMBER))
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RANDOM\n'..__res) end
end
V_RECORD = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DIROUT(4)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RECORD\n'..__res) end
end
V_UNRECORD = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DIROUT(-4)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNRECORD\n'..__res) end
end
V_ADVENT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("A hollow voice says \"Fool.\"", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ADVENT\n'..__res) end
end
V_ALARM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    
    if LQ(GETP(PRSO, PQSTRENGTH), 0) then 
      	__tmp = TELL("The ", D, PRSO, " is rudely awakened.", CR)
      	__tmp = AWAKEN(PRSO)
    elseif T then 
      	__tmp = TELL("He's wide awake, or haven't you noticed...", CR)
    end

  elseif T then 
    	__tmp = TELL("The ", D, PRSO, " isn't sleeping.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ALARM\n'..__res) end
end
V_ANSWER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Nobody seems to be awaiting your answer.", CR)
	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ANSWER\n'..__res) end
end
V_ATTACK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FSETQ(PRSO, ACTORBIT)) then 
    	__tmp = TELL("I've known strange people, but fighting a ", D, PRSO, "?", CR)
  elseif PASS(NOT(PRSI) or EQUALQ(PRSI, HANDS)) then 
    	__tmp = TELL("Trying to attack a ", D, PRSO, " with your bare hands is suicidal.", CR)
  elseif NOT(INQ(PRSI, WINNER)) then 
    	__tmp = TELL("You aren't even holding the ", D, PRSI, ".", CR)
  elseif NOT(FSETQ(PRSI, WEAPONBIT)) then 
    	__tmp = TELL("Trying to attack the ", D, PRSO, " with a ", D, PRSI, " is suicidal.", CR)
  elseif T then 
    	__tmp = HERO_BLOW()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ATTACK\n'..__res) end
end
V_BACK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Sorry, my memory is poor. Please give a direction.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BACK\n'..__res) end
end
V_BLAST = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't blast anything by using words.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BLAST\n'..__res) end
end
PRE_BOARD = function(...)
	local AV
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() AV = LOC(WINNER) return AV end)

  if NULL_F() then 
    	error(true)
  elseif FSETQ(PRSO, VEHBIT) then 
    
    if NOT(INQ(PRSO, HERE)) then 
      	__tmp = TELL("The ", D, PRSO, " must be on the ground to be boarded.", CR)
    elseif FSETQ(AV, VEHBIT) then 
      	__tmp = TELL("You are already in the ", D, AV, "!", CR)
    elseif T then 
      	error(false)
    end

  elseif EQUALQ(PRSO, WATER, GLOBAL_WATER) then 
    	__tmp = PERFORM(VQSWIM, PRSO)
    	error(true)
  elseif T then 
    	__tmp = TELL("You have a theory on how to board a ", D, PRSO, ", perhaps?", CR)
  end

	__tmp = 	error(2)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_BOARD\n'..__res) end
end
V_BOARD = function(...)
	local AV
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You are now in the ", D, PRSO, ".", CR)
	__tmp =   MOVE(WINNER, PRSO)
	__tmp =   APPLY(GETP(PRSO, PQACTION), M_ENTER)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BOARD\n'..__res) end
end
V_BREATHE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQINFLATE, PRSO, LUNGS)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BREATHE\n'..__res) end
end
V_BRUSH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("If you wish, but heaven only knows why.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BRUSH\n'..__res) end
end
V_BUG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Bug? Not in a flawless program like this! (Cough, cough).", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BUG\n'..__res) end
end
TELL_NO_PRSI = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You didn't say with what!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TELL_NO_PRSI\n'..__res) end
end
PRE_BURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(PRSI) then 
    	__tmp = TELL_NO_PRSI()
  elseif FLAMINGQ(PRSI) then 
    	error(false)
  elseif T then 
    	__tmp = TELL("With a ", D, PRSI, "??!?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_BURN\n'..__res) end
end
V_BURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NULL_F() then 
    	error(false)
  elseif FSETQ(PRSO, BURNBIT) then 
    
    if PASS(INQ(PRSO, WINNER) or INQ(WINNER, PRSO)) then 
      	__tmp = REMOVE_CAREFULLY(PRSO)
      	__tmp = TELL("The ", D, PRSO)
      	__tmp = TELL(" catches fire. Unfortunately, you were ")
      
      if INQ(WINNER, PRSO) then 
        	__tmp = TELL("in")
      elseif T then 
        	__tmp = TELL("holding")
      end

      	__tmp = JIGS_UP(" it at the time.")
    elseif T then 
      	__tmp = REMOVE_CAREFULLY(PRSO)
      	__tmp = TELL("The ", D, PRSO, " catches fire and is consumed.", CR)
    end

  elseif T then 
    	__tmp = TELL("You can't burn a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BURN\n'..__res) end
end
V_CHOMP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Preposterous!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CHOMP\n'..__res) end
end
V_CLIMB_DOWN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_CLIMB_UP(PQDOWN, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_DOWN\n'..__res) end
end
V_CLIMB_FOO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_CLIMB_UP(PQUP, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_FOO\n'..__res) end
end
V_CLIMB_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, VEHBIT) then 
    	__tmp = PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif T then 
    	__tmp = TELL("You can't climb onto the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_ON\n'..__res) end
end
V_CLIMB_UP = function(...)
	local DIR, OBJ = ...
	local X
	local TX
	if select('#', ...) < 1 then DIR = PQUP end
	if select('#', ...) < 2 then OBJ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(OBJ and NOT(EQUALQ(PRSO, ROOMS))) then 
    	__tmp = APPLY(function() OBJ = PRSO return OBJ end)
  end


  if APPLY(function() TX = GETPT(HERE, DIR) return TX end) then 
    
    if OBJ then 
      	__tmp = APPLY(function() X = PTSIZE(TX) return X end)
      
      if PASS(EQUALQ(X, NEXIT) or PASS(EQUALQ(X, CEXIT, DEXIT, UEXIT) and NOT(GLOBAL_INQ(PRSO, GETB(TX, 0))))) then 
        	__tmp = TELL("The ", D, OBJ, " do")
        
        if NOT(EQUALQ(OBJ, STAIRS)) then 
          	__tmp = TELL("es")
        end

        	__tmp = TELL("n't lead ")
        
        if EQUALQ(DIR, PQUP) then 
          	__tmp = TELL("up")
        elseif T then 
          	__tmp = TELL("down")
        end

        	__tmp = TELL("ward.", CR)
        	error(true)
      end

    end

    	__tmp = DO_WALK(DIR)
    	error(true)
  elseif PASS(OBJ and ZMEMQ(WQWALL, APPLY(function() X = GETPT(PRSO, PQSYNONYM) return X end), PTSIZE(X))) then 
    	__tmp = TELL("Climbing the walls is to no avail.", CR)
  elseif PASS(NOT(EQUALQ(HERE, PATH)) and EQUALQ(OBJ, nil, TREE) and GLOBAL_INQ(TREE, HERE)) then 
    	__tmp = TELL("There are no climbable trees here.", CR)
    	error(true)
  elseif EQUALQ(OBJ, nil, ROOMS) then 
    	__tmp = TELL("You can't go that way.", CR)
  elseif T then 
    	__tmp = TELL("You can't do that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_UP\n'..__res) end
end
V_CLOSE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(FSETQ(PRSO, CONTBIT)) and NOT(FSETQ(PRSO, DOORBIT))) then 
    	__tmp = TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  elseif PASS(NOT(FSETQ(PRSO, SURFACEBIT)) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = FCLEAR(PRSO, OPENBIT)
      	__tmp = TELL("Closed.", CR)
      
      if PASS(LIT and NOT(APPLY(function() LIT = LITQ(HERE) return LIT end))) then 
        	__tmp = TELL("It is now pitch black.", CR)
      end

      	error(true)
    elseif T then 
      	__tmp = TELL("It is already closed.", CR)
    end

  elseif FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = FCLEAR(PRSO, OPENBIT)
      	__tmp = TELL("The ", D, PRSO, " is now closed.", CR)
    elseif T then 
      	__tmp = TELL("It is already closed.", CR)
    end

  elseif T then 
    	__tmp = TELL("You cannot close that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLOSE\n'..__res) end
end
V_COMMAND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("The ", D, PRSO, " pays no attention.", CR)
  elseif T then 
    	__tmp = TELL("You cannot talk to that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_COMMAND\n'..__res) end
end
V_COUNT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSO, BLESSINGS) then 
    	__tmp = TELL("Well, for one, you are playing Zork...", CR)
  elseif T then 
    	__tmp = TELL("You have lost your mind.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_COUNT\n'..__res) end
end
V_CROSS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't cross that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CROSS\n'..__res) end
end
V_CURSES = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PRSO then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	__tmp = TELL("Insults of this nature won't help you.", CR)
    elseif T then 
      	__tmp = TELL("What a loony!", CR)
    end

  elseif T then 
    	__tmp = TELL("Such language in a high-class establishment like this!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CURSES\n'..__res) end
end
V_CUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = PERFORM(VQATTACK, PRSO, PRSI)
  elseif PASS(FSETQ(PRSO, BURNBIT) and FSETQ(PRSI, WEAPONBIT)) then 
    
    if INQ(WINNER, PRSO) then 
      	__tmp = TELL("Not a bright idea, especially since you're in it.", CR)
      	error(true)
    end

    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = TELL("Your skillful ", D, PRSI, "smanship slices the ", D, PRSO, " into innumerable slivers which blow away.", CR)
  elseif NOT(FSETQ(PRSI, WEAPONBIT)) then 
    	__tmp = TELL("The \"cutting edge\" of a ", D, PRSI, " is hardly adequate.", CR)
  elseif T then 
    	__tmp = TELL("Strange concept, cutting the ", D, PRSO, "....", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CUT\n'..__res) end
end
V_DEFLATE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Come on, now!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DEFLATE\n'..__res) end
end
V_DIG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(PRSI) then 
    	__tmp = APPLY(function() PRSI = HANDS return PRSI end)
  end


  if EQUALQ(PRSI, SHOVEL) then 
    	__tmp = TELL("There's no reason to be digging here.", CR)
    	error(true)
  end


  if FSETQ(PRSI, TOOLBIT) then 
    	__tmp = TELL("Digging with the ", D, PRSI, " is slow and tedious.", CR)
  elseif T then 
    	__tmp = TELL("Digging with a ", D, PRSI, " is silly.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DIG\n'..__res) end
end
V_DISEMBARK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(PRSO, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif NOT(EQUALQ(LOC(WINNER), PRSO)) then 
    	__tmp = TELL("You're not in that!", CR)
    	__tmp = 	error(2)
  elseif FSETQ(HERE, RLANDBIT) then 
    	__tmp = TELL("You are on your own feet again.", CR)
    	__tmp = MOVE(WINNER, HERE)
  elseif T then 
    	__tmp = TELL("You realize that getting out here would be fatal.", CR)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DISEMBARK\n'..__res) end
end
V_DISENCHANT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Nothing happens.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DISENCHANT\n'..__res) end
end
V_DRINK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_EAT()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DRINK\n'..__res) end
end
V_DRINK_FROM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How peculiar!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DRINK_FROM\n'..__res) end
end
PRE_DROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSO, LOC(WINNER)) then 
    	__tmp = PERFORM(VQDISEMBARK, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_DROP\n'..__res) end
end
V_DROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if IDROP() then 
    	__tmp = TELL("Dropped.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DROP\n'..__res) end
end
V_EAT = function(...)
  local EATQ = nil
  local DRINKQ = nil
  local NOBJ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() EATQ = FSETQ(PRSO, FOODBIT) return EATQ end) then 
    
    if PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) then 
      	__tmp = TELL("You're not holding that.", CR)
    elseif VERBQ(DRINK) then 
      	__tmp = TELL("How can you drink that?")
    elseif T then 
      	__tmp = TELL("Thank you very much. It really hit the spot.")
      	__tmp = REMOVE_CAREFULLY(PRSO)
    end

    	__tmp = CRLF()
  elseif FSETQ(PRSO, DRINKBIT) then 
    	__tmp = APPLY(function() DRINKQ = T return DRINKQ end)
    	__tmp = APPLY(function() NOBJ = LOC(PRSO) return NOBJ end)
    
    if PASS(INQ(PRSO, GLOBAL_OBJECTS) or GLOBAL_INQ(GLOBAL_WATER, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) then 
      	__tmp = HIT_SPOT()
    elseif PASS(NOT(NOBJ) or NOT(ACCESSIBLEQ(NOBJ))) then 
      	__tmp = TELL("There isn't any water here.", CR)
    elseif PASS(ACCESSIBLEQ(NOBJ) and NOT(INQ(NOBJ, WINNER))) then 
      	__tmp = TELL("You have to be holding the ", D, NOBJ, " first.", CR)
    elseif NOT(FSETQ(NOBJ, OPENBIT)) then 
      	__tmp = TELL("You'll have to open the ", D, NOBJ, " first.", CR)
    elseif T then 
      	__tmp = HIT_SPOT()
    end

  elseif NOT(PASS(EATQ or DRINKQ)) then 
    	__tmp = TELL("I don't think that the ", D, PRSO, " would agree with you.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EAT\n'..__res) end
end
HIT_SPOT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(PRSO, WATER) and NOT(GLOBAL_INQ(GLOBAL_WATER, HERE))) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
  end

	__tmp =   TELL("Thank you very much. I was rather thirsty (from all this talking, probably).", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HIT_SPOT\n'..__res) end
end
V_ECHO = function(...)
	local LST
	local MAX
  local ECH = 0
	local CNT
	local __ok, __res = pcall(function()
	local __tmp = nil

  if GQ(GETB(P_LEXV, P_LEXWORDS), 0) then 
    	__tmp = APPLY(function() LST = REST(P_LEXV, MULL(GETB(P_LEXV, P_LEXWORDS), P_WORDLEN)) return LST end)
    	__tmp = APPLY(function() MAX = SUB(ADD(GETB(LST, 0), GETB(LST, 1)), 1) return MAX end)
    
    local __prog30 = function()
      
      if GQ(APPLY(function() ECH = ADD(ECH, 1) return ECH end), 2) then 
        	__tmp = TELL("...", CR)
        return true
      elseif T then 
        	__tmp = APPLY(function() CNT = SUB(GETB(LST, 1), 1) return CNT end)
        
        local __prog31 = function()
          
          if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), MAX) then 
            return true
          elseif T then 
            	__tmp = PRINTC(GETB(P_INBUF, CNT))
          end


error(123) end
local __ok31, __res31
repeat __ok31, __res31 = pcall(__prog31)
until __ok31 or __res31 ~= 123
if not __ok31 then error(__res31)
else __tmp = __res31 or true end

        	__tmp = TELL(" ")
      end


error(123) end
local __ok30, __res30
repeat __ok30, __res30 = pcall(__prog30)
until __ok30 or __res30 ~= 123
if not __ok30 then error(__res30)
else __tmp = __res30 or true end

  elseif T then 
    	__tmp = TELL("echo echo ...", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ECHO\n'..__res) end
end
V_ENCHANT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   NULL_F()
	__tmp =   V_DISENCHANT()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ENCHANT\n'..__res) end
end
REMOVE_CAREFULLY = function(...)
	local OBJ = ...
	local OLIT
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(OBJ, P_IT_OBJECT) then 
    	__tmp = APPLY(function() P_IT_OBJECT = nil return P_IT_OBJECT end)
  end

	__tmp = APPLY(function() OLIT = LIT return OLIT end)
	__tmp =   REMOVE(OBJ)
	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)

  if PASS(OLIT and NOT(EQUALQ(OLIT, LIT))) then 
    	__tmp = TELL("You are left in the dark...", CR)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('REMOVE_CAREFULLY\n'..__res) end
end
V_ENTER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DO_WALK(PQIN)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ENTER\n'..__res) end
end
V_EXAMINE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if GETP(PRSO, PQTEXT) then 
    	__tmp = TELL(GETP(PRSO, PQTEXT), CR)
  elseif PASS(FSETQ(PRSO, CONTBIT) or FSETQ(PRSO, DOORBIT)) then 
    	__tmp = V_LOOK_INSIDE()
  elseif T then 
    	__tmp = TELL("There's nothing special about the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EXAMINE\n'..__res) end
end
V_EXIT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(PRSO, nil, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif PASS(PRSO and INQ(WINNER, PRSO)) then 
    	__tmp = PERFORM(VQDISEMBARK, PRSO)
    	error(true)
  else 
    	__tmp = DO_WALK(PQOUT)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EXIT\n'..__res) end
end
V_EXORCISE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("What a bizarre concept!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EXORCISE\n'..__res) end
end
PRE_FILL = function(...)
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(PRSI) then 
    	__tmp = APPLY(function() TX = GETPT(HERE, PQGLOBAL) return TX end)
    
    if PASS(TX and ZMEMQB(GLOBAL_WATER, TX, SUB(PTSIZE(TX), 1))) then 
      	__tmp = PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif INQ(WATER, LOC(WINNER)) then 
      	__tmp = PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif T then 
      	__tmp = TELL("There is nothing to fill it with.", CR)
      	error(true)
    end

  end


  if EQUALQ(PRSI, WATER) then 
    	error(false)
  elseif NOT(EQUALQ(PRSI, GLOBAL_WATER)) then 
    	__tmp = PERFORM(VQPUT, PRSI, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_FILL\n'..__res) end
end
V_FILL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(PRSI) then 
    
    if GLOBAL_INQ(GLOBAL_WATER, HERE) then 
      	__tmp = PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif INQ(WATER, LOC(WINNER)) then 
      	__tmp = PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif T then 
      	__tmp = TELL("There's nothing to fill it with.", CR)
    end

  elseif T then 
    	__tmp = TELL("You may know how to do that, but I don't.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FILL\n'..__res) end
end
V_FIND = function(...)
  local L = LOC(PRSO)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSO, HANDS, LUNGS) then 
    	__tmp = TELL("Within six feet of your head, assuming you haven't left that somewhere.", CR)
  elseif EQUALQ(PRSO, ME) then 
    	__tmp = TELL("You're around here somewhere...", CR)
  elseif EQUALQ(L, GLOBAL_OBJECTS) then 
    	__tmp = TELL("You find it.", CR)
  elseif INQ(PRSO, WINNER) then 
    	__tmp = TELL("You have it.", CR)
  elseif PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) then 
    	__tmp = TELL("It's right here.", CR)
  elseif FSETQ(L, ACTORBIT) then 
    	__tmp = TELL("The ", D, L, " has it.", CR)
  elseif FSETQ(L, SURFACEBIT) then 
    	__tmp = TELL("It's on the ", D, L, ".", CR)
  elseif FSETQ(L, CONTBIT) then 
    	__tmp = TELL("It's in the ", D, L, ".", CR)
  elseif T then 
    	__tmp = TELL("Beats me.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FIND\n'..__res) end
end
V_FOLLOW = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You're nuts!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FOLLOW\n'..__res) end
end
V_FROBOZZ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The FROBOZZ Corporation created, owns, and operates this dungeon.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FROBOZZ\n'..__res) end
end
PRE_GIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(HELDQ(PRSO)) then 
    	__tmp = TELL("That's easy for you to say since you don't even have the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_GIVE\n'..__res) end
end
V_GIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FSETQ(PRSI, ACTORBIT)) then 
    	__tmp = TELL("You can't give a ", D, PRSO, " to a ", D, PRSI, "!", CR)
  elseif T then 
    	__tmp = TELL("The ", D, PRSI, " refuses it politely.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_GIVE\n'..__res) end
end
V_HATCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Bizarre!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_HATCH\n'..__res) end
end
HS = 0
V_HELLO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PRSO then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	__tmp = TELL("The ", D, PRSO, " bows his head to you in greeting.", CR)
    elseif T then 
      	__tmp = TELL("It's a well known fact that only schizophrenics say \"Hello\" to a ", D, PRSO, ".", CR)
    end

  elseif T then 
    	__tmp = TELL(PICK_ONE(HELLOS), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_HELLO\n'..__res) end
end
V_INCANT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The incantation echoes back faintly, but nothing else happens.", CR)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_INCANT\n'..__res) end
end
V_INFLATE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How can you inflate that?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_INFLATE\n'..__res) end
end
V_KICK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Kicking the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KICK\n'..__res) end
end
V_KISS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("I'd sooner kiss a pig.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KISS\n'..__res) end
end
V_KNOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, DOORBIT) then 
    	__tmp = TELL("Nobody's home.", CR)
  elseif T then 
    	__tmp = TELL("Why knock on a ", D, PRSO, "?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KNOCK\n'..__res) end
end
V_LAMP_OFF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, LIGHTBIT) then 
    
    if NOT(FSETQ(PRSO, ONBIT)) then 
      	__tmp = TELL("It is already off.", CR)
    elseif T then 
      	__tmp = FCLEAR(PRSO, ONBIT)
      
      if LIT then 
        	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
      end

      	__tmp = TELL("The ", D, PRSO, " is now off.", CR)
      
      if NOT(LIT) then 
        	__tmp = TELL("It is now pitch black.", CR)
      end

    end

  elseif T then 
    	__tmp = TELL("You can't turn that off.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAMP_OFF\n'..__res) end
end
V_LAMP_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, LIGHTBIT) then 
    
    if FSETQ(PRSO, ONBIT) then 
      	__tmp = TELL("It is already on.", CR)
    elseif T then 
      	__tmp = FSET(PRSO, ONBIT)
      	__tmp = TELL("The ", D, PRSO, " is now on.", CR)
      
      if NOT(LIT) then 
        	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
        	__tmp = CRLF()
        	__tmp = V_LOOK()
      end

    end

  elseif FSETQ(PRSO, BURNBIT) then 
    	__tmp = TELL("If you wish to burn the ", D, PRSO, ", you should say so.", CR)
  elseif T then 
    	__tmp = TELL("You can't turn that on.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAMP_ON\n'..__res) end
end
V_LAUNCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, VEHBIT) then 
    	__tmp = TELL("You can't launch that by saying \"launch\"!", CR)
  elseif T then 
    	__tmp = TELL("That's pretty weird.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAUNCH\n'..__res) end
end
V_LEAN_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Getting tired?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LEAN_ON\n'..__res) end
end
V_LEAP = function(...)
	local TX
	local S
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PRSO then 
    
    if INQ(PRSO, HERE) then 
      
      if FSETQ(PRSO, ACTORBIT) then 
        	__tmp = TELL("The ", D, PRSO, " is too big to jump over.", CR)
      elseif T then 
        	__tmp = V_SKIP()
      end

    elseif T then 
      	__tmp = TELL("That would be a good trick.", CR)
    end

  elseif APPLY(function() TX = GETPT(HERE, PQDOWN) return TX end) then 
    	__tmp = APPLY(function() S = PTSIZE(TX) return S end)
    
    if PASS(EQUALQ(S, 2) or PASS(EQUALQ(S, 4) and NOT(VALUE(GETB(TX, 1))))) then 
      	__tmp = TELL("This was not a very safe place to try jumping.", CR)
      	__tmp = JIGS_UP(PICK_ONE(JUMPLOSS))
    elseif EQUALQ(HERE, UP_A_TREE) then 
      	__tmp = TELL("In a feat of unaccustomed daring, you manage to land on your feet without killing yourself.", CR, CR)
      	__tmp = DO_WALK(PQDOWN)
      	error(true)
    elseif T then 
      	__tmp = V_SKIP()
    end

  elseif T then 
    	__tmp = V_SKIP()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LEAP\n'..__res) end
end
JUMPLOSS = LTABLE(0,"You should have looked before you leaped.","In the movies, your life would be passing before your eyes.","Geronimo...")
V_LEAVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DO_WALK(PQOUT)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LEAVE\n'..__res) end
end
V_LISTEN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The ", D, PRSO, " makes no sound.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LISTEN\n'..__res) end
end
V_LOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It doesn't seem to work.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOCK\n'..__res) end
end
V_LOOK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if DESCRIBE_ROOM(T) then 
    	__tmp = DESCRIBE_OBJECTS(T)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK\n'..__res) end
end
V_LOOK_BEHIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("There is nothing behind the ", D, PRSO, ".", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_BEHIND\n'..__res) end
end
V_LOOK_INSIDE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = TELL("The ", D, PRSO, " is open, but I can't tell what's beyond it.")
    elseif T then 
      	__tmp = TELL("The ", D, PRSO, " is closed.")
    end

    	__tmp = CRLF()
  elseif FSETQ(PRSO, CONTBIT) then 
    
    if FSETQ(PRSO, ACTORBIT) then 
      	__tmp = TELL("There is nothing special to be seen.", CR)
    elseif SEE_INSIDEQ(PRSO) then 
      
      if PASS(FIRSTQ(PRSO) and PRINT_CONT(PRSO)) then 
        	error(true)
      elseif NULL_F() then 
        	error(true)
      elseif T then 
        	__tmp = TELL("The ", D, PRSO, " is empty.", CR)
      end

    elseif T then 
      	__tmp = TELL("The ", D, PRSO, " is closed.", CR)
    end

  elseif T then 
    	__tmp = TELL("You can't look inside a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_INSIDE\n'..__res) end
end
V_LOOK_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, SURFACEBIT) then 
    	__tmp = PERFORM(VQLOOK_INSIDE, PRSO)
    	error(true)
  elseif T then 
    	__tmp = TELL("Look on a ", D, PRSO, "???", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_ON\n'..__res) end
end
V_LOOK_UNDER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("There is nothing but dust there.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_UNDER\n'..__res) end
end
V_LOWER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Playing in this way with the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOWER\n'..__res) end
end
V_MAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't do that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MAKE\n'..__res) end
end
V_MELT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It's not clear that a ", D, PRSO, " can be melted.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MELT\n'..__res) end
end
PRE_MOVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if HELDQ(PRSO) then 
    	__tmp = TELL("You aren't an accomplished enough juggler.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_MOVE\n'..__res) end
end
V_MOVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, TAKEBIT) then 
    	__tmp = TELL("Moving the ", D, PRSO, " reveals nothing.", CR)
  elseif T then 
    	__tmp = TELL("You can't move the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MOVE\n'..__res) end
end
V_MUMBLE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You'll have to speak up if you expect me to hear you!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MUMBLE\n'..__res) end
end
PRE_MUNG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NULL_F() then 
    	error(true)
  elseif PASS(NOT(PRSI) or NOT(FSETQ(PRSI, WEAPONBIT))) then 
    	__tmp = TELL("Trying to destroy the ", D, PRSO, " with ")
    
    if NOT(PRSI) then 
      	__tmp = TELL("your bare hands")
    elseif T then 
      	__tmp = TELL("a ", D, PRSI)
    end

    	__tmp = TELL(" is futile.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_MUNG\n'..__res) end
end
V_MUNG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = PERFORM(VQATTACK, PRSO, PRSI)
    	error(true)
  elseif T then 
    	__tmp = TELL("Nice try.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MUNG\n'..__res) end
end
V_ODYSSEUS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(EQUALQ(HERE, CYCLOPS_ROOM) and INQ(CYCLOPS, HERE) and NOT(CYCLOPS_FLAG)) then 
    	__tmp = DISABLE(INT(I_CYCLOPS))
    	__tmp = APPLY(function() CYCLOPS_FLAG = T return CYCLOPS_FLAG end)
    	__tmp = TELL("The cyclops, hearing the name of his father's deadly nemesis, flees the room by knocking down the wall on the east of the room.", CR)
    	__tmp = APPLY(function() MAGIC_FLAG = T return MAGIC_FLAG end)
    	__tmp = FCLEAR(CYCLOPS, FIGHTBIT)
    	__tmp = REMOVE_CAREFULLY(CYCLOPS)
  elseif T then 
    	__tmp = TELL("Wasn't he a sailor?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ODYSSEUS\n'..__res) end
end
V_OIL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You probably put spinach in your gas tank, too.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OIL\n'..__res) end
end
V_OPEN = function(...)
	local F
	local STR
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(FSETQ(PRSO, CONTBIT) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = TELL("It is already open.", CR)
    elseif T then 
      	__tmp = FSET(PRSO, OPENBIT)
      	__tmp = FSET(PRSO, TOUCHBIT)
      
      if PASS(NOT(FIRSTQ(PRSO)) or FSETQ(PRSO, TRANSBIT)) then 
        	__tmp = TELL("Opened.", CR)
      elseif PASS(APPLY(function() F = FIRSTQ(PRSO) return F end) and NOT(NEXTQ(F)) and NOT(FSETQ(F, TOUCHBIT)) and APPLY(function() STR = GETP(F, PQFDESC) return STR end)) then 
        	__tmp = TELL("The ", D, PRSO, " opens.", CR)
        	__tmp = TELL(STR, CR)
      elseif T then 
        	__tmp = TELL("Opening the ", D, PRSO, " reveals ")
        	__tmp = PRINT_CONTENTS(PRSO)
        	__tmp = TELL(".", CR)
      end

    end

  elseif FSETQ(PRSO, DOORBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      	__tmp = TELL("It is already open.", CR)
    elseif T then 
      	__tmp = TELL("The ", D, PRSO, " opens.", CR)
      	__tmp = FSET(PRSO, OPENBIT)
    end

  elseif T then 
    	__tmp = TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OPEN\n'..__res) end
end
V_OVERBOARD = function(...)
	local LOCN
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSI, TEETH) then 
    
    if FSETQ(APPLY(function() LOCN = LOC(WINNER) return LOCN end), VEHBIT) then 
      	__tmp = MOVE(PRSO, LOC(LOCN))
      	__tmp = TELL("Ahoy -- ", D, PRSO, " overboard!", CR)
    elseif T then 
      	__tmp = TELL("You're not in anything!", CR)
    end

  elseif FSETQ(LOC(WINNER), VEHBIT) then 
    	__tmp = PERFORM(VQTHROW, PRSO)
    	error(true)
  elseif T then 
    	__tmp = TELL("Huh?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OVERBOARD\n'..__res) end
end
V_PICK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't pick that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PICK\n'..__res) end
end
V_PLAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("You become so engrossed in the role of the ", D, PRSO, " that you kill yourself, just as he might have done!", CR)
    	__tmp = JIGS_UP("")
  else 
    	__tmp = TELL("That's silly!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PLAY\n'..__res) end
end
V_PLUG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This has no effect.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PLUG\n'..__res) end
end
V_POUR_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSO, WATER) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    
    if FLAMINGQ(PRSI) then 
      	__tmp = TELL("The ", D, PRSI, " is extinguished.", CR)
      	__tmp = NULL_F()
      	__tmp = FCLEAR(PRSI, ONBIT)
      	__tmp = FCLEAR(PRSI, FLAMEBIT)
    elseif T then 
      	__tmp = TELL("The water spills over the ", D, PRSI, ", to the floor, and evaporates.", CR)
    end

  elseif EQUALQ(PRSO, PUTTY) then 
    	__tmp = PERFORM(VQPUT, PUTTY, PRSI)
  elseif T then 
    	__tmp = TELL("You can't pour that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_POUR_ON\n'..__res) end
end
V_PRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(HERE, SOUTH_TEMPLE) then 
    	__tmp = GOTO(FOREST_1)
  elseif T then 
    	__tmp = TELL("If you pray enough, your prayers may be answered.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PRAY\n'..__res) end
end
V_PUMP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(PRSI and NOT(EQUALQ(PRSI, PUMP))) then 
    	__tmp = TELL("Pump it up with a ", D, PRSI, "?", CR)
  elseif INQ(PUMP, WINNER) then 
    	__tmp = PERFORM(VQINFLATE, PRSO, PUMP)
  elseif T then 
    	__tmp = TELL("It's really not clear how.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUMP\n'..__res) end
end
V_PUSH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Pushing the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUSH\n'..__res) end
end
V_PUSH_TO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't push things to that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUSH_TO\n'..__res) end
end
PRE_PUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NULL_F() then 
    	error(false)
  elseif T then 
    	__tmp = PRE_GIVE()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_PUT\n'..__res) end
end
V_PUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(FSETQ(PRSI, OPENBIT) or OPENABLEQ(PRSI) or FSETQ(PRSI, VEHBIT)) then 
    	__tmp = PASS(FSETQ(PRSI, OPENBIT) or OPENABLEQ(PRSI) or FSETQ(PRSI, VEHBIT))
  elseif T then 
    	__tmp = TELL("You can't do that.", CR)
    	error(true)
  end


  if NOT(FSETQ(PRSI, OPENBIT)) then 
    	__tmp = TELL("The ", D, PRSI, " isn't open.", CR)
    	__tmp = THIS_IS_IT(PRSI)
  elseif EQUALQ(PRSI, PRSO) then 
    	__tmp = TELL("How can you do that?", CR)
  elseif INQ(PRSO, PRSI) then 
    	__tmp = TELL("The ", D, PRSO, " is already in the ", D, PRSI, ".", CR)
  elseif GQ(SUB(ADD(WEIGHT(PRSI), WEIGHT(PRSO)), GETP(PRSI, PQSIZE)), GETP(PRSI, PQCAPACITY)) then 
    	__tmp = TELL("There's no room.", CR)
  elseif PASS(NOT(HELDQ(PRSO)) and FSETQ(PRSO, TRYTAKEBIT)) then 
    	__tmp = TELL("You don't have the ", D, PRSO, ".", CR)
    	error(true)
  elseif PASS(NOT(HELDQ(PRSO)) and NOT(ITAKE())) then 
    	error(true)
  elseif T then 
    	__tmp = MOVE(PRSO, PRSI)
    	__tmp = FSET(PRSO, TOUCHBIT)
    	__tmp = SCORE_OBJ(PRSO)
    	__tmp = TELL("Done.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT\n'..__res) end
end
V_PUT_BEHIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("That hiding place is too obvious.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_BEHIND\n'..__res) end
end
V_PUT_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSI, GROUND) then 
    	__tmp = PERFORM(VQDROP, PRSO)
    	error(true)
  elseif FSETQ(PRSI, SURFACEBIT) then 
    	__tmp = V_PUT()
  elseif T then 
    	__tmp = TELL("There's no good surface on the ", D, PRSI, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_ON\n'..__res) end
end
V_PUT_UNDER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't do that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_UNDER\n'..__res) end
end
V_RAISE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_LOWER()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RAISE\n'..__res) end
end
V_RAPE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("What a (ahem!) strange idea.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RAPE\n'..__res) end
end
PRE_READ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(LIT) then 
    	__tmp = TELL("It is impossible to read in the dark.", CR)
  elseif PASS(PRSI and NOT(FSETQ(PRSI, TRANSBIT))) then 
    	__tmp = TELL("How does one look through a ", D, PRSI, "?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_READ\n'..__res) end
end
V_READ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FSETQ(PRSO, READBIT)) then 
    	__tmp = TELL("How does one read a ", D, PRSO, "?", CR)
  elseif T then 
    	__tmp = TELL(GETP(PRSO, PQTEXT), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_READ\n'..__res) end
end
V_READ_PAGE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQREAD, PRSO)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_READ_PAGE\n'..__res) end
end
V_REPENT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It could very well be too late!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_REPENT\n'..__res) end
end
V_REPLY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It is hardly likely that the ", D, PRSO, " is interested.", CR)
	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_REPLY\n'..__res) end
end
V_RING = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How, exactly, can you ring that?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RING\n'..__res) end
end
V_RUB = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Fiddling with the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RUB\n'..__res) end
end
V_SAY = function(...)
	local V
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(P_CONT) then 
    	__tmp = TELL("Say what?", CR)
    	error(true)
  end

	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)

  if APPLY(function() V = FIND_IN(HERE, ACTORBIT) return V end) then 
    	__tmp = TELL("You must address the ", D, V, " directly.", CR)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif NOT(EQUALQ(GET(P_LEXV, P_CONT), WQHELLO)) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = TELL("Talking to yourself is a sign of impending mental collapse.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SAY\n'..__res) end
end
V_SEARCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You find nothing unusual.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SEARCH\n'..__res) end
end
V_SEND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("Why would you send for the ", D, PRSO, "?", CR)
  elseif T then 
    	__tmp = TELL("That doesn't make sends.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SEND\n'..__res) end
end
PRE_SGIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQGIVE, PRSI, PRSO)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_SGIVE\n'..__res) end
end
V_SGIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Foo!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SGIVE\n'..__res) end
end
V_SHAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("This seems to have no effect.", CR)
  elseif NOT(FSETQ(PRSO, TAKEBIT)) then 
    	__tmp = TELL("You can't take it; thus, you can't shake it!", CR)
  elseif FSETQ(PRSO, CONTBIT) then 
    
    if FSETQ(PRSO, OPENBIT) then 
      
      if FIRSTQ(PRSO) then 
        	__tmp = SHAKE_LOOP()
        	__tmp = TELL("The contents of the ", D, PRSO, " spill ")
        
        if NOT(FSETQ(HERE, RLANDBIT)) then 
          	__tmp = TELL("out and disappear")
        elseif T then 
          	__tmp = TELL("to the ground")
        end

        	__tmp = TELL(".", CR)
      elseif T then 
        	__tmp = TELL("Shaken.", CR)
      end

    elseif T then 
      
      if FIRSTQ(PRSO) then 
        	__tmp = TELL("It sounds like there is something inside the ", D, PRSO, ".", CR)
      elseif T then 
        	__tmp = TELL("The ", D, PRSO, " sounds empty.", CR)
      end

    end

  elseif T then 
    	__tmp = TELL("Shaken.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SHAKE\n'..__res) end
end
SHAKE_LOOP = function(...)
	local X
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog32 = function()
    
    if APPLY(function() X = FIRSTQ(PRSO) return X end) then 
      	__tmp = FSET(X, TOUCHBIT)
      	__tmp = MOVE(X, APPLY(function()
        if EQUALQ(HERE, UP_A_TREE) then 
          	__tmp = PATH
        elseif NOT(FSETQ(HERE, RLANDBIT)) then 
          	__tmp = PSEUDO_OBJECT
        elseif T then 
          	__tmp = HERE
        end
 end))
    elseif T then 
      return true
    end


error(123) end
local __ok32, __res32
repeat __ok32, __res32 = pcall(__prog32)
until __ok32 or __res32 ~= 123
if not __ok32 then error(__res32)
else __tmp = __res32 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SHAKE_LOOP\n'..__res) end
end
V_SKIP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL(PICK_ONE(WHEEEEE), CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SKIP\n'..__res) end
end
WHEEEEE = LTABLE(0,"Very good. Now you can go to the second grade.","Are you enjoying yourself?","Wheeeeeeeeee!!!!!","Do you expect me to applaud?")
V_SMELL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It smells like a ", D, PRSO, ".", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SMELL\n'..__res) end
end
V_SPIN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't spin that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SPIN\n'..__res) end
end
V_SPRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SQUEEZE()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SPRAY\n'..__res) end
end
V_SQUEEZE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("The ", D, PRSO, " does not understand this.")
  elseif T then 
    	__tmp = TELL("How singularly useless.")
  end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SQUEEZE\n'..__res) end
end
V_SSPRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQSPRAY, PRSI, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SSPRAY\n'..__res) end
end
V_STAB = function(...)
	local W
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() W = FIND_WEAPON(WINNER) return W end) then 
    	__tmp = PERFORM(VQATTACK, PRSO, W)
    	error(true)
  elseif T then 
    	__tmp = TELL("No doubt you propose to stab the ", D, PRSO, " with your pinky?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAB\n'..__res) end
end
V_STAND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(LOC(WINNER), VEHBIT) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif T then 
    	__tmp = TELL("You are already standing, I think.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAND\n'..__res) end
end
V_STAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You will be lost without me!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAY\n'..__res) end
end
V_STRIKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    	__tmp = TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", D, PRSO, " with a weapon.", CR)
  elseif T then 
    	__tmp = PERFORM(VQLAMP_ON, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STRIKE\n'..__res) end
end
V_SWIM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(HERE, ON_LAKE, IN_LAKE) then 
    	__tmp = TELL("What do you think you're doing?", CR)
  elseif NULL_F() then 
    	error(false)
  elseif T then 
    	__tmp = TELL("Go jump in a lake!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SWIM\n'..__res) end
end
V_SWING = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(PRSI) then 
    	__tmp = TELL("Whoosh!", CR)
  elseif T then 
    	__tmp = PERFORM(VQATTACK, PRSI, PRSO)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SWING\n'..__res) end
end
PRE_TAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if INQ(PRSO, WINNER) then 
    
    if FSETQ(PRSO, WEARBIT) then 
      	__tmp = TELL("You are already wearing it.", CR)
    elseif T then 
      	__tmp = TELL("You already have that!", CR)
    end

  elseif PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    	__tmp = TELL("You can't reach something that's inside a closed container.", CR)
    	error(true)
  elseif PRSI then 
    
    if EQUALQ(PRSI, GROUND) then 
      	__tmp = APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

    	__tmp = NULL_F()
    
    if NOT(EQUALQ(PRSI, LOC(PRSO))) then 
      	__tmp = TELL("The ", D, PRSO, " isn't in the ", D, PRSI, ".", CR)
    elseif T then 
      	__tmp = APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

  elseif EQUALQ(PRSO, LOC(WINNER)) then 
    	__tmp = TELL("You're inside of it!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_TAKE\n'..__res) end
end
V_TAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(ITAKE(), T) then 
    
    if FSETQ(PRSO, WEARBIT) then 
      	__tmp = TELL("You are now wearing the ", D, PRSO, ".", CR)
    elseif T then 
      	__tmp = TELL("Taken.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TAKE\n'..__res) end
end
V_TELL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(PRSO, ACTORBIT) then 
    
    if P_CONT then 
      	__tmp = APPLY(function() WINNER = PRSO return WINNER end)
      	__tmp = APPLY(function() HERE = LOC(WINNER) return HERE end)
    elseif T then 
      	__tmp = TELL("The ", D, PRSO, " pauses for a moment, perhaps thinking that you should reread the manual.", CR)
    end

  elseif T then 
    	__tmp = TELL("You can't talk to the ", D, PRSO, "!", CR)
    	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TELL\n'..__res) end
end
V_THROUGH = function(...)
	local OBJ = ...
	local M
	if select('#', ...) < 1 then OBJ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(FSETQ(PRSO, DOORBIT) and APPLY(function() M = OTHER_SIDE(PRSO) return M end)) then 
    	__tmp = DO_WALK(M)
    	error(true)
  elseif PASS(NOT(OBJ) and FSETQ(PRSO, VEHBIT)) then 
    	__tmp = PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif PASS(OBJ or NOT(FSETQ(PRSO, TAKEBIT))) then 
    	__tmp = NULL_F()
    	__tmp = TELL("You hit your head against the ", D, PRSO, " as you attempt this feat.", CR)
  elseif INQ(PRSO, WINNER) then 
    	__tmp = TELL("That would involve quite a contortion!", CR)
  elseif T then 
    	__tmp = TELL(PICK_ONE(YUKS), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_THROUGH\n'..__res) end
end
V_THROW = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if IDROP() then 
    
    if EQUALQ(PRSI, ME) then 
      	__tmp = TELL("A terrific throw! The ", D, PRSO)
      	__tmp = APPLY(function() WINNER = PLAYER return WINNER end)
      	__tmp = JIGS_UP(" hits you squarely in the head. Normally, this wouldn't do much damage, but by incredible mischance, you fall over backwards trying to duck, and break your neck, justice being swift and merciful in the Great Underground Empire.")
    elseif PASS(PRSI and FSETQ(PRSI, ACTORBIT)) then 
      	__tmp = TELL("The ", D, PRSI, " ducks as the ", D, PRSO, " flies by and crashes to the ground.", CR)
    elseif T then 
      	__tmp = TELL("Thrown.", CR)
    end

  else 
    	__tmp = TELL("Huh?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_THROW\n'..__res) end
end
V_THROW_OFF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't throw anything off of that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_THROW_OFF\n'..__res) end
end
V_TIE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(PRSI, WINNER) then 
    	__tmp = TELL("You can't tie anything to yourself.", CR)
  elseif T then 
    	__tmp = TELL("You can't tie the ", D, PRSO, " to that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TIE\n'..__res) end
end
V_TIE_UP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You could certainly never tie it with that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TIE_UP\n'..__res) end
end
V_TREASURE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(HERE, NORTH_TEMPLE) then 
    	__tmp = GOTO(TREASURE_ROOM)
  elseif EQUALQ(HERE, TREASURE_ROOM) then 
    	__tmp = GOTO(NORTH_TEMPLE)
  elseif T then 
    	__tmp = TELL("Nothing happens.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TREASURE\n'..__res) end
end
PRE_TURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil


  if PASS(EQUALQ(PRSI, nil, ROOMS) and NOT(EQUALQ(PRSO, BOOK))) then 
    	__tmp = TELL("Your bare hands don't appear to be enough.", CR)
  elseif NOT(FSETQ(PRSO, TURNBIT)) then 
    	__tmp = TELL("You can't turn that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_TURN\n'..__res) end
end
V_TURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This has no effect.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TURN\n'..__res) end
end
V_UNLOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_LOCK()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNLOCK\n'..__res) end
end
V_UNTIE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This cannot be tied, so it cannot be untied!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNTIE\n'..__res) end
end
V_WAIT = function(...)
	local NUM = ...
	if select('#', ...) < 1 then NUM = 3 end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Time passes...", CR)

  local __prog33 = function()
    
    if LQ(APPLY(function() NUM = SUB(NUM, 1) return NUM end), 0) then 
      return true
    elseif CLOCKER() then 
      return true
    end


error(123) end
local __ok33, __res33
repeat __ok33, __res33 = pcall(__prog33)
until __ok33 or __res33 ~= 123
if not __ok33 then error(__res33)
else __tmp = __res33 or true end

	__tmp = APPLY(function() CLOCK_WAIT = T return CLOCK_WAIT end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WAIT\n'..__res) end
end
V_WALK = function(...)
	local PT
	local PTS
	local STR
	local OBJ
	local RM
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(P_WALK_DIR) then 
    	__tmp = PERFORM(VQWALK_TO, PRSO)
    	error(true)
  elseif APPLY(function() PT = GETPT(HERE, PRSO) return PT end) then 
    
    if EQUALQ(APPLY(function() PTS = PTSIZE(PT) return PTS end), UEXIT) then 
      	__tmp = GOTO(GETB(PT, REXIT))
    elseif EQUALQ(PTS, NEXIT) then 
      	__tmp = TELL(GET(PT, NEXITSTR), CR)
      	__tmp = 	error(2)
    elseif EQUALQ(PTS, FEXIT) then 
      
      if APPLY(function() RM = APPLY(GET(PT, FEXITFCN)) return RM end) then 
        	__tmp = GOTO(RM)
      elseif NULL_F() then 
        	error(false)
      elseif T then 
        	__tmp = 	error(2)
      end

    elseif EQUALQ(PTS, CEXIT) then 
      
      if VALUE(GETB(PT, CEXITFLAG)) then 
        	__tmp = GOTO(GETB(PT, REXIT))
      elseif APPLY(function() STR = GET(PT, CEXITSTR) return STR end) then 
        	__tmp = TELL(STR, CR)
        	__tmp = 	error(2)
      elseif T then 
        	__tmp = TELL("You can't go that way.", CR)
        	__tmp = 	error(2)
      end

    elseif EQUALQ(PTS, DEXIT) then 
      
      if FSETQ(APPLY(function() OBJ = GETB(PT, DEXITOBJ) return OBJ end), OPENBIT) then 
        	__tmp = GOTO(GETB(PT, REXIT))
      elseif APPLY(function() STR = GET(PT, DEXITSTR) return STR end) then 
        	__tmp = TELL(STR, CR)
        	__tmp = 	error(2)
      elseif T then 
        	__tmp = TELL("The ", D, OBJ, " is closed.", CR)
        	__tmp = THIS_IS_IT(OBJ)
        	__tmp = 	error(2)
      end

    end

  elseif PASS(NOT(LIT) and PROB(80) and EQUALQ(WINNER, ADVENTURER) and NOT(FSETQ(HERE, NONLANDBIT))) then 
    
    if SPRAYEDQ then 
      	__tmp = TELL("There are odd noises in the darkness, and there is no exit in that direction.", CR)
      	__tmp = 	error(2)
    elseif NULL_F() then 
      	error(false)
    elseif T then 
      	__tmp = JIGS_UP("Oh, no! You have walked into the slavering fangs of a lurking grue!")
    end

  elseif T then 
    	__tmp = TELL("You can't go that way.", CR)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK\n'..__res) end
end
V_WALK_AROUND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Use compass directions for movement.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK_AROUND\n'..__res) end
end
V_WALK_TO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(PRSO and PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE))) then 
    	__tmp = TELL("It's here!", CR)
  elseif T then 
    	__tmp = TELL("You should supply a direction!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK_TO\n'..__res) end
end
V_WAVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Waving the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WAVE\n'..__res) end
end
V_WEAR = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(FSETQ(PRSO, WEARBIT)) then 
    	__tmp = TELL("You can't wear the ", D, PRSO, ".", CR)
  elseif T then 
    	__tmp = PERFORM(VQTAKE, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WEAR\n'..__res) end
end
V_WIN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Naturally!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WIN\n'..__res) end
end
V_WIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You cannot wind up a ", D, PRSO, ".", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WIND\n'..__res) end
end
V_WISH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("With luck, your wish will come true.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WISH\n'..__res) end
end
V_YELL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Aaaarrrrgggghhhh!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_YELL\n'..__res) end
end
V_ZORK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("At your service!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ZORK\n'..__res) end
end
LIT = nil
SPRAYEDQ = nil
V_FIRST_LOOK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if DESCRIBE_ROOM() then 
    
    if NOT(SUPER_BRIEF) then 
      	__tmp = DESCRIBE_OBJECTS()
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FIRST_LOOK\n'..__res) end
end
DESCRIBE_ROOM = function(...)
	local LOOKQ = ...
	local VQ
	local STR
	local AV
	if select('#', ...) < 1 then LOOKQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() VQ = PASS(LOOKQ or VERBOSE) return VQ end)

  if NOT(LIT) then 
    	__tmp = TELL("It is pitch black.")
    
    if NOT(SPRAYEDQ) then 
      	__tmp = TELL(" You are likely to be eaten by a grue.")
    end

    	__tmp = CRLF()
    	__tmp = NULL_F()
    	error(false)
  end


  if NOT(FSETQ(HERE, TOUCHBIT)) then 
    	__tmp = FSET(HERE, TOUCHBIT)
    	__tmp = APPLY(function() VQ = T return VQ end)
  end


  if FSETQ(HERE, MAZEBIT) then 
    	__tmp = FCLEAR(HERE, TOUCHBIT)
  end


  if INQ(HERE, ROOMS) then 
    	__tmp = TELL(D, HERE)
    
    if FSETQ(APPLY(function() AV = LOC(WINNER) return AV end), VEHBIT) then 
      	__tmp = TELL(", in the ", D, AV)
    end

    	__tmp = CRLF()
  end


  if PASS(LOOKQ or NOT(SUPER_BRIEF)) then 
    	__tmp = APPLY(function() AV = LOC(WINNER) return AV end)
    
    if PASS(VQ and APPLY(GETP(HERE, PQACTION), M_LOOK)) then 
      	error(true)
    elseif PASS(VQ and APPLY(function() STR = GETP(HERE, PQLDESC) return STR end)) then 
      	__tmp = TELL(STR, CR)
    elseif T then 
      	__tmp = APPLY(GETP(HERE, PQACTION), M_FLASH)
    end

    
    if PASS(NOT(EQUALQ(HERE, AV)) and FSETQ(AV, VEHBIT)) then 
      	__tmp = APPLY(GETP(AV, PQACTION), M_LOOK)
    end

  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_ROOM\n'..__res) end
end
DESCRIBE_OBJECTS = function(...)
	local VQ = ...
	if select('#', ...) < 1 then VQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if LIT then 
    
    if FIRSTQ(HERE) then 
      	__tmp = PRINT_CONT(HERE, APPLY(function() VQ = PASS(VQ or VERBOSE) return VQ end), -1)
    end

  elseif T then 
    	__tmp = TELL("Only bats can see in the dark. And you're not one.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_OBJECTS\n'..__res) end
end
DESC_OBJECT = nil
DESCRIBE_OBJECT = function(...)
	local OBJ, VQ, LEVEL = ...
  local STR = nil
	local AV
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() DESC_OBJECT = OBJ return DESC_OBJECT end)

  if PASS(ZEROQ(LEVEL) and APPLY(GETP(OBJ, PQDESCFCN), M_OBJDESC)) then 
    	error(true)
  elseif PASS(ZEROQ(LEVEL) and PASS(PASS(NOT(FSETQ(OBJ, TOUCHBIT)) and APPLY(function() STR = GETP(OBJ, PQFDESC) return STR end)) or APPLY(function() STR = GETP(OBJ, PQLDESC) return STR end))) then 
    	__tmp = TELL(STR)
  elseif ZEROQ(LEVEL) then 
    	__tmp = TELL("There is a ", D, OBJ, " here")
    
    if FSETQ(OBJ, ONBIT) then 
      	__tmp = TELL(" (providing light)")
    end

    	__tmp = TELL(".")
  elseif T then 
    	__tmp = TELL(GET(INDENTS, LEVEL))
    	__tmp = TELL("A ", D, OBJ)
    
    if FSETQ(OBJ, ONBIT) then 
      	__tmp = TELL(" (providing light)")
    elseif PASS(FSETQ(OBJ, WEARBIT) and INQ(OBJ, WINNER)) then 
      	__tmp = TELL(" (being worn)")
    end

  end

	__tmp =   NULL_F()

  if PASS(ZEROQ(LEVEL) and APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) then 
    	__tmp = TELL(" (outside the ", D, AV, ")")
  end

	__tmp =   CRLF()

  if PASS(SEE_INSIDEQ(OBJ) and FIRSTQ(OBJ)) then 
    	__tmp = PRINT_CONT(OBJ, VQ, LEVEL)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_OBJECT\n'..__res) end
end
PRINT_CONTENTS = function(...)
	local OBJ = ...
	local F
	local N
  local bSTQ = T
  local ITQ = nil
  local TWOQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() F = FIRSTQ(OBJ) return F end) then 
    
    local __prog34 = function()
      APPLY(function() N = NEXTQ(F) return N end)
      
      if bSTQ then 
        	__tmp = APPLY(function() bSTQ = nil return bSTQ end)
      else 
        	__tmp = TELL(", ")
        
        if NOT(N) then 
          	__tmp = TELL("and ")
        end

      end

      TELL("a ", D, F)
      
      if PASS(NOT(ITQ) and NOT(TWOQ)) then 
        	__tmp = APPLY(function() ITQ = F return ITQ end)
      else 
        	__tmp = APPLY(function() TWOQ = T return TWOQ end)
        	__tmp = APPLY(function() ITQ = nil return ITQ end)
      end

      APPLY(function() F = N return F end)
      
      if NOT(F) then 
        
        if PASS(ITQ and NOT(TWOQ)) then 
          	__tmp = THIS_IS_IT(ITQ)
        end

        	error(true)
      end


error(123) end
local __ok34, __res34
repeat __ok34, __res34 = pcall(__prog34)
until __ok34 or __res34 ~= 123
if not __ok34 then error(__res34)
else __tmp = __res34 or true end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRINT_CONTENTS\n'..__res) end
end
PRINT_CONT = function(...)
	local OBJ, VQ, LEVEL = ...
	local Y
	local bSTQ
	local SHIT
	local AV
	local STR
  local PVQ = nil
  local INVQ = nil
	if select('#', ...) < 2 then VQ = nil end
	if select('#', ...) < 3 then LEVEL = 0 end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(APPLY(function() Y = FIRSTQ(OBJ) return Y end)) then 
    	error(true)
  end


  if PASS(APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) then 
    	__tmp = T
  else 
    	__tmp = APPLY(function() AV = nil return AV end)
  end

	__tmp = APPLY(function() bSTQ = T return bSTQ end)
	__tmp = APPLY(function() SHIT = T return SHIT end)

  if EQUALQ(WINNER, OBJ, LOC(OBJ)) then 
    	__tmp = APPLY(function() INVQ = T return INVQ end)
  else 
    
    local __prog35 = function()
      
      if NOT(Y) then 
        return true
      elseif EQUALQ(Y, AV) then 
        	__tmp = APPLY(function() PVQ = T return PVQ end)
      elseif EQUALQ(Y, WINNER) then 
        	__tmp = EQUALQ(Y, WINNER)
      elseif PASS(NOT(FSETQ(Y, INVISIBLE)) and NOT(FSETQ(Y, TOUCHBIT)) and APPLY(function() STR = GETP(Y, PQFDESC) return STR end)) then 
        
        if NOT(FSETQ(Y, NDESCBIT)) then 
          	__tmp = TELL(STR, CR)
          	__tmp = APPLY(function() SHIT = nil return SHIT end)
        end

        
        if PASS(SEE_INSIDEQ(Y) and NOT(GETP(LOC(Y), PQDESCFCN)) and FIRSTQ(Y)) then 
          
          if PRINT_CONT(Y, VQ, 0) then 
            	__tmp = APPLY(function() bSTQ = nil return bSTQ end)
          end

        end

      end

      APPLY(function() Y = NEXTQ(Y) return Y end)

error(123) end
local __ok35, __res35
repeat __ok35, __res35 = pcall(__prog35)
until __ok35 or __res35 ~= 123
if not __ok35 then error(__res35)
else __tmp = __res35 or true end

  end

	__tmp = APPLY(function() Y = FIRSTQ(OBJ) return Y end)

  local __prog36 = function()
    
    if NOT(Y) then 
      
      if PASS(PVQ and AV and FIRSTQ(AV)) then 
        	__tmp = APPLY(function() LEVEL = ADD(LEVEL, 1) return LEVEL end)
        	__tmp = PRINT_CONT(AV, VQ, LEVEL)
      end

      return true
    elseif EQUALQ(Y, AV, ADVENTURER) then 
      	__tmp = EQUALQ(Y, AV, ADVENTURER)
    elseif PASS(NOT(FSETQ(Y, INVISIBLE)) and PASS(INVQ or FSETQ(Y, TOUCHBIT) or NOT(GETP(Y, PQFDESC)))) then 
      
      if NOT(FSETQ(Y, NDESCBIT)) then 
        
        if bSTQ then 
          
          if FIRSTER(OBJ, LEVEL) then 
            
            if LQ(LEVEL, 0) then 
              	__tmp = APPLY(function() LEVEL = 0 return LEVEL end)
            end

          end

          	__tmp = APPLY(function() LEVEL = ADD(1, LEVEL) return LEVEL end)
          	__tmp = APPLY(function() bSTQ = nil return bSTQ end)
        end

        
        if LQ(LEVEL, 0) then 
          	__tmp = APPLY(function() LEVEL = 0 return LEVEL end)
        end

        	__tmp = DESCRIBE_OBJECT(Y, VQ, LEVEL)
      elseif PASS(FIRSTQ(Y) and SEE_INSIDEQ(Y)) then 
        	__tmp = APPLY(function() LEVEL = ADD(LEVEL, 1) return LEVEL end)
        	__tmp = PRINT_CONT(Y, VQ, LEVEL)
        	__tmp = APPLY(function() LEVEL = SUB(LEVEL, 1) return LEVEL end)
      end

    end

    APPLY(function() Y = NEXTQ(Y) return Y end)

error(123) end
local __ok36, __res36
repeat __ok36, __res36 = pcall(__prog36)
until __ok36 or __res36 ~= 123
if not __ok36 then error(__res36)
else __tmp = __res36 or true end


  if PASS(bSTQ and SHIT) then 
    	error(false)
  elseif T then 
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRINT_CONT\n'..__res) end
end
FIRSTER = function(...)
	local OBJ, LEVEL = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(OBJ, TROPHY_CASE) then 
    	__tmp = TELL("Your collection of treasures consists of:", CR)
  elseif EQUALQ(OBJ, WINNER) then 
    	__tmp = TELL("You are carrying:", CR)
  elseif NOT(INQ(OBJ, ROOMS)) then 
    
    if GQ(LEVEL, 0) then 
      	__tmp = TELL(GET(INDENTS, LEVEL))
    end

    
    if FSETQ(OBJ, SURFACEBIT) then 
      	__tmp = TELL("Sitting on the ", D, OBJ, " is: ", CR)
    elseif FSETQ(OBJ, ACTORBIT) then 
      	__tmp = TELL("The ", D, OBJ, " is holding: ", CR)
    elseif T then 
      	__tmp = TELL("The ", D, OBJ, " contains:", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIRSTER\n'..__res) end
end
SEE_INSIDEQ = function(...)
	local OBJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PASS(NOT(FSETQ(OBJ, INVISIBLE)) and PASS(FSETQ(OBJ, TRANSBIT) or FSETQ(OBJ, OPENBIT)))
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SEE_INSIDEQ\n'..__res) end
end
MOVES = 0
SCORE = 0
BASE_SCORE = 0
WON_FLAG = nil
SCORE_UPD = function(...)
	local NUM = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() BASE_SCORE = ADD(BASE_SCORE, NUM) return BASE_SCORE end)
	__tmp = APPLY(function() SCORE = ADD(SCORE, NUM) return SCORE end)

  if PASS(EQUALQ(SCORE, 350) and NOT(WON_FLAG)) then 
    	__tmp = APPLY(function() WON_FLAG = T return WON_FLAG end)
    	__tmp = FCLEAR(MAP, INVISIBLE)
    	__tmp = FCLEAR(WEST_OF_HOUSE, TOUCHBIT)
    	__tmp = TELL("An almost inaudible voice whispers in your ear, \"Look to your treasures for the final secret.\"", CR)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SCORE_UPD\n'..__res) end
end
SCORE_OBJ = function(...)
	local OBJ = ...
	local TEMP
	local __ok, __res = pcall(function()
	local __tmp = nil

  if GQ(APPLY(function() TEMP = GETP(OBJ, PQVALUE) return TEMP end), 0) then 
    	__tmp = SCORE_UPD(TEMP)
    	__tmp = PUTP(OBJ, PQVALUE, 0)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SCORE_OBJ\n'..__res) end
end
YESQ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PRINTI(">")
	__tmp =   READ(P_INBUF, P_LEXV)

  if EQUALQ(GET(P_LEXV, 1), WQYES, WQY) then 
    	error(true)
  elseif T then 
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('YESQ\n'..__res) end
end
DEAD = nil
DEATHS = 0
LUCKY = 1
FUMBLE_NUMBER = 7
FUMBLE_PROB = 8
ITAKE = function(...)
	local VB = ...
	local CNT
	local OBJ
	if select('#', ...) < 1 then VB = T end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if DEAD then 
    
    if VB then 
      	__tmp = TELL("Your hand passes through its object.", CR)
    end

    	error(false)
  elseif NOT(FSETQ(PRSO, TAKEBIT)) then 
    
    if VB then 
      	__tmp = TELL(PICK_ONE(YUKS), CR)
    end

    	error(false)
  elseif NULL_F() then 
    	error(false)
  elseif PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    	error(false)
  elseif PASS(NOT(INQ(LOC(PRSO), WINNER)) and GQ(ADD(WEIGHT(PRSO), WEIGHT(WINNER)), LOAD_ALLOWED)) then 
    
    if VB then 
      	__tmp = TELL("Your load is too heavy")
      
      if LQ(LOAD_ALLOWED, LOAD_MAX) then 
        	__tmp = TELL(", especially in light of your condition.")
      elseif T then 
        	__tmp = TELL(".")
      end

      	__tmp = CRLF()
    end

    	__tmp = 	error(2)
  elseif PASS(VERBQ(TAKE) and GQ(APPLY(function() CNT = CCOUNT(WINNER) return CNT end), FUMBLE_NUMBER) and PROB(MULL(CNT, FUMBLE_PROB))) then 
    	__tmp = TELL("You're holding too many things already!", CR)
    	error(false)
  elseif T then 
    	__tmp = MOVE(PRSO, WINNER)
    	__tmp = FCLEAR(PRSO, NDESCBIT)
    	__tmp = FSET(PRSO, TOUCHBIT)
    	__tmp = NULL_F()
    	__tmp = NULL_F()
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ITAKE\n'..__res) end
end
IDROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) then 
    	__tmp = TELL("You're not carrying the ", D, PRSO, ".", CR)
    	error(false)
  elseif PASS(NOT(INQ(PRSO, WINNER)) and NOT(FSETQ(LOC(PRSO), OPENBIT))) then 
    	__tmp = TELL("The ", D, PRSO, " is closed.", CR)
    	error(false)
  elseif T then 
    	__tmp = MOVE(PRSO, LOC(WINNER))
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('IDROP\n'..__res) end
end
CCOUNT = function(...)
	local OBJ = ...
  local CNT = 0
	local X
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() X = FIRSTQ(OBJ) return X end) then 
    
    local __prog37 = function()
      
      if NOT(FSETQ(X, WEARBIT)) then 
        	__tmp = APPLY(function() CNT = ADD(CNT, 1) return CNT end)
      end

      
      if NOT(APPLY(function() X = NEXTQ(X) return X end)) then 
        return true
      end


error(123) end
local __ok37, __res37
repeat __ok37, __res37 = pcall(__prog37)
until __ok37 or __res37 ~= 123
if not __ok37 then error(__res37)
else __tmp = __res37 or true end

  end

	__tmp = CNT
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CCOUNT\n'..__res) end
end
WEIGHT = function(...)
	local OBJ = ...
	local CONT
  local WT = 0
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() CONT = FIRSTQ(OBJ) return CONT end) then 
    
    local __prog38 = function()
      
      if PASS(EQUALQ(OBJ, PLAYER) and FSETQ(CONT, WEARBIT)) then 
        	__tmp = APPLY(function() WT = ADD(WT, 1) return WT end)
      elseif T then 
        	__tmp = APPLY(function() WT = ADD(WT, WEIGHT(CONT)) return WT end)
      end

      
      if NOT(APPLY(function() CONT = NEXTQ(CONT) return CONT end)) then 
        return true
      end


error(123) end
local __ok38, __res38
repeat __ok38, __res38 = pcall(__prog38)
until __ok38 or __res38 ~= 123
if not __ok38 then error(__res38)
else __tmp = __res38 or true end

  end

	__tmp =   ADD(WT, GETP(OBJ, PQSIZE))
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
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
INDENTS = TABLE("","  ","    ","      ","        ","          ")
HACK_HACK = function(...)
	local STR = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(INQ(PRSO, GLOBAL_OBJECTS) and VERBQ(WAVE, RAISE, LOWER)) then 
    	__tmp = TELL("The ", D, PRSO, " isn't here!", CR)
  elseif T then 
    	__tmp = TELL(STR, D, PRSO, PICK_ONE(HO_HUM), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HACK_HACK\n'..__res) end
end
HO_HUM = LTABLE(0," doesn't seem to work."," isn't notably helpful."," has no effect.")
NO_GO_TELL = function(...)
	local AV, WLOC = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if AV then 
    	__tmp = TELL("You can't go there in a ", D, WLOC, ".")
  elseif T then 
    	__tmp = TELL("You can't go there without a vehicle.")
  end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NO_GO_TELL\n'..__res) end
end
GOTO = function(...)
	local RM, VQ = ...
  local LB = FSETQ(RM, RLANDBIT)
  local WLOC = LOC(WINNER)
  local AV = nil
	local OLIT
	local OHERE
	if select('#', ...) < 2 then VQ = T end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() OLIT = LIT return OLIT end)
	__tmp = APPLY(function() OHERE = HERE return OHERE end)

  if FSETQ(WLOC, VEHBIT) then 
    	__tmp = APPLY(function() AV = GETP(WLOC, PQVTYPE) return AV end)
  end


  if PASS(NOT(LB) and NOT(AV)) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif PASS(NOT(LB) and NOT(FSETQ(RM, AV))) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif PASS(FSETQ(HERE, RLANDBIT) and LB and AV and NOT(EQUALQ(AV, RLANDBIT)) and NOT(FSETQ(RM, AV))) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif FSETQ(RM, RMUNGBIT) then 
    	__tmp = TELL(GETP(RM, PQLDESC), CR)
    	error(false)
  elseif T then 
    
    if PASS(LB and NOT(FSETQ(HERE, RLANDBIT)) and NOT(DEAD) and FSETQ(WLOC, VEHBIT)) then 
      	__tmp = TELL("The ", D, WLOC, " comes to a rest on the shore.", CR, CR)
    end

    
    if AV then 
      	__tmp = MOVE(WLOC, RM)
    elseif T then 
      	__tmp = MOVE(WINNER, RM)
    end

    	__tmp = APPLY(function() HERE = RM return HERE end)
    	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if PASS(NOT(OLIT) and NOT(LIT) and PROB(80)) then 
      
      if SPRAYEDQ then 
        	__tmp = TELL("There are sinister gurgling noises in the darkness all around you!", CR)
      elseif NULL_F() then 
        	error(false)
      elseif T then 
        	__tmp = TELL("Oh, no! A lurking grue slithered into the ")
        
        if FSETQ(LOC(WINNER), VEHBIT) then 
          	__tmp = TELL(D, LOC(WINNER))
        elseif T then 
          	__tmp = TELL("room")
        end

        	__tmp = JIGS_UP(" and devoured you!")
        	error(true)
      end

    end

    
    if PASS(NOT(LIT) and EQUALQ(WINNER, ADVENTURER)) then 
      	__tmp = TELL("You have moved into a dark place.", CR)
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    end

    	__tmp = APPLY(GETP(HERE, PQACTION), M_ENTER)
    	__tmp = SCORE_OBJ(RM)
    
    if NOT(EQUALQ(HERE, RM)) then 
      	error(true)
    elseif PASS(NOT(EQUALQ(ADVENTURER, WINNER)) and INQ(ADVENTURER, OHERE)) then 
      	__tmp = TELL("The ", D, WINNER, " leaves the room.", CR)
    elseif PASS(EQUALQ(HERE, OHERE) and EQUALQ(HERE, ENTRANCE_TO_HADES)) then 
      	error(true)
    elseif PASS(VQ and EQUALQ(WINNER, ADVENTURER)) then 
      	__tmp = V_FIRST_LOOK()
    end

    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GOTO\n'..__res) end
end
LKP = function(...)
	local ITM, TBL = ...
  local CNT = 0
  local LEN = GET(TBL, 0)
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog39 = function()
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), LEN) then 
      	error(false)
    elseif EQUALQ(GET(TBL, CNT), ITM) then 
      
      if EQUALQ(CNT, LEN) then 
        	error(false)
      elseif T then 
        error(GET(TBL, ADD(CNT, 1)))
      end

    end


error(123) end
local __ok39, __res39
repeat __ok39, __res39 = pcall(__prog39)
until __ok39 or __res39 ~= 123
if not __ok39 then error(__res39)
else __tmp = __res39 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LKP\n'..__res) end
end
DO_WALK = function(...)
	local DIR = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() P_WALK_DIR = DIR return P_WALK_DIR end)
	__tmp =   PERFORM(VQWALK, DIR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DO_WALK\n'..__res) end
end
GLOBAL_INQ = function(...)
	local OBJ1, OBJ2 = ...
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() TX = GETPT(OBJ2, PQGLOBAL) return TX end) then 
    	__tmp = ZMEMQB(OBJ1, TX, SUB(PTSIZE(TX), 1))
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GLOBAL_INQ\n'..__res) end
end
FIND_IN = function(...)
	local WHERE, WHAT = ...
	local W
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() W = FIRSTQ(WHERE) return W end)

  if NOT(W) then 
    	error(false)
  end


  local __prog40 = function()
    
    if PASS(FSETQ(W, WHAT) and NOT(EQUALQ(W, ADVENTURER))) then 
      error(W)
    elseif NOT(APPLY(function() W = NEXTQ(W) return W end)) then 
      error(nil)
    end


error(123) end
local __ok40, __res40
repeat __ok40, __res40 = pcall(__prog40)
until __ok40 or __res40 ~= 123
if not __ok40 then error(__res40)
else __tmp = __res40 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIND_IN\n'..__res) end
end
HELDQ = function(...)
	local CAN = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog41 = function()
    APPLY(function() CAN = LOC(CAN) return CAN end)
    
    if NOT(CAN) then 
      	error(false)
    elseif EQUALQ(CAN, WINNER) then 
      	error(true)
    end


error(123) end
local __ok41, __res41
repeat __ok41, __res41 = pcall(__prog41)
until __ok41 or __res41 ~= 123
if not __ok41 then error(__res41)
else __tmp = __res41 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HELDQ\n'..__res) end
end
OTHER_SIDE = function(...)
	local DOBJ = ...
  local P = 0
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog42 = function()
    
    if LQ(APPLY(function() P = NEXTP(HERE, P) return P end), LOW_DIRECTION) then 
      error(nil)
    else 
      	__tmp = APPLY(function() TX = GETPT(HERE, P) return TX end)
      
      if PASS(EQUALQ(PTSIZE(TX), DEXIT) and EQUALQ(GETB(TX, DEXITOBJ), DOBJ)) then 
        error(P)
      end

    end


error(123) end
local __ok42, __res42
repeat __ok42, __res42 = pcall(__prog42)
until __ok42 or __res42 ~= 123
if not __ok42 then error(__res42)
else __tmp = __res42 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('OTHER_SIDE\n'..__res) end
end
MUNG_ROOM = function(...)
	local RM, STR = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

	__tmp =   FSET(RM, RMUNGBIT)
	__tmp =   PUTP(RM, PQLDESC, STR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MUNG_ROOM\n'..__res) end
end
THIS_IS_IT = function(...)
	local OBJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() P_IT_OBJECT = OBJ return P_IT_OBJECT end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('THIS_IS_IT\n'..__res) end
end

if   NEQUALQ(ZORK_NUMBER, 3) then 
  SWIMYUKS = LTABLE(0,"You can't swim in the dungeon.")

end
HELLOS = LTABLE(0,"Hello.","Good day.","Nice weather we've been having lately.","Goodbye.")
YUKS = LTABLE(0,"A valiant attempt.","You can't be serious.","An interesting idea...","What a concept!")
DUMMY = LTABLE(0,"Look around.","Too late for that.","Have your eyes checked.")
