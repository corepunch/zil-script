
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
_V_VERBOSE = {
}
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
_V_BRIEF = {
}
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
_V_SUPER_BRIEF = {
}
V_INVENTORY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FIRSTQ(WINNER) return __tmp end) then 
    	__tmp = PRINT_CONT(WINNER)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You are empty-handed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_INVENTORY\n'..__res) end
end
_V_INVENTORY = {
}
FINISH = function(...)
	local WRD
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE()

  local __prog28 = function()
    CRLF()
    TELL("Would you like to restart the game from the beginning, restore a saved game position, or end this session of the game?\n (Type RESTART, RESTORE, or QUIT):\n >")
    READ(P_INBUF, P_LEXV)
    APPLY(function() WRD = GET(P_LEXV, 1) return WRD end)
    
    if APPLY(function() __tmp = EQUALQ(WRD, WQRESTART) return __tmp end) then 
      	__tmp = RESTART()
      	__tmp = TELL("Failed.", CR)
    elseif APPLY(function() __tmp = EQUALQ(WRD, WQRESTORE) return __tmp end) then 
      
      if APPLY(function() __tmp = RESTORE() return __tmp end) then 
        	__tmp = TELL("Ok.", CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("Failed.", CR)
      end

    elseif APPLY(function() __tmp = EQUALQ(WRD, WQQUIT, WQQ) return __tmp end) then 
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
_FINISH = {
}
V_QUIT = function(...)
	local SCOR
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE()
	__tmp =   TELL("Do you wish to leave the game? (Y is affirmative): ")

  if APPLY(function() __tmp = YESQ() return __tmp end) then 
    	__tmp = QUIT()
  else 
    	__tmp = TELL("Ok.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_QUIT\n'..__res) end
end
_V_QUIT = {
}
V_RESTART = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SCORE(T)
	__tmp =   TELL("Do you wish to restart? (Y is affirmative): ")

  if APPLY(function() __tmp = YESQ() return __tmp end) then 
    	__tmp = TELL("Restarting.", CR)
    	__tmp = RESTART()
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RESTART\n'..__res) end
end
_V_RESTART = {
}
V_RESTORE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = RESTORE() return __tmp end) then 
    	__tmp = TELL("Ok.", CR)
    	__tmp = V_FIRST_LOOK()
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RESTORE\n'..__res) end
end
_V_RESTORE = {
}
V_SAVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = SAVE() return __tmp end) then 
    	__tmp = TELL("Ok.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Failed.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SAVE\n'..__res) end
end
_V_SAVE = {
}
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
_V_SCRIPT = {
}
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
_V_UNSCRIPT = {
}
V_VERSION = function(...)
  local CNT = 17
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("ZORK I: The Great Underground Empire\n Infocom interactive fiction - a fantasy story\n Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986")
	__tmp =   TELL(" Infocom, Inc. All rights reserved.", CR)
	__tmp =   TELL("ZORK is a registered trademark of Infocom, Inc.\n Release ")
	__tmp =   PRINTN(BAND(GET(0, 1), 2047))
	__tmp =   TELL(" / Serial number ")

  local __prog29 = function()
    
    if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), 23) return __tmp end) then 
      return true
    elseif APPLY(function() __tmp = T return __tmp end) then 
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
_V_VERSION = {
}
V_VERIFY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Verifying disk...", CR)

  if APPLY(function() __tmp = VERIFY() return __tmp end) then 
    	__tmp = TELL("The disk is correct.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(CR, "** Disk Failure **", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_VERIFY\n'..__res) end
end
_V_VERIFY = {
}
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
_V_COMMAND_FILE = {
}
V_RANDOM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(EQUALQ(PRSO, INTNUM)) return __tmp end) then 
    	__tmp = TELL("Illegal call to #RND.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = RANDOM(SUB(0, P_NUMBER))
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RANDOM\n'..__res) end
end
_V_RANDOM = {
}
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
_V_RECORD = {
}
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
_V_UNRECORD = {
}
V_ADVENT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("A hollow voice says \"Fool.\"", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ADVENT\n'..__res) end
end
_V_ADVENT = {
}
V_ALARM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = LQ(GETP(PRSO, PQSTRENGTH), 0) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " is rudely awakened.", CR)
      	__tmp = AWAKEN(PRSO)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("He's wide awake, or haven't you noticed...", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " isn't sleeping.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ALARM\n'..__res) end
end
_V_ALARM = {
}
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
_V_ANSWER = {
}
V_ATTACK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(FSETQ(PRSO, ACTORBIT)) return __tmp end) then 
    	__tmp = TELL("I've known strange people, but fighting a ", D, PRSO, "?", CR)
  elseif APPLY(function() __tmp = PASS(NOT(PRSI) or EQUALQ(PRSI, HANDS)) return __tmp end) then 
    	__tmp = TELL("Trying to attack a ", D, PRSO, " with your bare hands is suicidal.", CR)
  elseif APPLY(function() __tmp = NOT(INQ(PRSI, WINNER)) return __tmp end) then 
    	__tmp = TELL("You aren't even holding the ", D, PRSI, ".", CR)
  elseif APPLY(function() __tmp = NOT(FSETQ(PRSI, WEAPONBIT)) return __tmp end) then 
    	__tmp = TELL("Trying to attack the ", D, PRSO, " with a ", D, PRSI, " is suicidal.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = HERO_BLOW()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ATTACK\n'..__res) end
end
_V_ATTACK = {
}
V_BACK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Sorry, my memory is poor. Please give a direction.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BACK\n'..__res) end
end
_V_BACK = {
}
V_BLAST = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't blast anything by using words.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BLAST\n'..__res) end
end
_V_BLAST = {
}
PRE_BOARD = function(...)
	local AV
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() AV = LOC(WINNER) return AV end)

  if APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(true)
  elseif APPLY(function() __tmp = FSETQ(PRSO, VEHBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = NOT(INQ(PRSO, HERE)) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " must be on the ground to be boarded.", CR)
    elseif APPLY(function() __tmp = FSETQ(AV, VEHBIT) return __tmp end) then 
      	__tmp = TELL("You are already in the ", D, AV, "!", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	error(false)
    end

  elseif APPLY(function() __tmp = EQUALQ(PRSO, WATER, GLOBAL_WATER) return __tmp end) then 
    	__tmp = PERFORM(VQSWIM, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You have a theory on how to board a ", D, PRSO, ", perhaps?", CR)
  end

	__tmp = 	error(2)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_BOARD\n'..__res) end
end
_PRE_BOARD = {
}
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
_V_BOARD = {
}
V_BREATHE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQINFLATE, PRSO, LUNGS)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BREATHE\n'..__res) end
end
_V_BREATHE = {
}
V_BRUSH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("If you wish, but heaven only knows why.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BRUSH\n'..__res) end
end
_V_BRUSH = {
}
V_BUG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Bug? Not in a flawless program like this! (Cough, cough).", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BUG\n'..__res) end
end
_V_BUG = {
}
TELL_NO_PRSI = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You didn't say with what!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TELL_NO_PRSI\n'..__res) end
end
_TELL_NO_PRSI = {
}
PRE_BURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
    	__tmp = TELL_NO_PRSI()
  elseif APPLY(function() __tmp = FLAMINGQ(PRSI) return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("With a ", D, PRSI, "??!?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_BURN\n'..__res) end
end
_PRE_BURN = {
}
V_BURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = FSETQ(PRSO, BURNBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = PASS(INQ(PRSO, WINNER) or INQ(WINNER, PRSO)) return __tmp end) then 
      	__tmp = REMOVE_CAREFULLY(PRSO)
      	__tmp = TELL("The ", D, PRSO)
      	__tmp = TELL(" catches fire. Unfortunately, you were ")
      
      if APPLY(function() __tmp = INQ(WINNER, PRSO) return __tmp end) then 
        	__tmp = TELL("in")
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("holding")
      end

      	__tmp = JIGS_UP(" it at the time.")
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = REMOVE_CAREFULLY(PRSO)
      	__tmp = TELL("The ", D, PRSO, " catches fire and is consumed.", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't burn a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_BURN\n'..__res) end
end
_V_BURN = {
}
V_CHOMP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Preposterous!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CHOMP\n'..__res) end
end
_V_CHOMP = {
}
V_CLIMB_DOWN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_CLIMB_UP(PQDOWN, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_DOWN\n'..__res) end
end
_V_CLIMB_DOWN = {
}
V_CLIMB_FOO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_CLIMB_UP(PQUP, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_FOO\n'..__res) end
end
_V_CLIMB_FOO = {
}
V_CLIMB_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, VEHBIT) return __tmp end) then 
    	__tmp = PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't climb onto the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_ON\n'..__res) end
end
_V_CLIMB_ON = {
}
V_CLIMB_UP = function(...)
	local DIR, OBJ = ...
	local X
	local TX
	if select('#', ...) < 1 then DIR = PQUP end
	if select('#', ...) < 2 then OBJ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(OBJ and NOT(EQUALQ(PRSO, ROOMS))) return __tmp end) then 
    	__tmp = APPLY(function() OBJ = PRSO return OBJ end)
  end


  if APPLY(function() __tmp = APPLY(function() TX = GETPT(HERE, DIR) return TX end) return __tmp end) then 
    
    if APPLY(function() __tmp = OBJ return __tmp end) then 
      	__tmp = APPLY(function() X = PTSIZE(TX) return X end)
      
      if APPLY(function() __tmp = PASS(EQUALQ(X, NEXIT) or PASS(EQUALQ(X, CEXIT, DEXIT, UEXIT) and NOT(GLOBAL_INQ(PRSO, GETB(TX, 0))))) return __tmp end) then 
        	__tmp = TELL("The ", D, OBJ, " do")
        
        if APPLY(function() __tmp = NOT(EQUALQ(OBJ, STAIRS)) return __tmp end) then 
          	__tmp = TELL("es")
        end

        	__tmp = TELL("n't lead ")
        
        if APPLY(function() __tmp = EQUALQ(DIR, PQUP) return __tmp end) then 
          	__tmp = TELL("up")
        elseif APPLY(function() __tmp = T return __tmp end) then 
          	__tmp = TELL("down")
        end

        	__tmp = TELL("ward.", CR)
        	error(true)
      end

    end

    	__tmp = DO_WALK(DIR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(OBJ and ZMEMQ(WQWALL, APPLY(function() X = GETPT(PRSO, PQSYNONYM) return X end), PTSIZE(X))) return __tmp end) then 
    	__tmp = TELL("Climbing the walls is to no avail.", CR)
  elseif APPLY(function() __tmp = PASS(NOT(EQUALQ(HERE, PATH)) and EQUALQ(OBJ, nil, TREE) and GLOBAL_INQ(TREE, HERE)) return __tmp end) then 
    	__tmp = TELL("There are no climbable trees here.", CR)
    	error(true)
  elseif APPLY(function() __tmp = EQUALQ(OBJ, nil, ROOMS) return __tmp end) then 
    	__tmp = TELL("You can't go that way.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't do that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLIMB_UP\n'..__res) end
end
_V_CLIMB_UP = {
}
V_CLOSE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(NOT(FSETQ(PRSO, CONTBIT)) and NOT(FSETQ(PRSO, DOORBIT))) return __tmp end) then 
    	__tmp = TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  elseif APPLY(function() __tmp = PASS(NOT(FSETQ(PRSO, SURFACEBIT)) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      	__tmp = FCLEAR(PRSO, OPENBIT)
      	__tmp = TELL("Closed.", CR)
      
      if APPLY(function() __tmp = PASS(LIT and NOT(APPLY(function() LIT = LITQ(HERE) return LIT end))) return __tmp end) then 
        	__tmp = TELL("It is now pitch black.", CR)
      end

      	error(true)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("It is already closed.", CR)
    end

  elseif APPLY(function() __tmp = FSETQ(PRSO, DOORBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      	__tmp = FCLEAR(PRSO, OPENBIT)
      	__tmp = TELL("The ", D, PRSO, " is now closed.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("It is already closed.", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You cannot close that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CLOSE\n'..__res) end
end
_V_CLOSE = {
}
V_COMMAND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " pays no attention.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You cannot talk to that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_COMMAND\n'..__res) end
end
_V_COMMAND = {
}
V_COUNT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSO, BLESSINGS) return __tmp end) then 
    	__tmp = TELL("Well, for one, you are playing Zork...", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You have lost your mind.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_COUNT\n'..__res) end
end
_V_COUNT = {
}
V_CROSS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't cross that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CROSS\n'..__res) end
end
_V_CROSS = {
}
V_CURSES = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PRSO return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
      	__tmp = TELL("Insults of this nature won't help you.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("What a loony!", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Such language in a high-class establishment like this!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CURSES\n'..__res) end
end
_V_CURSES = {
}
V_CUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = PERFORM(VQATTACK, PRSO, PRSI)
  elseif APPLY(function() __tmp = PASS(FSETQ(PRSO, BURNBIT) and FSETQ(PRSI, WEAPONBIT)) return __tmp end) then 
    
    if APPLY(function() __tmp = INQ(WINNER, PRSO) return __tmp end) then 
      	__tmp = TELL("Not a bright idea, especially since you're in it.", CR)
      	error(true)
    end

    	__tmp = REMOVE_CAREFULLY(PRSO)
    	__tmp = TELL("Your skillful ", D, PRSI, "smanship slices the ", D, PRSO, " into innumerable slivers which blow away.", CR)
  elseif APPLY(function() __tmp = NOT(FSETQ(PRSI, WEAPONBIT)) return __tmp end) then 
    	__tmp = TELL("The \"cutting edge\" of a ", D, PRSI, " is hardly adequate.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Strange concept, cutting the ", D, PRSO, "....", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_CUT\n'..__res) end
end
_V_CUT = {
}
V_DEFLATE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Come on, now!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DEFLATE\n'..__res) end
end
_V_DEFLATE = {
}
V_DIG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
    	__tmp = APPLY(function() PRSI = HANDS return PRSI end)
  end


  if APPLY(function() __tmp = EQUALQ(PRSI, SHOVEL) return __tmp end) then 
    	__tmp = TELL("There's no reason to be digging here.", CR)
    	error(true)
  end


  if APPLY(function() __tmp = FSETQ(PRSI, TOOLBIT) return __tmp end) then 
    	__tmp = TELL("Digging with the ", D, PRSI, " is slow and tedious.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Digging with a ", D, PRSI, " is silly.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DIG\n'..__res) end
end
_V_DIG = {
}
V_DISEMBARK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(EQUALQ(PRSO, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) return __tmp end) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif APPLY(function() __tmp = NOT(EQUALQ(LOC(WINNER), PRSO)) return __tmp end) then 
    	__tmp = TELL("You're not in that!", CR)
    	__tmp = 	error(2)
  elseif APPLY(function() __tmp = FSETQ(HERE, RLANDBIT) return __tmp end) then 
    	__tmp = TELL("You are on your own feet again.", CR)
    	__tmp = MOVE(WINNER, HERE)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You realize that getting out here would be fatal.", CR)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DISEMBARK\n'..__res) end
end
_V_DISEMBARK = {
}
V_DISENCHANT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Nothing happens.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DISENCHANT\n'..__res) end
end
_V_DISENCHANT = {
}
V_DRINK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_EAT()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DRINK\n'..__res) end
end
_V_DRINK = {
}
V_DRINK_FROM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How peculiar!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DRINK_FROM\n'..__res) end
end
_V_DRINK_FROM = {
}
PRE_DROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSO, LOC(WINNER)) return __tmp end) then 
    	__tmp = PERFORM(VQDISEMBARK, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_DROP\n'..__res) end
end
_PRE_DROP = {
}
V_DROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = IDROP() return __tmp end) then 
    	__tmp = TELL("Dropped.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_DROP\n'..__res) end
end
_V_DROP = {
}
V_EAT = function(...)
  local EATQ = nil
  local DRINKQ = nil
  local NOBJ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() EATQ = FSETQ(PRSO, FOODBIT) return EATQ end) return __tmp end) then 
    
    if APPLY(function() __tmp = PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) return __tmp end) then 
      	__tmp = TELL("You're not holding that.", CR)
    elseif APPLY(function() __tmp = VERBQ(DRINK) return __tmp end) then 
      	__tmp = TELL("How can you drink that?")
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("Thank you very much. It really hit the spot.")
      	__tmp = REMOVE_CAREFULLY(PRSO)
    end

    	__tmp = CRLF()
  elseif APPLY(function() __tmp = FSETQ(PRSO, DRINKBIT) return __tmp end) then 
    	__tmp = APPLY(function() DRINKQ = T return DRINKQ end)
    	__tmp = APPLY(function() NOBJ = LOC(PRSO) return NOBJ end)
    
    if APPLY(function() __tmp = PASS(INQ(PRSO, GLOBAL_OBJECTS) or GLOBAL_INQ(GLOBAL_WATER, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) return __tmp end) then 
      	__tmp = HIT_SPOT()
    elseif APPLY(function() __tmp = PASS(NOT(NOBJ) or NOT(ACCESSIBLEQ(NOBJ))) return __tmp end) then 
      	__tmp = TELL("There isn't any water here.", CR)
    elseif APPLY(function() __tmp = PASS(ACCESSIBLEQ(NOBJ) and NOT(INQ(NOBJ, WINNER))) return __tmp end) then 
      	__tmp = TELL("You have to be holding the ", D, NOBJ, " first.", CR)
    elseif APPLY(function() __tmp = NOT(FSETQ(NOBJ, OPENBIT)) return __tmp end) then 
      	__tmp = TELL("You'll have to open the ", D, NOBJ, " first.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = HIT_SPOT()
    end

  elseif APPLY(function() __tmp = NOT(PASS(EATQ or DRINKQ)) return __tmp end) then 
    	__tmp = TELL("I don't think that the ", D, PRSO, " would agree with you.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EAT\n'..__res) end
end
_V_EAT = {
	'DRINK',
}
HIT_SPOT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(EQUALQ(PRSO, WATER) and NOT(GLOBAL_INQ(GLOBAL_WATER, HERE))) return __tmp end) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
  end

	__tmp =   TELL("Thank you very much. I was rather thirsty (from all this talking, probably).", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HIT_SPOT\n'..__res) end
end
_HIT_SPOT = {
}
V_ECHO = function(...)
	local LST
	local MAX
  local ECH = 0
	local CNT
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = GQ(GETB(P_LEXV, P_LEXWORDS), 0) return __tmp end) then 
    	__tmp = APPLY(function() LST = REST(P_LEXV, MULL(GETB(P_LEXV, P_LEXWORDS), P_WORDLEN)) return LST end)
    	__tmp = APPLY(function() MAX = SUB(ADD(GETB(LST, 0), GETB(LST, 1)), 1) return MAX end)
    
    local __prog30 = function()
      
      if APPLY(function() __tmp = GQ(APPLY(function() ECH = ADD(ECH, 1) return ECH end), 2) return __tmp end) then 
        	__tmp = TELL("...", CR)
        return true
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = APPLY(function() CNT = SUB(GETB(LST, 1), 1) return CNT end)
        
        local __prog31 = function()
          
          if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), MAX) return __tmp end) then 
            return true
          elseif APPLY(function() __tmp = T return __tmp end) then 
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

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("echo echo ...", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ECHO\n'..__res) end
end
_V_ECHO = {
}
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
_V_ENCHANT = {
}
REMOVE_CAREFULLY = function(...)
	local OBJ = ...
	local OLIT
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(OBJ, P_IT_OBJECT) return __tmp end) then 
    	__tmp = APPLY(function() P_IT_OBJECT = nil return P_IT_OBJECT end)
  end

	__tmp = APPLY(function() OLIT = LIT return OLIT end)
	__tmp =   REMOVE(OBJ)
	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)

  if APPLY(function() __tmp = PASS(OLIT and NOT(EQUALQ(OLIT, LIT))) return __tmp end) then 
    	__tmp = TELL("You are left in the dark...", CR)
  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('REMOVE_CAREFULLY\n'..__res) end
end
_REMOVE_CAREFULLY = {
}
V_ENTER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   DO_WALK(PQIN)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ENTER\n'..__res) end
end
_V_ENTER = {
}
V_EXAMINE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = GETP(PRSO, PQTEXT) return __tmp end) then 
    	__tmp = TELL(GETP(PRSO, PQTEXT), CR)
  elseif APPLY(function() __tmp = PASS(FSETQ(PRSO, CONTBIT) or FSETQ(PRSO, DOORBIT)) return __tmp end) then 
    	__tmp = V_LOOK_INSIDE()
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("There's nothing special about the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EXAMINE\n'..__res) end
end
_V_EXAMINE = {
}
V_EXIT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(EQUALQ(PRSO, nil, ROOMS) and FSETQ(LOC(WINNER), VEHBIT)) return __tmp end) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif APPLY(function() __tmp = PASS(PRSO and INQ(WINNER, PRSO)) return __tmp end) then 
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
_V_EXIT = {
}
V_EXORCISE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("What a bizarre concept!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_EXORCISE\n'..__res) end
end
_V_EXORCISE = {
}
PRE_FILL = function(...)
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
    	__tmp = APPLY(function() TX = GETPT(HERE, PQGLOBAL) return TX end)
    
    if APPLY(function() __tmp = PASS(TX and ZMEMQB(GLOBAL_WATER, TX, SUB(PTSIZE(TX), 1))) return __tmp end) then 
      	__tmp = PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif APPLY(function() __tmp = INQ(WATER, LOC(WINNER)) return __tmp end) then 
      	__tmp = PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("There is nothing to fill it with.", CR)
      	error(true)
    end

  end


  if APPLY(function() __tmp = EQUALQ(PRSI, WATER) return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = NOT(EQUALQ(PRSI, GLOBAL_WATER)) return __tmp end) then 
    	__tmp = PERFORM(VQPUT, PRSI, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_FILL\n'..__res) end
end
_PRE_FILL = {
}
V_FILL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
    
    if APPLY(function() __tmp = GLOBAL_INQ(GLOBAL_WATER, HERE) return __tmp end) then 
      	__tmp = PERFORM(VQFILL, PRSO, GLOBAL_WATER)
      	error(true)
    elseif APPLY(function() __tmp = INQ(WATER, LOC(WINNER)) return __tmp end) then 
      	__tmp = PERFORM(VQFILL, PRSO, WATER)
      	error(true)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("There's nothing to fill it with.", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You may know how to do that, but I don't.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FILL\n'..__res) end
end
_V_FILL = {
}
V_FIND = function(...)
  local L = LOC(PRSO)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSO, HANDS, LUNGS) return __tmp end) then 
    	__tmp = TELL("Within six feet of your head, assuming you haven't left that somewhere.", CR)
  elseif APPLY(function() __tmp = EQUALQ(PRSO, ME) return __tmp end) then 
    	__tmp = TELL("You're around here somewhere...", CR)
  elseif APPLY(function() __tmp = EQUALQ(L, GLOBAL_OBJECTS) return __tmp end) then 
    	__tmp = TELL("You find it.", CR)
  elseif APPLY(function() __tmp = INQ(PRSO, WINNER) return __tmp end) then 
    	__tmp = TELL("You have it.", CR)
  elseif APPLY(function() __tmp = PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE) or EQUALQ(PRSO, PSEUDO_OBJECT)) return __tmp end) then 
    	__tmp = TELL("It's right here.", CR)
  elseif APPLY(function() __tmp = FSETQ(L, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("The ", D, L, " has it.", CR)
  elseif APPLY(function() __tmp = FSETQ(L, SURFACEBIT) return __tmp end) then 
    	__tmp = TELL("It's on the ", D, L, ".", CR)
  elseif APPLY(function() __tmp = FSETQ(L, CONTBIT) return __tmp end) then 
    	__tmp = TELL("It's in the ", D, L, ".", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Beats me.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FIND\n'..__res) end
end
_V_FIND = {
}
V_FOLLOW = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You're nuts!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FOLLOW\n'..__res) end
end
_V_FOLLOW = {
}
V_FROBOZZ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The FROBOZZ Corporation created, owns, and operates this dungeon.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FROBOZZ\n'..__res) end
end
_V_FROBOZZ = {
}
PRE_GIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(HELDQ(PRSO)) return __tmp end) then 
    	__tmp = TELL("That's easy for you to say since you don't even have the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_GIVE\n'..__res) end
end
_PRE_GIVE = {
}
V_GIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(FSETQ(PRSI, ACTORBIT)) return __tmp end) then 
    	__tmp = TELL("You can't give a ", D, PRSO, " to a ", D, PRSI, "!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("The ", D, PRSI, " refuses it politely.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_GIVE\n'..__res) end
end
_V_GIVE = {
}
V_HATCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Bizarre!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_HATCH\n'..__res) end
end
_V_HATCH = {
}
HS = 0
V_HELLO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PRSO return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " bows his head to you in greeting.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("It's a well known fact that only schizophrenics say \"Hello\" to a ", D, PRSO, ".", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(PICK_ONE(HELLOS), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_HELLO\n'..__res) end
end
_V_HELLO = {
}
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
_V_INCANT = {
}
V_INFLATE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How can you inflate that?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_INFLATE\n'..__res) end
end
_V_INFLATE = {
}
V_KICK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Kicking the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KICK\n'..__res) end
end
_V_KICK = {
}
V_KISS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("I'd sooner kiss a pig.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KISS\n'..__res) end
end
_V_KISS = {
}
V_KNOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, DOORBIT) return __tmp end) then 
    	__tmp = TELL("Nobody's home.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Why knock on a ", D, PRSO, "?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_KNOCK\n'..__res) end
end
_V_KNOCK = {
}
V_LAMP_OFF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, LIGHTBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = NOT(FSETQ(PRSO, ONBIT)) return __tmp end) then 
      	__tmp = TELL("It is already off.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = FCLEAR(PRSO, ONBIT)
      
      if APPLY(function() __tmp = LIT return __tmp end) then 
        	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
      end

      	__tmp = TELL("The ", D, PRSO, " is now off.", CR)
      
      if APPLY(function() __tmp = NOT(LIT) return __tmp end) then 
        	__tmp = TELL("It is now pitch black.", CR)
      end

    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't turn that off.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAMP_OFF\n'..__res) end
end
_V_LAMP_OFF = {
}
V_LAMP_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, LIGHTBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, ONBIT) return __tmp end) then 
      	__tmp = TELL("It is already on.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = FSET(PRSO, ONBIT)
      	__tmp = TELL("The ", D, PRSO, " is now on.", CR)
      
      if APPLY(function() __tmp = NOT(LIT) return __tmp end) then 
        	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
        	__tmp = CRLF()
        	__tmp = V_LOOK()
      end

    end

  elseif APPLY(function() __tmp = FSETQ(PRSO, BURNBIT) return __tmp end) then 
    	__tmp = TELL("If you wish to burn the ", D, PRSO, ", you should say so.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't turn that on.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAMP_ON\n'..__res) end
end
_V_LAMP_ON = {
}
V_LAUNCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, VEHBIT) return __tmp end) then 
    	__tmp = TELL("You can't launch that by saying \"launch\"!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("That's pretty weird.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LAUNCH\n'..__res) end
end
_V_LAUNCH = {
}
V_LEAN_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Getting tired?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LEAN_ON\n'..__res) end
end
_V_LEAN_ON = {
}
V_LEAP = function(...)
	local TX
	local S
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PRSO return __tmp end) then 
    
    if APPLY(function() __tmp = INQ(PRSO, HERE) return __tmp end) then 
      
      if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
        	__tmp = TELL("The ", D, PRSO, " is too big to jump over.", CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = V_SKIP()
      end

    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("That would be a good trick.", CR)
    end

  elseif APPLY(function() __tmp = APPLY(function() TX = GETPT(HERE, PQDOWN) return TX end) return __tmp end) then 
    	__tmp = APPLY(function() S = PTSIZE(TX) return S end)
    
    if APPLY(function() __tmp = PASS(EQUALQ(S, 2) or PASS(EQUALQ(S, 4) and NOT(VALUE(GETB(TX, 1))))) return __tmp end) then 
      	__tmp = TELL("This was not a very safe place to try jumping.", CR)
      	__tmp = JIGS_UP(PICK_ONE(JUMPLOSS))
    elseif APPLY(function() __tmp = EQUALQ(HERE, UP_A_TREE) return __tmp end) then 
      	__tmp = TELL("In a feat of unaccustomed daring, you manage to land on your feet without killing yourself.", CR, CR)
      	__tmp = DO_WALK(PQDOWN)
      	error(true)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = V_SKIP()
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = V_SKIP()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LEAP\n'..__res) end
end
_V_LEAP = {
}
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
_V_LEAVE = {
}
V_LISTEN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("The ", D, PRSO, " makes no sound.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LISTEN\n'..__res) end
end
_V_LISTEN = {
}
V_LOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It doesn't seem to work.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOCK\n'..__res) end
end
_V_LOCK = {
}
V_LOOK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = DESCRIBE_ROOM(T) return __tmp end) then 
    	__tmp = DESCRIBE_OBJECTS(T)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK\n'..__res) end
end
_V_LOOK = {
}
V_LOOK_BEHIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("There is nothing behind the ", D, PRSO, ".", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_BEHIND\n'..__res) end
end
_V_LOOK_BEHIND = {
}
V_LOOK_INSIDE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, DOORBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " is open, but I can't tell what's beyond it.")
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " is closed.")
    end

    	__tmp = CRLF()
  elseif APPLY(function() __tmp = FSETQ(PRSO, CONTBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
      	__tmp = TELL("There is nothing special to be seen.", CR)
    elseif APPLY(function() __tmp = SEE_INSIDEQ(PRSO) return __tmp end) then 
      
      if APPLY(function() __tmp = PASS(FIRSTQ(PRSO) and PRINT_CONT(PRSO)) return __tmp end) then 
        	error(true)
      elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
        	error(true)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("The ", D, PRSO, " is empty.", CR)
      end

    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " is closed.", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't look inside a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_INSIDE\n'..__res) end
end
_V_LOOK_INSIDE = {
}
V_LOOK_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, SURFACEBIT) return __tmp end) then 
    	__tmp = PERFORM(VQLOOK_INSIDE, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Look on a ", D, PRSO, "???", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_ON\n'..__res) end
end
_V_LOOK_ON = {
}
V_LOOK_UNDER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("There is nothing but dust there.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOOK_UNDER\n'..__res) end
end
_V_LOOK_UNDER = {
}
V_LOWER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Playing in this way with the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_LOWER\n'..__res) end
end
_V_LOWER = {
}
V_MAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't do that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MAKE\n'..__res) end
end
_V_MAKE = {
}
V_MELT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It's not clear that a ", D, PRSO, " can be melted.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MELT\n'..__res) end
end
_V_MELT = {
}
PRE_MOVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = HELDQ(PRSO) return __tmp end) then 
    	__tmp = TELL("You aren't an accomplished enough juggler.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_MOVE\n'..__res) end
end
_PRE_MOVE = {
}
V_MOVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, TAKEBIT) return __tmp end) then 
    	__tmp = TELL("Moving the ", D, PRSO, " reveals nothing.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't move the ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MOVE\n'..__res) end
end
_V_MOVE = {
}
V_MUMBLE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You'll have to speak up if you expect me to hear you!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MUMBLE\n'..__res) end
end
_V_MUMBLE = {
}
PRE_MUNG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(true)
  elseif APPLY(function() __tmp = PASS(NOT(PRSI) or NOT(FSETQ(PRSI, WEAPONBIT))) return __tmp end) then 
    	__tmp = TELL("Trying to destroy the ", D, PRSO, " with ")
    
    if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
      	__tmp = TELL("your bare hands")
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("a ", D, PRSI)
    end

    	__tmp = TELL(" is futile.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_MUNG\n'..__res) end
end
_PRE_MUNG = {
}
V_MUNG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = PERFORM(VQATTACK, PRSO, PRSI)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Nice try.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_MUNG\n'..__res) end
end
_V_MUNG = {
}
V_ODYSSEUS = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(EQUALQ(HERE, CYCLOPS_ROOM) and INQ(CYCLOPS, HERE) and NOT(CYCLOPS_FLAG)) return __tmp end) then 
    	__tmp = DISABLE(INT(I_CYCLOPS))
    	__tmp = APPLY(function() CYCLOPS_FLAG = T return CYCLOPS_FLAG end)
    	__tmp = TELL("The cyclops, hearing the name of his father's deadly nemesis, flees the room by knocking down the wall on the east of the room.", CR)
    	__tmp = APPLY(function() MAGIC_FLAG = T return MAGIC_FLAG end)
    	__tmp = FCLEAR(CYCLOPS, FIGHTBIT)
    	__tmp = REMOVE_CAREFULLY(CYCLOPS)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Wasn't he a sailor?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ODYSSEUS\n'..__res) end
end
_V_ODYSSEUS = {
}
V_OIL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You probably put spinach in your gas tank, too.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OIL\n'..__res) end
end
_V_OIL = {
}
V_OPEN = function(...)
	local F
	local STR
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(FSETQ(PRSO, CONTBIT) and NOT(EQUALQ(GETP(PRSO, PQCAPACITY), 0))) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      	__tmp = TELL("It is already open.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = FSET(PRSO, OPENBIT)
      	__tmp = FSET(PRSO, TOUCHBIT)
      
      if APPLY(function() __tmp = PASS(NOT(FIRSTQ(PRSO)) or FSETQ(PRSO, TRANSBIT)) return __tmp end) then 
        	__tmp = TELL("Opened.", CR)
      elseif APPLY(function() __tmp = PASS(APPLY(function() F = FIRSTQ(PRSO) return F end) and NOT(NEXTQ(F)) and NOT(FSETQ(F, TOUCHBIT)) and APPLY(function() STR = GETP(F, PQFDESC) return STR end)) return __tmp end) then 
        	__tmp = TELL("The ", D, PRSO, " opens.", CR)
        	__tmp = TELL(STR, CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("Opening the ", D, PRSO, " reveals ")
        	__tmp = PRINT_CONTENTS(PRSO)
        	__tmp = TELL(".", CR)
      end

    end

  elseif APPLY(function() __tmp = FSETQ(PRSO, DOORBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      	__tmp = TELL("It is already open.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " opens.", CR)
      	__tmp = FSET(PRSO, OPENBIT)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You must tell me how to do that to a ", D, PRSO, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OPEN\n'..__res) end
end
_V_OPEN = {
}
V_OVERBOARD = function(...)
	local LOCN
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSI, TEETH) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(APPLY(function() LOCN = LOC(WINNER) return LOCN end), VEHBIT) return __tmp end) then 
      	__tmp = MOVE(PRSO, LOC(LOCN))
      	__tmp = TELL("Ahoy -- ", D, PRSO, " overboard!", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("You're not in anything!", CR)
    end

  elseif APPLY(function() __tmp = FSETQ(LOC(WINNER), VEHBIT) return __tmp end) then 
    	__tmp = PERFORM(VQTHROW, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Huh?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_OVERBOARD\n'..__res) end
end
_V_OVERBOARD = {
}
V_PICK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't pick that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PICK\n'..__res) end
end
_V_PICK = {
}
V_PLAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
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
_V_PLAY = {
}
V_PLUG = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This has no effect.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PLUG\n'..__res) end
end
_V_PLUG = {
}
V_POUR_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSO, WATER) return __tmp end) then 
    	__tmp = REMOVE_CAREFULLY(PRSO)
    
    if APPLY(function() __tmp = FLAMINGQ(PRSI) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSI, " is extinguished.", CR)
      	__tmp = NULL_F()
      	__tmp = FCLEAR(PRSI, ONBIT)
      	__tmp = FCLEAR(PRSI, FLAMEBIT)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The water spills over the ", D, PRSI, ", to the floor, and evaporates.", CR)
    end

  elseif APPLY(function() __tmp = EQUALQ(PRSO, PUTTY) return __tmp end) then 
    	__tmp = PERFORM(VQPUT, PUTTY, PRSI)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't pour that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_POUR_ON\n'..__res) end
end
_V_POUR_ON = {
}
V_PRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(HERE, SOUTH_TEMPLE) return __tmp end) then 
    	__tmp = GOTO(FOREST_1)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("If you pray enough, your prayers may be answered.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PRAY\n'..__res) end
end
_V_PRAY = {
}
V_PUMP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(PRSI and NOT(EQUALQ(PRSI, PUMP))) return __tmp end) then 
    	__tmp = TELL("Pump it up with a ", D, PRSI, "?", CR)
  elseif APPLY(function() __tmp = INQ(PUMP, WINNER) return __tmp end) then 
    	__tmp = PERFORM(VQINFLATE, PRSO, PUMP)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("It's really not clear how.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUMP\n'..__res) end
end
_V_PUMP = {
}
V_PUSH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Pushing the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUSH\n'..__res) end
end
_V_PUSH = {
}
V_PUSH_TO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't push things to that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUSH_TO\n'..__res) end
end
_V_PUSH_TO = {
}
PRE_PUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = PRE_GIVE()
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_PUT\n'..__res) end
end
_PRE_PUT = {
}
V_PUT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(FSETQ(PRSI, OPENBIT) or OPENABLEQ(PRSI) or FSETQ(PRSI, VEHBIT)) return __tmp end) then 
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't do that.", CR)
    	error(true)
  end


  if APPLY(function() __tmp = NOT(FSETQ(PRSI, OPENBIT)) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSI, " isn't open.", CR)
    	__tmp = THIS_IS_IT(PRSI)
  elseif APPLY(function() __tmp = EQUALQ(PRSI, PRSO) return __tmp end) then 
    	__tmp = TELL("How can you do that?", CR)
  elseif APPLY(function() __tmp = INQ(PRSO, PRSI) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " is already in the ", D, PRSI, ".", CR)
  elseif APPLY(function() __tmp = GQ(SUB(ADD(WEIGHT(PRSI), WEIGHT(PRSO)), GETP(PRSI, PQSIZE)), GETP(PRSI, PQCAPACITY)) return __tmp end) then 
    	__tmp = TELL("There's no room.", CR)
  elseif APPLY(function() __tmp = PASS(NOT(HELDQ(PRSO)) and FSETQ(PRSO, TRYTAKEBIT)) return __tmp end) then 
    	__tmp = TELL("You don't have the ", D, PRSO, ".", CR)
    	error(true)
  elseif APPLY(function() __tmp = PASS(NOT(HELDQ(PRSO)) and NOT(ITAKE())) return __tmp end) then 
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
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
_V_PUT = {
}
V_PUT_BEHIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("That hiding place is too obvious.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_BEHIND\n'..__res) end
end
_V_PUT_BEHIND = {
}
V_PUT_ON = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSI, GROUND) return __tmp end) then 
    	__tmp = PERFORM(VQDROP, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = FSETQ(PRSI, SURFACEBIT) return __tmp end) then 
    	__tmp = V_PUT()
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("There's no good surface on the ", D, PRSI, ".", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_ON\n'..__res) end
end
_V_PUT_ON = {
}
V_PUT_UNDER = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't do that.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_PUT_UNDER\n'..__res) end
end
_V_PUT_UNDER = {
}
V_RAISE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_LOWER()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RAISE\n'..__res) end
end
_V_RAISE = {
}
V_RAPE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("What a (ahem!) strange idea.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RAPE\n'..__res) end
end
_V_RAPE = {
}
PRE_READ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(LIT) return __tmp end) then 
    	__tmp = TELL("It is impossible to read in the dark.", CR)
  elseif APPLY(function() __tmp = PASS(PRSI and NOT(FSETQ(PRSI, TRANSBIT))) return __tmp end) then 
    	__tmp = TELL("How does one look through a ", D, PRSI, "?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_READ\n'..__res) end
end
_PRE_READ = {
}
V_READ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(FSETQ(PRSO, READBIT)) return __tmp end) then 
    	__tmp = TELL("How does one read a ", D, PRSO, "?", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(GETP(PRSO, PQTEXT), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_READ\n'..__res) end
end
_V_READ = {
}
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
_V_READ_PAGE = {
}
V_REPENT = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("It could very well be too late!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_REPENT\n'..__res) end
end
_V_REPENT = {
}
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
_V_REPLY = {
}
V_RING = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("How, exactly, can you ring that?", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RING\n'..__res) end
end
_V_RING = {
}
V_RUB = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Fiddling with the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_RUB\n'..__res) end
end
_V_RUB = {
}
V_SAY = function(...)
	local V
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(P_CONT) return __tmp end) then 
    	__tmp = TELL("Say what?", CR)
    	error(true)
  end

	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)

  if APPLY(function() __tmp = APPLY(function() V = FIND_IN(HERE, ACTORBIT) return V end) return __tmp end) then 
    	__tmp = TELL("You must address the ", D, V, " directly.", CR)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif APPLY(function() __tmp = NOT(EQUALQ(GET(P_LEXV, P_CONT), WQHELLO)) return __tmp end) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    	__tmp = TELL("Talking to yourself is a sign of impending mental collapse.", CR)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SAY\n'..__res) end
end
_V_SAY = {
}
V_SEARCH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You find nothing unusual.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SEARCH\n'..__res) end
end
_V_SEARCH = {
}
V_SEND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("Why would you send for the ", D, PRSO, "?", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("That doesn't make sends.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SEND\n'..__res) end
end
_V_SEND = {
}
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
_PRE_SGIVE = {
}
V_SGIVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Foo!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SGIVE\n'..__res) end
end
_V_SGIVE = {
}
V_SHAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("This seems to have no effect.", CR)
  elseif APPLY(function() __tmp = NOT(FSETQ(PRSO, TAKEBIT)) return __tmp end) then 
    	__tmp = TELL("You can't take it; thus, you can't shake it!", CR)
  elseif APPLY(function() __tmp = FSETQ(PRSO, CONTBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, OPENBIT) return __tmp end) then 
      
      if APPLY(function() __tmp = FIRSTQ(PRSO) return __tmp end) then 
        	__tmp = SHAKE_LOOP()
        	__tmp = TELL("The contents of the ", D, PRSO, " spill ")
        
        if APPLY(function() __tmp = NOT(FSETQ(HERE, RLANDBIT)) return __tmp end) then 
          	__tmp = TELL("out and disappear")
        elseif APPLY(function() __tmp = T return __tmp end) then 
          	__tmp = TELL("to the ground")
        end

        	__tmp = TELL(".", CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("Shaken.", CR)
      end

    elseif APPLY(function() __tmp = T return __tmp end) then 
      
      if APPLY(function() __tmp = FIRSTQ(PRSO) return __tmp end) then 
        	__tmp = TELL("It sounds like there is something inside the ", D, PRSO, ".", CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("The ", D, PRSO, " sounds empty.", CR)
      end

    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Shaken.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SHAKE\n'..__res) end
end
_V_SHAKE = {
}
SHAKE_LOOP = function(...)
	local X
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog32 = function()
    
    if APPLY(function() __tmp = APPLY(function() X = FIRSTQ(PRSO) return X end) return __tmp end) then 
      	__tmp = FSET(X, TOUCHBIT)
      	__tmp = MOVE(X, APPLY(function()
        if APPLY(function() __tmp = EQUALQ(HERE, UP_A_TREE) return __tmp end) then 
          	__tmp = PATH
        elseif APPLY(function() __tmp = NOT(FSETQ(HERE, RLANDBIT)) return __tmp end) then 
          	__tmp = PSEUDO_OBJECT
        elseif APPLY(function() __tmp = T return __tmp end) then 
          	__tmp = HERE
        end
 end))
    elseif APPLY(function() __tmp = T return __tmp end) then 
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
_SHAKE_LOOP = {
}
V_SKIP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL(PICK_ONE(WHEEEEE), CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SKIP\n'..__res) end
end
_V_SKIP = {
}
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
_V_SMELL = {
}
V_SPIN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't spin that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SPIN\n'..__res) end
end
_V_SPIN = {
}
V_SPRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_SQUEEZE()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SPRAY\n'..__res) end
end
_V_SPRAY = {
}
V_SQUEEZE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " does not understand this.")
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("How singularly useless.")
  end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SQUEEZE\n'..__res) end
end
_V_SQUEEZE = {
}
V_SSPRAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PERFORM(VQSPRAY, PRSI, PRSO)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SSPRAY\n'..__res) end
end
_V_SSPRAY = {
}
V_STAB = function(...)
	local W
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() W = FIND_WEAPON(WINNER) return W end) return __tmp end) then 
    	__tmp = PERFORM(VQATTACK, PRSO, W)
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("No doubt you propose to stab the ", D, PRSO, " with your pinky?", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAB\n'..__res) end
end
_V_STAB = {
}
V_STAND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(LOC(WINNER), VEHBIT) return __tmp end) then 
    	__tmp = PERFORM(VQDISEMBARK, LOC(WINNER))
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You are already standing, I think.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAND\n'..__res) end
end
_V_STAND = {
}
V_STAY = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You will be lost without me!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STAY\n'..__res) end
end
_V_STAY = {
}
V_STRIKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    	__tmp = TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", D, PRSO, " with a weapon.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = PERFORM(VQLAMP_ON, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_STRIKE\n'..__res) end
end
_V_STRIKE = {
}
V_SWIM = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(HERE, ON_LAKE, IN_LAKE) return __tmp end) then 
    	__tmp = TELL("What do you think you're doing?", CR)
  elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Go jump in a lake!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SWIM\n'..__res) end
end
_V_SWIM = {
}
V_SWING = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(PRSI) return __tmp end) then 
    	__tmp = TELL("Whoosh!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = PERFORM(VQATTACK, PRSI, PRSO)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_SWING\n'..__res) end
end
_V_SWING = {
}
PRE_TAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = INQ(PRSO, WINNER) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, WEARBIT) return __tmp end) then 
      	__tmp = TELL("You are already wearing it.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("You already have that!", CR)
    end

  elseif APPLY(function() __tmp = PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) return __tmp end) then 
    	__tmp = TELL("You can't reach something that's inside a closed container.", CR)
    	error(true)
  elseif APPLY(function() __tmp = PRSI return __tmp end) then 
    
    if APPLY(function() __tmp = EQUALQ(PRSI, GROUND) return __tmp end) then 
      	__tmp = APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

    	__tmp = NULL_F()
    
    if APPLY(function() __tmp = NOT(EQUALQ(PRSI, LOC(PRSO))) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " isn't in the ", D, PRSI, ".", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = APPLY(function() PRSI = nil return PRSI end)
      	error(false)
    end

  elseif APPLY(function() __tmp = EQUALQ(PRSO, LOC(WINNER)) return __tmp end) then 
    	__tmp = TELL("You're inside of it!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_TAKE\n'..__res) end
end
_PRE_TAKE = {
}
V_TAKE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(ITAKE(), T) return __tmp end) then 
    
    if APPLY(function() __tmp = FSETQ(PRSO, WEARBIT) return __tmp end) then 
      	__tmp = TELL("You are now wearing the ", D, PRSO, ".", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("Taken.", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TAKE\n'..__res) end
end
_V_TAKE = {
}
V_TELL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = FSETQ(PRSO, ACTORBIT) return __tmp end) then 
    
    if APPLY(function() __tmp = P_CONT return __tmp end) then 
      	__tmp = APPLY(function() WINNER = PRSO return WINNER end)
      	__tmp = APPLY(function() HERE = LOC(WINNER) return HERE end)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The ", D, PRSO, " pauses for a moment, perhaps thinking that you should reread the manual.", CR)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
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
_V_TELL = {
}
V_THROUGH = function(...)
	local OBJ = ...
	local M
	if select('#', ...) < 1 then OBJ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(FSETQ(PRSO, DOORBIT) and APPLY(function() M = OTHER_SIDE(PRSO) return M end)) return __tmp end) then 
    	__tmp = DO_WALK(M)
    	error(true)
  elseif APPLY(function() __tmp = PASS(NOT(OBJ) and FSETQ(PRSO, VEHBIT)) return __tmp end) then 
    	__tmp = PERFORM(VQBOARD, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = PASS(OBJ or NOT(FSETQ(PRSO, TAKEBIT))) return __tmp end) then 
    	__tmp = NULL_F()
    	__tmp = TELL("You hit your head against the ", D, PRSO, " as you attempt this feat.", CR)
  elseif APPLY(function() __tmp = INQ(PRSO, WINNER) return __tmp end) then 
    	__tmp = TELL("That would involve quite a contortion!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(PICK_ONE(YUKS), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_THROUGH\n'..__res) end
end
_V_THROUGH = {
}
V_THROW = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = IDROP() return __tmp end) then 
    
    if APPLY(function() __tmp = EQUALQ(PRSI, ME) return __tmp end) then 
      	__tmp = TELL("A terrific throw! The ", D, PRSO)
      	__tmp = APPLY(function() WINNER = PLAYER return WINNER end)
      	__tmp = JIGS_UP(" hits you squarely in the head. Normally, this wouldn't do much damage, but by incredible mischance, you fall over backwards trying to duck, and break your neck, justice being swift and merciful in the Great Underground Empire.")
    elseif APPLY(function() __tmp = PASS(PRSI and FSETQ(PRSI, ACTORBIT)) return __tmp end) then 
      	__tmp = TELL("The ", D, PRSI, " ducks as the ", D, PRSO, " flies by and crashes to the ground.", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
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
_V_THROW = {
}
V_THROW_OFF = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You can't throw anything off of that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_THROW_OFF\n'..__res) end
end
_V_THROW_OFF = {
}
V_TIE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(PRSI, WINNER) return __tmp end) then 
    	__tmp = TELL("You can't tie anything to yourself.", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't tie the ", D, PRSO, " to that.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TIE\n'..__res) end
end
_V_TIE = {
}
V_TIE_UP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You could certainly never tie it with that!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TIE_UP\n'..__res) end
end
_V_TIE_UP = {
}
V_TREASURE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(HERE, NORTH_TEMPLE) return __tmp end) then 
    	__tmp = GOTO(TREASURE_ROOM)
  elseif APPLY(function() __tmp = EQUALQ(HERE, TREASURE_ROOM) return __tmp end) then 
    	__tmp = GOTO(NORTH_TEMPLE)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Nothing happens.", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TREASURE\n'..__res) end
end
_V_TREASURE = {
}
PRE_TURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil


  if APPLY(function() __tmp = PASS(EQUALQ(PRSI, nil, ROOMS) and NOT(EQUALQ(PRSO, BOOK))) return __tmp end) then 
    	__tmp = TELL("Your bare hands don't appear to be enough.", CR)
  elseif APPLY(function() __tmp = NOT(FSETQ(PRSO, TURNBIT)) return __tmp end) then 
    	__tmp = TELL("You can't turn that!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRE_TURN\n'..__res) end
end
_PRE_TURN = {
}
V_TURN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This has no effect.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_TURN\n'..__res) end
end
_V_TURN = {
}
V_UNLOCK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   V_LOCK()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNLOCK\n'..__res) end
end
_V_UNLOCK = {
}
V_UNTIE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("This cannot be tied, so it cannot be untied!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_UNTIE\n'..__res) end
end
_V_UNTIE = {
}
V_WAIT = function(...)
	local NUM = ...
	if select('#', ...) < 1 then NUM = 3 end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Time passes...", CR)

  local __prog33 = function()
    
    if APPLY(function() __tmp = LQ(APPLY(function() NUM = SUB(NUM, 1) return NUM end), 0) return __tmp end) then 
      return true
    elseif APPLY(function() __tmp = CLOCKER() return __tmp end) then 
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
_V_WAIT = {
}
V_WALK = function(...)
	local PT
	local PTS
	local STR
	local OBJ
	local RM
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(P_WALK_DIR) return __tmp end) then 
    	__tmp = PERFORM(VQWALK_TO, PRSO)
    	error(true)
  elseif APPLY(function() __tmp = APPLY(function() PT = GETPT(HERE, PRSO) return PT end) return __tmp end) then 
    
    if APPLY(function() __tmp = EQUALQ(APPLY(function() PTS = PTSIZE(PT) return PTS end), UEXIT) return __tmp end) then 
      	__tmp = GOTO(GETB(PT, REXIT))
    elseif APPLY(function() __tmp = EQUALQ(PTS, NEXIT) return __tmp end) then 
      	__tmp = TELL(GET(PT, NEXITSTR), CR)
      	__tmp = 	error(2)
    elseif APPLY(function() __tmp = EQUALQ(PTS, FEXIT) return __tmp end) then 
      
      if APPLY(function() __tmp = APPLY(function() RM = APPLY(GET(PT, FEXITFCN)) return RM end) return __tmp end) then 
        	__tmp = GOTO(RM)
      elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
        	error(false)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = 	error(2)
      end

    elseif APPLY(function() __tmp = EQUALQ(PTS, CEXIT) return __tmp end) then 
      
      if APPLY(function() __tmp = VALUE(GETB(PT, CEXITFLAG)) return __tmp end) then 
        	__tmp = GOTO(GETB(PT, REXIT))
      elseif APPLY(function() __tmp = APPLY(function() STR = GET(PT, CEXITSTR) return STR end) return __tmp end) then 
        	__tmp = TELL(STR, CR)
        	__tmp = 	error(2)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("You can't go that way.", CR)
        	__tmp = 	error(2)
      end

    elseif APPLY(function() __tmp = EQUALQ(PTS, DEXIT) return __tmp end) then 
      
      if APPLY(function() __tmp = FSETQ(APPLY(function() OBJ = GETB(PT, DEXITOBJ) return OBJ end), OPENBIT) return __tmp end) then 
        	__tmp = GOTO(GETB(PT, REXIT))
      elseif APPLY(function() __tmp = APPLY(function() STR = GET(PT, DEXITSTR) return STR end) return __tmp end) then 
        	__tmp = TELL(STR, CR)
        	__tmp = 	error(2)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("The ", D, OBJ, " is closed.", CR)
        	__tmp = THIS_IS_IT(OBJ)
        	__tmp = 	error(2)
      end

    end

  elseif APPLY(function() __tmp = PASS(NOT(LIT) and PROB(80) and EQUALQ(WINNER, ADVENTURER) and NOT(FSETQ(HERE, NONLANDBIT))) return __tmp end) then 
    
    if APPLY(function() __tmp = SPRAYEDQ return __tmp end) then 
      	__tmp = TELL("There are odd noises in the darkness, and there is no exit in that direction.", CR)
      	__tmp = 	error(2)
    elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
      	error(false)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = JIGS_UP("Oh, no! You have walked into the slavering fangs of a lurking grue!")
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't go that way.", CR)
    	__tmp = 	error(2)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK\n'..__res) end
end
_V_WALK = {
}
V_WALK_AROUND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Use compass directions for movement.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK_AROUND\n'..__res) end
end
_V_WALK_AROUND = {
}
V_WALK_TO = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(PRSO and PASS(INQ(PRSO, HERE) or GLOBAL_INQ(PRSO, HERE))) return __tmp end) then 
    	__tmp = TELL("It's here!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You should supply a direction!", CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WALK_TO\n'..__res) end
end
_V_WALK_TO = {
}
V_WAVE = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   HACK_HACK("Waving the ")
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WAVE\n'..__res) end
end
_V_WAVE = {
}
V_WEAR = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = NOT(FSETQ(PRSO, WEARBIT)) return __tmp end) then 
    	__tmp = TELL("You can't wear the ", D, PRSO, ".", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = PERFORM(VQTAKE, PRSO)
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WEAR\n'..__res) end
end
_V_WEAR = {
}
V_WIN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Naturally!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WIN\n'..__res) end
end
_V_WIN = {
}
V_WIND = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("You cannot wind up a ", D, PRSO, ".", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WIND\n'..__res) end
end
_V_WIND = {
}
V_WISH = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("With luck, your wish will come true.", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_WISH\n'..__res) end
end
_V_WISH = {
}
V_YELL = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("Aaaarrrrgggghhhh!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_YELL\n'..__res) end
end
_V_YELL = {
}
V_ZORK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("At your service!", CR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_ZORK\n'..__res) end
end
_V_ZORK = {
}
LIT = nil
SPRAYEDQ = nil
V_FIRST_LOOK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = DESCRIBE_ROOM() return __tmp end) then 
    
    if APPLY(function() __tmp = NOT(SUPER_BRIEF) return __tmp end) then 
      	__tmp = DESCRIBE_OBJECTS()
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('V_FIRST_LOOK\n'..__res) end
end
_V_FIRST_LOOK = {
}
DESCRIBE_ROOM = function(...)
	local LOOKQ = ...
	local VQ
	local STR
	local AV
	if select('#', ...) < 1 then LOOKQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() VQ = PASS(LOOKQ or VERBOSE) return VQ end)

  if APPLY(function() __tmp = NOT(LIT) return __tmp end) then 
    	__tmp = TELL("It is pitch black.")
    
    if APPLY(function() __tmp = NOT(SPRAYEDQ) return __tmp end) then 
      	__tmp = TELL(" You are likely to be eaten by a grue.")
    end

    	__tmp = CRLF()
    	__tmp = NULL_F()
    	error(false)
  end


  if APPLY(function() __tmp = NOT(FSETQ(HERE, TOUCHBIT)) return __tmp end) then 
    	__tmp = FSET(HERE, TOUCHBIT)
    	__tmp = APPLY(function() VQ = T return VQ end)
  end


  if APPLY(function() __tmp = FSETQ(HERE, MAZEBIT) return __tmp end) then 
    	__tmp = FCLEAR(HERE, TOUCHBIT)
  end


  if APPLY(function() __tmp = INQ(HERE, ROOMS) return __tmp end) then 
    	__tmp = TELL(D, HERE)
    
    if APPLY(function() __tmp = FSETQ(APPLY(function() AV = LOC(WINNER) return AV end), VEHBIT) return __tmp end) then 
      	__tmp = TELL(", in the ", D, AV)
    end

    	__tmp = CRLF()
  end


  if APPLY(function() __tmp = PASS(LOOKQ or NOT(SUPER_BRIEF)) return __tmp end) then 
    	__tmp = APPLY(function() AV = LOC(WINNER) return AV end)
    
    if APPLY(function() __tmp = PASS(VQ and APPLY(GETP(HERE, PQACTION), M_LOOK)) return __tmp end) then 
      	error(true)
    elseif APPLY(function() __tmp = PASS(VQ and APPLY(function() STR = GETP(HERE, PQLDESC) return STR end)) return __tmp end) then 
      	__tmp = TELL(STR, CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = APPLY(GETP(HERE, PQACTION), M_FLASH)
    end

    
    if APPLY(function() __tmp = PASS(NOT(EQUALQ(HERE, AV)) and FSETQ(AV, VEHBIT)) return __tmp end) then 
      	__tmp = APPLY(GETP(AV, PQACTION), M_LOOK)
    end

  end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_ROOM\n'..__res) end
end
_DESCRIBE_ROOM = {
}
DESCRIBE_OBJECTS = function(...)
	local VQ = ...
	if select('#', ...) < 1 then VQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = LIT return __tmp end) then 
    
    if APPLY(function() __tmp = FIRSTQ(HERE) return __tmp end) then 
      	__tmp = PRINT_CONT(HERE, APPLY(function() VQ = PASS(VQ or VERBOSE) return VQ end), -1)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("Only bats can see in the dark. And you're not one.", CR)
  end

	 return __tmp end)
	GM_NOTES(HERE)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_OBJECTS\n'..__res) end
end
_DESCRIBE_OBJECTS = {
}
DESC_OBJECT = nil
DESCRIBE_OBJECT = function(...)
	local OBJ, VQ, LEVEL = ...
  local STR = nil
	local AV
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() DESC_OBJECT = OBJ return DESC_OBJECT end)

  if APPLY(function() __tmp = PASS(ZEROQ(LEVEL) and APPLY(GETP(OBJ, PQDESCFCN), M_OBJDESC)) return __tmp end) then 
    	error(true)
  elseif APPLY(function() __tmp = PASS(ZEROQ(LEVEL) and PASS(PASS(NOT(FSETQ(OBJ, TOUCHBIT)) and APPLY(function() STR = GETP(OBJ, PQFDESC) return STR end)) or APPLY(function() STR = GETP(OBJ, PQLDESC) return STR end))) return __tmp end) then 
    	__tmp = TELL(STR)
  elseif APPLY(function() __tmp = ZEROQ(LEVEL) return __tmp end) then 
    	__tmp = TELL("There is a ", D, OBJ, " here")
    
    if APPLY(function() __tmp = FSETQ(OBJ, ONBIT) return __tmp end) then 
      	__tmp = TELL(" (providing light)")
    end

    	__tmp = TELL(".")
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(GET(INDENTS, LEVEL))
    	__tmp = TELL("A ", D, OBJ)
    
    if APPLY(function() __tmp = FSETQ(OBJ, ONBIT) return __tmp end) then 
      	__tmp = TELL(" (providing light)")
    elseif APPLY(function() __tmp = PASS(FSETQ(OBJ, WEARBIT) and INQ(OBJ, WINNER)) return __tmp end) then 
      	__tmp = TELL(" (being worn)")
    end

  end

	__tmp =   NULL_F()

  if APPLY(function() __tmp = PASS(ZEROQ(LEVEL) and APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) return __tmp end) then 
    	__tmp = TELL(" (outside the ", D, AV, ")")
  end

	__tmp =   CRLF()

  if APPLY(function() __tmp = PASS(SEE_INSIDEQ(OBJ) and FIRSTQ(OBJ)) return __tmp end) then 
    	__tmp = PRINT_CONT(OBJ, VQ, LEVEL)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DESCRIBE_OBJECT\n'..__res) end
end
_DESCRIBE_OBJECT = {
}
PRINT_CONTENTS = function(...)
	local OBJ = ...
	local F
	local N
  local bSTQ = T
  local ITQ = nil
  local TWOQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() F = FIRSTQ(OBJ) return F end) return __tmp end) then 
    
    local __prog34 = function()
      APPLY(function() N = NEXTQ(F) return N end)
      
      if APPLY(function() __tmp = bSTQ return __tmp end) then 
        	__tmp = APPLY(function() bSTQ = nil return bSTQ end)
      else 
        	__tmp = TELL(", ")
        
        if APPLY(function() __tmp = NOT(N) return __tmp end) then 
          	__tmp = TELL("and ")
        end

      end

      TELL("a ", D, F)
      
      if APPLY(function() __tmp = PASS(NOT(ITQ) and NOT(TWOQ)) return __tmp end) then 
        	__tmp = APPLY(function() ITQ = F return ITQ end)
      else 
        	__tmp = APPLY(function() TWOQ = T return TWOQ end)
        	__tmp = APPLY(function() ITQ = nil return ITQ end)
      end

      APPLY(function() F = N return F end)
      
      if APPLY(function() __tmp = NOT(F) return __tmp end) then 
        
        if APPLY(function() __tmp = PASS(ITQ and NOT(TWOQ)) return __tmp end) then 
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
_PRINT_CONTENTS = {
}
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

  if APPLY(function() __tmp = NOT(APPLY(function() Y = FIRSTQ(OBJ) return Y end)) return __tmp end) then 
    	error(true)
  end


  if APPLY(function() __tmp = PASS(APPLY(function() AV = LOC(WINNER) return AV end) and FSETQ(AV, VEHBIT)) return __tmp end) then 
    	__tmp = T
  else 
    	__tmp = APPLY(function() AV = nil return AV end)
  end

	__tmp = APPLY(function() bSTQ = T return bSTQ end)
	__tmp = APPLY(function() SHIT = T return SHIT end)

  if APPLY(function() __tmp = EQUALQ(WINNER, OBJ, LOC(OBJ)) return __tmp end) then 
    	__tmp = APPLY(function() INVQ = T return INVQ end)
  else 
    
    local __prog35 = function()
      
      if APPLY(function() __tmp = NOT(Y) return __tmp end) then 
        return true
      elseif APPLY(function() __tmp = EQUALQ(Y, AV) return __tmp end) then 
        	__tmp = APPLY(function() PVQ = T return PVQ end)
      elseif APPLY(function() __tmp = EQUALQ(Y, WINNER) return __tmp end) then 
      elseif APPLY(function() __tmp = PASS(NOT(FSETQ(Y, INVISIBLE)) and NOT(FSETQ(Y, TOUCHBIT)) and APPLY(function() STR = GETP(Y, PQFDESC) return STR end)) return __tmp end) then 
        
        if APPLY(function() __tmp = NOT(FSETQ(Y, NDESCBIT)) return __tmp end) then 
          	__tmp = TELL(STR, CR)
          	__tmp = APPLY(function() SHIT = nil return SHIT end)
        end

        
        if APPLY(function() __tmp = PASS(SEE_INSIDEQ(Y) and NOT(GETP(LOC(Y), PQDESCFCN)) and FIRSTQ(Y)) return __tmp end) then 
          
          if APPLY(function() __tmp = PRINT_CONT(Y, VQ, 0) return __tmp end) then 
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
    
    if APPLY(function() __tmp = NOT(Y) return __tmp end) then 
      
      if APPLY(function() __tmp = PASS(PVQ and AV and FIRSTQ(AV)) return __tmp end) then 
        	__tmp = APPLY(function() LEVEL = ADD(LEVEL, 1) return LEVEL end)
        	__tmp = PRINT_CONT(AV, VQ, LEVEL)
      end

      return true
    elseif APPLY(function() __tmp = EQUALQ(Y, AV, ADVENTURER) return __tmp end) then 
    elseif APPLY(function() __tmp = PASS(NOT(FSETQ(Y, INVISIBLE)) and PASS(INVQ or FSETQ(Y, TOUCHBIT) or NOT(GETP(Y, PQFDESC)))) return __tmp end) then 
      
      if APPLY(function() __tmp = NOT(FSETQ(Y, NDESCBIT)) return __tmp end) then 
        
        if APPLY(function() __tmp = bSTQ return __tmp end) then 
          
          if APPLY(function() __tmp = FIRSTER(OBJ, LEVEL) return __tmp end) then 
            
            if APPLY(function() __tmp = LQ(LEVEL, 0) return __tmp end) then 
              	__tmp = APPLY(function() LEVEL = 0 return LEVEL end)
            end

          end

          	__tmp = APPLY(function() LEVEL = ADD(1, LEVEL) return LEVEL end)
          	__tmp = APPLY(function() bSTQ = nil return bSTQ end)
        end

        
        if APPLY(function() __tmp = LQ(LEVEL, 0) return __tmp end) then 
          	__tmp = APPLY(function() LEVEL = 0 return LEVEL end)
        end

        	__tmp = DESCRIBE_OBJECT(Y, VQ, LEVEL)
      elseif APPLY(function() __tmp = PASS(FIRSTQ(Y) and SEE_INSIDEQ(Y)) return __tmp end) then 
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


  if APPLY(function() __tmp = PASS(bSTQ and SHIT) return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PRINT_CONT\n'..__res) end
end
_PRINT_CONT = {
}
FIRSTER = function(...)
	local OBJ, LEVEL = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = EQUALQ(OBJ, TROPHY_CASE) return __tmp end) then 
    	__tmp = TELL("Your collection of treasures consists of:", CR)
  elseif APPLY(function() __tmp = EQUALQ(OBJ, WINNER) return __tmp end) then 
    	__tmp = TELL("You are carrying:", CR)
  elseif APPLY(function() __tmp = NOT(INQ(OBJ, ROOMS)) return __tmp end) then 
    
    if APPLY(function() __tmp = GQ(LEVEL, 0) return __tmp end) then 
      	__tmp = TELL(GET(INDENTS, LEVEL))
    end

    
    if APPLY(function() __tmp = FSETQ(OBJ, SURFACEBIT) return __tmp end) then 
      	__tmp = TELL("Sitting on the ", D, OBJ, " is: ", CR)
    elseif APPLY(function() __tmp = FSETQ(OBJ, ACTORBIT) return __tmp end) then 
      	__tmp = TELL("The ", D, OBJ, " is holding: ", CR)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = TELL("The ", D, OBJ, " contains:", CR)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('FIRSTER\n'..__res) end
end
_FIRSTER = {
}
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
_SEE_INSIDEQ = {
}
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

  if APPLY(function() __tmp = PASS(EQUALQ(SCORE, 350) and NOT(WON_FLAG)) return __tmp end) then 
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
_SCORE_UPD = {
}
SCORE_OBJ = function(...)
	local OBJ = ...
	local TEMP
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = GQ(APPLY(function() TEMP = GETP(OBJ, PQVALUE) return TEMP end), 0) return __tmp end) then 
    	__tmp = SCORE_UPD(TEMP)
    	__tmp = PUTP(OBJ, PQVALUE, 0)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SCORE_OBJ\n'..__res) end
end
_SCORE_OBJ = {
}
YESQ = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PRINTI(">")
	__tmp =   READ(P_INBUF, P_LEXV)

  if APPLY(function() __tmp = EQUALQ(GET(P_LEXV, 1), WQYES, WQY) return __tmp end) then 
    	error(true)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('YESQ\n'..__res) end
end
_YESQ = {
}
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

  if APPLY(function() __tmp = DEAD return __tmp end) then 
    
    if APPLY(function() __tmp = VB return __tmp end) then 
      	__tmp = TELL("Your hand passes through its object.", CR)
    end

    	error(false)
  elseif APPLY(function() __tmp = NOT(FSETQ(PRSO, TAKEBIT)) return __tmp end) then 
    
    if APPLY(function() __tmp = VB return __tmp end) then 
      	__tmp = TELL(PICK_ONE(YUKS), CR)
    end

    	error(false)
  elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = PASS(FSETQ(LOC(PRSO), CONTBIT) and NOT(FSETQ(LOC(PRSO), OPENBIT))) return __tmp end) then 
    	error(false)
  elseif APPLY(function() __tmp = PASS(NOT(INQ(LOC(PRSO), WINNER)) and GQ(ADD(WEIGHT(PRSO), WEIGHT(WINNER)), LOAD_ALLOWED)) return __tmp end) then 
    
    if APPLY(function() __tmp = VB return __tmp end) then 
      	__tmp = TELL("Your load is too heavy")
      
      if APPLY(function() __tmp = LQ(LOAD_ALLOWED, LOAD_MAX) return __tmp end) then 
        	__tmp = TELL(", especially in light of your condition.")
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL(".")
      end

      	__tmp = CRLF()
    end

    	__tmp = 	error(2)
  elseif APPLY(function() __tmp = PASS(VERBQ(TAKE) and GQ(APPLY(function() CNT = CCOUNT(WINNER) return CNT end), FUMBLE_NUMBER) and PROB(MULL(CNT, FUMBLE_PROB))) return __tmp end) then 
    	__tmp = TELL("You're holding too many things already!", CR)
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
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
_ITAKE = {
	'TAKE',
}
IDROP = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = PASS(NOT(INQ(PRSO, WINNER)) and NOT(INQ(LOC(PRSO), WINNER))) return __tmp end) then 
    	__tmp = TELL("You're not carrying the ", D, PRSO, ".", CR)
    	error(false)
  elseif APPLY(function() __tmp = PASS(NOT(INQ(PRSO, WINNER)) and NOT(FSETQ(LOC(PRSO), OPENBIT))) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " is closed.", CR)
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = MOVE(PRSO, LOC(WINNER))
    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('IDROP\n'..__res) end
end
_IDROP = {
}
CCOUNT = function(...)
	local OBJ = ...
  local CNT = 0
	local X
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() X = FIRSTQ(OBJ) return X end) return __tmp end) then 
    
    local __prog37 = function()
      
      if APPLY(function() __tmp = NOT(FSETQ(X, WEARBIT)) return __tmp end) then 
        	__tmp = APPLY(function() CNT = ADD(CNT, 1) return CNT end)
      end

      
      if APPLY(function() __tmp = NOT(APPLY(function() X = NEXTQ(X) return X end)) return __tmp end) then 
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
_CCOUNT = {
}
WEIGHT = function(...)
	local OBJ = ...
	local CONT
  local WT = 0
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() CONT = FIRSTQ(OBJ) return CONT end) return __tmp end) then 
    
    local __prog38 = function()
      
      if APPLY(function() __tmp = PASS(EQUALQ(OBJ, PLAYER) and FSETQ(CONT, WEARBIT)) return __tmp end) then 
        	__tmp = APPLY(function() WT = ADD(WT, 1) return WT end)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = APPLY(function() WT = ADD(WT, WEIGHT(CONT)) return WT end)
      end

      
      if APPLY(function() __tmp = NOT(APPLY(function() CONT = NEXTQ(CONT) return CONT end)) return __tmp end) then 
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
_WEIGHT = {
}
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

  if APPLY(function() __tmp = PASS(INQ(PRSO, GLOBAL_OBJECTS) and VERBQ(WAVE, RAISE, LOWER)) return __tmp end) then 
    	__tmp = TELL("The ", D, PRSO, " isn't here!", CR)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL(STR, D, PRSO, PICK_ONE(HO_HUM), CR)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('HACK_HACK\n'..__res) end
end
_HACK_HACK = {
	'WAVE',
}
HO_HUM = LTABLE(0," doesn't seem to work."," isn't notably helpful."," has no effect.")
NO_GO_TELL = function(...)
	local AV, WLOC = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = AV return __tmp end) then 
    	__tmp = TELL("You can't go there in a ", D, WLOC, ".")
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = TELL("You can't go there without a vehicle.")
  end

	__tmp =   CRLF()
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NO_GO_TELL\n'..__res) end
end
_NO_GO_TELL = {
}
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

  if APPLY(function() __tmp = FSETQ(WLOC, VEHBIT) return __tmp end) then 
    	__tmp = APPLY(function() AV = GETP(WLOC, PQVTYPE) return AV end)
  end


  if APPLY(function() __tmp = PASS(NOT(LB) and NOT(AV)) return __tmp end) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif APPLY(function() __tmp = PASS(NOT(LB) and NOT(FSETQ(RM, AV))) return __tmp end) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif APPLY(function() __tmp = PASS(FSETQ(HERE, RLANDBIT) and LB and AV and NOT(EQUALQ(AV, RLANDBIT)) and NOT(FSETQ(RM, AV))) return __tmp end) then 
    	__tmp = NO_GO_TELL(AV, WLOC)
    	error(false)
  elseif APPLY(function() __tmp = FSETQ(RM, RMUNGBIT) return __tmp end) then 
    	__tmp = TELL(GETP(RM, PQLDESC), CR)
    	error(false)
  elseif APPLY(function() __tmp = T return __tmp end) then 
    
    if APPLY(function() __tmp = PASS(LB and NOT(FSETQ(HERE, RLANDBIT)) and NOT(DEAD) and FSETQ(WLOC, VEHBIT)) return __tmp end) then 
      	__tmp = TELL("The ", D, WLOC, " comes to a rest on the shore.", CR, CR)
    end

    
    if APPLY(function() __tmp = AV return __tmp end) then 
      	__tmp = MOVE(WLOC, RM)
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = MOVE(WINNER, RM)
    end

    	__tmp = APPLY(function() HERE = RM return HERE end)
    	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if APPLY(function() __tmp = PASS(NOT(OLIT) and NOT(LIT) and PROB(80)) return __tmp end) then 
      
      if APPLY(function() __tmp = SPRAYEDQ return __tmp end) then 
        	__tmp = TELL("There are sinister gurgling noises in the darkness all around you!", CR)
      elseif APPLY(function() __tmp = NULL_F() return __tmp end) then 
        	error(false)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("Oh, no! A lurking grue slithered into the ")
        
        if APPLY(function() __tmp = FSETQ(LOC(WINNER), VEHBIT) return __tmp end) then 
          	__tmp = TELL(D, LOC(WINNER))
        elseif APPLY(function() __tmp = T return __tmp end) then 
          	__tmp = TELL("room")
        end

        	__tmp = JIGS_UP(" and devoured you!")
        	error(true)
      end

    end

    
    if APPLY(function() __tmp = PASS(NOT(LIT) and EQUALQ(WINNER, ADVENTURER)) return __tmp end) then 
      	__tmp = TELL("You have moved into a dark place.", CR)
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    end

    	__tmp = APPLY(GETP(HERE, PQACTION), M_ENTER)
    	__tmp = SCORE_OBJ(RM)
    
    if APPLY(function() __tmp = NOT(EQUALQ(HERE, RM)) return __tmp end) then 
      	error(true)
    elseif APPLY(function() __tmp = PASS(NOT(EQUALQ(ADVENTURER, WINNER)) and INQ(ADVENTURER, OHERE)) return __tmp end) then 
      	__tmp = TELL("The ", D, WINNER, " leaves the room.", CR)
    elseif APPLY(function() __tmp = PASS(EQUALQ(HERE, OHERE) and EQUALQ(HERE, ENTRANCE_TO_HADES)) return __tmp end) then 
      	error(true)
    elseif APPLY(function() __tmp = PASS(VQ and EQUALQ(WINNER, ADVENTURER)) return __tmp end) then 
      	__tmp = V_FIRST_LOOK()
    end

    	error(true)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GOTO\n'..__res) end
end
_GOTO = {
}
LKP = function(...)
	local ITM, TBL = ...
  local CNT = 0
  local LEN = GET(TBL, 0)
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog39 = function()
    
    if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), LEN) return __tmp end) then 
      	error(false)
    elseif APPLY(function() __tmp = EQUALQ(GET(TBL, CNT), ITM) return __tmp end) then 
      
      if APPLY(function() __tmp = EQUALQ(CNT, LEN) return __tmp end) then 
        	error(false)
      elseif APPLY(function() __tmp = T return __tmp end) then 
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
_LKP = {
}
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
_DO_WALK = {
}
GLOBAL_INQ = function(...)
	local OBJ1, OBJ2 = ...
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() __tmp = APPLY(function() TX = GETPT(OBJ2, PQGLOBAL) return TX end) return __tmp end) then 
    	__tmp = ZMEMQB(OBJ1, TX, SUB(PTSIZE(TX), 1))
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GLOBAL_INQ\n'..__res) end
end
_GLOBAL_INQ = {
}
FIND_IN = function(...)
	local WHERE, WHAT = ...
	local W
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() W = FIRSTQ(WHERE) return W end)

  if APPLY(function() __tmp = NOT(W) return __tmp end) then 
    	error(false)
  end


  local __prog40 = function()
    
    if APPLY(function() __tmp = PASS(FSETQ(W, WHAT) and NOT(EQUALQ(W, ADVENTURER))) return __tmp end) then 
      error(W)
    elseif APPLY(function() __tmp = NOT(APPLY(function() W = NEXTQ(W) return W end)) return __tmp end) then 
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
_FIND_IN = {
}
HELDQ = function(...)
	local CAN = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog41 = function()
    APPLY(function() CAN = LOC(CAN) return CAN end)
    
    if APPLY(function() __tmp = NOT(CAN) return __tmp end) then 
      	error(false)
    elseif APPLY(function() __tmp = EQUALQ(CAN, WINNER) return __tmp end) then 
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
_HELDQ = {
}
OTHER_SIDE = function(...)
	local DOBJ = ...
  local P = 0
	local TX
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog42 = function()
    
    if APPLY(function() __tmp = LQ(APPLY(function() P = NEXTP(HERE, P) return P end), LOW_DIRECTION) return __tmp end) then 
      error(nil)
    else 
      	__tmp = APPLY(function() TX = GETPT(HERE, P) return TX end)
      
      if APPLY(function() __tmp = PASS(EQUALQ(PTSIZE(TX), DEXIT) and EQUALQ(GETB(TX, DEXITOBJ), DOBJ)) return __tmp end) then 
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
_OTHER_SIDE = {
}
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
_MUNG_ROOM = {
}
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
_THIS_IS_IT = {
}

if APPLY(function() __tmp =   NEQUALQ(ZORK_NUMBER, 3) return __tmp end) then 
  SWIMYUKS = LTABLE(0,"You can't swim in the dungeon.")

end
HELLOS = LTABLE(0,"Hello.","Good day.","Nice weather we've been having lately.","Goodbye.")
YUKS = LTABLE(0,"A valiant attempt.","You can't be serious.","An interesting idea...","What a concept!")
DUMMY = LTABLE(0,"Look around.","Too late for that.","Have your eyes checked.")
