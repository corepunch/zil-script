<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/main">

<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room for clock system testing.")
      (FLAGS RLANDBIT ONBIT)>

;"Global test counters"
<GLOBAL TEST-FIRED 0>
<GLOBAL TEST8-FIRED 0>
<GLOBAL COUNT1 0>
<GLOBAL COUNT2 0>
<GLOBAL ZERO-FIRED <>>
<GLOBAL TEST-HAS-RUN <>>

;"Test interrupt function"
<ROUTINE TEST-INTERRUPT ()
  <SETG TEST-FIRED <+ ,TEST-FIRED 1>>
  T>

;"Test demon for test 8"
<ROUTINE TEST8-DEMON ()
  <SETG TEST8-FIRED <+ ,TEST8-FIRED 1>>
  T>

;"Test demon 1 for test 10"
<ROUTINE TEST-DEMON1 ()
  <SETG COUNT1 <+ ,COUNT1 1>>
  T>

;"Test demon 2 for test 10"
<ROUTINE TEST-DEMON2 ()
  <SETG COUNT2 <+ ,COUNT2 1>>
  T>

;"Test zero-tick demon"
<ROUTINE TEST-ZERO-DEMON ()
  <SETG ZERO-FIRED T>
  T>

<ROUTINE RUN-TEST ()
    ;"Prevent test from running multiple times due to coroutine system"
    <COND (,TEST-HAS-RUN <RTRUE>)>
    <SETG TEST-HAS-RUN T>
    
    <TELL "=== Clock System Direct Tests ===" CR CR>
    
    ;"Test 1: Verify globals are defined"
    <TELL "Test 1: Verify clock globals are defined" CR>
    <ASSERT "C_TABLE should be defined" ,C-TABLE>
    <ASSERT "C_TABLELEN should be 180" <==? ,C-TABLELEN 180>>
    <ASSERT "C_DEMONS should be 180" <==? ,C-DEMONS 180>>
    <ASSERT "C_INTS should be 180" <==? ,C-INTS 180>>
    <ASSERT "C_INTLEN should be 6" <==? ,C-INTLEN 6>>
    <ASSERT "C_ENABLEDQ should be 0" <==? ,C-ENABLEDQ 0>>
    <ASSERT "C_TICK should be 1" <==? ,C-TICK 1>>
    <ASSERT "C_RTN should be 2" <==? ,C-RTN 2>>
    <ASSERT "CLOCK_WAIT should be false/nil" <NOT ,CLOCK-WAIT>>
    <ASSERT "MOVES should be 0" <==? ,MOVES 0>>
    <TELL "All globals defined correctly" CR CR>
    
    ;"Test 2: Verify C_TABLE is a memory address (number)"
    <TELL "Test 2: Verify C_TABLE is a memory address" CR>
    <ASSERT "C_TABLE should be defined (truthy)" ,C-TABLE>
    <TELL "C_TABLE is a valid memory address" CR CR>
    
    ;"Test 3: Verify functions are defined and callable"
    <TELL "Test 3: Verify clock functions are callable" CR>
    <ASSERT "INT should be a routine" <==? <type INT> "function">>
    <ASSERT "QUEUE should be a routine" <==? <type QUEUE> "function">>
    <ASSERT "CLOCKER should be a routine" <==? <type CLOCKER> "function">>
    <TELL "All functions are callable" CR CR>
    
    ;"Test 4: Test INT function - create a demon"
    <TELL "Test 4: Test INT function (demon)" CR>
    <TELL "  Calling INT to create demon for TEST-INTERRUPT" CR>
    <LET ((CINT <INT ,TEST-INTERRUPT T>))
      <ASSERT "INT should return a demon entry" CINT>
      <TELL "INT created demon entry" CR CR>>
    
    ;"Test 5: Test QUEUE function"
    <TELL "Test 5: Test QUEUE function" CR>
    <LET ((DEMO <INT ,TEST-INTERRUPT T>))
      <ASSERT "QUEUE should return the interrupt entry" <QUEUE ,TEST-INTERRUPT 5>>
      <TELL "QUEUE set tick count" CR CR>>
    
    ;"Test 6: Test CLOCKER increments MOVES"
    <TELL "Test 6: Test CLOCKER increments MOVES" CR>
    <LET ((INIT-MOVES ,MOVES))
      <CLOCKER>
      <ASSERT "MOVES should increment" <G? ,MOVES .INIT-MOVES>>
      <TELL "CLOCKER incremented MOVES" CR CR>>
    
    ;"Test 7: Test CLOCK_WAIT pauses clock"
    <TELL "Test 7: Test CLOCK_WAIT pauses clock" CR>
    <SETG CLOCK-WAIT T>
    <LET ((MOVES-BEFORE ,MOVES))
      <CLOCKER>
      <ASSERT "CLOCK_WAIT should be cleared" <NOT ,CLOCK-WAIT>>
      <ASSERT "MOVES should not increment when paused" <==? ,MOVES .MOVES-BEFORE>>
      <TELL "CLOCK_WAIT pauses clock correctly" CR CR>>
    
    ;"Test 8: Test demon firing when tick counts down"
    <TELL "Test 8: Test demon firing" CR>
    <SETG TEST8-FIRED 0>
    <LET ((DEMO8 <INT ,TEST8-DEMON T>))
      <TELL "  Enabling and queuing demon with tick=2" CR>
      <ENABLE .DEMO8>
      <QUEUE ,TEST8-DEMON 2>
      
      ;"First CLOCKER - should not fire (2->1)"
      <CLOCKER>
      <ASSERT "Demon should not fire on first CLOCKER" <==? ,TEST8-FIRED 0>>
      <TELL "  Tick=2: Demon not fired" CR>
      
      ;<TELL "Second CLOCKER - should fire (1->0)" CR>
      <CLOCKER>
      <ASSERT "Demon should fire on second CLOCKER" <G? ,TEST8-FIRED 0>>
      <TELL "  Tick=1: Demon fired" CR>>
    <TELL "Demon fires at correct time" CR CR>
    
    ;"Test 9: Test INT finds existing demon"
    <TELL "Test 9: Test INT finds existing demon" CR>
    <LET ((FIRST <INT ,TEST-DEMON1 T>)
          (SECOND <INT ,TEST-DEMON1 T>))
      <ASSERT "INT should return same entry for same function" <==? .FIRST .SECOND>>
      <TELL "INT reuses existing demon entry" CR CR>>
    
    ;"Test 10: Test multiple demons"
    <TELL "Test 10: Test multiple demons" CR>
    <SETG COUNT1 0>
    <SETG COUNT2 0>
    <LET ((D1 <INT ,TEST-DEMON1 T>)
          (D2 <INT ,TEST-DEMON2 T>))
      <ENABLE .D1>
      <ENABLE .D2>
      <QUEUE ,TEST-DEMON1 1>
      <QUEUE ,TEST-DEMON2 2>
      
      ;"First CLOCKER - d1 should fire (1->0), d2 should not (2->1)"
      <CLOCKER>
      <ASSERT "First demon should fire" <==? ,COUNT1 1>>
      <ASSERT "Second demon should not fire yet" <==? ,COUNT2 0>>
      
      ;<TELL "Second CLOCKER - d2 should fire (1->0)" CR>
      <CLOCKER>
      <ASSERT "Second demon should fire" <==? ,COUNT2 1>>
      <TELL "Multiple demons work correctly" CR CR>>
    
    ;"Test 11: Test demon tracking"
    <TELL "Test 11: Test demon tracking" CR>
    <ASSERT "C_INTS should decrease as demons are added" <L? ,C-INTS 180>>
    <ASSERT "C_DEMONS should decrease as demons are created" <L? ,C-DEMONS 180>>
    <TELL "Demon boundaries correct" CR CR>
    
    ;"Test 12: Test tick=0 demons don't fire"
    <TELL "Test 12: Test tick=0 demons don't fire" CR>
    <SETG ZERO-FIRED <>>
    <LET ((D12 <INT ,TEST-ZERO-DEMON T>))
      <ENABLE .D12>
      <QUEUE ,TEST-ZERO-DEMON 0>
      
      <CLOCKER>
      <ASSERT "Demon with tick=0 should not fire" <NOT ,ZERO-FIRED>>
      <TELL "Tick=0 demons don't fire" CR CR>>
    
    <TELL CR "=== All Clock System Tests Passed ===" CR>

<ROUTINE GO ()
    <SETG HERE ,TESTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <RUN-TEST>>

<GLOBAL CO <CO-CREATE GO>>
