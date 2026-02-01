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

<OBJECT VALVE
        (IN TEST-ROOM)
        (SYNONYM VALVE)
        (DESC "valve")
        (LDESC "A valve is here.")
        (FLAGS TURNBIT)>

<OBJECT WHEEL
        (IN TEST-ROOM)
        (SYNONYM WHEEL)
        (DESC "wheel")
        (LDESC "A wheel is here.")>

<ROUTINE GO ()
        <SETG HERE ,TEST-ROOM>
        <SETG WINNER ,ADVENTURER>
        <SETG LIT T>
        <MOVE ,WINNER ,HERE>
        <V-LOOK>
        <MAIN-LOOP>>

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT "Valve has TURNBIT flag" <FSET? ,VALVE ,TURNBIT>>
    <ASSERT "Wheel does not have TURNBIT flag" <NOT <FSET? ,WHEEL ,TURNBIT>>>
    <CO-RESUME ,CO "look">
    <TELL CR "All tests completed!" CR>>
