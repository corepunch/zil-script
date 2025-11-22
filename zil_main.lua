
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

  local __prog73 = function()
    APPLY(function() TRASH = MAIN_LOOP_1() return TRASH end)

error(123) end
local __ok73, __res73
repeat __ok73, __res73 = pcall(__prog73)
until __ok73 or __res73 ~= 123
if not __ok73 then error(__res73)
else __tmp = __res73 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAIN_LOOP\n'..__res) end
end
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

  if APPLY(function() P_WON = PARSER() return P_WON end) then 
    	__tmp = APPLY(function() ICNT = GET(P_PRSI, P_MATCHLEN) return ICNT end)
    	__tmp = APPLY(function() OCNT = GET(P_PRSO, P_MATCHLEN) return OCNT end)
    
    if PASS(P_IT_OBJECT and ACCESSIBLEQ(P_IT_OBJECT)) then 
      	__tmp = APPLY(function() TMP = nil return TMP end)
      
      local __prog74 = function()
        
        if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), ICNT) then 
          return true
        elseif T then 
          
          if EQUALQ(GET(P_PRSI, CNT), IT) then 
            	__tmp = PUT(P_PRSI, CNT, P_IT_OBJECT)
            	__tmp = APPLY(function() TMP = T return TMP end)
            return true
          end

        end


error(123) end
local __ok74, __res74
repeat __ok74, __res74 = pcall(__prog74)
until __ok74 or __res74 ~= 123
if not __ok74 then error(__res74)
else __tmp = __res74 or true end

      
      if NOT(TMP) then 
        	__tmp = APPLY(function() CNT = 0 return CNT end)
        
        local __prog75 = function()
          
          if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), OCNT) then 
            return true
          elseif T then 
            
            if EQUALQ(GET(P_PRSO, CNT), IT) then 
              	__tmp = PUT(P_PRSO, CNT, P_IT_OBJECT)
              return true
            end

          end


error(123) end
local __ok75, __res75
repeat __ok75, __res75 = pcall(__prog75)
until __ok75 or __res75 ~= 123
if not __ok75 then error(__res75)
else __tmp = __res75 or true end

      end

      	__tmp = APPLY(function() CNT = 0 return CNT end)
    end

    	__tmp = APPLY(function() NUM = APPLY(function()
      if ZEROQ(OCNT) then 
        	__tmp = OCNT
      elseif GQ(OCNT, 1) then 
        	__tmp = APPLY(function() TBL = P_PRSO return TBL end)
        
        if ZEROQ(ICNT) then 
          	__tmp = APPLY(function() OBJ = nil return OBJ end)
        elseif T then 
          	__tmp = APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
        end

        	__tmp = OCNT
      elseif GQ(ICNT, 1) then 
        	__tmp = APPLY(function() PTBL = nil return PTBL end)
        	__tmp = APPLY(function() TBL = P_PRSI return TBL end)
        	__tmp = APPLY(function() OBJ = GET(P_PRSO, 1) return OBJ end)
        	__tmp = ICNT
      elseif T then 
        	__tmp = 1
      end
 return __tmp end) return NUM end)
    
    if PASS(NOT(OBJ) and ONEQ(ICNT)) then 
      	__tmp = APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
    end

    
    if PASS(EQUALQ(PRSA, VQWALK) and NOT(ZEROQ(P_WALK_DIR))) then 
      	__tmp = APPLY(function() V = PERFORM(PRSA, PRSO) return V end)
    elseif ZEROQ(NUM) then 
      
      if ZEROQ(BAND(GETB(P_SYNTAX, P_SBITS), P_SONUMS)) then 
        	__tmp = APPLY(function() V = PERFORM(PRSA) return V end)
        	__tmp = APPLY(function() PRSO = nil return PRSO end)
      elseif NOT(LIT) then 
        	__tmp = TELL("It's too dark to see.", CR)
      elseif T then 
        	__tmp = TELL("It's not clear what you're referring to.", CR)
        	__tmp = APPLY(function() V = nil return V end)
      end

    elseif T then 
      	__tmp = APPLY(function() P_NOT_HERE = 0 return P_NOT_HERE end)
      	__tmp = APPLY(function() P_MULT = nil return P_MULT end)
      
      if GQ(NUM, 1) then 
        	__tmp = APPLY(function() P_MULT = T return P_MULT end)
      end

      	__tmp = APPLY(function() TMP = nil return TMP end)
      
      local __prog76 = function()
        
        if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), NUM) then 
          
          if GQ(P_NOT_HERE, 0) then 
            	__tmp = TELL("The ")
            
            if NOT(EQUALQ(P_NOT_HERE, NUM)) then 
              	__tmp = TELL("other ")
            end

            	__tmp = TELL("object")
            
            if NOT(EQUALQ(P_NOT_HERE, 1)) then 
              	__tmp = TELL("s")
            end

            	__tmp = TELL(" that you mentioned ")
            
            if NOT(EQUALQ(P_NOT_HERE, 1)) then 
              	__tmp = TELL("are")
            elseif T then 
              	__tmp = TELL("is")
            end

            	__tmp = TELL("n't here.", CR)
          elseif NOT(TMP) then 
            	__tmp = TELL("There's nothing here you can take.", CR)
          end

          return true
        elseif T then 
          
          if PTBL then 
            	__tmp = APPLY(function() OBJ1 = GET(P_PRSO, CNT) return OBJ1 end)
          elseif T then 
            	__tmp = APPLY(function() OBJ1 = GET(P_PRSI, CNT) return OBJ1 end)
          end

          	__tmp = APPLY(function() O = APPLY(function()
            if PTBL then 
              	__tmp = OBJ1
            elseif T then 
              	__tmp = OBJ
            end
 return __tmp end) return O end)
          	__tmp = APPLY(function() I = APPLY(function()
            if PTBL then 
              	__tmp = OBJ
            elseif T then 
              	__tmp = OBJ1
            end
 return __tmp end) return I end)
          
          if PASS(GQ(NUM, 1) or EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL)) then 
            	__tmp = APPLY(function() V = LOC(WINNER) return V end)
            
            if EQUALQ(O, NOT_HERE_OBJECT) then 
              	__tmp = APPLY(function() P_NOT_HERE = ADD(P_NOT_HERE, 1) return P_NOT_HERE end)
              	error(123)
            elseif PASS(VERBQ(TAKE) and I and EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL) and NOT(INQ(O, I))) then 
              	error(123)
            elseif PASS(EQUALQ(P_GETFLAGS, P_ALL) and VERBQ(TAKE) and PASS(PASS(NOT(EQUALQ(LOC(O), WINNER, HERE, V)) and NOT(EQUALQ(LOC(O), I)) and NOT(FSETQ(LOC(O), SURFACEBIT))) or NOT(PASS(FSETQ(O, TAKEBIT) or FSETQ(O, TRYTAKEBIT))))) then 
              	error(123)
            else 
              
              if EQUALQ(OBJ1, IT) then 
                	__tmp = PRINTD(P_IT_OBJECT)
              elseif T then 
                	__tmp = PRINTD(OBJ1)
              end

              	__tmp = TELL(": ")
            end

          end

          	__tmp = APPLY(function() PRSO = O return PRSO end)
          	__tmp = APPLY(function() PRSI = I return PRSI end)
          	__tmp = APPLY(function() TMP = T return TMP end)
          	__tmp = APPLY(function() V = PERFORM(PRSA, PRSO, PRSI) return V end)
          
          if EQUALQ(V, M_FATAL) then 
            return true
          end

        end


error(123) end
local __ok76, __res76
repeat __ok76, __res76 = pcall(__prog76)
until __ok76 or __res76 ~= 123
if not __ok76 then error(__res76)
else __tmp = __res76 or true end

    end

    
    if NOT(EQUALQ(V, M_FATAL)) then 
      	__tmp = APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_END) return V end)
    end

    
    if EQUALQ(V, M_FATAL) then 
      	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
    end

  elseif T then 
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  end

	__tmp =   NULL_F()

  if P_WON then 
    
    if VERBQ(TELL, BRIEF, SUPER_BRIEF, VERBOSE, SAVE, VERSION, QUIT, RESTART, SCORE, SCRIPT, UNSCRIPT, RESTORE) then 
      	__tmp = T
    elseif T then 
      	__tmp = APPLY(function() V = CLOCKER() return V end)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MAIN_LOOP_1\n'..__res) end
end
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

  if PASS(EQUALQ(IT, I, O) and NOT(ACCESSIBLEQ(P_IT_OBJECT))) then 
    	__tmp = TELL("I don't see what you are referring to.", CR)
    	__tmp = 	error(2)
  end


  if EQUALQ(O, IT) then 
    	__tmp = APPLY(function() O = P_IT_OBJECT return O end)
  end


  if EQUALQ(I, IT) then 
    	__tmp = APPLY(function() I = P_IT_OBJECT return I end)
  end

	__tmp = APPLY(function() PRSA = A return PRSA end)
	__tmp = APPLY(function() PRSO = O return PRSO end)

  if PASS(PRSO and NOT(EQUALQ(PRSI, IT)) and NOT(VERBQ(WALK))) then 
    	__tmp = APPLY(function() P_IT_OBJECT = PRSO return P_IT_OBJECT end)
  end

	__tmp = APPLY(function() PRSI = I return PRSI end)

  if PASS(EQUALQ(NOT_HERE_OBJECT, PRSO, PRSI) and APPLY(function() V = NOT_HERE_OBJECT_F() return V end)) then 
    	__tmp = V
  elseif T then 
    	__tmp = APPLY(function() O = PRSO return O end)
    	__tmp = APPLY(function() I = PRSI return I end)
    
    if APPLY(function() V = APPLY(GETP(WINNER, PQACTION)) return V end) then 
      	__tmp = V
    elseif APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_BEG) return V end) then 
      	__tmp = V
    elseif APPLY(function() V = APPLY(GET(PREACTIONS, A)) return V end) then 
      	__tmp = V
    elseif PASS(I and APPLY(function() V = APPLY(GETP(I, PQACTION)) return V end)) then 
      	__tmp = V
    elseif PASS(O and NOT(EQUALQ(A, VQWALK)) and LOC(O) and APPLY(function() V = APPLY(GETP(LOC(O), PQCONTFCN)) return V end)) then 
      	__tmp = V
    elseif PASS(O and NOT(EQUALQ(A, VQWALK)) and APPLY(function() V = APPLY(GETP(O, PQACTION)) return V end)) then 
      	__tmp = V
    elseif APPLY(function() V = APPLY(GET(ACTIONS, A)) return V end) then 
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
