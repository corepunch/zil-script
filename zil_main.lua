
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
MAIN_LOOP = function()
	local TRASH
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    APPLY(function() TRASH = MAIN_LOOP_1() return TRASH end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MAIN_LOOP\n'..__res) end
end
MAIN_LOOP_1 = function()
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
APPLY(function() CNT = 0 return CNT end)
APPLY(function() OBJ = nil return OBJ end)
APPLY(function() PTBL = T return PTBL end)

  if APPLY(function() P_WON = PARSER() return P_WON end) then 
    APPLY(function() ICNT = GET(P_PRSI, P_MATCHLEN) return ICNT end)
    APPLY(function() OCNT = GET(P_PRSO, P_MATCHLEN) return OCNT end)
    
    if PASS(P_IT_OBJECT and ACCESSIBLEQ(P_IT_OBJECT)) then 
      APPLY(function() TMP = nil return TMP end)
      
      APPLY(function() while true do
        
        if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), ICNT) then 
          return 
        elseif T then 
          
          if EQUALQ(GET(P_PRSI, CNT), IT) then 
            PUT(P_PRSI, CNT, P_IT_OBJECT)
            APPLY(function() TMP = T return TMP end)
            return 
          end

        end


      end end)

      
      if NOT(TMP) then 
        APPLY(function() CNT = 0 return CNT end)
        
        APPLY(function() while true do
          
          if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), OCNT) then 
            return 
          elseif T then 
            
            if EQUALQ(GET(P_PRSO, CNT), IT) then 
              PUT(P_PRSO, CNT, P_IT_OBJECT)
              return 
            end

          end


        end end)

      end

      APPLY(function() CNT = 0 return CNT end)
    end

    APPLY(function() NUM = APPLY(function()
      if ZEROQ(OCNT) then 
        -- 	return OCNT
      elseif GQ(OCNT, 1) then 
        APPLY(function() TBL = P_PRSO return TBL end)
        
        if ZEROQ(ICNT) then 
          APPLY(function() OBJ = nil return OBJ end)
        elseif T then 
          APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
        end

        -- 	return OCNT
      elseif GQ(ICNT, 1) then 
        APPLY(function() PTBL = nil return PTBL end)
        APPLY(function() TBL = P_PRSI return TBL end)
        APPLY(function() OBJ = GET(P_PRSO, 1) return OBJ end)
        -- 	return ICNT
      elseif T then 
        -- 	return 1
      end
 end) return NUM end)
    
    if PASS(NOT(OBJ) and ONEQ(ICNT)) then 
      APPLY(function() OBJ = GET(P_PRSI, 1) return OBJ end)
    end

    
    if PASS(EQUALQ(PRSA, VQWALK) and NOT(ZEROQ(P_WALK_DIR))) then 
      APPLY(function() V = PERFORM(PRSA, PRSO) return V end)
    elseif ZEROQ(NUM) then 
      
      if ZEROQ(BAND(GETB(P_SYNTAX, P_SBITS), P_SONUMS)) then 
        APPLY(function() V = PERFORM(PRSA) return V end)
        APPLY(function() PRSO = nil return PRSO end)
      elseif NOT(LIT) then 
        TELL("It's too dark to see.", CR)
      elseif T then 
        TELL("It's not clear what you're referring to.", CR)
        APPLY(function() V = nil return V end)
      end

    elseif T then 
      APPLY(function() P_NOT_HERE = 0 return P_NOT_HERE end)
      APPLY(function() P_MULT = nil return P_MULT end)
      
      if GQ(NUM, 1) then 
        APPLY(function() P_MULT = T return P_MULT end)
      end

      APPLY(function() TMP = nil return TMP end)
      
      APPLY(function() while true do
        
        if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), NUM) then 
          
          if GQ(P_NOT_HERE, 0) then 
            TELL("The ")
            
            if NOT(EQUALQ(P_NOT_HERE, NUM)) then 
              TELL("other ")
            end

            TELL("object")
            
            if NOT(EQUALQ(P_NOT_HERE, 1)) then 
              TELL("s")
            end

            TELL(" that you mentioned ")
            
            if NOT(EQUALQ(P_NOT_HERE, 1)) then 
              TELL("are")
            elseif T then 
              TELL("is")
            end

            TELL("n't here.", CR)
          elseif NOT(TMP) then 
            TELL("There's nothing here you can take.", CR)
          end

          return 
        elseif T then 
          
          if PTBL then 
            APPLY(function() OBJ1 = GET(P_PRSO, CNT) return OBJ1 end)
          elseif T then 
            APPLY(function() OBJ1 = GET(P_PRSI, CNT) return OBJ1 end)
          end

          APPLY(function() O = APPLY(function()
            if PTBL then 
              -- 	return OBJ1
            elseif T then 
              -- 	return OBJ
            end
 end) return O end)
          APPLY(function() I = APPLY(function()
            if PTBL then 
              -- 	return OBJ
            elseif T then 
              -- 	return OBJ1
            end
 end) return I end)
          
          if PASS(GQ(NUM, 1) or EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL)) then 
            APPLY(function() V = LOC(WINNER) return V end)
            
            if EQUALQ(O, NOT_HERE_OBJECT) then 
              APPLY(function() P_NOT_HERE = ADD(P_NOT_HERE, 1) return P_NOT_HERE end)
              AGAIN()
            elseif PASS(VERBQ(TAKE) and I and EQUALQ(GET(GET(P_ITBL, P_NC1), 0), WQALL) and NOT(INQ(O, I))) then 
              AGAIN()
            elseif PASS(EQUALQ(P_GETFLAGS, P_ALL) and VERBQ(TAKE) and PASS(PASS(NOT(EQUALQ(LOC(O), WINNER, HERE, V)) and NOT(EQUALQ(LOC(O), I)) and NOT(FSETQ(LOC(O), SURFACEBIT))) or NOT(PASS(FSETQ(O, TAKEBIT) or FSETQ(O, TRYTAKEBIT))))) then 
              AGAIN()
            else 
              
              if EQUALQ(OBJ1, IT) then 
                PRINTD(P_IT_OBJECT)
              elseif T then 
                PRINTD(OBJ1)
              end

              TELL(": ")
            end

          end

          APPLY(function() PRSO = O return PRSO end)
          APPLY(function() PRSI = I return PRSI end)
          APPLY(function() TMP = T return TMP end)
          APPLY(function() V = PERFORM(PRSA, PRSO, PRSI) return V end)
          
          if EQUALQ(V, M_FATAL) then 
            return 
          end

        end


      end end)

    end

    
    if NOT(EQUALQ(V, M_FATAL)) then 
      APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_END) return V end)
    end

    
    if EQUALQ(V, M_FATAL) then 
      APPLY(function() P_CONT = nil return P_CONT end)
    end

  elseif T then 
    APPLY(function() P_CONT = nil return P_CONT end)
  end

  NULL_F()

  if P_WON then 
    
    if VERBQ(TELL, BRIEF, SUPER_BRIEF, VERBOSE, SAVE, VERSION, QUIT, RESTART, SCORE, SCRIPT, UNSCRIPT, RESTORE) then 
      -- 	return T
    elseif T then 
      	return APPLY(function() V = CLOCKER() return V end)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MAIN_LOOP_1\n'..__res) end
end
P_MULT = nil
P_NOT_HERE = 0
PERFORM = function(A, O, I)
	local V
	local OA
	local OO
	local OI
  O = O or nil
  I = I or nil
	local __ok, __res = pcall(function()
APPLY(function() OA = PRSA return OA end)
APPLY(function() OO = PRSO return OO end)
APPLY(function() OI = PRSI return OI end)

  if PASS(EQUALQ(IT, I, O) and NOT(ACCESSIBLEQ(P_IT_OBJECT))) then 
    TELL("I don't see what you are referring to.", CR)
    RFATAL()
  end


  if EQUALQ(O, IT) then 
    APPLY(function() O = P_IT_OBJECT return O end)
  end


  if EQUALQ(I, IT) then 
    APPLY(function() I = P_IT_OBJECT return I end)
  end

APPLY(function() PRSA = A return PRSA end)
APPLY(function() PRSO = O return PRSO end)

  if PASS(PRSO and NOT(EQUALQ(PRSI, IT)) and NOT(VERBQ(WALK))) then 
    APPLY(function() P_IT_OBJECT = PRSO return P_IT_OBJECT end)
  end

APPLY(function() PRSI = I return PRSI end)

  if PASS(EQUALQ(NOT_HERE_OBJECT, PRSO, PRSI) and APPLY(function() V = NOT_HERE_OBJECT_F() return V end)) then 
    -- V
  elseif T then 
    APPLY(function() O = PRSO return O end)
    APPLY(function() I = PRSI return I end)
    
    if APPLY(function() V = APPLY(GETP(WINNER, PQACTION)) return V end) then 
      -- V
    elseif APPLY(function() V = APPLY(GETP(LOC(WINNER), PQACTION), M_BEG) return V end) then 
      -- V
    elseif APPLY(function() V = APPLY(GET(PREACTIONS, A)) return V end) then 
      -- V
    elseif PASS(I and APPLY(function() V = APPLY(GETP(I, PQACTION)) return V end)) then 
      -- V
    elseif PASS(O and NOT(EQUALQ(A, VQWALK)) and LOC(O) and APPLY(function() V = APPLY(GETP(LOC(O), PQCONTFCN)) return V end)) then 
      -- V
    elseif PASS(O and NOT(EQUALQ(A, VQWALK)) and APPLY(function() V = APPLY(GETP(O, PQACTION)) return V end)) then 
      -- V
    elseif APPLY(function() V = APPLY(GET(ACTIONS, A)) return V end) then 
      -- V
    end

  end

APPLY(function() PRSA = OA return PRSA end)
APPLY(function() PRSO = OO return PRSO end)
APPLY(function() PRSI = OI return PRSI end)
	return V
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PERFORM\n'..__res) end
end
