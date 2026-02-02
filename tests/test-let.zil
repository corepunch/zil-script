<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room for LET testing.")
      (FLAGS RLANDBIT ONBIT)>

<ROUTINE RUN-TEST ()
    <TELL "=== LET Tests ===" CR CR>
    
    ;"Test 1: Basic LET with single binding"
    <TELL "Test 1: Basic LET with single binding" CR>
    <LET ((X 42))
      <ASSERT "X should be 42" <==? .X 42>>
      <ASSERT "X from bare identifier should be 42" <==? X 42>>
      <TELL "Basic LET works" CR CR>>
    
    ;"Test 2: LET with multiple bindings"
    <TELL "Test 2: LET with multiple bindings" CR>
    <LET ((A 10) (B 20))
      <ASSERT "A should be 10" <==? .A 10>>
      <ASSERT "B should be 20" <==? .B 20>>
      <ASSERT "A + B should be 30" <==? <+ .A .B> 30>>
      <TELL "Multiple bindings work" CR CR>>
    
    ;"Test 3: LET with hyphenated variable names"
    <TELL "Test 3: LET with hyphenated variable names" CR>
    <LET ((MY-VAR 100))
      <ASSERT "MY-VAR should be 100" <==? .MY-VAR 100>>
      <ASSERT "MY-VAR bare reference should be 100" <==? MY-VAR 100>>
      <TELL "Hyphenated names work" CR CR>>
    
    ;"Test 4: LET with expression as initial value"
    <TELL "Test 4: LET with expression as initial value" CR>
    <LET ((RESULT <+ 5 7>))
      <ASSERT "RESULT should be 12" <==? .RESULT 12>>
      <TELL "Expression initialization works" CR CR>>
    
    ;"Test 5: LET with nested expressions"
    <TELL "Test 5: LET with nested expressions" CR>
    <LET ((OUTER 5))
      <LET ((INNER <* .OUTER 2>))
        <ASSERT "INNER should be 10" <==? .INNER 10>>
        <ASSERT "OUTER should still be 5" <==? .OUTER 5>>
        <TELL "Nested LET works" CR CR>>>
    
    ;"Test 6: LET doesn't interfere with globals"
    <TELL "Test 6: LET doesn't interfere with globals" CR>
    <SETG GLOBAL-VAR 999>
    <LET ((LOCAL-VAR 111))
      <ASSERT "LOCAL-VAR should be 111" <==? .LOCAL-VAR 111>>
      <ASSERT "GLOBAL-VAR should still be 999" <==? ,GLOBAL-VAR 999>>
      <TELL "Locals and globals coexist" CR CR>>
    
    ;"Test 7: LET scope is limited"
    <TELL "Test 7: LET scope is limited" CR>
    <SETG TEMP-VAR 0>
    <LET ((SCOPED 77))
      <SETG TEMP-VAR .SCOPED>>
    <ASSERT "TEMP-VAR should be 77 after LET" <==? ,TEMP-VAR 77>>
    <TELL "LET scope is properly limited" CR CR>
    
    <TELL CR "=== All LET Tests Passed ===" CR>>

<ROUTINE GO ()
    <SETG HERE ,TESTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <RUN-TEST>>

<GLOBAL CO <CO-CREATE GO>>
