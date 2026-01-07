
SERIAL = 0
PLAYER = nil
P_WON = nil
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
MAIN_LOOP = function(...)
	local TRASH
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog43 = function()
    APPLY(function() TRASH = MAIN_LOOP_1() return TRASH end)

error(123) end
local __ok43, __res43
repeat __ok43, __res43 = pcall(__prog43)
until __ok43 or __res43 ~= 123
if not __ok43 then error(__res43)
else __tmp = __res43 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAIN_LOOP\n'..__res) end
end
_MAIN_LOOP = {
}
MAIN_LOOP_1 = function(...)
	local ICNT
	local OCNT
	local NUM
	local CNT
	local OBJ
	local TBL
	local V
	local PTBL
	local OBJ1
	local TMP
	local O
	local I
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() CNT = 0 return CNT end)
	__tmp = APPLY(function() OBJ = nil return OBJ end)
	__tmp = APPLY(function() PTBL = T return PTBL end)

  if APPLY(function() __tmp = APPLY(function() P_WON = PARSER() return P_WON end) return __tmp end) then 
    	__tmp = APPLY(function() ICNT = GET(P_PRSI, P_MATCHLEN) return ICNT end)
    	__tmp = APPLY(function() OCNT = GET(P_PRSO, P_MATCHLEN) return OCNT end)
    
    if APPLY(function() __tmp = PASS(P_IT_OBJECT and ACCESSIBLEQ(P_IT_OBJECT)) return __tmp end) then 
      	__tmp = APPLY(function() TMP = nil return TMP end)
      
      local __prog44 = function()
        
        if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), ICNT) return __tmp end) then 
          return true
        elseif APPLY(function() __tmp = T return __tmp end) then 
          
          if APPLY(function() __tmp = EQUALQ(GET(P_PRSI, CNT), IT) return __tmp end) then 
            	__tmp = PUT(P_PRSI, CNT, P_IT_OBJECT)
            	__tmp = APPLY(function() TMP = T return TMP end)
            return true
          end

        end


error(123) end
local __ok44, __res44
repeat __ok44, __res44 = pcall(__prog44)
until __ok44 or __res44 ~= 123
if not __ok44 then error(__res44)
else __tmp = __res44 or true end

      
      if APPLY(function() __tmp = NOT(TMP) return __tmp end) then 
        	__tmp = APPLY(function() CNT = 0 return CNT end)
        
        local __prog45 = function()
          
          if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), OCNT) return __tmp end) then 
            return true
          elseif APPLY(function() __tmp = T return __tmp end) then 
            
            if APPLY(function() __tmp = EQUALQ(GET(P_PRSO, CNT), IT) return __tmp end) then 
              	__tmp = PUT(P_PRSO, CNT, P_IT_OBJECT)
              return true
            end

          end


error(123) end
local __ok45, __res45
repeat __ok45, __res45 = pcall(__prog45)
until __ok45 or __res45 ~= 123
if not __ok45 then error(__res45)
else __tmp = __res45 or true end

      end

      	__tmp = APPLY(function() CNT = 0 return CNT end)
    end

    	__tmp = APPLY(function() NUM = APPLY(function()
      if APPLY(function() __tmp = ZEROQ(OCNT) return __tmp end) then 
        	__tmp = OCNT
      elseif APPLY(function() __tmp = GQ(OCNT, 1) return __tmp end) then 
        	__tmp = APPLY(function() TBL = P_PRSO return TBL end)
        
        if APPLY(function() __tmp = ZEROQ(ICNT) return __tmp end) then 
          	__tmp = APPLY(function() OBJ = nil return OBJ end)
        elseif APPLY(function() __tmp = T return __tmp end) then 
          	__tmp = APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
        end

        	__tmp = OCNT
      elseif APPLY(function() __tmp = GQ(ICNT, 1) return __tmp end) then 
        	__tmp = APPLY(function() PTBL = nil return PTBL end)
        	__tmp = APPLY(function() TBL = P_PRSI return TBL end)
        	__tmp = APPLY(function() OBJ = GET(P_PRSO, 1) return OBJ end)
        	__tmp = ICNT
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = 1
      end
 return __tmp end) return NUM end)
    
    if APPLY(function() __tmp = PASS(NOT(OBJ) and ONEQ(ICNT)) return __tmp end) then 
      	__tmp = APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
    end

    
    if APPLY(function() __tmp = PASS(EQUALQ(PRSA, VQWALK) and NOT(ZEROQ(P_WALK_DIR))) return __tmp end) then 
      	__tmp = APPLY(function() V = PERFORM(PRSA, PRSO) return V end)
    elseif APPLY(function() __tmp = ZEROQ(NUM) return __tmp end) then 
      
      if APPLY(function() __tmp = ZEROQ(BAND(GETB(P_SYNTAX, P_SBITS), P_SONUMS)) return __tmp end) then 
        	__tmp = APPLY(function() V = PERFORM(PRSA) return V end)
        	__tmp = APPLY(function() PRSO = nil return PRSO end)
      elseif APPLY(function() __tmp = NOT(LIT) return __tmp end) then 
        	__tmp = TELL("It's too dark to see.", CR)
      elseif APPLY(function() __tmp = T return __tmp end) then 
        	__tmp = TELL("It's not clear what you're referring to.", CR)
        	__tmp = APPLY(function() V = nil return V end)
      end

    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = APPLY(function() P_NOT_HERE = 0 return P_NOT_HERE end)
      	__tmp = APPLY(function() P_MULT = nil return P_MULT end)
      
      if APPLY(function() __tmp = GQ(NUM, 1) return __tmp end) then 
        	__tmp = APPLY(function() P_MULT = T return P_MULT end)
      end

      	__tmp = APPLY(function() TMP = nil return TMP end)
      
      local __prog46 = function()
        
        if APPLY(function() __tmp = GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), NUM) return __tmp end) then 
          
          if APPLY(function() __tmp = GQ(P_NOT_HERE, 0) return __tmp end) then 
            	__tmp = TELL("The ")
            
            if APPLY(function() __tmp = NOT(EQUALQ(P_NOT_HERE, NUM)) return __tmp end) then 
              	__tmp = TELL("other ")
            end

            	__tmp = TELL("object")
            
            if APPLY(function() __tmp = NOT(EQUALQ(P_NOT_HERE, 1)) return __tmp end) then 
              	__tmp = TELL("s")
            end

            	__tmp = TELL(" that you mentioned ")
            
            if APPLY(function() __tmp = NOT(EQUALQ(P_NOT_HERE, 1)) return __tmp end) then 
              	__tmp = TELL("are")
            elseif APPLY(function() __tmp = T return __tmp end) then 
              	__tmp = TELL("is")
            end

            	__tmp = TELL("n't here.", CR)
          elseif APPLY(function() __tmp = NOT(TMP) return __tmp end) then 
            	__tmp = TELL("There's nothing here you can take.", CR)
          end

          return true
        elseif APPLY(function() __tmp = T return __tmp end) then 
          
          if APPLY(function() __tmp = PTBL return __tmp end) then 
            	__tmp = APPLY(function() OBJ1 = GET(P_PRSO, CNT) return OBJ1 end)
          elseif APPLY(function() __tmp = T return __tmp end) then 
            	__tmp = APPLY(function() OBJ1 = GET(P_PRSI, CNT) return OBJ1 end)
          end

          	__tmp = APPLY(function() O = APPLY(function()
            if APPLY(function() __tmp = PTBL return __tmp end) then 
              	__tmp = OBJ1
            elseif APPLY(function() __tmp = T return __tmp end) then 
              	__tmp = OBJ
            end
 return __tmp end) return O end)
          	__tmp = APPLY(function() I = APPLY(function()
            if APPLY(function() __tmp = PTBL return __tmp end) then 
              	__tmp = OBJ
            elseif APPLY(function() __tmp = T return __tmp end) then 
              	__tmp = OBJ1
            end
 return __tmp end) return I end)
          
          if APPLY(function() __tmp = PASS(GQ(NUM, 1) or EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL)) return __tmp end) then 
            	__tmp = APPLY(function() V = LOC(WINNER) return V end)
            
            if APPLY(function() __tmp = EQUALQ(O, NOT_HERE_OBJECT) return __tmp end) then 
              	__tmp = APPLY(function() P_NOT_HERE = ADD(P_NOT_HERE, 1) return P_NOT_HERE end)
              	error(123)
            elseif APPLY(function() __tmp = PASS(VERBQ(TAKE) and I and EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL) and NOT(INQ(O, I))) return __tmp end) then 
              	error(123)
            elseif APPLY(function() __tmp = PASS(EQUALQ(P_GETFLAGS, P_ALL) and VERBQ(TAKE) and PASS(PASS(NOT(EQUALQ(LOC(O), WINNER, HERE, V)) and NOT(EQUALQ(LOC(O), I)) and NOT(FSETQ(LOC(O), SURFACEBIT))) or NOT(PASS(FSETQ(O, TAKEBIT) or FSETQ(O, TRYTAKEBIT))))) return __tmp end) then 
              	error(123)
            else 
              
              if APPLY(function() __tmp = EQUALQ(OBJ1, IT) return __tmp end) then 
                	__tmp = PRINTD(P_IT_OBJECT)
              elseif APPLY(function() __tmp = T return __tmp end) then 
                	__tmp = PRINTD(OBJ1)
              end

              	__tmp = TELL(": ")
            end

          end

          	__tmp = APPLY(function() PRSO = O return PRSO end)
          	__tmp = APPLY(function() PRSI = I return PRSI end)
          	__tmp = APPLY(function() TMP = T return TMP end)
          	__tmp = APPLY(function() V = PERFORM(PRSA, PRSO, PRSI) return V end)
          
          if APPLY(function() __tmp = EQUALQ(V, M_FATAL) return __tmp end) then 
            return true
          end

        end


error(123) end
local __ok46, __res46
repeat __ok46, __res46 = pcall(__prog46)
until __ok46 or __res46 ~= 123
if not __ok46 then error(__res46)
else __tmp = __res46 or true end

    end

    
    if APPLY(function() __tmp = NOT(EQUALQ(V, M_FATAL)) return __tmp end) then 
      	__tmp = APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_END) return V end)
    end

    
    if APPLY(function() __tmp = EQUALQ(V, M_FATAL) return __tmp end) then 
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    end

  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  end

	__tmp =   NULL_F()

  if APPLY(function() __tmp = P_WON return __tmp end) then 
    
    if APPLY(function() __tmp = VERBQ(TELL, BRIEF, SUPER_BRIEF, VERBOSE, SAVE, VERSION, QUIT, RESTART, SCORE, SCRIPT, UNSCRIPT, RESTORE) return __tmp end) then 
      	__tmp = T
    elseif APPLY(function() __tmp = T return __tmp end) then 
      	__tmp = APPLY(function() V = CLOCKER() return V end)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAIN_LOOP_1\n'..__res) end
end
_MAIN_LOOP_1 = {
	'TAKE',
	'TAKE',
	'TELL',
}
P_MULT = nil
P_NOT_HERE = 0
PERFORM = function(...)
	local A, O, I = ...
	local V
	local OA
	local OO
	local OI
	if select('#', ...) < 2 then O = nil end
	if select('#', ...) < 3 then I = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() OA = PRSA return OA end)
	__tmp = APPLY(function() OO = PRSO return OO end)
	__tmp = APPLY(function() OI = PRSI return OI end)

  if APPLY(function() __tmp = PASS(EQUALQ(IT, I, O) and NOT(ACCESSIBLEQ(P_IT_OBJECT))) return __tmp end) then 
    	__tmp = TELL("I don't see what you are referring to.", CR)
    	__tmp = 	error(2)
  end


  if APPLY(function() __tmp = EQUALQ(O, IT) return __tmp end) then 
    	__tmp = APPLY(function() O = P_IT_OBJECT return O end)
  end


  if APPLY(function() __tmp = EQUALQ(I, IT) return __tmp end) then 
    	__tmp = APPLY(function() I = P_IT_OBJECT return I end)
  end

	__tmp = APPLY(function() PRSA = A return PRSA end)
	__tmp = APPLY(function() PRSO = O return PRSO end)

  if APPLY(function() __tmp = PASS(PRSO and NOT(EQUALQ(PRSI, IT)) and NOT(VERBQ(WALK))) return __tmp end) then 
    	__tmp = APPLY(function() P_IT_OBJECT = PRSO return P_IT_OBJECT end)
  end

	__tmp = APPLY(function() PRSI = I return PRSI end)

  if APPLY(function() __tmp = PASS(EQUALQ(NOT_HERE_OBJECT, PRSO, PRSI) and APPLY(function() V = NOT_HERE_OBJECT_F() return V end)) return __tmp end) then 
    	__tmp = V
  elseif APPLY(function() __tmp = T return __tmp end) then 
    	__tmp = APPLY(function() O = PRSO return O end)
    	__tmp = APPLY(function() I = PRSI return I end)
    
    if APPLY(function() __tmp = APPLY(function() V = APPLY(GETP(WINNER, PQACTION)) return V end) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_BEG) return V end) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = APPLY(function() V = APPLY(GET(PREACTIONS, A)) return V end) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = PASS(I and APPLY(function() V = APPLY(GETP(I, PQACTION)) return V end)) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = PASS(O and NOT(EQUALQ(A, VQWALK)) and LOC(O) and APPLY(function() V = APPLY(GETP(LOC(O), PQCONTFCN)) return V end)) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = PASS(O and NOT(EQUALQ(A, VQWALK)) and APPLY(function() V = APPLY(GETP(O, PQACTION)) return V end)) return __tmp end) then 
      	__tmp = V
    elseif APPLY(function() __tmp = APPLY(function() V = APPLY(GET(ACTIONS, A)) return V end) return __tmp end) then 
      	__tmp = V
    end

  end

	__tmp = APPLY(function() PRSA = OA return PRSA end)
	__tmp = APPLY(function() PRSO = OO return PRSO end)
	__tmp = APPLY(function() PRSI = OI return PRSI end)
	__tmp = V
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PERFORM\n'..__res) end
end
_PERFORM = {
	'WALK',
}
