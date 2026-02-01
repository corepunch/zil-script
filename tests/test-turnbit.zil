<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/main">

<DIRECTIONS NORTH SOUTH>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

<ROOM TEST-ROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room for TURNBIT flag testing.")
      (FLAGS RLANDBIT ONBIT)>

<GLOBAL VALVE-TURNED <>>
<GLOBAL WHEEL-TURNED <>>

<ROUTINE VALVE-F ()
         <COND (<VERB? TURN>
                <TELL "You turn the valve with all your might!" CR>
                <SETG VALVE-TURNED T>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A valve that can be turned." CR>
                <RTRUE>)>>

<OBJECT VALVE
        (IN TEST-ROOM)
        (SYNONYM VALVE)
        (DESC "valve")
        (LDESC "A valve is here.")
        (FLAGS TURNBIT)
        (ACTION VALVE-F)>

<ROUTINE WHEEL-F ()
         <COND (<VERB? TURN>
                <TELL "You turn the wheel successfully!" CR>
                <SETG WHEEL-TURNED T>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A wheel without TURNBIT." CR>
                <RTRUE>)>>

<OBJECT WHEEL
        (IN TEST-ROOM)
        (SYNONYM WHEEL)
        (DESC "wheel")
        (LDESC "A wheel is here.")
        (ACTION WHEEL-F)>

<ROUTINE GO ()
        <SETG HERE ,TEST-ROOM>
        <SETG WINNER ,ADVENTURER>
        <SETG LIT T>
        <MOVE ,WINNER ,HERE>
        <V-LOOK>
        <MAIN-LOOP>>

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT "Turn valve WITH TURNBIT - should succeed" <CO-RESUME ,CO "turn valve" T> ,VALVE-TURNED>
    <SETG VALVE-TURNED <>>
    <ASSERT "Turn valve with bare hands - should NOT turn" <CO-RESUME ,CO "turn valve" T> <NOT ,VALVE-TURNED>>
    <ASSERT "Turn wheel WITHOUT TURNBIT - should fail" <CO-RESUME ,CO "turn wheel" T> <NOT ,WHEEL-TURNED>>
    <TELL CR "All tests completed!" CR>>
