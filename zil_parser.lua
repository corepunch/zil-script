
APPLY(function() SIBREAKS = ".,\"" return SIBREAKS end)PRSA = nil
PRSI = nil
PRSO = nil
P_TABLE = 0
P_ONEOBJ = 0
P_SYNTAX = 0
P_CCTBL = TABLE(0,0,0,0)
CC_SBPTR = 0
CC_SEPTR = 1
CC_DBPTR = 2
CC_DEPTR = 3
P_LEN = 0
P_DIR = 0
HERE = 0
WINNER = 0
P_LEXV = ITABLE(59)
AGAIN_LEXV = ITABLE(59)
RESERVE_LEXV = ITABLE(59)
RESERVE_PTR = nil
P_INBUF = ITABLE(120)
OOPS_INBUF = ITABLE(120)
OOPS_TABLE = TABLE(nil,nil,nil,nil)
O_PTR = 0
O_START = 1
O_LENGTH = 2
O_END = 3
P_CONT = nil
P_IT_OBJECT = nil
P_OFLAG = nil
P_MERGED = nil
P_ACLAUSE = nil
P_ANAM = nil
P_AADJ = nil
P_LEXWORDS = 1
P_LEXSTART = 1
P_LEXELEN = 2
P_WORDLEN = 4
P_PSOFF = 4
P_P1OFF = 5
P_P1BITS = 3
P_ITBLLEN = 9
P_ITBL = TABLE(0,0,0,0,0,0,0,0,0,0)
P_OTBL = TABLE(0,0,0,0,0,0,0,0,0,0)
P_VTBL = TABLE(0,0,0,0)
P_OVTBL = TABLE(0)
P_NCN = 0
P_VERB = 0
P_VERBN = 1
P_PREP1 = 2
P_PREP1N = 3
P_PREP2 = 4
P_PREP2N = 5
P_NC1 = 6
P_NC1L = 7
P_NC2 = 8
P_NC2L = 9
QUOTE_FLAG = nil
P_END_ON_PREP = nil
PARSER = function(...)
  local PTR = P_LEXSTART
	local WRD
  local VAL = 0
  local VERB = nil
  local OF_FLAG = nil
	local OWINNER
	local OMERGED
	local LEN
  local DIR = nil
  local NW = 0
  local LW = 0
  local CNT = -1
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog1 = function()
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), P_ITBLLEN) then 
      return true
    elseif T then 
      
      if NOT(P_OFLAG) then 
        	__tmp = PUT(P_OTBL, CNT, GET(P_ITBL, CNT))
      end

      	__tmp = PUT(P_ITBL, CNT, 0)
    end


error(123) end
local __ok1, __res1
repeat __ok1, __res1 = pcall(__prog1)
until __ok1 or __res1 ~= 123
if not __ok1 then error(__res1)
else __tmp = __res1 or true end

	__tmp = APPLY(function() OWINNER = WINNER return OWINNER end)
	__tmp = APPLY(function() OMERGED = P_MERGED return OMERGED end)
	__tmp = APPLY(function() P_ADVERB = nil return P_ADVERB end)
	__tmp = APPLY(function() P_MERGED = nil return P_MERGED end)
	__tmp = APPLY(function() P_END_ON_PREP = nil return P_END_ON_PREP end)
	__tmp =   PUT(P_PRSO, P_MATCHLEN, 0)
	__tmp =   PUT(P_PRSI, P_MATCHLEN, 0)
	__tmp =   PUT(P_BUTS, P_MATCHLEN, 0)

  if PASS(NOT(QUOTE_FLAG) and NEQUALQ(WINNER, PLAYER)) then 
    	__tmp = APPLY(function() WINNER = PLAYER return WINNER end)
    	__tmp = APPLY(function() HERE = META_LOC(PLAYER) return HERE end)
    	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
  end


  if RESERVE_PTR then 
    	__tmp = APPLY(function() PTR = RESERVE_PTR return PTR end)
    	__tmp = STUFF(RESERVE_LEXV, P_LEXV)
    
    if PASS(NOT(SUPER_BRIEF) and EQUALQ(PLAYER, WINNER)) then 
      	__tmp = CRLF()
    end

    	__tmp = APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif P_CONT then 
    	__tmp = APPLY(function() PTR = P_CONT return PTR end)
    
    if PASS(NOT(SUPER_BRIEF) and EQUALQ(PLAYER, WINNER) and NOT(VERBQ(SAY))) then 
      	__tmp = CRLF()
    end

    	__tmp = APPLY(function() P_CONT = nil return P_CONT end)
  elseif T then 
    	__tmp = APPLY(function() WINNER = PLAYER return WINNER end)
    	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    
    if NOT(FSETQ(LOC(WINNER), VEHBIT)) then 
      	__tmp = APPLY(function() HERE = LOC(WINNER) return HERE end)
    end

    	__tmp = APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if NOT(SUPER_BRIEF) then 
      	__tmp = CRLF()
    end

    	__tmp = TELL(">")
    	__tmp = READ(P_INBUF, P_LEXV)
  end

	__tmp = APPLY(function() P_LEN = GETB(P_LEXV, P_LEXWORDS) return P_LEN end)

  if ZEROQ(P_LEN) then 
    	__tmp = TELL("I beg your pardon?", CR)
    	error(false)
  end


  if EQUALQ(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end), WQOOPS) then 
    
    if EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQPERIOD, WQCOMMA) then 
      	__tmp = APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
      	__tmp = APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end)
    end

    
    if NOT(GQ(P_LEN, 1)) then 
      	__tmp = TELL("I can't help your clumsiness.", CR)
      	error(false)
    elseif GET(OOPS_TABLE, O_PTR) then 
      
      if PASS(GQ(P_LEN, 2) and EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQQUOTE)) then 
        	__tmp = TELL("Sorry, you can't correct mistakes in quoted text.", CR)
        	error(false)
      elseif GQ(P_LEN, 2) then 
        	__tmp = TELL("Warning: only the first word after OOPS is used.", CR)
      end

      	__tmp = PUT(AGAIN_LEXV, GET(OOPS_TABLE, O_PTR), GET(P_LEXV, ADD(PTR, P_LEXELEN)))
      	__tmp = APPLY(function() WINNER = OWINNER return WINNER end)
      	__tmp = INBUF_ADD(GETB(P_LEXV, ADD(MULL(PTR, P_LEXELEN), 6)), GETB(P_LEXV, ADD(MULL(PTR, P_LEXELEN), 7)), ADD(MULL(GET(OOPS_TABLE, O_PTR), P_LEXELEN), 3))
      	__tmp = STUFF(AGAIN_LEXV, P_LEXV)
      	__tmp = APPLY(function() P_LEN = GETB(P_LEXV, P_LEXWORDS) return P_LEN end)
      	__tmp = APPLY(function() PTR = GET(OOPS_TABLE, O_START) return PTR end)
      	__tmp = INBUF_STUFF(OOPS_INBUF, P_INBUF)
    elseif T then 
      	__tmp = PUT(OOPS_TABLE, O_END, nil)
      	__tmp = TELL("There was no word to replace!", CR)
      	error(false)
    end

  elseif T then 
    
    if NOT(EQUALQ(WRD, WQAGAIN, WQG)) then 
      	__tmp = APPLY(function() P_NUMBER = 0 return P_NUMBER end)
    end

    	__tmp = PUT(OOPS_TABLE, O_END, nil)
  end


  if EQUALQ(GET(P_LEXV, PTR), WQAGAIN, WQG) then 
    
    if ZEROQ(GETB(OOPS_INBUF, 1)) then 
      	__tmp = TELL("Beg pardon?", CR)
      	error(false)
    elseif P_OFLAG then 
      	__tmp = TELL("It's difficult to repeat fragments.", CR)
      	error(false)
    elseif NOT(P_WON) then 
      	__tmp = TELL("That would just repeat a mistake.", CR)
      	error(false)
    elseif GQ(P_LEN, 1) then 
      
      if PASS(EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQPERIOD, WQCOMMA, WQTHEN) or EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQAND)) then 
        	__tmp = APPLY(function() PTR = ADD(PTR, MULL(2, P_LEXELEN)) return PTR end)
        	__tmp = PUTB(P_LEXV, P_LEXWORDS, SUB(GETB(P_LEXV, P_LEXWORDS), 2))
      elseif T then 
        	__tmp = TELL("I couldn't understand that sentence.", CR)
        	error(false)
      end

    elseif T then 
      	__tmp = APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
      	__tmp = PUTB(P_LEXV, P_LEXWORDS, SUB(GETB(P_LEXV, P_LEXWORDS), 1))
    end

    
    if GQ(GETB(P_LEXV, P_LEXWORDS), 0) then 
      	__tmp = STUFF(P_LEXV, RESERVE_LEXV)
      	__tmp = APPLY(function() RESERVE_PTR = PTR return RESERVE_PTR end)
    elseif T then 
      	__tmp = APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    end

    	__tmp = APPLY(function() WINNER = OWINNER return WINNER end)
    	__tmp = APPLY(function() P_MERGED = OMERGED return P_MERGED end)
    	__tmp = INBUF_STUFF(OOPS_INBUF, P_INBUF)
    	__tmp = STUFF(AGAIN_LEXV, P_LEXV)
    	__tmp = APPLY(function() CNT = -1 return CNT end)
    	__tmp = APPLY(function() DIR = AGAIN_DIR return DIR end)
    
    local __prog2 = function()
      
      if APPLY(function() CNT = CNT + 1 return CNT > P_ITBLLEN end) then 
        return true
      elseif T then 
        	__tmp = PUT(P_ITBL, CNT, GET(P_OTBL, CNT))
      end


error(123) end
local __ok2, __res2
repeat __ok2, __res2 = pcall(__prog2)
until __ok2 or __res2 ~= 123
if not __ok2 then error(__res2)
else __tmp = __res2 or true end

  elseif T then 
    	__tmp = STUFF(P_LEXV, AGAIN_LEXV)
    	__tmp = INBUF_STUFF(P_INBUF, OOPS_INBUF)
    	__tmp = PUT(OOPS_TABLE, O_START, PTR)
    	__tmp = PUT(OOPS_TABLE, O_LENGTH, MULL(4, P_LEN))
    	__tmp = APPLY(function() LEN = MULL(2, ADD(PTR, MULL(P_LEXELEN, GETB(P_LEXV, P_LEXWORDS)))) return LEN end)
    	__tmp = PUT(OOPS_TABLE, O_END, ADD(GETB(P_LEXV, SUB(LEN, 1)), GETB(P_LEXV, SUB(LEN, 2))))
    	__tmp = APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    	__tmp = APPLY(function() LEN = P_LEN return LEN end)
    	__tmp = APPLY(function() P_DIR = nil return P_DIR end)
    	__tmp = APPLY(function() P_NCN = 0 return P_NCN end)
    	__tmp = APPLY(function() P_GETFLAGS = 0 return P_GETFLAGS end)
    
    local __prog3 = function()
      
      if LQ(APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end), 0) then 
        	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
        return true
      elseif PASS(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end) or APPLY(function() WRD = NUMBERQ(PTR) return WRD end)) then 
        
        if ZEROQ(P_LEN) then 
          	__tmp = APPLY(function() NW = 0 return NW end)
        elseif T then 
          	__tmp = APPLY(function() NW = GET(P_LEXV, ADD(PTR, P_LEXELEN)) return NW end)
        end

        
        if PASS(EQUALQ(WRD, WQTO) and EQUALQ(VERB, ACTQTELL)) then 
          	__tmp = APPLY(function() WRD = WQQUOTE return WRD end)
        elseif PASS(EQUALQ(WRD, WQTHEN) and GQ(P_LEN, 0) and NOT(VERB) and NOT(QUOTE_FLAG)) then 
          
          if EQUALQ(LW, 0, WQPERIOD) then 
            	__tmp = APPLY(function() WRD = WQTHE return WRD end)
          else 
            	__tmp = PUT(P_ITBL, P_VERB, ACTQTELL)
            	__tmp = PUT(P_ITBL, P_VERBN, 0)
            	__tmp = APPLY(function() WRD = WQQUOTE return WRD end)
          end

        end

        
        if EQUALQ(WRD, WQTHEN, WQPERIOD, WQQUOTE) then 
          
          if EQUALQ(WRD, WQQUOTE) then 
            
            if QUOTE_FLAG then 
              	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
            elseif T then 
              	__tmp = APPLY(function() QUOTE_FLAG = T return QUOTE_FLAG end)
            end

          end

          	__tmp = PASS(ZEROQ(P_LEN) or APPLY(function() P_CONT = ADD(PTR, P_LEXELEN) return P_CONT end))
          	__tmp = PUTB(P_LEXV, P_LEXWORDS, P_LEN)
          return true
        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQDIRECTION, P1QDIRECTION) return VAL end) and EQUALQ(VERB, nil, ACTQWALK) and PASS(EQUALQ(LEN, 1) or PASS(EQUALQ(LEN, 2) and EQUALQ(VERB, ACTQWALK)) or PASS(EQUALQ(NW, WQTHEN, WQPERIOD, WQQUOTE) and NOT(LQ(LEN, 2))) or PASS(QUOTE_FLAG and EQUALQ(LEN, 2) and EQUALQ(NW, WQQUOTE)) or PASS(GQ(LEN, 2) and EQUALQ(NW, WQCOMMA, WQAND)))) then 
          	__tmp = APPLY(function() DIR = VAL return DIR end)
          
          if EQUALQ(NW, WQCOMMA, WQAND) then 
            	__tmp = PUT(P_LEXV, ADD(PTR, P_LEXELEN), WQTHEN)
          end

          
          if NOT(GQ(LEN, 2)) then 
            	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
            return true
          end

        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQVERB, P1QVERB) return VAL end) and NOT(VERB)) then 
          	__tmp = APPLY(function() VERB = VAL return VERB end)
          	__tmp = PUT(P_ITBL, P_VERB, VAL)
          	__tmp = PUT(P_ITBL, P_VERBN, P_VTBL)
          	__tmp = PUT(P_VTBL, 0, WRD)
          	__tmp = PUTB(P_VTBL, 2, GETB(P_LEXV, APPLY(function() CNT = ADD(MULL(PTR, 2), 2) return CNT end)))
          	__tmp = PUTB(P_VTBL, 3, GETB(P_LEXV, ADD(CNT, 1)))
        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQPREPOSITION, 0) return VAL end) or EQUALQ(WRD, WQALL, WQONE) or WTQ(WRD, PSQADJECTIVE) or WTQ(WRD, PSQOBJECT)) then 
          
          if PASS(GQ(P_LEN, 1) and EQUALQ(NW, WQOF) and ZEROQ(VAL) and NOT(EQUALQ(WRD, WQALL, WQONE, WQA))) then 
            	__tmp = APPLY(function() OF_FLAG = T return OF_FLAG end)
          elseif PASS(NOT(ZEROQ(VAL)) and PASS(ZEROQ(P_LEN) or EQUALQ(NW, WQTHEN, WQPERIOD))) then 
            	__tmp = APPLY(function() P_END_ON_PREP = T return P_END_ON_PREP end)
            
            if LQ(P_NCN, 2) then 
              	__tmp = PUT(P_ITBL, P_PREP1, VAL)
              	__tmp = PUT(P_ITBL, P_PREP1N, WRD)
            end

          elseif EQUALQ(P_NCN, 2) then 
            	__tmp = TELL("There were too many nouns in that sentence.", CR)
            	error(false)
          elseif T then 
            	__tmp = APPLY(function() P_NCN = ADD(P_NCN, 1) return P_NCN end)
            	__tmp = APPLY(function() P_ACT = VERB return P_ACT end)
            	__tmp = PASS(APPLY(function() PTR = CLAUSE(PTR, VAL, WRD) return PTR end) or 	error(false))
            
            if LQ(PTR, 0) then 
              	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
              return true
            end

          end

        elseif EQUALQ(WRD, WQOF) then 
          
          if PASS(NOT(OF_FLAG) or EQUALQ(NW, WQPERIOD, WQTHEN)) then 
            	__tmp = CANT_USE(PTR)
            	error(false)
          elseif T then 
            	__tmp = APPLY(function() OF_FLAG = nil return OF_FLAG end)
          end

        elseif WTQ(WRD, PSQBUZZ_WORD) then 
          	__tmp = WTQ(WRD, PSQBUZZ_WORD)
        elseif PASS(EQUALQ(VERB, ACTQTELL) and WTQ(WRD, PSQVERB, P1QVERB) and EQUALQ(WINNER, PLAYER)) then 
          	__tmp = TELL("Please consult your manual for the correct way to talk to other people or creatures.", CR)
          	error(false)
        elseif T then 
          	__tmp = CANT_USE(PTR)
          	error(false)
        end

      elseif T then 
        	__tmp = UNKNOWN_WORD(PTR)
        	error(false)
      end

      APPLY(function() LW = WRD return LW end)
      APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)

error(123) end
local __ok3, __res3
repeat __ok3, __res3 = pcall(__prog3)
until __ok3 or __res3 ~= 123
if not __ok3 then error(__res3)
else __tmp = __res3 or true end

  end

	__tmp =   PUT(OOPS_TABLE, O_PTR, nil)

  if DIR then 
    	__tmp = APPLY(function() PRSA = VQWALK return PRSA end)
    	__tmp = APPLY(function() PRSO = DIR return PRSO end)
    	__tmp = APPLY(function() P_OFLAG = nil return P_OFLAG end)
    	__tmp = APPLY(function() P_WALK_DIR = DIR return P_WALK_DIR end)
    	__tmp = APPLY(function() AGAIN_DIR = DIR return AGAIN_DIR end)
  else 
    
    if P_OFLAG then 
      	__tmp = ORPHAN_MERGE()
    end

    	__tmp = APPLY(function() P_WALK_DIR = nil return P_WALK_DIR end)
    	__tmp = APPLY(function() AGAIN_DIR = nil return AGAIN_DIR end)
    
    if PASS(SYNTAX_CHECK() and SNARF_OBJECTS() and MANY_CHECK() and TAKE_CHECK()) then 
      	__tmp = T
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PARSER\n'..__res) end
end
P_ACT = nil
P_WALK_DIR = nil
AGAIN_DIR = nil
STUFF = function(...)
	local SRC, DEST, MAX = ...
  local PTR = P_LEXSTART
  local CTR = 1
	local BPTR
	if select('#', ...) < 3 then MAX = 29 end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUTB(DEST, 0, GETB(SRC, 0))
	__tmp =   PUTB(DEST, 1, GETB(SRC, 1))

  local __prog4 = function()
    PUT(DEST, PTR, GET(SRC, PTR))
    APPLY(function() BPTR = ADD(MULL(PTR, 2), 2) return BPTR end)
    PUTB(DEST, BPTR, GETB(SRC, BPTR))
    APPLY(function() BPTR = ADD(MULL(PTR, 2), 3) return BPTR end)
    PUTB(DEST, BPTR, GETB(SRC, BPTR))
    APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
    
    if APPLY(function() CTR = CTR + 1 return CTR > MAX end) then 
      return true
    end


error(123) end
local __ok4, __res4
repeat __ok4, __res4 = pcall(__prog4)
until __ok4 or __res4 ~= 123
if not __ok4 then error(__res4)
else __tmp = __res4 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('STUFF\n'..__res) end
end
INBUF_STUFF = function(...)
	local SRC, DEST = ...
	local CNT
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() CNT = SUB(GETB(SRC, 0), 1) return CNT end)

  local __prog5 = function()
    PUTB(DEST, CNT, GETB(SRC, CNT))
    
    if APPLY(function() CNT = CNT - 1 return CNT < 0 end) then 
      return true
    end


error(123) end
local __ok5, __res5
repeat __ok5, __res5 = pcall(__prog5)
until __ok5 or __res5 ~= 123
if not __ok5 then error(__res5)
else __tmp = __res5 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('INBUF_STUFF\n'..__res) end
end
INBUF_ADD = function(...)
	local LEN, BEG, SLOT = ...
	local DBEG
  local CTR = 0
	local TMP
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() TMP = GET(OOPS_TABLE, O_END) return TMP end) then 
    	__tmp = APPLY(function() DBEG = TMP return DBEG end)
  elseif T then 
    	__tmp = APPLY(function() DBEG = ADD(GETB(AGAIN_LEXV, APPLY(function() TMP = GET(OOPS_TABLE, O_LENGTH) return TMP end)), GETB(AGAIN_LEXV, ADD(TMP, 1))) return DBEG end)
  end

	__tmp =   PUT(OOPS_TABLE, O_END, ADD(DBEG, LEN))

  local __prog6 = function()
    PUTB(OOPS_INBUF, ADD(DBEG, CTR), GETB(P_INBUF, ADD(BEG, CTR)))
    APPLY(function() CTR = ADD(CTR, 1) return CTR end)
    
    if EQUALQ(CTR, LEN) then 
      return true
    end


error(123) end
local __ok6, __res6
repeat __ok6, __res6 = pcall(__prog6)
until __ok6 or __res6 ~= 123
if not __ok6 then error(__res6)
else __tmp = __res6 or true end

	__tmp =   PUTB(AGAIN_LEXV, SLOT, DBEG)
	__tmp =   PUTB(AGAIN_LEXV, SUB(SLOT, 1), LEN)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('INBUF_ADD\n'..__res) end
end
WTQ = function(...)
	local PTR, BIT, B1 = ...
  local OFFS = P_P1OFF
	local TYP
	if select('#', ...) < 3 then B1 = 5 end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if BTST(APPLY(function() TYP = GETB(PTR, P_PSOFF) return TYP end), BIT) then 
    
    if GQ(B1, 4) then 
      	error(true)
    elseif T then 
      	__tmp = APPLY(function() TYP = BAND(TYP, P_P1BITS) return TYP end)
      
      if NOT(EQUALQ(TYP, B1)) then 
        	__tmp = APPLY(function() OFFS = ADD(OFFS, 1) return OFFS end)
      end

      	__tmp = GETB(PTR, OFFS)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WTQ\n'..__res) end
end
CLAUSE = function(...)
	local PTR, VAL, WRD = ...
	local OFF
	local NUM
  local ANDFLG = nil
  local FIRSTQQ = T
	local NW
  local LW = 0
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() OFF = MULL(SUB(P_NCN, 1), 2) return OFF end)

  if NOT(EQUALQ(VAL, 0)) then 
    	__tmp = PUT(P_ITBL, APPLY(function() NUM = ADD(P_PREP1, OFF) return NUM end), VAL)
    	__tmp = PUT(P_ITBL, ADD(NUM, 1), WRD)
    	__tmp = APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
  elseif T then 
    	__tmp = APPLY(function() P_LEN = ADD(P_LEN, 1) return P_LEN end)
  end


  if ZEROQ(P_LEN) then 
    	__tmp = APPLY(function() P_NCN = SUB(P_NCN, 1) return P_NCN end)
    error(-1)
  end

	__tmp =   PUT(P_ITBL, APPLY(function() NUM = ADD(P_NC1, OFF) return NUM end), REST(P_LEXV, MULL(PTR, 2)))

  if EQUALQ(GET(P_LEXV, PTR), WQTHE, WQA, WQAN) then 
    	__tmp = PUT(P_ITBL, NUM, REST(GET(P_ITBL, NUM), 4))
  end


  local __prog7 = function()
    
    if LQ(APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end), 0) then 
      	__tmp = PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(PTR, 2)))
      error(-1)
    end

    
    if PASS(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end) or APPLY(function() WRD = NUMBERQ(PTR) return WRD end)) then 
      
      if ZEROQ(P_LEN) then 
        	__tmp = APPLY(function() NW = 0 return NW end)
      elseif T then 
        	__tmp = APPLY(function() NW = GET(P_LEXV, ADD(PTR, P_LEXELEN)) return NW end)
      end

      
      if EQUALQ(WRD, WQAND, WQCOMMA) then 
        	__tmp = APPLY(function() ANDFLG = T return ANDFLG end)
      elseif EQUALQ(WRD, WQALL, WQONE) then 
        
        if EQUALQ(NW, WQOF) then 
          	__tmp = APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end)
          	__tmp = APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
        end

      elseif PASS(EQUALQ(WRD, WQTHEN, WQPERIOD) or PASS(WTQ(WRD, PSQPREPOSITION) and GET(P_ITBL, P_VERB) and NOT(FIRSTQQ))) then 
        	__tmp = APPLY(function() P_LEN = ADD(P_LEN, 1) return P_LEN end)
        	__tmp = PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(PTR, 2)))
        error(SUB(PTR, P_LEXELEN))
      elseif WTQ(WRD, PSQOBJECT) then 
        
        if PASS(GQ(P_LEN, 0) and EQUALQ(NW, WQOF) and NOT(EQUALQ(WRD, WQALL, WQONE))) then 
          	__tmp = T
        elseif PASS(WTQ(WRD, PSQADJECTIVE, P1QADJECTIVE) and NOT(EQUALQ(NW, 0)) and WTQ(NW, PSQOBJECT)) then 
          	__tmp = PASS(WTQ(WRD, PSQADJECTIVE, P1QADJECTIVE) and NOT(EQUALQ(NW, 0)) and WTQ(NW, PSQOBJECT))
        elseif PASS(NOT(ANDFLG) and NOT(EQUALQ(NW, WQBUT, WQEXCEPT)) and NOT(EQUALQ(NW, WQAND, WQCOMMA))) then 
          	__tmp = PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(ADD(PTR, 2), 2)))
          error(PTR)
        elseif T then 
          	__tmp = APPLY(function() ANDFLG = nil return ANDFLG end)
        end

      elseif PASS(PASS(P_MERGED or P_OFLAG or NOT(EQUALQ(GET(P_ITBL, P_VERB), 0))) and PASS(WTQ(WRD, PSQADJECTIVE) or WTQ(WRD, PSQBUZZ_WORD))) then 
        	__tmp = PASS(PASS(P_MERGED or P_OFLAG or NOT(EQUALQ(GET(P_ITBL, P_VERB), 0))) and PASS(WTQ(WRD, PSQADJECTIVE) or WTQ(WRD, PSQBUZZ_WORD)))
      elseif PASS(ANDFLG and PASS(WTQ(WRD, PSQDIRECTION) or WTQ(WRD, PSQVERB))) then 
        	__tmp = APPLY(function() PTR = SUB(PTR, 4) return PTR end)
        	__tmp = PUT(P_LEXV, ADD(PTR, 2), WQTHEN)
        	__tmp = APPLY(function() P_LEN = ADD(P_LEN, 2) return P_LEN end)
      elseif WTQ(WRD, PSQPREPOSITION) then 
        	__tmp = T
      elseif T then 
        	__tmp = CANT_USE(PTR)
        	error(false)
      end

    elseif T then 
      	__tmp = UNKNOWN_WORD(PTR)
      	error(false)
    end

    APPLY(function() LW = WRD return LW end)
    APPLY(function() FIRSTQQ = nil return FIRSTQQ end)
    APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)

error(123) end
local __ok7, __res7
repeat __ok7, __res7 = pcall(__prog7)
until __ok7 or __res7 ~= 123
if not __ok7 then error(__res7)
else __tmp = __res7 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CLAUSE\n'..__res) end
end
NUMBERQ = function(...)
	local PTR = ...
	local CNT
	local BPTR
	local CHR
  local SUM = 0
  local TIM = nil
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() CNT = GETB(REST(P_LEXV, MULL(PTR, 2)), 2) return CNT end)
	__tmp = APPLY(function() BPTR = GETB(REST(P_LEXV, MULL(PTR, 2)), 3) return BPTR end)

  local __prog8 = function()
    
    if LQ(APPLY(function() CNT = SUB(CNT, 1) return CNT end), 0) then 
      return true
    elseif T then 
      	__tmp = APPLY(function() CHR = GETB(P_INBUF, BPTR) return CHR end)
      
      if EQUALQ(CHR, 58) then 
        	__tmp = APPLY(function() TIM = SUM return TIM end)
        	__tmp = APPLY(function() SUM = 0 return SUM end)
      elseif GQ(SUM, 10000) then 
        	error(false)
      elseif PASS(LQ(CHR, 58) and GQ(CHR, 47)) then 
        	__tmp = APPLY(function() SUM = ADD(MULL(SUM, 10), SUB(CHR, 48)) return SUM end)
      elseif T then 
        	error(false)
      end

      	__tmp = APPLY(function() BPTR = ADD(BPTR, 1) return BPTR end)
    end


error(123) end
local __ok8, __res8
repeat __ok8, __res8 = pcall(__prog8)
until __ok8 or __res8 ~= 123
if not __ok8 then error(__res8)
else __tmp = __res8 or true end

	__tmp =   PUT(P_LEXV, PTR, WQINTNUM)

  if GQ(SUM, 1000) then 
    	error(false)
  elseif TIM then 
    
    if LQ(TIM, 8) then 
      	__tmp = APPLY(function() TIM = ADD(TIM, 12) return TIM end)
    elseif GQ(TIM, 23) then 
      	error(false)
    end

    	__tmp = APPLY(function() SUM = ADD(SUM, MULL(TIM, 60)) return SUM end)
  end

	__tmp = APPLY(function() P_NUMBER = SUM return P_NUMBER end)
	__tmp = WQINTNUM
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NUMBERQ\n'..__res) end
end
P_NUMBER = 0
P_DIRECTION = 0
ORPHAN_MERGE = function(...)
  local CNT = -1
	local TEMP
	local VERB
	local BEG
	local END
  local ADJ = nil
	local WRD
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() P_OFLAG = nil return P_OFLAG end)

  if PASS(EQUALQ(WTQ(APPLY(function() WRD = GET(GET(P_ITBL, P_VERBN), 0) return WRD end), PSQVERB, P1QVERB), GET(P_OTBL, P_VERB)) or NOT(ZEROQ(WTQ(WRD, PSQADJECTIVE)))) then 
    	__tmp = APPLY(function() ADJ = T return ADJ end)
  elseif PASS(NOT(ZEROQ(WTQ(WRD, PSQOBJECT, P1QOBJECT))) and EQUALQ(P_NCN, 0)) then 
    	__tmp = PUT(P_ITBL, P_VERB, 0)
    	__tmp = PUT(P_ITBL, P_VERBN, 0)
    	__tmp = PUT(P_ITBL, P_NC1, REST(P_LEXV, 2))
    	__tmp = PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
    	__tmp = APPLY(function() P_NCN = 1 return P_NCN end)
  end


  if PASS(NOT(ZEROQ(APPLY(function() VERB = GET(P_ITBL, P_VERB) return VERB end))) and NOT(ADJ) and NOT(EQUALQ(VERB, GET(P_OTBL, P_VERB)))) then 
    	error(false)
  elseif EQUALQ(P_NCN, 2) then 
    	error(false)
  elseif EQUALQ(GET(P_OTBL, P_NC1), 1) then 
    
    if PASS(EQUALQ(APPLY(function() TEMP = GET(P_ITBL, P_PREP1) return TEMP end), GET(P_OTBL, P_PREP1)) or ZEROQ(TEMP)) then 
      
      if ADJ then 
        	__tmp = PUT(P_OTBL, P_NC1, REST(P_LEXV, 2))
        
        if ZEROQ(GET(P_ITBL, P_NC1L)) then 
          	__tmp = PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
        end

        
        if ZEROQ(P_NCN) then 
          	__tmp = APPLY(function() P_NCN = 1 return P_NCN end)
        end

      elseif T then 
        	__tmp = PUT(P_OTBL, P_NC1, GET(P_ITBL, P_NC1))
      end

      	__tmp = PUT(P_OTBL, P_NC1L, GET(P_ITBL, P_NC1L))
    elseif T then 
      	error(false)
    end

  elseif EQUALQ(GET(P_OTBL, P_NC2), 1) then 
    
    if PASS(EQUALQ(APPLY(function() TEMP = GET(P_ITBL, P_PREP1) return TEMP end), GET(P_OTBL, P_PREP2)) or ZEROQ(TEMP)) then 
      
      if ADJ then 
        	__tmp = PUT(P_ITBL, P_NC1, REST(P_LEXV, 2))
        
        if ZEROQ(GET(P_ITBL, P_NC1L)) then 
          	__tmp = PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
        end

      end

      	__tmp = PUT(P_OTBL, P_NC2, GET(P_ITBL, P_NC1))
      	__tmp = PUT(P_OTBL, P_NC2L, GET(P_ITBL, P_NC1L))
      	__tmp = APPLY(function() P_NCN = 2 return P_NCN end)
    elseif T then 
      	error(false)
    end

  elseif NOT(ZEROQ(P_ACLAUSE)) then 
    
    if PASS(NOT(EQUALQ(P_NCN, 1)) and NOT(ADJ)) then 
      	__tmp = APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
      	error(false)
    elseif T then 
      	__tmp = APPLY(function() BEG = GET(P_ITBL, P_NC1) return BEG end)
      
      if ADJ then 
        	__tmp = APPLY(function() BEG = REST(P_LEXV, 2) return BEG end)
        	__tmp = APPLY(function() ADJ = nil return ADJ end)
      end

      	__tmp = APPLY(function() END = GET(P_ITBL, P_NC1L) return END end)
      
      local __prog9 = function()
        APPLY(function() WRD = GET(BEG, 0) return WRD end)
        
        if EQUALQ(BEG, END) then 
          
          if ADJ then 
            	__tmp = ACLAUSE_WIN(ADJ)
            return true
          elseif T then 
            	__tmp = APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
            	error(false)
          end

        elseif PASS(NOT(ADJ) and PASS(BTST(GETB(WRD, P_PSOFF), PSQADJECTIVE) or EQUALQ(WRD, WQALL, WQONE))) then 
          	__tmp = APPLY(function() ADJ = WRD return ADJ end)
        elseif EQUALQ(WRD, WQONE) then 
          	__tmp = ACLAUSE_WIN(ADJ)
          return true
        elseif BTST(GETB(WRD, P_PSOFF), PSQOBJECT) then 
          
          if EQUALQ(WRD, P_ANAM) then 
            	__tmp = ACLAUSE_WIN(ADJ)
          elseif T then 
            	__tmp = NCLAUSE_WIN()
          end

          return true
        end

        APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)
        
        if EQUALQ(END, 0) then 
          	__tmp = APPLY(function() END = BEG return END end)
          	__tmp = APPLY(function() P_NCN = 1 return P_NCN end)
          	__tmp = PUT(P_ITBL, P_NC1, BACK(BEG, 4))
          	__tmp = PUT(P_ITBL, P_NC1L, BEG)
        end


error(123) end
local __ok9, __res9
repeat __ok9, __res9 = pcall(__prog9)
until __ok9 or __res9 ~= 123
if not __ok9 then error(__res9)
else __tmp = __res9 or true end

    end

  end

	__tmp =   PUT(P_VTBL, 0, GET(P_OVTBL, 0))
	__tmp =   PUTB(P_VTBL, 2, GETB(P_OVTBL, 2))
	__tmp =   PUTB(P_VTBL, 3, GETB(P_OVTBL, 3))
	__tmp =   PUT(P_OTBL, P_VERBN, P_VTBL)
	__tmp =   PUTB(P_VTBL, 2, 0)

  local __prog10 = function()
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), P_ITBLLEN) then 
      	__tmp = APPLY(function() P_MERGED = T return P_MERGED end)
      	error(true)
    elseif T then 
      	__tmp = PUT(P_ITBL, CNT, GET(P_OTBL, CNT))
    end


error(123) end
local __ok10, __res10
repeat __ok10, __res10 = pcall(__prog10)
until __ok10 or __res10 ~= 123
if not __ok10 then error(__res10)
else __tmp = __res10 or true end

	__tmp = T
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ORPHAN_MERGE\n'..__res) end
end
ACLAUSE_WIN = function(...)
	local ADJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUT(P_ITBL, P_VERB, GET(P_OTBL, P_VERB))
	__tmp =   PUT(P_CCTBL, CC_SBPTR, P_ACLAUSE)
	__tmp =   PUT(P_CCTBL, CC_SEPTR, ADD(P_ACLAUSE, 1))
	__tmp =   PUT(P_CCTBL, CC_DBPTR, P_ACLAUSE)
	__tmp =   PUT(P_CCTBL, CC_DEPTR, ADD(P_ACLAUSE, 1))
	__tmp =   CLAUSE_COPY(P_OTBL, P_OTBL, ADJ)
	__tmp =   PASS(NOT(EQUALQ(GET(P_OTBL, P_NC2), 0)) and APPLY(function() P_NCN = 2 return P_NCN end))
	__tmp = APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ACLAUSE_WIN\n'..__res) end
end
NCLAUSE_WIN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUT(P_CCTBL, CC_SBPTR, P_NC1)
	__tmp =   PUT(P_CCTBL, CC_SEPTR, P_NC1L)
	__tmp =   PUT(P_CCTBL, CC_DBPTR, P_ACLAUSE)
	__tmp =   PUT(P_CCTBL, CC_DEPTR, ADD(P_ACLAUSE, 1))
	__tmp =   CLAUSE_COPY(P_ITBL, P_OTBL)
	__tmp =   PASS(NOT(EQUALQ(GET(P_OTBL, P_NC2), 0)) and APPLY(function() P_NCN = 2 return P_NCN end))
	__tmp = APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('NCLAUSE_WIN\n'..__res) end
end
WORD_PRINT = function(...)
	local CNT, BUF = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog11 = function()
    
    if APPLY(function() CNT = CNT - 1 return CNT < 0 end) then 
      return true
    else 
      	__tmp = PRINTC(GETB(P_INBUF, BUF))
      	__tmp = APPLY(function() BUF = ADD(BUF, 1) return BUF end)
    end


error(123) end
local __ok11, __res11
repeat __ok11, __res11 = pcall(__prog11)
until __ok11 or __res11 ~= 123
if not __ok11 then error(__res11)
else __tmp = __res11 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WORD_PRINT\n'..__res) end
end
UNKNOWN_WORD = function(...)
	local PTR = ...
	local BUF
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUT(OOPS_TABLE, O_PTR, PTR)

  if VERBQ(SAY) then 
    	__tmp = TELL("Nothing happens.", CR)
    	error(false)
  end

	__tmp =   TELL("I don't know the word \"")
	__tmp =   WORD_PRINT(GETB(REST(P_LEXV, APPLY(function() BUF = MULL(PTR, 2) return BUF end)), 2), GETB(REST(P_LEXV, BUF), 3))
	__tmp =   TELL("\".", CR)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	__tmp = APPLY(function() P_OFLAG = nil return P_OFLAG end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('UNKNOWN_WORD\n'..__res) end
end
CANT_USE = function(...)
	local PTR = ...
	local BUF
	local __ok, __res = pcall(function()
	local __tmp = nil

  if VERBQ(SAY) then 
    	__tmp = TELL("Nothing happens.", CR)
    	error(false)
  end

	__tmp =   TELL("You used the word \"")
	__tmp =   WORD_PRINT(GETB(REST(P_LEXV, APPLY(function() BUF = MULL(PTR, 2) return BUF end)), 2), GETB(REST(P_LEXV, BUF), 3))
	__tmp =   TELL("\" in a way that I don't understand.", CR)
	__tmp = APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	__tmp = APPLY(function() P_OFLAG = nil return P_OFLAG end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CANT_USE\n'..__res) end
end
P_SLOCBITS = 0
P_SYNLEN = 8
P_SBITS = 0
P_SPREP1 = 1
P_SPREP2 = 2
P_SFWIM1 = 3
P_SFWIM2 = 4
P_SLOC1 = 5
P_SLOC2 = 6
P_SACTION = 7
P_SONUMS = 3
SYNTAX_CHECK = function(...)
	local SYN
	local LEN
	local NUM
	local OBJ
  local DRIVE1 = nil
  local DRIVE2 = nil
	local PREP
	local VERB
	local TMP
	local __ok, __res = pcall(function()
	local __tmp = nil

  if ZEROQ(APPLY(function() VERB = GET(P_ITBL, P_VERB) return VERB end)) then 
    	__tmp = TELL("There was no verb in that sentence!", CR)
    	error(false)
  end

	__tmp = APPLY(function() SYN = GET(VERBS, SUB(255, VERB)) return SYN end)
	__tmp = APPLY(function() LEN = GETB(SYN, 0) return LEN end)
	__tmp = APPLY(function() SYN = REST(SYN) return SYN end)

  local __prog12 = function()
    APPLY(function() NUM = BAND(GETB(SYN, P_SBITS), P_SONUMS) return NUM end)
    
    if GQ(P_NCN, NUM) then 
      	__tmp = T
    elseif PASS(NOT(LQ(NUM, 1)) and ZEROQ(P_NCN) and PASS(ZEROQ(APPLY(function() PREP = GET(P_ITBL, P_PREP1) return PREP end)) or EQUALQ(PREP, GETB(SYN, P_SPREP1)))) then 
      	__tmp = APPLY(function() DRIVE1 = SYN return DRIVE1 end)
    elseif EQUALQ(GETB(SYN, P_SPREP1), GET(P_ITBL, P_PREP1)) then 
      
      if PASS(EQUALQ(NUM, 2) and EQUALQ(P_NCN, 1)) then 
        	__tmp = APPLY(function() DRIVE2 = SYN return DRIVE2 end)
      elseif EQUALQ(GETB(SYN, P_SPREP2), GET(P_ITBL, P_PREP2)) then 
        	__tmp = SYNTAX_FOUND(SYN)
        	error(true)
      end

    end

    
    if APPLY(function() LEN = LEN - 1 return LEN < 1 end) then 
      
      if PASS(DRIVE1 or DRIVE2) then 
        return true
      elseif T then 
        	__tmp = TELL("That sentence isn't one I recognize.", CR)
        	error(false)
      end

    elseif T then 
      	__tmp = APPLY(function() SYN = REST(SYN, P_SYNLEN) return SYN end)
    end


error(123) end
local __ok12, __res12
repeat __ok12, __res12 = pcall(__prog12)
until __ok12 or __res12 ~= 123
if not __ok12 then error(__res12)
else __tmp = __res12 or true end


  if PASS(DRIVE1 and APPLY(function() OBJ = GWIM(GETB(DRIVE1, P_SFWIM1), GETB(DRIVE1, P_SLOC1), GETB(DRIVE1, P_SPREP1)) return OBJ end)) then 
    	__tmp = PUT(P_PRSO, P_MATCHLEN, 1)
    	__tmp = PUT(P_PRSO, 1, OBJ)
    	__tmp = SYNTAX_FOUND(DRIVE1)
  elseif PASS(DRIVE2 and APPLY(function() OBJ = GWIM(GETB(DRIVE2, P_SFWIM2), GETB(DRIVE2, P_SLOC2), GETB(DRIVE2, P_SPREP2)) return OBJ end)) then 
    	__tmp = PUT(P_PRSI, P_MATCHLEN, 1)
    	__tmp = PUT(P_PRSI, 1, OBJ)
    	__tmp = SYNTAX_FOUND(DRIVE2)
  elseif EQUALQ(VERB, ACTQFIND) then 
    	__tmp = TELL("That question can't be answered.", CR)
    	error(false)
  elseif NOT(EQUALQ(WINNER, PLAYER)) then 
    	__tmp = CANT_ORPHAN()
  elseif T then 
    	__tmp = ORPHAN(DRIVE1, DRIVE2)
    	__tmp = TELL("What do you want to ")
    	__tmp = APPLY(function() TMP = GET(P_OTBL, P_VERBN) return TMP end)
    
    if EQUALQ(TMP, 0) then 
      	__tmp = TELL("tell")
    elseif ZEROQ(GETB(P_VTBL, 2)) then 
      	__tmp = PRINTB(GET(TMP, 0))
    elseif T then 
      	__tmp = WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
      	__tmp = PUTB(P_VTBL, 2, 0)
    end

    
    if DRIVE2 then 
      	__tmp = TELL(" ")
      	__tmp = THING_PRINT(T, T)
    end

    	__tmp = APPLY(function() P_OFLAG = T return P_OFLAG end)
    	__tmp = PREP_PRINT(APPLY(function()
      if DRIVE1 then 
        	__tmp = GETB(DRIVE1, P_SPREP1)
      elseif T then 
        	__tmp = GETB(DRIVE2, P_SPREP2)
      end
 end))
    	__tmp = TELL("?", CR)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SYNTAX_CHECK\n'..__res) end
end
CANT_ORPHAN = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   TELL("\"I don't understand! What are you referring to?\"", CR)
	error(false)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CANT_ORPHAN\n'..__res) end
end
ORPHAN = function(...)
	local D1, D2 = ...
  local CNT = -1
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(P_MERGED) then 
    	__tmp = PUT(P_OCLAUSE, P_MATCHLEN, 0)
  end

	__tmp =   PUT(P_OVTBL, 0, GET(P_VTBL, 0))
	__tmp =   PUTB(P_OVTBL, 2, GETB(P_VTBL, 2))
	__tmp =   PUTB(P_OVTBL, 3, GETB(P_VTBL, 3))

  local __prog13 = function()
    
    if APPLY(function() CNT = CNT + 1 return CNT > P_ITBLLEN end) then 
      return true
    elseif T then 
      	__tmp = PUT(P_OTBL, CNT, GET(P_ITBL, CNT))
    end


error(123) end
local __ok13, __res13
repeat __ok13, __res13 = pcall(__prog13)
until __ok13 or __res13 ~= 123
if not __ok13 then error(__res13)
else __tmp = __res13 or true end


  if EQUALQ(P_NCN, 2) then 
    	__tmp = PUT(P_CCTBL, CC_SBPTR, P_NC2)
    	__tmp = PUT(P_CCTBL, CC_SEPTR, P_NC2L)
    	__tmp = PUT(P_CCTBL, CC_DBPTR, P_NC2)
    	__tmp = PUT(P_CCTBL, CC_DEPTR, P_NC2L)
    	__tmp = CLAUSE_COPY(P_ITBL, P_OTBL)
  end


  if NOT(LQ(P_NCN, 1)) then 
    	__tmp = PUT(P_CCTBL, CC_SBPTR, P_NC1)
    	__tmp = PUT(P_CCTBL, CC_SEPTR, P_NC1L)
    	__tmp = PUT(P_CCTBL, CC_DBPTR, P_NC1)
    	__tmp = PUT(P_CCTBL, CC_DEPTR, P_NC1L)
    	__tmp = CLAUSE_COPY(P_ITBL, P_OTBL)
  end


  if D1 then 
    	__tmp = PUT(P_OTBL, P_PREP1, GETB(D1, P_SPREP1))
    	__tmp = PUT(P_OTBL, P_NC1, 1)
  elseif D2 then 
    	__tmp = PUT(P_OTBL, P_PREP2, GETB(D2, P_SPREP2))
    	__tmp = PUT(P_OTBL, P_NC2, 1)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ORPHAN\n'..__res) end
end
THING_PRINT = function(...)
	local PRSOQ, THEQ = ...
	local BEG
	local END
	if select('#', ...) < 2 then THEQ = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PRSOQ then 
    	__tmp = APPLY(function() BEG = GET(P_ITBL, P_NC1) return BEG end)
    	__tmp = APPLY(function() END = GET(P_ITBL, P_NC1L) return END end)
  else 
    	__tmp = APPLY(function() BEG = GET(P_ITBL, P_NC2) return BEG end)
    	__tmp = APPLY(function() END = GET(P_ITBL, P_NC2L) return END end)
  end

	__tmp =   BUFFER_PRINT(BEG, END, THEQ)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('THING_PRINT\n'..__res) end
end
BUFFER_PRINT = function(...)
	local BEG, END, CP = ...
  local NOSP = T
	local WRD
  local FIRSTQQ = T
  local PN = nil
  local QQ = nil
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog14 = function()
    
    if EQUALQ(BEG, END) then 
      return true
    elseif T then 
      	__tmp = APPLY(function() WRD = GET(BEG, 0) return WRD end)
      
      if EQUALQ(WRD, WQCOMMA) then 
        	__tmp = TELL(", ")
      elseif NOSP then 
        	__tmp = APPLY(function() NOSP = nil return NOSP end)
      else 
        	__tmp = TELL(" ")
      end

      
      if EQUALQ(WRD, WQPERIOD, WQCOMMA) then 
        	__tmp = APPLY(function() NOSP = T return NOSP end)
      elseif EQUALQ(WRD, WQME) then 
        	__tmp = PRINTD(ME)
        	__tmp = APPLY(function() PN = T return PN end)
      elseif EQUALQ(WRD, WQINTNUM) then 
        	__tmp = PRINTN(P_NUMBER)
        	__tmp = APPLY(function() PN = T return PN end)
      elseif T then 
        
        if PASS(FIRSTQQ and NOT(PN) and CP) then 
          	__tmp = TELL("the ")
        end

        
        if PASS(P_OFLAG or P_MERGED) then 
          	__tmp = PRINTB(WRD)
        elseif PASS(EQUALQ(WRD, WQIT) and ACCESSIBLEQ(P_IT_OBJECT)) then 
          	__tmp = PRINTD(P_IT_OBJECT)
        elseif T then 
          	__tmp = WORD_PRINT(GETB(BEG, 2), GETB(BEG, 3))
        end

        	__tmp = APPLY(function() FIRSTQQ = nil return FIRSTQQ end)
      end

    end

    APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)

error(123) end
local __ok14, __res14
repeat __ok14, __res14 = pcall(__prog14)
until __ok14 or __res14 ~= 123
if not __ok14 then error(__res14)
else __tmp = __res14 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BUFFER_PRINT\n'..__res) end
end
PREP_PRINT = function(...)
	local PREP = ...
	local WRD
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(ZEROQ(PREP)) then 
    	__tmp = TELL(" ")
    
    if T then 
      	__tmp = APPLY(function() WRD = PREP_FIND(PREP) return WRD end)
      	__tmp = PRINTB(WRD)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PREP_PRINT\n'..__res) end
end
CLAUSE_COPY = function(...)
	local SRC, DEST, INSRT = ...
	local BEG
	local END
	if select('#', ...) < 3 then INSRT = nil end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() BEG = GET(SRC, GET(P_CCTBL, CC_SBPTR)) return BEG end)
	__tmp = APPLY(function() END = GET(SRC, GET(P_CCTBL, CC_SEPTR)) return END end)
	__tmp =   PUT(DEST, GET(P_CCTBL, CC_DBPTR), REST(P_OCLAUSE, ADD(MULL(GET(P_OCLAUSE, P_MATCHLEN), P_LEXELEN), 2)))

  local __prog15 = function()
    
    if EQUALQ(BEG, END) then 
      	__tmp = PUT(DEST, GET(P_CCTBL, CC_DEPTR), REST(P_OCLAUSE, ADD(MULL(GET(P_OCLAUSE, P_MATCHLEN), P_LEXELEN), 2)))
      return true
    elseif T then 
      
      if PASS(INSRT and EQUALQ(P_ANAM, GET(BEG, 0))) then 
        	__tmp = CLAUSE_ADD(INSRT)
      end

      	__tmp = CLAUSE_ADD(GET(BEG, 0))
    end

    APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)

error(123) end
local __ok15, __res15
repeat __ok15, __res15 = pcall(__prog15)
until __ok15 or __res15 ~= 123
if not __ok15 then error(__res15)
else __tmp = __res15 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CLAUSE_COPY\n'..__res) end
end
CLAUSE_ADD = function(...)
	local WRD = ...
	local PTR
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() PTR = ADD(GET(P_OCLAUSE, P_MATCHLEN), 2) return PTR end)
	__tmp =   PUT(P_OCLAUSE, SUB(PTR, 1), WRD)
	__tmp =   PUT(P_OCLAUSE, PTR, 0)
	__tmp =   PUT(P_OCLAUSE, P_MATCHLEN, PTR)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('CLAUSE_ADD\n'..__res) end
end
PREP_FIND = function(...)
	local PREP = ...
  local CNT = 0
	local SIZE
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() SIZE = MULL(GET(PREPOSITIONS, 0), 2) return SIZE end)

  local __prog16 = function()
    
    if APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    elseif EQUALQ(GET(PREPOSITIONS, CNT), PREP) then 
      error(GET(PREPOSITIONS, SUB(CNT, 1)))
    end


error(123) end
local __ok16, __res16
repeat __ok16, __res16 = pcall(__prog16)
until __ok16 or __res16 ~= 123
if not __ok16 then error(__res16)
else __tmp = __res16 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('PREP_FIND\n'..__res) end
end
SYNTAX_FOUND = function(...)
	local SYN = ...
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() P_SYNTAX = SYN return P_SYNTAX end)
	__tmp = APPLY(function() PRSA = GETB(SYN, P_SACTION) return PRSA end)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SYNTAX_FOUND\n'..__res) end
end
P_GWIMBIT = 0
GWIM = function(...)
	local GBIT, LBIT, PREP = ...
	local OBJ
	local __ok, __res = pcall(function()
	local __tmp = nil

  if EQUALQ(GBIT, RMUNGBIT) then 
    error(ROOMS)
  end

	__tmp = APPLY(function() P_GWIMBIT = GBIT return P_GWIMBIT end)
	__tmp = APPLY(function() P_SLOCBITS = LBIT return P_SLOCBITS end)
	__tmp =   PUT(P_MERGE, P_MATCHLEN, 0)

  if GET_OBJECT(P_MERGE, nil) then 
    	__tmp = APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
    
    if EQUALQ(GET(P_MERGE, P_MATCHLEN), 1) then 
      	__tmp = APPLY(function() OBJ = GET(P_MERGE, 1) return OBJ end)
      	__tmp = TELL("(")
      
      if PASS(NOT(ZEROQ(PREP)) and NOT(P_END_ON_PREP)) then 
        	__tmp = PRINTB(APPLY(function() PREP = PREP_FIND(PREP) return PREP end))
        
        if EQUALQ(PREP, WQOUT) then 
          	__tmp = TELL(" of")
        end

        	__tmp = TELL(" ")
        
        if EQUALQ(OBJ, HANDS) then 
          	__tmp = TELL("your hands")
        elseif T then 
          	__tmp = TELL("the ", D, OBJ)
        end

        	__tmp = TELL(")", CR)
      else 
        	__tmp = TELL(D, OBJ, ")", CR)
      end

      	__tmp = OBJ
    end

  elseif T then 
    	__tmp = APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GWIM\n'..__res) end
end
SNARF_OBJECTS = function(...)
	local OPTR
	local IPTR
	local L
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PUT(P_BUTS, P_MATCHLEN, 0)

  if NOT(EQUALQ(APPLY(function() IPTR = GET(P_ITBL, P_NC2) return IPTR end), 0)) then 
    	__tmp = APPLY(function() P_SLOCBITS = GETB(P_SYNTAX, P_SLOC2) return P_SLOCBITS end)
    	__tmp = PASS(SNARFEM(IPTR, GET(P_ITBL, P_NC2L), P_PRSI) or 	error(false))
  end


  if NOT(EQUALQ(APPLY(function() OPTR = GET(P_ITBL, P_NC1) return OPTR end), 0)) then 
    	__tmp = APPLY(function() P_SLOCBITS = GETB(P_SYNTAX, P_SLOC1) return P_SLOCBITS end)
    	__tmp = PASS(SNARFEM(OPTR, GET(P_ITBL, P_NC1L), P_PRSO) or 	error(false))
  end


  if NOT(ZEROQ(GET(P_BUTS, P_MATCHLEN))) then 
    	__tmp = APPLY(function() L = GET(P_PRSO, P_MATCHLEN) return L end)
    
    if OPTR then 
      	__tmp = APPLY(function() P_PRSO = BUT_MERGE(P_PRSO) return P_PRSO end)
    end

    
    if PASS(IPTR and PASS(NOT(OPTR) or EQUALQ(L, GET(P_PRSO, P_MATCHLEN)))) then 
      	__tmp = APPLY(function() P_PRSI = BUT_MERGE(P_PRSI) return P_PRSI end)
    end

  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SNARF_OBJECTS\n'..__res) end
end
BUT_MERGE = function(...)
	local TBL = ...
	local LEN
	local BUTLEN
  local CNT = 1
  local MATCHES = 0
	local OBJ
	local NTBL
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() LEN = GET(TBL, P_MATCHLEN) return LEN end)
	__tmp =   PUT(P_MERGE, P_MATCHLEN, 0)

  local __prog17 = function()
    
    if APPLY(function() LEN = LEN - 1 return LEN < 0 end) then 
      return true
    elseif ZMEMQ(APPLY(function() OBJ = GET(TBL, CNT) return OBJ end), P_BUTS) then 
      	__tmp = ZMEMQ(APPLY(function() OBJ = GET(TBL, CNT) return OBJ end), P_BUTS)
    elseif T then 
      	__tmp = PUT(P_MERGE, ADD(MATCHES, 1), OBJ)
      	__tmp = APPLY(function() MATCHES = ADD(MATCHES, 1) return MATCHES end)
    end

    APPLY(function() CNT = ADD(CNT, 1) return CNT end)

error(123) end
local __ok17, __res17
repeat __ok17, __res17 = pcall(__prog17)
until __ok17 or __res17 ~= 123
if not __ok17 then error(__res17)
else __tmp = __res17 or true end

	__tmp =   PUT(P_MERGE, P_MATCHLEN, MATCHES)
	__tmp = APPLY(function() NTBL = P_MERGE return NTBL end)
	__tmp = APPLY(function() P_MERGE = TBL return P_MERGE end)
	__tmp = NTBL
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('BUT_MERGE\n'..__res) end
end
P_NAM = nil
P_ADJ = nil
P_ADVERB = nil
P_ADJN = nil
P_PRSO = ITABLE(50)
P_PRSI = ITABLE(50)
P_BUTS = ITABLE(50)
P_MERGE = ITABLE(50)
P_OCLAUSE = ITABLE(100)
P_MATCHLEN = 0
P_GETFLAGS = 0
P_ALL = 1
P_ONE = 2
P_INHIBIT = 4
P_AND = nil
SNARFEM = function(...)
	local PTR, EPTR, TBL = ...
  local BUT = nil
	local LEN
	local WV
	local WRD
	local NW
  local WAS_ALL = nil
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() P_AND = nil return P_AND end)

  if EQUALQ(P_GETFLAGS, P_ALL) then 
    	__tmp = APPLY(function() WAS_ALL = T return WAS_ALL end)
  end

	__tmp = APPLY(function() P_GETFLAGS = 0 return P_GETFLAGS end)
	__tmp =   PUT(TBL, P_MATCHLEN, 0)
	__tmp = APPLY(function() WRD = GET(PTR, 0) return WRD end)

  local __prog18 = function()
    
    if EQUALQ(PTR, EPTR) then 
      	__tmp = APPLY(function() WV = GET_OBJECT(PASS(BUT or TBL)) return WV end)
      
      if WAS_ALL then 
        	__tmp = APPLY(function() P_GETFLAGS = P_ALL return P_GETFLAGS end)
      end

      error(WV)
    elseif T then 
      
      if EQUALQ(EPTR, REST(PTR, P_WORDLEN)) then 
        	__tmp = APPLY(function() NW = 0 return NW end)
      elseif T then 
        	__tmp = APPLY(function() NW = GET(PTR, P_LEXELEN) return NW end)
      end

      
      if EQUALQ(WRD, WQALL) then 
        	__tmp = APPLY(function() P_GETFLAGS = P_ALL return P_GETFLAGS end)
        
        if EQUALQ(NW, WQOF) then 
          	__tmp = APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
        end

      elseif EQUALQ(WRD, WQBUT, WQEXCEPT) then 
        	__tmp = PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
        	__tmp = APPLY(function() BUT = P_BUTS return BUT end)
        	__tmp = PUT(BUT, P_MATCHLEN, 0)
      elseif EQUALQ(WRD, WQA, WQONE) then 
        
        if NOT(P_ADJ) then 
          	__tmp = APPLY(function() P_GETFLAGS = P_ONE return P_GETFLAGS end)
          
          if EQUALQ(NW, WQOF) then 
            	__tmp = APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
          end

        elseif T then 
          	__tmp = APPLY(function() P_NAM = P_ONEOBJ return P_NAM end)
          	__tmp = PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
          	__tmp = PASS(ZEROQ(NW) and 	error(true))
        end

      elseif PASS(EQUALQ(WRD, WQAND, WQCOMMA) and NOT(EQUALQ(NW, WQAND, WQCOMMA))) then 
        	__tmp = APPLY(function() P_AND = T return P_AND end)
        	__tmp = PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
        	__tmp = T
      elseif WTQ(WRD, PSQBUZZ_WORD) then 
        	__tmp = WTQ(WRD, PSQBUZZ_WORD)
      elseif EQUALQ(WRD, WQAND, WQCOMMA) then 
        	__tmp = EQUALQ(WRD, WQAND, WQCOMMA)
      elseif EQUALQ(WRD, WQOF) then 
        
        if ZEROQ(P_GETFLAGS) then 
          	__tmp = APPLY(function() P_GETFLAGS = P_INHIBIT return P_GETFLAGS end)
        end

      elseif PASS(APPLY(function() WV = WTQ(WRD, PSQADJECTIVE, P1QADJECTIVE) return WV end) and NOT(P_ADJ)) then 
        	__tmp = APPLY(function() P_ADJ = WV return P_ADJ end)
        	__tmp = APPLY(function() P_ADJN = WRD return P_ADJN end)
      elseif WTQ(WRD, PSQOBJECT, P1QOBJECT) then 
        	__tmp = APPLY(function() P_NAM = WRD return P_NAM end)
        	__tmp = APPLY(function() P_ONEOBJ = WRD return P_ONEOBJ end)
      end

    end

    
    if NOT(EQUALQ(PTR, EPTR)) then 
      	__tmp = APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
      	__tmp = APPLY(function() WRD = NW return WRD end)
    end


error(123) end
local __ok18, __res18
repeat __ok18, __res18 = pcall(__prog18)
until __ok18 or __res18 ~= 123
if not __ok18 then error(__res18)
else __tmp = __res18 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SNARFEM\n'..__res) end
end
SH = 128
SC = 64
SIR = 32
SOG = 16
STAKE = 8
SMANY = 4
SHAVE = 2
GET_OBJECT = function(...)
	local TBL, VRB = ...
	local BITS
	local LEN
	local XBITS
	local TLEN
  local GCHECK = nil
  local OLEN = 0
	local OBJ
	if select('#', ...) < 2 then VRB = T end
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() XBITS = P_SLOCBITS return XBITS end)
	__tmp = APPLY(function() TLEN = GET(TBL, P_MATCHLEN) return TLEN end)

  if BTST(P_GETFLAGS, P_INHIBIT) then 
    	error(true)
  end


  if PASS(NOT(P_NAM) and P_ADJ) then 
    
    if WTQ(P_ADJN, PSQOBJECT, P1QOBJECT) then 
      	__tmp = APPLY(function() P_NAM = P_ADJN return P_NAM end)
      	__tmp = APPLY(function() P_ADJ = nil return P_ADJ end)
    elseif NULL_F() then 
      	__tmp = T
    end

  end


  if PASS(NOT(P_NAM) and NOT(P_ADJ) and NOT(EQUALQ(P_GETFLAGS, P_ALL)) and ZEROQ(P_GWIMBIT)) then 
    
    if VRB then 
      	__tmp = TELL("There seems to be a noun missing in that sentence!", CR)
    end

    	error(false)
  end


  if PASS(NOT(EQUALQ(P_GETFLAGS, P_ALL)) or ZEROQ(P_SLOCBITS)) then 
    	__tmp = APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
  end

	__tmp = APPLY(function() P_TABLE = TBL return P_TABLE end)

  local __prog19 = function()
    
    if GCHECK then 
      	__tmp = GLOBAL_CHECK(TBL)
    elseif T then 
      
      if LIT then 
        	__tmp = FCLEAR(PLAYER, TRANSBIT)
        	__tmp = DO_SL(HERE, SOG, SIR)
        	__tmp = FSET(PLAYER, TRANSBIT)
      end

      	__tmp = DO_SL(PLAYER, SH, SC)
    end
    APPLY(function() LEN = SUB(GET(TBL, P_MATCHLEN), TLEN) return LEN end)    
    if BTST(P_GETFLAGS, P_ALL) then 
      	__tmp = BTST(P_GETFLAGS, P_ALL)
    elseif PASS(BTST(P_GETFLAGS, P_ONE) and NOT(ZEROQ(LEN))) then 
      
      if NOT(EQUALQ(LEN, 1)) then 
        	__tmp = PUT(TBL, 1, GET(TBL, RANDOM(LEN)))
        	__tmp = TELL("(How about the ")
        	__tmp = PRINTD(GET(TBL, 1))
        	__tmp = TELL("?)", CR)
      end

      	__tmp = PUT(TBL, P_MATCHLEN, 1)
    elseif PASS(GQ(LEN, 1) or PASS(ZEROQ(LEN) and NOT(EQUALQ(P_SLOCBITS, -1)))) then 
      
      if EQUALQ(P_SLOCBITS, -1) then 
        	__tmp = APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)
        	__tmp = APPLY(function() OLEN = LEN return OLEN end)
        	__tmp = PUT(TBL, P_MATCHLEN, SUB(GET(TBL, P_MATCHLEN), LEN))
        	error(123)
      elseif T then 
        
        if ZEROQ(LEN) then 
          	__tmp = APPLY(function() LEN = OLEN return LEN end)
        end

        
        if NOT(EQUALQ(WINNER, PLAYER)) then 
          	__tmp = CANT_ORPHAN()
          	error(false)
        elseif PASS(VRB and P_NAM) then 
          	__tmp = WHICH_PRINT(TLEN, LEN, TBL)
          	__tmp = APPLY(function() P_ACLAUSE = APPLY(function()
            if EQUALQ(TBL, P_PRSO) then 
              	__tmp = P_NC1
            elseif T then 
              	__tmp = P_NC2
            end
 return __tmp end) return P_ACLAUSE end)
          	__tmp = APPLY(function() P_AADJ = P_ADJ return P_AADJ end)
          	__tmp = APPLY(function() P_ANAM = P_NAM return P_ANAM end)
          	__tmp = ORPHAN(nil, nil)
          	__tmp = APPLY(function() P_OFLAG = T return P_OFLAG end)
        elseif VRB then 
          	__tmp = TELL("There seems to be a noun missing in that sentence!", CR)
        end

        	__tmp = APPLY(function() P_NAM = nil return P_NAM end)
        	__tmp = APPLY(function() P_ADJ = nil return P_ADJ end)
        	error(false)
      end

    end
    
    if PASS(ZEROQ(LEN) and GCHECK) then 
      
      if VRB then 
        	__tmp = APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)
        
        if PASS(LIT or VERBQ(TELL)) then 
          	__tmp = OBJ_FOUND(NOT_HERE_OBJECT, TBL)
          	__tmp = APPLY(function() P_XNAM = P_NAM return P_XNAM end)
          	__tmp = APPLY(function() P_XADJ = P_ADJ return P_XADJ end)
          	__tmp = APPLY(function() P_XADJN = P_ADJN return P_XADJN end)
          	__tmp = APPLY(function() P_NAM = nil return P_NAM end)
          	__tmp = APPLY(function() P_ADJ = nil return P_ADJ end)
          	__tmp = APPLY(function() P_ADJN = nil return P_ADJN end)
          	error(true)
        elseif T then 
          	__tmp = TELL("It's too dark to see!", CR)
        end

      end

      	__tmp = APPLY(function() P_NAM = nil return P_NAM end)
      	__tmp = APPLY(function() P_ADJ = nil return P_ADJ end)
      	error(false)
    elseif ZEROQ(LEN) then 
      	__tmp = APPLY(function() GCHECK = T return GCHECK end)
      	error(123)
    end
    APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)    APPLY(function() P_NAM = nil return P_NAM end)    APPLY(function() P_ADJ = nil return P_ADJ end)    	error(true)end
local __ok19, __res19
repeat __ok19, __res19 = pcall(__prog19)
until __ok19 or __res19 ~= 123
if not __ok19 then error(__res19)
else __tmp = __res19 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GET_OBJECT\n'..__res) end
end
P_XNAM = nil
P_XADJ = nil
P_XADJN = nil
WHICH_PRINT = function(...)
	local TLEN, LEN, TBL = ...
	local OBJ
	local RLEN
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() RLEN = LEN return RLEN end)
	__tmp =   TELL("Which ")

  if PASS(P_OFLAG or P_MERGED or P_AND) then 
    	__tmp = PRINTB(APPLY(function()
      if P_NAM then 
        	__tmp = P_NAM
      elseif P_ADJ then 
        	__tmp = P_ADJN
      else 
        	__tmp = WQONE
      end
 end))
  else 
    	__tmp = THING_PRINT(EQUALQ(TBL, P_PRSO))
  end

	__tmp =   TELL(" do you mean, ")

  local __prog20 = function()
    APPLY(function() TLEN = ADD(TLEN, 1) return TLEN end)
    APPLY(function() OBJ = GET(TBL, TLEN) return OBJ end)
    TELL("the ", D, OBJ)
    
    if EQUALQ(LEN, 2) then 
      
      if NOT(EQUALQ(RLEN, 2)) then 
        	__tmp = TELL(",")
      end

      	__tmp = TELL(" or ")
    elseif GQ(LEN, 2) then 
      	__tmp = TELL(", ")
    end

    
    if LQ(APPLY(function() LEN = SUB(LEN, 1) return LEN end), 1) then 
      	__tmp = TELL("?", CR)
      return true
    end


error(123) end
local __ok20, __res20
repeat __ok20, __res20 = pcall(__prog20)
until __ok20 or __res20 ~= 123
if not __ok20 then error(__res20)
else __tmp = __res20 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('WHICH_PRINT\n'..__res) end
end
GLOBAL_CHECK = function(...)
	local TBL = ...
	local LEN
	local RMG
	local RMGL
  local CNT = 0
	local OBJ
	local OBITS
	local FOO
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() LEN = GET(TBL, P_MATCHLEN) return LEN end)
	__tmp = APPLY(function() OBITS = P_SLOCBITS return OBITS end)

  if APPLY(function() RMG = GETPT(HERE, PQGLOBAL) return RMG end) then 
    	__tmp = APPLY(function() RMGL = SUB(PTSIZE(RMG), 1) return RMGL end)
    
    local __prog21 = function()
      
      if THIS_ITQ(APPLY(function() OBJ = GETB(RMG, CNT) return OBJ end), TBL) then 
        	__tmp = OBJ_FOUND(OBJ, TBL)
      end

      
      if APPLY(function() CNT = CNT + 1 return CNT > RMGL end) then 
        return true
      end


error(123) end
local __ok21, __res21
repeat __ok21, __res21 = pcall(__prog21)
until __ok21 or __res21 ~= 123
if not __ok21 then error(__res21)
else __tmp = __res21 or true end

  end


  if APPLY(function() RMG = GETPT(HERE, PQPSEUDO) return RMG end) then 
    	__tmp = APPLY(function() RMGL = SUB(DIV(PTSIZE(RMG), 4), 1) return RMGL end)
    	__tmp = APPLY(function() CNT = 0 return CNT end)
    
    local __prog22 = function()
      
      if EQUALQ(P_NAM, GET(RMG, MULL(CNT, 2))) then 
        	__tmp = PUTP(PSEUDO_OBJECT, PQACTION, GET(RMG, ADD(MULL(CNT, 2), 1)))
        	__tmp = APPLY(function() FOO = BACK(GETPT(PSEUDO_OBJECT, PQACTION), 5) return FOO end)
        	__tmp = PUT(FOO, 0, GET(P_NAM, 0))
        	__tmp = PUT(FOO, 1, GET(P_NAM, 1))
        	__tmp = OBJ_FOUND(PSEUDO_OBJECT, TBL)
        return true
      elseif APPLY(function() CNT = CNT + 1 return CNT > RMGL end) then 
        return true
      end


error(123) end
local __ok22, __res22
repeat __ok22, __res22 = pcall(__prog22)
until __ok22 or __res22 ~= 123
if not __ok22 then error(__res22)
else __tmp = __res22 or true end

  end


  if EQUALQ(GET(TBL, P_MATCHLEN), LEN) then 
    	__tmp = APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
    	__tmp = APPLY(function() P_TABLE = TBL return P_TABLE end)
    	__tmp = DO_SL(GLOBAL_OBJECTS, 1, 1)
    	__tmp = APPLY(function() P_SLOCBITS = OBITS return P_SLOCBITS end)
    
    if PASS(ZEROQ(GET(TBL, P_MATCHLEN)) and EQUALQ(PRSA, VQLOOK_INSIDE, VQSEARCH, VQEXAMINE)) then 
      	__tmp = DO_SL(ROOMS, 1, 1)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('GLOBAL_CHECK\n'..__res) end
end
DO_SL = function(...)
	local OBJ, BIT1, BIT2 = ...
	local BTS
	local __ok, __res = pcall(function()
	local __tmp = nil

  if BTST(P_SLOCBITS, ADD(BIT1, BIT2)) then 
    	__tmp = SEARCH_LIST(OBJ, P_TABLE, P_SRCALL)
  elseif T then 
    
    if BTST(P_SLOCBITS, BIT1) then 
      	__tmp = SEARCH_LIST(OBJ, P_TABLE, P_SRCTOP)
    elseif BTST(P_SLOCBITS, BIT2) then 
      	__tmp = SEARCH_LIST(OBJ, P_TABLE, P_SRCBOT)
    elseif T then 
      	error(true)
    end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('DO_SL\n'..__res) end
end
P_SRCBOT = 2
P_SRCTOP = 0
P_SRCALL = 1
SEARCH_LIST = function(...)
	local OBJ, TBL, LVL = ...
	local FLS
	local NOBJ
	local __ok, __res = pcall(function()
	local __tmp = nil

  if APPLY(function() OBJ = FIRSTQ(OBJ) return OBJ end) then 
    
    local __prog23 = function()
      
      if PASS(NOT(EQUALQ(LVL, P_SRCBOT)) and GETPT(OBJ, PQSYNONYM) and THIS_ITQ(OBJ, TBL)) then 
        	__tmp = OBJ_FOUND(OBJ, TBL)
      end

      
      if PASS(PASS(NOT(EQUALQ(LVL, P_SRCTOP)) or FSETQ(OBJ, SEARCHBIT) or FSETQ(OBJ, SURFACEBIT)) and APPLY(function() NOBJ = FIRSTQ(OBJ) return NOBJ end) and PASS(FSETQ(OBJ, OPENBIT) or FSETQ(OBJ, TRANSBIT))) then 
        	__tmp = APPLY(function() FLS = SEARCH_LIST(OBJ, TBL, APPLY(function()
            if FSETQ(OBJ, SURFACEBIT) then 
              	__tmp = P_SRCALL
            elseif FSETQ(OBJ, SEARCHBIT) then 
              	__tmp = P_SRCALL
            elseif T then 
              	__tmp = P_SRCTOP
            end
 end)) return FLS end)
      end

      
      if APPLY(function() OBJ = NEXTQ(OBJ) return OBJ end) then 
        	__tmp = APPLY(function() OBJ = NEXTQ(OBJ) return OBJ end)
      elseif T then 
        return true
      end


error(123) end
local __ok23, __res23
repeat __ok23, __res23 = pcall(__prog23)
until __ok23 or __res23 ~= 123
if not __ok23 then error(__res23)
else __tmp = __res23 or true end

  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('SEARCH_LIST\n'..__res) end
end
OBJ_FOUND = function(...)
	local OBJ, TBL = ...
	local PTR
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp = APPLY(function() PTR = GET(TBL, P_MATCHLEN) return PTR end)
	__tmp =   PUT(TBL, ADD(PTR, 1), OBJ)
	__tmp =   PUT(TBL, P_MATCHLEN, ADD(PTR, 1))
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('OBJ_FOUND\n'..__res) end
end
TAKE_CHECK = function(...)
	local __ok, __res = pcall(function()
	local __tmp = nil
	__tmp =   PASS(ITAKE_CHECK(P_PRSO, GETB(P_SYNTAX, P_SLOC1)) and ITAKE_CHECK(P_PRSI, GETB(P_SYNTAX, P_SLOC2)))
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('TAKE_CHECK\n'..__res) end
end
ITAKE_CHECK = function(...)
	local TBL, IBITS = ...
	local PTR
	local OBJ
	local TAKEN
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(APPLY(function() PTR = GET(TBL, P_MATCHLEN) return PTR end) and PASS(BTST(IBITS, SHAVE) or BTST(IBITS, STAKE))) then 
    
    local __prog24 = function()
      
      if LQ(APPLY(function() PTR = SUB(PTR, 1) return PTR end), 0) then 
        return true
      elseif T then 
        	__tmp = APPLY(function() OBJ = GET(TBL, ADD(PTR, 1)) return OBJ end)
        
        if EQUALQ(OBJ, IT) then 
          
          if NOT(ACCESSIBLEQ(P_IT_OBJECT)) then 
            	__tmp = TELL("I don't see what you're referring to.", CR)
            	error(false)
          elseif T then 
            	__tmp = APPLY(function() OBJ = P_IT_OBJECT return OBJ end)
          end

        end

        
        if PASS(NOT(HELDQ(OBJ)) and NOT(EQUALQ(OBJ, HANDS, ME))) then 
          	__tmp = APPLY(function() PRSO = OBJ return PRSO end)
          
          if FSETQ(OBJ, TRYTAKEBIT) then 
            	__tmp = APPLY(function() TAKEN = T return TAKEN end)
          elseif NOT(EQUALQ(WINNER, ADVENTURER)) then 
            	__tmp = APPLY(function() TAKEN = nil return TAKEN end)
          elseif PASS(BTST(IBITS, STAKE) and EQUALQ(ITAKE(nil), T)) then 
            	__tmp = APPLY(function() TAKEN = nil return TAKEN end)
          elseif T then 
            	__tmp = APPLY(function() TAKEN = T return TAKEN end)
          end

          
          if PASS(TAKEN and BTST(IBITS, SHAVE) and EQUALQ(WINNER, ADVENTURER)) then 
            
            if EQUALQ(OBJ, NOT_HERE_OBJECT) then 
              	__tmp = TELL("You don't have that!", CR)
              	error(false)
            end

            	__tmp = TELL("SHAVE: ", BTST(IBITS, SHAVE), CR)
            	__tmp = TELL("You don't have the ")
            	__tmp = PRINTD(OBJ)
            	__tmp = TELL(".", CR)
            	error(false)
          elseif PASS(NOT(TAKEN) and EQUALQ(WINNER, ADVENTURER)) then 
            	__tmp = TELL("(Taken)", CR)
          end

        end

      end


error(123) end
local __ok24, __res24
repeat __ok24, __res24 = pcall(__prog24)
until __ok24 or __res24 ~= 123
if not __ok24 then error(__res24)
else __tmp = __res24 or true end

  elseif T then 
    	__tmp = T
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ITAKE_CHECK\n'..__res) end
end
MANY_CHECK = function(...)
  local LOSS = nil
	local TMP
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(GQ(GET(P_PRSO, P_MATCHLEN), 1) and NOT(BTST(GETB(P_SYNTAX, P_SLOC1), SMANY))) then 
    	__tmp = APPLY(function() LOSS = 1 return LOSS end)
  elseif PASS(GQ(GET(P_PRSI, P_MATCHLEN), 1) and NOT(BTST(GETB(P_SYNTAX, P_SLOC2), SMANY))) then 
    	__tmp = APPLY(function() LOSS = 2 return LOSS end)
  end


  if LOSS then 
    	__tmp = TELL("You can't use multiple ")
    
    if EQUALQ(LOSS, 2) then 
      	__tmp = TELL("in")
    end

    	__tmp = TELL("direct objects with \"")
    	__tmp = APPLY(function() TMP = GET(P_ITBL, P_VERBN) return TMP end)
    
    if ZEROQ(TMP) then 
      	__tmp = TELL("tell")
    elseif PASS(P_OFLAG or P_MERGED) then 
      	__tmp = PRINTB(GET(TMP, 0))
    elseif T then 
      	__tmp = WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
    end

    	__tmp = TELL("\".", CR)
    	error(false)
  elseif T then 
    	__tmp = T
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('MANY_CHECK\n'..__res) end
end
ZMEMQ = function(...)
	local ITM, TBL, SIZE = ...
  local CNT = 1
	if select('#', ...) < 3 then SIZE = -1 end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if NOT(TBL) then 
    	error(false)
  end


  if NOT(LQ(SIZE, 0)) then 
    	__tmp = APPLY(function() CNT = 0 return CNT end)
  else 
    	__tmp = APPLY(function() SIZE = GET(TBL, 0) return SIZE end)
  end


  local __prog25 = function()
    
    if EQUALQ(ITM, GET(TBL, CNT)) then 
      error(REST(TBL, MULL(CNT, 2)))
    elseif APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    end


error(123) end
local __ok25, __res25
repeat __ok25, __res25 = pcall(__prog25)
until __ok25 or __res25 ~= 123
if not __ok25 then error(__res25)
else __tmp = __res25 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ZMEMQ\n'..__res) end
end
ZMEMQB = function(...)
	local ITM, TBL, SIZE = ...
  local CNT = 0
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog26 = function()
    
    if EQUALQ(ITM, GETB(TBL, CNT)) then 
      	error(true)
    elseif APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    end


error(123) end
local __ok26, __res26
repeat __ok26, __res26 = pcall(__prog26)
until __ok26 or __res26 ~= 123
if not __ok26 then error(__res26)
else __tmp = __res26 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ZMEMQB\n'..__res) end
end
ALWAYS_LIT = nil
LITQ = function(...)
	local RM, RMBIT = ...
	local OHERE
  local LIT = nil
	if select('#', ...) < 2 then RMBIT = T end
	local __ok, __res = pcall(function()
	local __tmp = nil

  if PASS(ALWAYS_LIT and EQUALQ(WINNER, PLAYER)) then 
    	error(true)
  end

	__tmp = APPLY(function() P_GWIMBIT = ONBIT return P_GWIMBIT end)
	__tmp = APPLY(function() OHERE = HERE return OHERE end)
	__tmp = APPLY(function() HERE = RM return HERE end)

  if PASS(RMBIT and FSETQ(RM, ONBIT)) then 
    	__tmp = APPLY(function() LIT = T return LIT end)
  elseif T then 
    	__tmp = PUT(P_MERGE, P_MATCHLEN, 0)
    	__tmp = APPLY(function() P_TABLE = P_MERGE return P_TABLE end)
    	__tmp = APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
    
    if EQUALQ(OHERE, RM) then 
      	__tmp = DO_SL(WINNER, 1, 1)
      
      if PASS(NOT(EQUALQ(WINNER, PLAYER)) and INQ(PLAYER, RM)) then 
        	__tmp = DO_SL(PLAYER, 1, 1)
      end

    end

    	__tmp = DO_SL(RM, 1, 1)
    
    if GQ(GET(P_TABLE, P_MATCHLEN), 0) then 
      	__tmp = APPLY(function() LIT = T return LIT end)
    end

  end

	__tmp = APPLY(function() HERE = OHERE return HERE end)
	__tmp = APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
	__tmp = LIT
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('LITQ\n'..__res) end
end
THIS_ITQ = function(...)
	local OBJ, TBL = ...
	local SYNS
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(OBJ, INVISIBLE) then 
    	error(false)
  elseif PASS(P_NAM and NOT(ZMEMQ(P_NAM, APPLY(function() SYNS = GETPT(OBJ, PQSYNONYM) return SYNS end), SUB(DIV(PTSIZE(SYNS), 2), 1)))) then 
    	error(false)
  elseif PASS(P_ADJ and PASS(NOT(APPLY(function() SYNS = GETPT(OBJ, PQADJECTIVE) return SYNS end)) or NOT(ZMEMQB(P_ADJ, SYNS, SUB(PTSIZE(SYNS), 1))))) then 
    	error(false)
  elseif PASS(NOT(ZEROQ(P_GWIMBIT)) and NOT(FSETQ(OBJ, P_GWIMBIT))) then 
    	error(false)
  end

	error(true)
	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('THIS_ITQ\n'..__res) end
end
ACCESSIBLEQ = function(...)
	local OBJ = ...
  local L = LOC(OBJ)
	local __ok, __res = pcall(function()
	local __tmp = nil

  if FSETQ(OBJ, INVISIBLE) then 
    	error(false)
  elseif NOT(L) then 
    	error(false)
  elseif EQUALQ(L, GLOBAL_OBJECTS) then 
    	error(true)
  elseif PASS(EQUALQ(L, LOCAL_GLOBALS) and GLOBAL_INQ(OBJ, HERE)) then 
    	error(true)
  elseif NOT(EQUALQ(META_LOC(OBJ), HERE, LOC(WINNER))) then 
    	error(false)
  elseif EQUALQ(L, WINNER, HERE, LOC(WINNER)) then 
    	error(true)
  elseif PASS(FSETQ(L, OPENBIT) and ACCESSIBLEQ(L)) then 
    	error(true)
  elseif T then 
    	error(false)
  end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('ACCESSIBLEQ\n'..__res) end
end
META_LOC = function(...)
	local OBJ = ...
	local __ok, __res = pcall(function()
	local __tmp = nil

  local __prog27 = function()
    
    if NOT(OBJ) then 
      	error(false)
    elseif INQ(OBJ, GLOBAL_OBJECTS) then 
      error(GLOBAL_OBJECTS)
    end

    
    if INQ(OBJ, ROOMS) then 
      error(OBJ)
    elseif T then 
      	__tmp = APPLY(function() OBJ = LOC(OBJ) return OBJ end)
    end


error(123) end
local __ok27, __res27
repeat __ok27, __res27 = pcall(__prog27)
until __ok27 or __res27 ~= 123
if not __ok27 then error(__res27)
else __tmp = __res27 or true end

	 return __tmp end)
	if __ok or (type(__res) ~= 'string' and type(__res) ~= 'nil') then
return __res
	else error('META_LOC\n'..__res) end
end
