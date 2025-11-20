
APPLY(function() SIBREAKS = ".,\"" return SIBREAKS end)PRSA = nil
PRSI = nil
PRSO = nil
P_TABLE = 0
P_ONEOBJ = 0
P_SYNTAX = 0
P_CCTBL = LTABLE(0,0,0,0)
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
OOPS_TABLE = LTABLE(nil,nil,nil,nil)
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
P_ITBL = LTABLE(0,0,0,0,0,0,0,0,0,0)
P_OTBL = LTABLE(0,0,0,0,0,0,0,0,0,0)
P_VTBL = LTABLE(0,0,0,0)
P_OVTBL = LTABLE(0)
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
PARSER = function()
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

  APPLY(function() while true do
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), P_ITBLLEN) then 
      return 
    elseif T then 
      
      if NOT(P_OFLAG) then 
        PUT(P_OTBL, CNT, GET(P_ITBL, CNT))
      end

      PUT(P_ITBL, CNT, 0)
    end


  end end)

APPLY(function() OWINNER = WINNER return OWINNER end)
APPLY(function() OMERGED = P_MERGED return OMERGED end)
APPLY(function() P_ADVERB = nil return P_ADVERB end)
APPLY(function() P_MERGED = nil return P_MERGED end)
APPLY(function() P_END_ON_PREP = nil return P_END_ON_PREP end)
  PUT(P_PRSO, P_MATCHLEN, 0)
  PUT(P_PRSI, P_MATCHLEN, 0)
  PUT(P_BUTS, P_MATCHLEN, 0)

  if PASS(NOT(QUOTE_FLAG) and NEQUALQ(WINNER, PLAYER)) then 
    APPLY(function() WINNER = PLAYER return WINNER end)
    APPLY(function() HERE = META_LOC(PLAYER) return HERE end)
    APPLY(function() LIT = LITQ(HERE) return LIT end)
  end


  if RESERVE_PTR then 
    APPLY(function() PTR = RESERVE_PTR return PTR end)
    STUFF(RESERVE_LEXV, P_LEXV)
    
    if PASS(NOT(SUPER_BRIEF) and EQUALQ(PLAYER, WINNER)) then 
      CRLF()
    end

    APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    APPLY(function() P_CONT = nil return P_CONT end)
  elseif P_CONT then 
    APPLY(function() PTR = P_CONT return PTR end)
    
    if PASS(NOT(SUPER_BRIEF) and EQUALQ(PLAYER, WINNER) and NOT(VERBQ(SAY))) then 
      CRLF()
    end

    APPLY(function() P_CONT = nil return P_CONT end)
  elseif T then 
    APPLY(function() WINNER = PLAYER return WINNER end)
    APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
    
    if NOT(FSETQ(LOC(WINNER), VEHBIT)) then 
      APPLY(function() HERE = LOC(WINNER) return HERE end)
    end

    APPLY(function() LIT = LITQ(HERE) return LIT end)
    
    if NOT(SUPER_BRIEF) then 
      CRLF()
    end

    TELL(">")
    READ(P_INBUF, P_LEXV)
  end

APPLY(function() P_LEN = GETB(P_LEXV, P_LEXWORDS) return P_LEN end)

  if ZEROQ(P_LEN) then 
    TELL("I beg your pardon?", CR)
    	error(false)
  end


  if EQUALQ(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end), WQOOPS) then 
    
    if EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQPERIOD, WQCOMMA) then 
      APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
      APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end)
    end

    
    if NOT(GQ(P_LEN, 1)) then 
      TELL("I can't help your clumsiness.", CR)
      	error(false)
    elseif GET(OOPS_TABLE, O_PTR) then 
      
      if PASS(GQ(P_LEN, 2) and EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQQUOTE)) then 
        TELL("Sorry, you can't correct mistakes in quoted text.", CR)
        	error(false)
      elseif GQ(P_LEN, 2) then 
        TELL("Warning: only the first word after OOPS is used.", CR)
      end

      PUT(AGAIN_LEXV, GET(OOPS_TABLE, O_PTR), GET(P_LEXV, ADD(PTR, P_LEXELEN)))
      APPLY(function() WINNER = OWINNER return WINNER end)
      INBUF_ADD(GETB(P_LEXV, ADD(MULL(PTR, P_LEXELEN), 6)), GETB(P_LEXV, ADD(MULL(PTR, P_LEXELEN), 7)), ADD(MULL(GET(OOPS_TABLE, O_PTR), P_LEXELEN), 3))
      STUFF(AGAIN_LEXV, P_LEXV)
      APPLY(function() P_LEN = GETB(P_LEXV, P_LEXWORDS) return P_LEN end)
      APPLY(function() PTR = GET(OOPS_TABLE, O_START) return PTR end)
      INBUF_STUFF(OOPS_INBUF, P_INBUF)
    elseif T then 
      PUT(OOPS_TABLE, O_END, nil)
      TELL("There was no word to replace!", CR)
      	error(false)
    end

  elseif T then 
    
    if NOT(EQUALQ(WRD, WQAGAIN, WQG)) then 
      APPLY(function() P_NUMBER = 0 return P_NUMBER end)
    end

    PUT(OOPS_TABLE, O_END, nil)
  end


  if EQUALQ(GET(P_LEXV, PTR), WQAGAIN, WQG) then 
    
    if ZEROQ(GETB(OOPS_INBUF, 1)) then 
      TELL("Beg pardon?", CR)
      	error(false)
    elseif P_OFLAG then 
      TELL("It's difficult to repeat fragments.", CR)
      	error(false)
    elseif NOT(P_WON) then 
      TELL("That would just repeat a mistake.", CR)
      	error(false)
    elseif GQ(P_LEN, 1) then 
      
      if PASS(EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQPERIOD, WQCOMMA, WQTHEN) or EQUALQ(GET(P_LEXV, ADD(PTR, P_LEXELEN)), WQAND)) then 
        APPLY(function() PTR = ADD(PTR, MULL(2, P_LEXELEN)) return PTR end)
        PUTB(P_LEXV, P_LEXWORDS, SUB(GETB(P_LEXV, P_LEXWORDS), 2))
      elseif T then 
        TELL("I couldn't understand that sentence.", CR)
        	error(false)
      end

    elseif T then 
      APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
      PUTB(P_LEXV, P_LEXWORDS, SUB(GETB(P_LEXV, P_LEXWORDS), 1))
    end

    
    if GQ(GETB(P_LEXV, P_LEXWORDS), 0) then 
      STUFF(P_LEXV, RESERVE_LEXV)
      APPLY(function() RESERVE_PTR = PTR return RESERVE_PTR end)
    elseif T then 
      APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    end

    APPLY(function() WINNER = OWINNER return WINNER end)
    APPLY(function() P_MERGED = OMERGED return P_MERGED end)
    INBUF_STUFF(OOPS_INBUF, P_INBUF)
    STUFF(AGAIN_LEXV, P_LEXV)
    APPLY(function() CNT = -1 return CNT end)
    APPLY(function() DIR = AGAIN_DIR return DIR end)
    
    APPLY(function() while true do
      
      if APPLY(function() CNT = CNT + 1 return CNT > P_ITBLLEN end) then 
        return 
      elseif T then 
        PUT(P_ITBL, CNT, GET(P_OTBL, CNT))
      end


    end end)

  elseif T then 
    STUFF(P_LEXV, AGAIN_LEXV)
    INBUF_STUFF(P_INBUF, OOPS_INBUF)
    PUT(OOPS_TABLE, O_START, PTR)
    PUT(OOPS_TABLE, O_LENGTH, MULL(4, P_LEN))
    APPLY(function() LEN = MULL(2, ADD(PTR, MULL(P_LEXELEN, GETB(P_LEXV, P_LEXWORDS)))) return LEN end)
    PUT(OOPS_TABLE, O_END, ADD(GETB(P_LEXV, SUB(LEN, 1)), GETB(P_LEXV, SUB(LEN, 2))))
    APPLY(function() RESERVE_PTR = nil return RESERVE_PTR end)
    APPLY(function() LEN = P_LEN return LEN end)
    APPLY(function() P_DIR = nil return P_DIR end)
    APPLY(function() P_NCN = 0 return P_NCN end)
    APPLY(function() P_GETFLAGS = 0 return P_GETFLAGS end)
    
    APPLY(function() while true do
      
      if LQ(APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end), 0) then 
        APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
        return 
      elseif PASS(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end) or APPLY(function() WRD = NUMBERQ(PTR) return WRD end)) then 
        
        if ZEROQ(P_LEN) then 
          APPLY(function() NW = 0 return NW end)
        elseif T then 
          APPLY(function() NW = GET(P_LEXV, ADD(PTR, P_LEXELEN)) return NW end)
        end

        
        if PASS(EQUALQ(WRD, WQTO) and EQUALQ(VERB, ACTQTELL)) then 
          APPLY(function() WRD = WQQUOTE return WRD end)
        elseif PASS(EQUALQ(WRD, WQTHEN) and GQ(P_LEN, 0) and NOT(VERB) and NOT(QUOTE_FLAG)) then 
          
          if EQUALQ(LW, 0, WQPERIOD) then 
            APPLY(function() WRD = WQTHE return WRD end)
          else 
            PUT(P_ITBL, P_VERB, ACTQTELL)
            PUT(P_ITBL, P_VERBN, 0)
            APPLY(function() WRD = WQQUOTE return WRD end)
          end

        end

        
        if EQUALQ(WRD, WQTHEN, WQPERIOD, WQQUOTE) then 
          
          if EQUALQ(WRD, WQQUOTE) then 
            
            if QUOTE_FLAG then 
              APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
            elseif T then 
              APPLY(function() QUOTE_FLAG = T return QUOTE_FLAG end)
            end

          end

          PASS(ZEROQ(P_LEN) or APPLY(function() P_CONT = ADD(PTR, P_LEXELEN) return P_CONT end))
          PUTB(P_LEXV, P_LEXWORDS, P_LEN)
          return 
        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQDIRECTION, P1QDIRECTION) return VAL end) and EQUALQ(VERB, nil, ACTQWALK) and PASS(EQUALQ(LEN, 1) or PASS(EQUALQ(LEN, 2) and EQUALQ(VERB, ACTQWALK)) or PASS(EQUALQ(NW, WQTHEN, WQPERIOD, WQQUOTE) and NOT(LQ(LEN, 2))) or PASS(QUOTE_FLAG and EQUALQ(LEN, 2) and EQUALQ(NW, WQQUOTE)) or PASS(GQ(LEN, 2) and EQUALQ(NW, WQCOMMA, WQAND)))) then 
          APPLY(function() DIR = VAL return DIR end)
          
          if EQUALQ(NW, WQCOMMA, WQAND) then 
            PUT(P_LEXV, ADD(PTR, P_LEXELEN), WQTHEN)
          end

          
          if NOT(GQ(LEN, 2)) then 
            APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
            return 
          end

        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQVERB, P1QVERB) return VAL end) and NOT(VERB)) then 
          APPLY(function() VERB = VAL return VERB end)
          PUT(P_ITBL, P_VERB, VAL)
          PUT(P_ITBL, P_VERBN, P_VTBL)
          PUT(P_VTBL, 0, WRD)
          PUTB(P_VTBL, 2, GETB(P_LEXV, APPLY(function() CNT = ADD(MULL(PTR, 2), 2) return CNT end)))
          PUTB(P_VTBL, 3, GETB(P_LEXV, ADD(CNT, 1)))
        elseif PASS(APPLY(function() VAL = WTQ(WRD, PSQPREPOSITION, 0) return VAL end) or EQUALQ(WRD, WQALL, WQONE) or WTQ(WRD, PSQADJECTIVE) or WTQ(WRD, PSQOBJECT)) then 
          
          if PASS(GQ(P_LEN, 1) and EQUALQ(NW, WQOF) and ZEROQ(VAL) and NOT(EQUALQ(WRD, WQALL, WQONE, WQA))) then 
            APPLY(function() OF_FLAG = T return OF_FLAG end)
          elseif PASS(NOT(ZEROQ(VAL)) and PASS(ZEROQ(P_LEN) or EQUALQ(NW, WQTHEN, WQPERIOD))) then 
            APPLY(function() P_END_ON_PREP = T return P_END_ON_PREP end)
            
            if LQ(P_NCN, 2) then 
              PUT(P_ITBL, P_PREP1, VAL)
              PUT(P_ITBL, P_PREP1N, WRD)
            end

          elseif EQUALQ(P_NCN, 2) then 
            TELL("There were too many nouns in that sentence.", CR)
            	error(false)
          elseif T then 
            APPLY(function() P_NCN = ADD(P_NCN, 1) return P_NCN end)
            APPLY(function() P_ACT = VERB return P_ACT end)
            PASS(APPLY(function() PTR = CLAUSE(PTR, VAL, WRD) return PTR end) or 	error(false))
            
            if LQ(PTR, 0) then 
              APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
              return 
            end

          end

        elseif EQUALQ(WRD, WQOF) then 
          
          if PASS(NOT(OF_FLAG) or EQUALQ(NW, WQPERIOD, WQTHEN)) then 
            CANT_USE(PTR)
            	error(false)
          elseif T then 
            APPLY(function() OF_FLAG = nil return OF_FLAG end)
          end

        elseif WTQ(WRD, PSQBUZZ_WORD) then 
        elseif PASS(EQUALQ(VERB, ACTQTELL) and WTQ(WRD, PSQVERB, P1QVERB) and EQUALQ(WINNER, PLAYER)) then 
          TELL("Please consult your manual for the correct way to talk to other people\nor creatures.", CR)
          	error(false)
        elseif T then 
          CANT_USE(PTR)
          	error(false)
        end

      elseif T then 
        UNKNOWN_WORD(PTR)
        	error(false)
      end

      APPLY(function() LW = WRD return LW end)
      APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)

    end end)

  end

  PUT(OOPS_TABLE, O_PTR, nil)

  if DIR then 
    APPLY(function() PRSA = VQWALK return PRSA end)
    APPLY(function() PRSO = DIR return PRSO end)
    APPLY(function() P_OFLAG = nil return P_OFLAG end)
    APPLY(function() P_WALK_DIR = DIR return P_WALK_DIR end)
    	return APPLY(function() AGAIN_DIR = DIR return AGAIN_DIR end)
  else 
    
    if P_OFLAG then 
      ORPHAN_MERGE()
    end

    APPLY(function() P_WALK_DIR = nil return P_WALK_DIR end)
    APPLY(function() AGAIN_DIR = nil return AGAIN_DIR end)
    
    if PASS(SYNTAX_CHECK() and SNARF_OBJECTS() and MANY_CHECK() and TAKE_CHECK()) then 
      -- 	return T
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PARSER\n'..__res) end
end
P_ACT = nil
P_WALK_DIR = nil
AGAIN_DIR = nil
STUFF = function(SRC, DEST, MAX)
  local PTR = P_LEXSTART
  local CTR = 1
	local BPTR
  MAX = MAX or 29
	local __ok, __res = pcall(function()
  PUTB(DEST, 0, GETB(SRC, 0))
  PUTB(DEST, 1, GETB(SRC, 1))

  APPLY(function() while true do
    PUT(DEST, PTR, GET(SRC, PTR))
    APPLY(function() BPTR = ADD(MULL(PTR, 2), 2) return BPTR end)
    PUTB(DEST, BPTR, GETB(SRC, BPTR))
    APPLY(function() BPTR = ADD(MULL(PTR, 2), 3) return BPTR end)
    PUTB(DEST, BPTR, GETB(SRC, BPTR))
    APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
    
    if APPLY(function() CTR = CTR + 1 return CTR > MAX end) then 
      return 
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('STUFF\n'..__res) end
end
INBUF_STUFF = function(SRC, DEST)
	local CNT
	local __ok, __res = pcall(function()
APPLY(function() CNT = SUB(GETB(SRC, 0), 1) return CNT end)

  APPLY(function() while true do
    PUTB(DEST, CNT, GETB(SRC, CNT))
    
    if APPLY(function() CNT = CNT - 1 return CNT < 0 end) then 
      return 
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('INBUF_STUFF\n'..__res) end
end
INBUF_ADD = function(LEN, BEG, SLOT)
	local DBEG
  local CTR = 0
	local TMP
	local __ok, __res = pcall(function()

  if APPLY(function() TMP = GET(OOPS_TABLE, O_END) return TMP end) then 
    APPLY(function() DBEG = TMP return DBEG end)
  elseif T then 
    APPLY(function() DBEG = ADD(GETB(AGAIN_LEXV, APPLY(function() TMP = GET(OOPS_TABLE, O_LENGTH) return TMP end)), GETB(AGAIN_LEXV, ADD(TMP, 1))) return DBEG end)
  end

  PUT(OOPS_TABLE, O_END, ADD(DBEG, LEN))

  APPLY(function() while true do
    PUTB(OOPS_INBUF, ADD(DBEG, CTR), GETB(P_INBUF, ADD(BEG, CTR)))
    APPLY(function() CTR = ADD(CTR, 1) return CTR end)
    
    if EQUALQ(CTR, LEN) then 
      return 
    end


  end end)

  PUTB(AGAIN_LEXV, SLOT, DBEG)
	return   PUTB(AGAIN_LEXV, SUB(SLOT, 1), LEN)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('INBUF_ADD\n'..__res) end
end
WTQ = function(PTR, BIT, B1)
  local OFFS = P_P1OFF
	local TYP
  B1 = B1 or 5
	local __ok, __res = pcall(function()

  if BTST(APPLY(function() TYP = GETB(PTR, P_PSOFF) return TYP end), BIT) then 
    
    if GQ(B1, 4) then 
      	error(true)
    elseif T then 
      APPLY(function() TYP = BAND(TYP, P_P1BITS) return TYP end)
      
      if NOT(EQUALQ(TYP, B1)) then 
        APPLY(function() OFFS = ADD(OFFS, 1) return OFFS end)
      end

      	return GETB(PTR, OFFS)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WTQ\n'..__res) end
end
CLAUSE = function(PTR, VAL, WRD)
	local OFF
	local NUM
  local ANDFLG = nil
  local FIRSTQQ = T
	local NW
  local LW = 0
	local __ok, __res = pcall(function()
APPLY(function() OFF = MULL(SUB(P_NCN, 1), 2) return OFF end)

  if NOT(EQUALQ(VAL, 0)) then 
    PUT(P_ITBL, APPLY(function() NUM = ADD(P_PREP1, OFF) return NUM end), VAL)
    PUT(P_ITBL, ADD(NUM, 1), WRD)
    APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
  elseif T then 
    APPLY(function() P_LEN = ADD(P_LEN, 1) return P_LEN end)
  end


  if ZEROQ(P_LEN) then 
    APPLY(function() P_NCN = SUB(P_NCN, 1) return P_NCN end)
    return -1
  end

  PUT(P_ITBL, APPLY(function() NUM = ADD(P_NC1, OFF) return NUM end), REST(P_LEXV, MULL(PTR, 2)))

  if EQUALQ(GET(P_LEXV, PTR), WQTHE, WQA, WQAN) then 
    PUT(P_ITBL, NUM, REST(GET(P_ITBL, NUM), 4))
  end


  APPLY(function() while true do
    
    if LQ(APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end), 0) then 
      PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(PTR, 2)))
      return -1
    end

    
    if PASS(APPLY(function() WRD = GET(P_LEXV, PTR) return WRD end) or APPLY(function() WRD = NUMBERQ(PTR) return WRD end)) then 
      
      if ZEROQ(P_LEN) then 
        APPLY(function() NW = 0 return NW end)
      elseif T then 
        APPLY(function() NW = GET(P_LEXV, ADD(PTR, P_LEXELEN)) return NW end)
      end

      
      if EQUALQ(WRD, WQAND, WQCOMMA) then 
        APPLY(function() ANDFLG = T return ANDFLG end)
      elseif EQUALQ(WRD, WQALL, WQONE) then 
        
        if EQUALQ(NW, WQOF) then 
          APPLY(function() P_LEN = SUB(P_LEN, 1) return P_LEN end)
          APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)
        end

      elseif PASS(EQUALQ(WRD, WQTHEN, WQPERIOD) or PASS(WTQ(WRD, PSQPREPOSITION) and GET(P_ITBL, P_VERB) and NOT(FIRSTQQ))) then 
        APPLY(function() P_LEN = ADD(P_LEN, 1) return P_LEN end)
        PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(PTR, 2)))
        return SUB(PTR, P_LEXELEN)
      elseif WTQ(WRD, PSQOBJECT) then 
        
        if PASS(GQ(P_LEN, 0) and EQUALQ(NW, WQOF) and NOT(EQUALQ(WRD, WQALL, WQONE))) then 
          -- T
        elseif PASS(WTQ(WRD, PSQADJECTIVE, P1QADJECTIVE) and NOT(EQUALQ(NW, 0)) and WTQ(NW, PSQOBJECT)) then 
        elseif PASS(NOT(ANDFLG) and NOT(EQUALQ(NW, WQBUT, WQEXCEPT)) and NOT(EQUALQ(NW, WQAND, WQCOMMA))) then 
          PUT(P_ITBL, ADD(NUM, 1), REST(P_LEXV, MULL(ADD(PTR, 2), 2)))
          return PTR
        elseif T then 
          APPLY(function() ANDFLG = nil return ANDFLG end)
        end

      elseif PASS(PASS(P_MERGED or P_OFLAG or NOT(EQUALQ(GET(P_ITBL, P_VERB), 0))) and PASS(WTQ(WRD, PSQADJECTIVE) or WTQ(WRD, PSQBUZZ_WORD))) then 
      elseif PASS(ANDFLG and PASS(WTQ(WRD, PSQDIRECTION) or WTQ(WRD, PSQVERB))) then 
        APPLY(function() PTR = SUB(PTR, 4) return PTR end)
        PUT(P_LEXV, ADD(PTR, 2), WQTHEN)
        APPLY(function() P_LEN = ADD(P_LEN, 2) return P_LEN end)
      elseif WTQ(WRD, PSQPREPOSITION) then 
        -- T
      elseif T then 
        CANT_USE(PTR)
        	error(false)
      end

    elseif T then 
      UNKNOWN_WORD(PTR)
      	error(false)
    end

    APPLY(function() LW = WRD return LW end)
    APPLY(function() FIRSTQQ = nil return FIRSTQQ end)
    APPLY(function() PTR = ADD(PTR, P_LEXELEN) return PTR end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CLAUSE\n'..__res) end
end
NUMBERQ = function(PTR)
	local CNT
	local BPTR
	local CHR
  local SUM = 0
  local TIM = nil
	local __ok, __res = pcall(function()
APPLY(function() CNT = GETB(REST(P_LEXV, MULL(PTR, 2)), 2) return CNT end)
APPLY(function() BPTR = GETB(REST(P_LEXV, MULL(PTR, 2)), 3) return BPTR end)

  APPLY(function() while true do
    
    if LQ(APPLY(function() CNT = SUB(CNT, 1) return CNT end), 0) then 
      return 
    elseif T then 
      APPLY(function() CHR = GETB(P_INBUF, BPTR) return CHR end)
      
      if EQUALQ(CHR, 58) then 
        APPLY(function() TIM = SUM return TIM end)
        APPLY(function() SUM = 0 return SUM end)
      elseif GQ(SUM, 10000) then 
        	error(false)
      elseif PASS(LQ(CHR, 58) and GQ(CHR, 47)) then 
        APPLY(function() SUM = ADD(MULL(SUM, 10), SUB(CHR, 48)) return SUM end)
      elseif T then 
        	error(false)
      end

      APPLY(function() BPTR = ADD(BPTR, 1) return BPTR end)
    end


  end end)

  PUT(P_LEXV, PTR, WQINTNUM)

  if GQ(SUM, 1000) then 
    	error(false)
  elseif TIM then 
    
    if LQ(TIM, 8) then 
      APPLY(function() TIM = ADD(TIM, 12) return TIM end)
    elseif GQ(TIM, 23) then 
      	error(false)
    end

    APPLY(function() SUM = ADD(SUM, MULL(TIM, 60)) return SUM end)
  end

APPLY(function() P_NUMBER = SUM return P_NUMBER end)
	return WQINTNUM
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('NUMBERQ\n'..__res) end
end
P_NUMBER = 0
P_DIRECTION = 0
ORPHAN_MERGE = function()
  local CNT = -1
	local TEMP
	local VERB
	local BEG
	local END
  local ADJ = nil
	local WRD
	local __ok, __res = pcall(function()
APPLY(function() P_OFLAG = nil return P_OFLAG end)

  if PASS(EQUALQ(WTQ(APPLY(function() WRD = GET(GET(P_ITBL, P_VERBN), 0) return WRD end), PSQVERB, P1QVERB), GET(P_OTBL, P_VERB)) or NOT(ZEROQ(WTQ(WRD, PSQADJECTIVE)))) then 
    APPLY(function() ADJ = T return ADJ end)
  elseif PASS(NOT(ZEROQ(WTQ(WRD, PSQOBJECT, P1QOBJECT))) and EQUALQ(P_NCN, 0)) then 
    PUT(P_ITBL, P_VERB, 0)
    PUT(P_ITBL, P_VERBN, 0)
    PUT(P_ITBL, P_NC1, REST(P_LEXV, 2))
    PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
    APPLY(function() P_NCN = 1 return P_NCN end)
  end


  if PASS(NOT(ZEROQ(APPLY(function() VERB = GET(P_ITBL, P_VERB) return VERB end))) and NOT(ADJ) and NOT(EQUALQ(VERB, GET(P_OTBL, P_VERB)))) then 
    	error(false)
  elseif EQUALQ(P_NCN, 2) then 
    	error(false)
  elseif EQUALQ(GET(P_OTBL, P_NC1), 1) then 
    
    if PASS(EQUALQ(APPLY(function() TEMP = GET(P_ITBL, P_PREP1) return TEMP end), GET(P_OTBL, P_PREP1)) or ZEROQ(TEMP)) then 
      
      if ADJ then 
        PUT(P_OTBL, P_NC1, REST(P_LEXV, 2))
        
        if ZEROQ(GET(P_ITBL, P_NC1L)) then 
          PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
        end

        
        if ZEROQ(P_NCN) then 
          APPLY(function() P_NCN = 1 return P_NCN end)
        end

      elseif T then 
        PUT(P_OTBL, P_NC1, GET(P_ITBL, P_NC1))
      end

      PUT(P_OTBL, P_NC1L, GET(P_ITBL, P_NC1L))
    elseif T then 
      	error(false)
    end

  elseif EQUALQ(GET(P_OTBL, P_NC2), 1) then 
    
    if PASS(EQUALQ(APPLY(function() TEMP = GET(P_ITBL, P_PREP1) return TEMP end), GET(P_OTBL, P_PREP2)) or ZEROQ(TEMP)) then 
      
      if ADJ then 
        PUT(P_ITBL, P_NC1, REST(P_LEXV, 2))
        
        if ZEROQ(GET(P_ITBL, P_NC1L)) then 
          PUT(P_ITBL, P_NC1L, REST(P_LEXV, 6))
        end

      end

      PUT(P_OTBL, P_NC2, GET(P_ITBL, P_NC1))
      PUT(P_OTBL, P_NC2L, GET(P_ITBL, P_NC1L))
      APPLY(function() P_NCN = 2 return P_NCN end)
    elseif T then 
      	error(false)
    end

  elseif NOT(ZEROQ(P_ACLAUSE)) then 
    
    if PASS(NOT(EQUALQ(P_NCN, 1)) and NOT(ADJ)) then 
      APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
      	error(false)
    elseif T then 
      APPLY(function() BEG = GET(P_ITBL, P_NC1) return BEG end)
      
      if ADJ then 
        APPLY(function() BEG = REST(P_LEXV, 2) return BEG end)
        APPLY(function() ADJ = nil return ADJ end)
      end

      APPLY(function() END = GET(P_ITBL, P_NC1L) return END end)
      
      APPLY(function() while true do
        APPLY(function() WRD = GET(BEG, 0) return WRD end)
        
        if EQUALQ(BEG, END) then 
          
          if ADJ then 
            ACLAUSE_WIN(ADJ)
            return 
          elseif T then 
            APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
            	error(false)
          end

        elseif PASS(NOT(ADJ) and PASS(BTST(GETB(WRD, P_PSOFF), PSQADJECTIVE) or EQUALQ(WRD, WQALL, WQONE))) then 
          APPLY(function() ADJ = WRD return ADJ end)
        elseif EQUALQ(WRD, WQONE) then 
          ACLAUSE_WIN(ADJ)
          return 
        elseif BTST(GETB(WRD, P_PSOFF), PSQOBJECT) then 
          
          if EQUALQ(WRD, P_ANAM) then 
            ACLAUSE_WIN(ADJ)
          elseif T then 
            NCLAUSE_WIN()
          end

          return 
        end

        APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)
        
        if EQUALQ(END, 0) then 
          APPLY(function() END = BEG return END end)
          APPLY(function() P_NCN = 1 return P_NCN end)
          PUT(P_ITBL, P_NC1, BACK(BEG, 4))
          PUT(P_ITBL, P_NC1L, BEG)
        end


      end end)

    end

  end

  PUT(P_VTBL, 0, GET(P_OVTBL, 0))
  PUTB(P_VTBL, 2, GETB(P_OVTBL, 2))
  PUTB(P_VTBL, 3, GETB(P_OVTBL, 3))
  PUT(P_OTBL, P_VERBN, P_VTBL)
  PUTB(P_VTBL, 2, 0)

  APPLY(function() while true do
    
    if GQ(APPLY(function() CNT = ADD(CNT, 1) return CNT end), P_ITBLLEN) then 
      APPLY(function() P_MERGED = T return P_MERGED end)
      	error(true)
    elseif T then 
      PUT(P_ITBL, CNT, GET(P_OTBL, CNT))
    end


  end end)

	return T
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ORPHAN_MERGE\n'..__res) end
end
ACLAUSE_WIN = function(ADJ)
	local __ok, __res = pcall(function()
  PUT(P_ITBL, P_VERB, GET(P_OTBL, P_VERB))
  PUT(P_CCTBL, CC_SBPTR, P_ACLAUSE)
  PUT(P_CCTBL, CC_SEPTR, ADD(P_ACLAUSE, 1))
  PUT(P_CCTBL, CC_DBPTR, P_ACLAUSE)
  PUT(P_CCTBL, CC_DEPTR, ADD(P_ACLAUSE, 1))
  CLAUSE_COPY(P_OTBL, P_OTBL, ADJ)
  PASS(NOT(EQUALQ(GET(P_OTBL, P_NC2), 0)) and APPLY(function() P_NCN = 2 return P_NCN end))
APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ACLAUSE_WIN\n'..__res) end
end
NCLAUSE_WIN = function()
	local __ok, __res = pcall(function()
  PUT(P_CCTBL, CC_SBPTR, P_NC1)
  PUT(P_CCTBL, CC_SEPTR, P_NC1L)
  PUT(P_CCTBL, CC_DBPTR, P_ACLAUSE)
  PUT(P_CCTBL, CC_DEPTR, ADD(P_ACLAUSE, 1))
  CLAUSE_COPY(P_ITBL, P_OTBL)
  PASS(NOT(EQUALQ(GET(P_OTBL, P_NC2), 0)) and APPLY(function() P_NCN = 2 return P_NCN end))
APPLY(function() P_ACLAUSE = nil return P_ACLAUSE end)
	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('NCLAUSE_WIN\n'..__res) end
end
WORD_PRINT = function(CNT, BUF)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if APPLY(function() CNT = CNT - 1 return CNT < 0 end) then 
      return 
    else 
      PRINTC(GETB(P_INBUF, BUF))
      APPLY(function() BUF = ADD(BUF, 1) return BUF end)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WORD_PRINT\n'..__res) end
end
UNKNOWN_WORD = function(PTR)
	local BUF
	local __ok, __res = pcall(function()
  PUT(OOPS_TABLE, O_PTR, PTR)

  if VERBQ(SAY) then 
    TELL("Nothing happens.", CR)
    	error(false)
  end

  TELL("I don't know the word \"")
  WORD_PRINT(GETB(REST(P_LEXV, APPLY(function() BUF = MULL(PTR, 2) return BUF end)), 2), GETB(REST(P_LEXV, BUF), 3))
  TELL("\".", CR)
APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	return APPLY(function() P_OFLAG = nil return P_OFLAG end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('UNKNOWN_WORD\n'..__res) end
end
CANT_USE = function(PTR)
	local BUF
	local __ok, __res = pcall(function()

  if VERBQ(SAY) then 
    TELL("Nothing happens.", CR)
    	error(false)
  end

  TELL("You used the word \"")
  WORD_PRINT(GETB(REST(P_LEXV, APPLY(function() BUF = MULL(PTR, 2) return BUF end)), 2), GETB(REST(P_LEXV, BUF), 3))
  TELL("\" in a way that I don't understand.", CR)
APPLY(function() QUOTE_FLAG = nil return QUOTE_FLAG end)
	return APPLY(function() P_OFLAG = nil return P_OFLAG end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
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
SYNTAX_CHECK = function()
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

  if ZEROQ(APPLY(function() VERB = GET(P_ITBL, P_VERB) return VERB end)) then 
    TELL("There was no verb in that sentence!", CR)
    	error(false)
  end

  TELL("SYNTAX-CHECK ", VERBS, VERB, CR)
APPLY(function() SYN = GET(VERBS, SUB(255, VERB)) return SYN end)
APPLY(function() LEN = GETB(SYN, 0) return LEN end)
APPLY(function() SYN = REST(SYN) return SYN end)

  APPLY(function() while true do
    APPLY(function() NUM = BAND(GETB(SYN, P_SBITS), P_SONUMS) return NUM end)
    TELL(NUM, " ", GETB(SYN, P_SBITS), CR)
    
    if GQ(P_NCN, NUM) then 
      -- T
    elseif PASS(NOT(LQ(NUM, 1)) and ZEROQ(P_NCN) and PASS(ZEROQ(APPLY(function() PREP = GET(P_ITBL, P_PREP1) return PREP end)) or EQUALQ(PREP, GETB(SYN, P_SPREP1)))) then 
      APPLY(function() DRIVE1 = SYN return DRIVE1 end)
    elseif EQUALQ(GETB(SYN, P_SPREP1), GET(P_ITBL, P_PREP1)) then 
      
      if PASS(EQUALQ(NUM, 2) and EQUALQ(P_NCN, 1)) then 
        APPLY(function() DRIVE2 = SYN return DRIVE2 end)
      elseif EQUALQ(GETB(SYN, P_SPREP2), GET(P_ITBL, P_PREP2)) then 
        SYNTAX_FOUND(SYN)
        	error(true)
      end

    end

    
    if APPLY(function() LEN = LEN - 1 return LEN < 1 end) then 
      
      if PASS(DRIVE1 or DRIVE2) then 
        return 
      elseif T then 
        TELL("That sentence isn't one I recognize.", CR)
        	error(false)
      end

    elseif T then 
      APPLY(function() SYN = REST(SYN, P_SYNLEN) return SYN end)
    end


  end end)


  if PASS(DRIVE1 and APPLY(function() OBJ = GWIM(GETB(DRIVE1, P_SFWIM1), GETB(DRIVE1, P_SLOC1), GETB(DRIVE1, P_SPREP1)) return OBJ end)) then 
    PUT(P_PRSO, P_MATCHLEN, 1)
    PUT(P_PRSO, 1, OBJ)
    	return SYNTAX_FOUND(DRIVE1)
  elseif PASS(DRIVE2 and APPLY(function() OBJ = GWIM(GETB(DRIVE2, P_SFWIM2), GETB(DRIVE2, P_SLOC2), GETB(DRIVE2, P_SPREP2)) return OBJ end)) then 
    PUT(P_PRSI, P_MATCHLEN, 1)
    PUT(P_PRSI, 1, OBJ)
    	return SYNTAX_FOUND(DRIVE2)
  elseif EQUALQ(VERB, ACTQFIND) then 
    TELL("That question can't be answered.", CR)
    	error(false)
  elseif NOT(EQUALQ(WINNER, PLAYER)) then 
    	return CANT_ORPHAN()
  elseif T then 
    ORPHAN(DRIVE1, DRIVE2)
    TELL("What do you want to ")
    APPLY(function() TMP = GET(P_OTBL, P_VERBN) return TMP end)
    
    if EQUALQ(TMP, 0) then 
      TELL("tell")
    elseif ZEROQ(GETB(P_VTBL, 2)) then 
      PRINTB(GET(TMP, 0))
    elseif T then 
      WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
      PUTB(P_VTBL, 2, 0)
    end

    
    if DRIVE2 then 
      TELL(" ")
      THING_PRINT(T, T)
    end

    APPLY(function() P_OFLAG = T return P_OFLAG end)
    PREP_PRINT(APPLY(function()
      if DRIVE1 then 
        	return GETB(DRIVE1, P_SPREP1)
      elseif T then 
        	return GETB(DRIVE2, P_SPREP2)
      end
 end))
    TELL("?", CR)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SYNTAX_CHECK\n'..__res) end
end
CANT_ORPHAN = function()
	local __ok, __res = pcall(function()
  TELL("\"I don't understand! What are you referring to?\"", CR)
	error(false)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CANT_ORPHAN\n'..__res) end
end
ORPHAN = function(D1, D2)
  local CNT = -1
	local __ok, __res = pcall(function()

  if NOT(P_MERGED) then 
    PUT(P_OCLAUSE, P_MATCHLEN, 0)
  end

  PUT(P_OVTBL, 0, GET(P_VTBL, 0))
  PUTB(P_OVTBL, 2, GETB(P_VTBL, 2))
  PUTB(P_OVTBL, 3, GETB(P_VTBL, 3))

  APPLY(function() while true do
    
    if APPLY(function() CNT = CNT + 1 return CNT > P_ITBLLEN end) then 
      return 
    elseif T then 
      PUT(P_OTBL, CNT, GET(P_ITBL, CNT))
    end


  end end)


  if EQUALQ(P_NCN, 2) then 
    PUT(P_CCTBL, CC_SBPTR, P_NC2)
    PUT(P_CCTBL, CC_SEPTR, P_NC2L)
    PUT(P_CCTBL, CC_DBPTR, P_NC2)
    PUT(P_CCTBL, CC_DEPTR, P_NC2L)
    CLAUSE_COPY(P_ITBL, P_OTBL)
  end


  if NOT(LQ(P_NCN, 1)) then 
    PUT(P_CCTBL, CC_SBPTR, P_NC1)
    PUT(P_CCTBL, CC_SEPTR, P_NC1L)
    PUT(P_CCTBL, CC_DBPTR, P_NC1)
    PUT(P_CCTBL, CC_DEPTR, P_NC1L)
    CLAUSE_COPY(P_ITBL, P_OTBL)
  end


  if D1 then 
    PUT(P_OTBL, P_PREP1, GETB(D1, P_SPREP1))
    	return PUT(P_OTBL, P_NC1, 1)
  elseif D2 then 
    PUT(P_OTBL, P_PREP2, GETB(D2, P_SPREP2))
    	return PUT(P_OTBL, P_NC2, 1)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ORPHAN\n'..__res) end
end
THING_PRINT = function(PRSOQ, THEQ)
	local BEG
	local END
  THEQ = THEQ or nil
	local __ok, __res = pcall(function()

  if PRSOQ then 
    APPLY(function() BEG = GET(P_ITBL, P_NC1) return BEG end)
    APPLY(function() END = GET(P_ITBL, P_NC1L) return END end)
  else 
    APPLY(function() BEG = GET(P_ITBL, P_NC2) return BEG end)
    APPLY(function() END = GET(P_ITBL, P_NC2L) return END end)
  end

	return   BUFFER_PRINT(BEG, END, THEQ)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('THING_PRINT\n'..__res) end
end
BUFFER_PRINT = function(BEG, END, CP)
  local NOSP = T
	local WRD
  local FIRSTQQ = T
  local PN = nil
  local QQ = nil
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if EQUALQ(BEG, END) then 
      return 
    elseif T then 
      APPLY(function() WRD = GET(BEG, 0) return WRD end)
      
      if EQUALQ(WRD, WQCOMMA) then 
        TELL(", ")
      elseif NOSP then 
        APPLY(function() NOSP = nil return NOSP end)
      else 
        TELL(" ")
      end

      
      if EQUALQ(WRD, WQPERIOD, WQCOMMA) then 
        APPLY(function() NOSP = T return NOSP end)
      elseif EQUALQ(WRD, WQME) then 
        PRINTD(ME)
        APPLY(function() PN = T return PN end)
      elseif EQUALQ(WRD, WQINTNUM) then 
        PRINTN(P_NUMBER)
        APPLY(function() PN = T return PN end)
      elseif T then 
        
        if PASS(FIRSTQQ and NOT(PN) and CP) then 
          TELL("the ")
        end

        
        if PASS(P_OFLAG or P_MERGED) then 
          PRINTB(WRD)
        elseif PASS(EQUALQ(WRD, WQIT) and ACCESSIBLEQ(P_IT_OBJECT)) then 
          PRINTD(P_IT_OBJECT)
        elseif T then 
          WORD_PRINT(GETB(BEG, 2), GETB(BEG, 3))
        end

        APPLY(function() FIRSTQQ = nil return FIRSTQQ end)
      end

    end

    APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('BUFFER_PRINT\n'..__res) end
end
PREP_PRINT = function(PREP)
	local WRD
	local __ok, __res = pcall(function()

  if NOT(ZEROQ(PREP)) then 
    TELL(" ")
    
    if T then 
      APPLY(function() WRD = PREP_FIND(PREP) return WRD end)
      	return PRINTB(WRD)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PREP_PRINT\n'..__res) end
end
CLAUSE_COPY = function(SRC, DEST, INSRT)
	local BEG
	local END
  INSRT = INSRT or nil
	local __ok, __res = pcall(function()
APPLY(function() BEG = GET(SRC, GET(P_CCTBL, CC_SBPTR)) return BEG end)
APPLY(function() END = GET(SRC, GET(P_CCTBL, CC_SEPTR)) return END end)
  PUT(DEST, GET(P_CCTBL, CC_DBPTR), REST(P_OCLAUSE, ADD(MULL(GET(P_OCLAUSE, P_MATCHLEN), P_LEXELEN), 2)))

  APPLY(function() while true do
    
    if EQUALQ(BEG, END) then 
      PUT(DEST, GET(P_CCTBL, CC_DEPTR), REST(P_OCLAUSE, ADD(MULL(GET(P_OCLAUSE, P_MATCHLEN), P_LEXELEN), 2)))
      return 
    elseif T then 
      
      if PASS(INSRT and EQUALQ(P_ANAM, GET(BEG, 0))) then 
        CLAUSE_ADD(INSRT)
      end

      CLAUSE_ADD(GET(BEG, 0))
    end

    APPLY(function() BEG = REST(BEG, P_WORDLEN) return BEG end)

  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CLAUSE_COPY\n'..__res) end
end
CLAUSE_ADD = function(WRD)
	local PTR
	local __ok, __res = pcall(function()
APPLY(function() PTR = ADD(GET(P_OCLAUSE, P_MATCHLEN), 2) return PTR end)
  PUT(P_OCLAUSE, SUB(PTR, 1), WRD)
  PUT(P_OCLAUSE, PTR, 0)
	return   PUT(P_OCLAUSE, P_MATCHLEN, PTR)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('CLAUSE_ADD\n'..__res) end
end
PREP_FIND = function(PREP)
  local CNT = 0
	local SIZE
	local __ok, __res = pcall(function()
APPLY(function() SIZE = MULL(GET(PREPOSITIONS, 0), 2) return SIZE end)

  APPLY(function() while true do
    
    if APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    elseif EQUALQ(GET(PREPOSITIONS, CNT), PREP) then 
      return GET(PREPOSITIONS, SUB(CNT, 1))
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('PREP_FIND\n'..__res) end
end
SYNTAX_FOUND = function(SYN)
	local __ok, __res = pcall(function()
APPLY(function() P_SYNTAX = SYN return P_SYNTAX end)
	return APPLY(function() PRSA = GETB(SYN, P_SACTION) return PRSA end)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SYNTAX_FOUND\n'..__res) end
end
P_GWIMBIT = 0
GWIM = function(GBIT, LBIT, PREP)
	local OBJ
	local __ok, __res = pcall(function()

  if EQUALQ(GBIT, RMUNGBIT) then 
    return ROOMS
  end

APPLY(function() P_GWIMBIT = GBIT return P_GWIMBIT end)
APPLY(function() P_SLOCBITS = LBIT return P_SLOCBITS end)
  PUT(P_MERGE, P_MATCHLEN, 0)

  if GET_OBJECT(P_MERGE, nil) then 
    APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
    
    if EQUALQ(GET(P_MERGE, P_MATCHLEN), 1) then 
      APPLY(function() OBJ = GET(P_MERGE, 1) return OBJ end)
      TELL("(")
      
      if PASS(NOT(ZEROQ(PREP)) and NOT(P_END_ON_PREP)) then 
        PRINTB(APPLY(function() PREP = PREP_FIND(PREP) return PREP end))
        
        if EQUALQ(PREP, WQOUT) then 
          TELL(" of")
        end

        TELL(" ")
        
        if EQUALQ(OBJ, HANDS) then 
          TELL("your hands")
        elseif T then 
          TELL("the ", D, OBJ)
        end

        TELL(")", CR)
      else 
        TELL(D, OBJ, ")", CR)
      end

      -- 	return OBJ
    end

  elseif T then 
    APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
    	error(false)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GWIM\n'..__res) end
end
SNARF_OBJECTS = function()
	local OPTR
	local IPTR
	local L
	local __ok, __res = pcall(function()
  PUT(P_BUTS, P_MATCHLEN, 0)

  if NOT(EQUALQ(APPLY(function() IPTR = GET(P_ITBL, P_NC2) return IPTR end), 0)) then 
    APPLY(function() P_SLOCBITS = GETB(P_SYNTAX, P_SLOC2) return P_SLOCBITS end)
    PASS(SNARFEM(IPTR, GET(P_ITBL, P_NC2L), P_PRSI) or 	error(false))
  end


  if NOT(EQUALQ(APPLY(function() OPTR = GET(P_ITBL, P_NC1) return OPTR end), 0)) then 
    APPLY(function() P_SLOCBITS = GETB(P_SYNTAX, P_SLOC1) return P_SLOCBITS end)
    PASS(SNARFEM(OPTR, GET(P_ITBL, P_NC1L), P_PRSO) or 	error(false))
  end


  if NOT(ZEROQ(GET(P_BUTS, P_MATCHLEN))) then 
    APPLY(function() L = GET(P_PRSO, P_MATCHLEN) return L end)
    
    if OPTR then 
      APPLY(function() P_PRSO = BUT_MERGE(P_PRSO) return P_PRSO end)
    end

    
    if PASS(IPTR and PASS(NOT(OPTR) or EQUALQ(L, GET(P_PRSO, P_MATCHLEN)))) then 
      APPLY(function() P_PRSI = BUT_MERGE(P_PRSI) return P_PRSI end)
    end

  end

	error(true)
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SNARF_OBJECTS\n'..__res) end
end
BUT_MERGE = function(TBL)
	local LEN
	local BUTLEN
  local CNT = 1
  local MATCHES = 0
	local OBJ
	local NTBL
	local __ok, __res = pcall(function()
APPLY(function() LEN = GET(TBL, P_MATCHLEN) return LEN end)
  PUT(P_MERGE, P_MATCHLEN, 0)

  APPLY(function() while true do
    
    if APPLY(function() LEN = LEN - 1 return LEN < 0 end) then 
      return 
    elseif ZMEMQ(APPLY(function() OBJ = GET(TBL, CNT) return OBJ end), P_BUTS) then 
    elseif T then 
      PUT(P_MERGE, ADD(MATCHES, 1), OBJ)
      APPLY(function() MATCHES = ADD(MATCHES, 1) return MATCHES end)
    end

    APPLY(function() CNT = ADD(CNT, 1) return CNT end)

  end end)

  PUT(P_MERGE, P_MATCHLEN, MATCHES)
APPLY(function() NTBL = P_MERGE return NTBL end)
APPLY(function() P_MERGE = TBL return P_MERGE end)
	return NTBL
	end)
	if __ok or type(__res) == 'boolean' then return __res
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
SNARFEM = function(PTR, EPTR, TBL)
  local BUT = nil
	local LEN
	local WV
	local WRD
	local NW
  local WAS_ALL = nil
	local __ok, __res = pcall(function()
APPLY(function() P_AND = nil return P_AND end)

  if EQUALQ(P_GETFLAGS, P_ALL) then 
    APPLY(function() WAS_ALL = T return WAS_ALL end)
  end

APPLY(function() P_GETFLAGS = 0 return P_GETFLAGS end)
  PUT(TBL, P_MATCHLEN, 0)
APPLY(function() WRD = GET(PTR, 0) return WRD end)

  APPLY(function() while true do
    
    if EQUALQ(PTR, EPTR) then 
      APPLY(function() WV = GET_OBJECT(PASS(BUT or TBL)) return WV end)
      
      if WAS_ALL then 
        APPLY(function() P_GETFLAGS = P_ALL return P_GETFLAGS end)
      end

      return WV
    elseif T then 
      
      if EQUALQ(EPTR, REST(PTR, P_WORDLEN)) then 
        APPLY(function() NW = 0 return NW end)
      elseif T then 
        APPLY(function() NW = GET(PTR, P_LEXELEN) return NW end)
      end

      
      if EQUALQ(WRD, WQALL) then 
        APPLY(function() P_GETFLAGS = P_ALL return P_GETFLAGS end)
        
        if EQUALQ(NW, WQOF) then 
          APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
        end

      elseif EQUALQ(WRD, WQBUT, WQEXCEPT) then 
        PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
        APPLY(function() BUT = P_BUTS return BUT end)
        PUT(BUT, P_MATCHLEN, 0)
      elseif EQUALQ(WRD, WQA, WQONE) then 
        
        if NOT(P_ADJ) then 
          APPLY(function() P_GETFLAGS = P_ONE return P_GETFLAGS end)
          
          if EQUALQ(NW, WQOF) then 
            APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
          end

        elseif T then 
          APPLY(function() P_NAM = P_ONEOBJ return P_NAM end)
          PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
          PASS(ZEROQ(NW) and 	error(true))
        end

      elseif PASS(EQUALQ(WRD, WQAND, WQCOMMA) and NOT(EQUALQ(NW, WQAND, WQCOMMA))) then 
        APPLY(function() P_AND = T return P_AND end)
        PASS(GET_OBJECT(PASS(BUT or TBL)) or 	error(false))
        -- T
      elseif WTQ(WRD, PSQBUZZ_WORD) then 
      elseif EQUALQ(WRD, WQAND, WQCOMMA) then 
      elseif EQUALQ(WRD, WQOF) then 
        
        if ZEROQ(P_GETFLAGS) then 
          APPLY(function() P_GETFLAGS = P_INHIBIT return P_GETFLAGS end)
        end

      elseif PASS(APPLY(function() WV = WTQ(WRD, PSQADJECTIVE, P1QADJECTIVE) return WV end) and NOT(P_ADJ)) then 
        APPLY(function() P_ADJ = WV return P_ADJ end)
        APPLY(function() P_ADJN = WRD return P_ADJN end)
      elseif WTQ(WRD, PSQOBJECT, P1QOBJECT) then 
        APPLY(function() P_NAM = WRD return P_NAM end)
        APPLY(function() P_ONEOBJ = WRD return P_ONEOBJ end)
      end

    end

    
    if NOT(EQUALQ(PTR, EPTR)) then 
      APPLY(function() PTR = REST(PTR, P_WORDLEN) return PTR end)
      APPLY(function() WRD = NW return WRD end)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SNARFEM\n'..__res) end
end
SH = 128
SC = 64
SIR = 32
SOG = 16
STAKE = 8
SMANY = 4
SHAVE = 2
GET_OBJECT = function(TBL, VRB)
	local BITS
	local LEN
	local XBITS
	local TLEN
  local GCHECK = nil
  local OLEN = 0
	local OBJ
  VRB = VRB or T
	local __ok, __res = pcall(function()
APPLY(function() XBITS = P_SLOCBITS return XBITS end)
APPLY(function() TLEN = GET(TBL, P_MATCHLEN) return TLEN end)

  if BTST(P_GETFLAGS, P_INHIBIT) then 
    	error(true)
  end


  if PASS(NOT(P_NAM) and P_ADJ) then 
    
    if WTQ(P_ADJN, PSQOBJECT, P1QOBJECT) then 
      APPLY(function() P_NAM = P_ADJN return P_NAM end)
      APPLY(function() P_ADJ = nil return P_ADJ end)
    elseif NULL_F() then 
      -- T
    end

  end


  if PASS(NOT(P_NAM) and NOT(P_ADJ) and NOT(EQUALQ(P_GETFLAGS, P_ALL)) and ZEROQ(P_GWIMBIT)) then 
    
    if VRB then 
      TELL("There seems to be a noun missing in that sentence!", CR)
    end

    	error(false)
  end


  if PASS(NOT(EQUALQ(P_GETFLAGS, P_ALL)) or ZEROQ(P_SLOCBITS)) then 
    APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
  end

APPLY(function() P_TABLE = TBL return P_TABLE end)

  do
    
    if GCHECK then 
      GLOBAL_CHECK(TBL)
    elseif T then 
      
      if LIT then 
        FCLEAR(PLAYER, TRANSBIT)
        DO_SL(HERE, SOG, SIR)
        FSET(PLAYER, TRANSBIT)
      end

      DO_SL(PLAYER, SH, SC)
    end
    APPLY(function() LEN = SUB(GET(TBL, P_MATCHLEN), TLEN) return LEN end)    
    if BTST(P_GETFLAGS, P_ALL) then 
    elseif PASS(BTST(P_GETFLAGS, P_ONE) and NOT(ZEROQ(LEN))) then 
      
      if NOT(EQUALQ(LEN, 1)) then 
        PUT(TBL, 1, GET(TBL, RANDOM(LEN)))
        TELL("(How about the ")
        PRINTD(GET(TBL, 1))
        TELL("?)", CR)
      end

      PUT(TBL, P_MATCHLEN, 1)
    elseif PASS(GQ(LEN, 1) or PASS(ZEROQ(LEN) and NOT(EQUALQ(P_SLOCBITS, -1)))) then 
      
      if EQUALQ(P_SLOCBITS, -1) then 
        APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)
        APPLY(function() OLEN = LEN return OLEN end)
        PUT(TBL, P_MATCHLEN, SUB(GET(TBL, P_MATCHLEN), LEN))
        AGAIN()
      elseif T then 
        
        if ZEROQ(LEN) then 
          APPLY(function() LEN = OLEN return LEN end)
        end

        
        if NOT(EQUALQ(WINNER, PLAYER)) then 
          CANT_ORPHAN()
          	error(false)
        elseif PASS(VRB and P_NAM) then 
          WHICH_PRINT(TLEN, LEN, TBL)
          APPLY(function() P_ACLAUSE = APPLY(function()
            if EQUALQ(TBL, P_PRSO) then 
              -- 	return P_NC1
            elseif T then 
              -- 	return P_NC2
            end
 end) return P_ACLAUSE end)
          APPLY(function() P_AADJ = P_ADJ return P_AADJ end)
          APPLY(function() P_ANAM = P_NAM return P_ANAM end)
          ORPHAN(nil, nil)
          APPLY(function() P_OFLAG = T return P_OFLAG end)
        elseif VRB then 
          TELL("There seems to be a noun missing in that sentence!", CR)
        end

        APPLY(function() P_NAM = nil return P_NAM end)
        APPLY(function() P_ADJ = nil return P_ADJ end)
        	error(false)
      end

    end
    
    if PASS(ZEROQ(LEN) and GCHECK) then 
      
      if VRB then 
        APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)
        
        if PASS(LIT or VERBQ(TELL)) then 
          OBJ_FOUND(NOT_HERE_OBJECT, TBL)
          APPLY(function() P_XNAM = P_NAM return P_XNAM end)
          APPLY(function() P_XADJ = P_ADJ return P_XADJ end)
          APPLY(function() P_XADJN = P_ADJN return P_XADJN end)
          APPLY(function() P_NAM = nil return P_NAM end)
          APPLY(function() P_ADJ = nil return P_ADJ end)
          APPLY(function() P_ADJN = nil return P_ADJN end)
          	error(true)
        elseif T then 
          TELL("It's too dark to see!", CR)
        end

      end

      APPLY(function() P_NAM = nil return P_NAM end)
      APPLY(function() P_ADJ = nil return P_ADJ end)
      	error(false)
    elseif ZEROQ(LEN) then 
      APPLY(function() GCHECK = T return GCHECK end)
      AGAIN()
    end
    APPLY(function() P_SLOCBITS = XBITS return P_SLOCBITS end)    APPLY(function() P_NAM = nil return P_NAM end)    APPLY(function() P_ADJ = nil return P_ADJ end)    	error(true)
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GET_OBJECT\n'..__res) end
end
P_XNAM = nil
P_XADJ = nil
P_XADJN = nil
WHICH_PRINT = function(TLEN, LEN, TBL)
	local OBJ
	local RLEN
	local __ok, __res = pcall(function()
APPLY(function() RLEN = LEN return RLEN end)
  TELL("Which ")

  if PASS(P_OFLAG or P_MERGED or P_AND) then 
    PRINTB(APPLY(function()
      if P_NAM then 
        -- 	return P_NAM
      elseif P_ADJ then 
        -- 	return P_ADJN
      else 
        -- 	return WQONE
      end
 end))
  else 
    THING_PRINT(EQUALQ(TBL, P_PRSO))
  end

  TELL(" do you mean, ")

  APPLY(function() while true do
    APPLY(function() TLEN = ADD(TLEN, 1) return TLEN end)
    APPLY(function() OBJ = GET(TBL, TLEN) return OBJ end)
    TELL("the ", D, OBJ)
    
    if EQUALQ(LEN, 2) then 
      
      if NOT(EQUALQ(RLEN, 2)) then 
        TELL(",")
      end

      TELL(" or ")
    elseif GQ(LEN, 2) then 
      TELL(", ")
    end

    
    if LQ(APPLY(function() LEN = SUB(LEN, 1) return LEN end), 1) then 
      TELL("?", CR)
      return 
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('WHICH_PRINT\n'..__res) end
end
GLOBAL_CHECK = function(TBL)
	local LEN
	local RMG
	local RMGL
  local CNT = 0
	local OBJ
	local OBITS
	local FOO
	local __ok, __res = pcall(function()
APPLY(function() LEN = GET(TBL, P_MATCHLEN) return LEN end)
APPLY(function() OBITS = P_SLOCBITS return OBITS end)

  if APPLY(function() RMG = GETPT(HERE, PQGLOBAL) return RMG end) then 
    APPLY(function() RMGL = SUB(PTSIZE(RMG), 1) return RMGL end)
    
    APPLY(function() while true do
      
      if THIS_ITQ(APPLY(function() OBJ = GETB(RMG, CNT) return OBJ end), TBL) then 
        OBJ_FOUND(OBJ, TBL)
      end

      
      if APPLY(function() CNT = CNT + 1 return CNT > RMGL end) then 
        return 
      end


    end end)

  end


  if APPLY(function() RMG = GETPT(HERE, PQPSEUDO) return RMG end) then 
    APPLY(function() RMGL = SUB(DIV(PTSIZE(RMG), 4), 1) return RMGL end)
    APPLY(function() CNT = 0 return CNT end)
    
    APPLY(function() while true do
      
      if EQUALQ(P_NAM, GET(RMG, MULL(CNT, 2))) then 
        PUTP(PSEUDO_OBJECT, PQACTION, GET(RMG, ADD(MULL(CNT, 2), 1)))
        APPLY(function() FOO = BACK(GETPT(PSEUDO_OBJECT, PQACTION), 5) return FOO end)
        PUT(FOO, 0, GET(P_NAM, 0))
        PUT(FOO, 1, GET(P_NAM, 1))
        OBJ_FOUND(PSEUDO_OBJECT, TBL)
        return 
      elseif APPLY(function() CNT = CNT + 1 return CNT > RMGL end) then 
        return 
      end


    end end)

  end


  if EQUALQ(GET(TBL, P_MATCHLEN), LEN) then 
    APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
    APPLY(function() P_TABLE = TBL return P_TABLE end)
    DO_SL(GLOBAL_OBJECTS, 1, 1)
    APPLY(function() P_SLOCBITS = OBITS return P_SLOCBITS end)
    
    if PASS(ZEROQ(GET(TBL, P_MATCHLEN)) and EQUALQ(PRSA, VQLOOK_INSIDE, VQSEARCH, VQEXAMINE)) then 
      	return DO_SL(ROOMS, 1, 1)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('GLOBAL_CHECK\n'..__res) end
end
DO_SL = function(OBJ, BIT1, BIT2)
	local BTS
	local __ok, __res = pcall(function()

  if BTST(P_SLOCBITS, ADD(BIT1, BIT2)) then 
    	return SEARCH_LIST(OBJ, P_TABLE, P_SRCALL)
  elseif T then 
    
    if BTST(P_SLOCBITS, BIT1) then 
      	return SEARCH_LIST(OBJ, P_TABLE, P_SRCTOP)
    elseif BTST(P_SLOCBITS, BIT2) then 
      	return SEARCH_LIST(OBJ, P_TABLE, P_SRCBOT)
    elseif T then 
      	error(true)
    end

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('DO_SL\n'..__res) end
end
P_SRCBOT = 2
P_SRCTOP = 0
P_SRCALL = 1
SEARCH_LIST = function(OBJ, TBL, LVL)
	local FLS
	local NOBJ
	local __ok, __res = pcall(function()

  if APPLY(function() OBJ = FIRSTQ(OBJ) return OBJ end) then 
    
    APPLY(function() while true do
      
      if PASS(NOT(EQUALQ(LVL, P_SRCBOT)) and GETPT(OBJ, PQSYNONYM) and THIS_ITQ(OBJ, TBL)) then 
        OBJ_FOUND(OBJ, TBL)
      end

      
      if PASS(PASS(NOT(EQUALQ(LVL, P_SRCTOP)) or FSETQ(OBJ, SEARCHBIT) or FSETQ(OBJ, SURFACEBIT)) and APPLY(function() NOBJ = FIRSTQ(OBJ) return NOBJ end) and PASS(FSETQ(OBJ, OPENBIT) or FSETQ(OBJ, TRANSBIT))) then 
        APPLY(function() FLS = SEARCH_LIST(OBJ, TBL, APPLY(function()
            if FSETQ(OBJ, SURFACEBIT) then 
              -- 	return P_SRCALL
            elseif FSETQ(OBJ, SEARCHBIT) then 
              -- 	return P_SRCALL
            elseif T then 
              -- 	return P_SRCTOP
            end
 end)) return FLS end)
      end

      
      if APPLY(function() OBJ = NEXTQ(OBJ) return OBJ end) then 
      elseif T then 
        return 
      end


    end end)

  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('SEARCH_LIST\n'..__res) end
end
OBJ_FOUND = function(OBJ, TBL)
	local PTR
	local __ok, __res = pcall(function()
APPLY(function() PTR = GET(TBL, P_MATCHLEN) return PTR end)
  PUT(TBL, ADD(PTR, 1), OBJ)
	return   PUT(TBL, P_MATCHLEN, ADD(PTR, 1))
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('OBJ_FOUND\n'..__res) end
end
TAKE_CHECK = function()
	local __ok, __res = pcall(function()
	return   PASS(ITAKE_CHECK(P_PRSO, GETB(P_SYNTAX, P_SLOC1)) and ITAKE_CHECK(P_PRSI, GETB(P_SYNTAX, P_SLOC2)))
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('TAKE_CHECK\n'..__res) end
end
ITAKE_CHECK = function(TBL, IBITS)
	local PTR
	local OBJ
	local TAKEN
	local __ok, __res = pcall(function()

  if PASS(APPLY(function() PTR = GET(TBL, P_MATCHLEN) return PTR end) and PASS(BTST(IBITS, SHAVE) or BTST(IBITS, STAKE))) then 
    
    APPLY(function() while true do
      
      if LQ(APPLY(function() PTR = SUB(PTR, 1) return PTR end), 0) then 
        return 
      elseif T then 
        APPLY(function() OBJ = GET(TBL, ADD(PTR, 1)) return OBJ end)
        
        if EQUALQ(OBJ, IT) then 
          
          if NOT(ACCESSIBLEQ(P_IT_OBJECT)) then 
            TELL("I don't see what you're referring to.", CR)
            	error(false)
          elseif T then 
            APPLY(function() OBJ = P_IT_OBJECT return OBJ end)
          end

        end

        
        if PASS(NOT(HELDQ(OBJ)) and NOT(EQUALQ(OBJ, HANDS, ME))) then 
          APPLY(function() PRSO = OBJ return PRSO end)
          
          if FSETQ(OBJ, TRYTAKEBIT) then 
            APPLY(function() TAKEN = T return TAKEN end)
          elseif NOT(EQUALQ(WINNER, ADVENTURER)) then 
            APPLY(function() TAKEN = nil return TAKEN end)
          elseif PASS(BTST(IBITS, STAKE) and EQUALQ(ITAKE(nil), T)) then 
            APPLY(function() TAKEN = nil return TAKEN end)
          elseif T then 
            APPLY(function() TAKEN = T return TAKEN end)
          end

          
          if PASS(TAKEN and BTST(IBITS, SHAVE) and EQUALQ(WINNER, ADVENTURER)) then 
            
            if EQUALQ(OBJ, NOT_HERE_OBJECT) then 
              TELL("You don't have that!", CR)
              	error(false)
            end

            TELL("You don't have the ")
            PRINTD(OBJ)
            TELL(".", CR)
            	error(false)
          elseif PASS(NOT(TAKEN) and EQUALQ(WINNER, ADVENTURER)) then 
            TELL("(Taken)", CR)
          end

        end

      end


    end end)

  elseif T then 
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ITAKE_CHECK\n'..__res) end
end
MANY_CHECK = function()
  local LOSS = nil
	local TMP
	local __ok, __res = pcall(function()

  if PASS(GQ(GET(P_PRSO, P_MATCHLEN), 1) and NOT(BTST(GETB(P_SYNTAX, P_SLOC1), SMANY))) then 
    APPLY(function() LOSS = 1 return LOSS end)
  elseif PASS(GQ(GET(P_PRSI, P_MATCHLEN), 1) and NOT(BTST(GETB(P_SYNTAX, P_SLOC2), SMANY))) then 
    APPLY(function() LOSS = 2 return LOSS end)
  end


  if LOSS then 
    TELL("You can't use multiple ")
    
    if EQUALQ(LOSS, 2) then 
      TELL("in")
    end

    TELL("direct objects with \"")
    APPLY(function() TMP = GET(P_ITBL, P_VERBN) return TMP end)
    
    if ZEROQ(TMP) then 
      TELL("tell")
    elseif PASS(P_OFLAG or P_MERGED) then 
      PRINTB(GET(TMP, 0))
    elseif T then 
      WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
    end

    TELL("\".", CR)
    	error(false)
  elseif T then 
  end

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('MANY_CHECK\n'..__res) end
end
ZMEMQ = function(ITM, TBL, SIZE)
  local CNT = 1
  SIZE = SIZE or -1
	local __ok, __res = pcall(function()

  if NOT(TBL) then 
    	error(false)
  end


  if NOT(LQ(SIZE, 0)) then 
    APPLY(function() CNT = 0 return CNT end)
  else 
    APPLY(function() SIZE = GET(TBL, 0) return SIZE end)
  end


  APPLY(function() while true do
    
    if EQUALQ(ITM, GET(TBL, CNT)) then 
      return REST(TBL, MULL(CNT, 2))
    elseif APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ZMEMQ\n'..__res) end
end
ZMEMQB = function(ITM, TBL, SIZE)
  local CNT = 0
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if EQUALQ(ITM, GETB(TBL, CNT)) then 
      	error(true)
    elseif APPLY(function() CNT = CNT + 1 return CNT > SIZE end) then 
      	error(false)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ZMEMQB\n'..__res) end
end
ALWAYS_LIT = nil
LITQ = function(RM, RMBIT)
	local OHERE
  local LIT = nil
  RMBIT = RMBIT or T
	local __ok, __res = pcall(function()

  if PASS(ALWAYS_LIT and EQUALQ(WINNER, PLAYER)) then 
    	error(true)
  end

APPLY(function() P_GWIMBIT = ONBIT return P_GWIMBIT end)
APPLY(function() OHERE = HERE return OHERE end)
APPLY(function() HERE = RM return HERE end)

  if PASS(RMBIT and FSETQ(RM, ONBIT)) then 
    APPLY(function() LIT = T return LIT end)
  elseif T then 
    PUT(P_MERGE, P_MATCHLEN, 0)
    APPLY(function() P_TABLE = P_MERGE return P_TABLE end)
    APPLY(function() P_SLOCBITS = -1 return P_SLOCBITS end)
    
    if EQUALQ(OHERE, RM) then 
      DO_SL(WINNER, 1, 1)
      
      if PASS(NOT(EQUALQ(WINNER, PLAYER)) and INQ(PLAYER, RM)) then 
        DO_SL(PLAYER, 1, 1)
      end

    end

    DO_SL(RM, 1, 1)
    
    if GQ(GET(P_TABLE, P_MATCHLEN), 0) then 
      APPLY(function() LIT = T return LIT end)
    end

  end

APPLY(function() HERE = OHERE return HERE end)
APPLY(function() P_GWIMBIT = 0 return P_GWIMBIT end)
	return LIT
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('LITQ\n'..__res) end
end
THIS_ITQ = function(OBJ, TBL)
	local SYNS
	local __ok, __res = pcall(function()

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
	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('THIS_ITQ\n'..__res) end
end
ACCESSIBLEQ = function(OBJ)
  local L = LOC(OBJ)
	local __ok, __res = pcall(function()

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

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('ACCESSIBLEQ\n'..__res) end
end
META_LOC = function(OBJ)
	local __ok, __res = pcall(function()

  APPLY(function() while true do
    
    if NOT(OBJ) then 
      	error(false)
    elseif INQ(OBJ, GLOBAL_OBJECTS) then 
      return GLOBAL_OBJECTS
    end

    
    if INQ(OBJ, ROOMS) then 
      return OBJ
    elseif T then 
      APPLY(function() OBJ = LOC(OBJ) return OBJ end)
    end


  end end)

	end)
	if __ok or type(__res) == 'boolean' then return __res
	else error('META_LOC\n'..__res) end
end
