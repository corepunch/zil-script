<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/main">

<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A dark test room.")>

<OBJECT FLASHLIGHT
        (IN ADVENTURER)
        (SYNONYM FLASHLIGHT LIGHT TORCH)
        (DESC "flashlight")
        (FLAGS TAKEBIT LIGHTBIT)
        (ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
    <COND (<VERB? LAMP-ON>
           <FSET ,FLASHLIGHT ,ONBIT>
           <TELL "The flashlight is now on." CR>
           <RTRUE>)
          (<VERB? LAMP-OFF>
           <FCLEAR ,FLASHLIGHT ,ONBIT>
           <TELL "The flashlight is now off." CR>
           <RTRUE>)>>

<OBJECT LANTERN
        (IN STARTROOM)
        (SYNONYM LANTERN LAMP)
        (DESC "lantern")
        (FLAGS TAKEBIT LIGHTBIT)
        (ACTION LANTERN-F)>

<ROUTINE LANTERN-F ()
    <COND (<VERB? LAMP-ON>
           <FSET ,LANTERN ,ONBIT>
           <TELL "The lantern is now lit." CR>
           <RTRUE>)
          (<VERB? LAMP-OFF>
           <FCLEAR ,LANTERN ,ONBIT>
           <TELL "The lantern is now dark." CR>
           <RTRUE>)>>

<ROUTINE GO ()
    <SETG HERE ,STARTROOM>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <FCLEAR ,FLASHLIGHT ,ONBIT>
    <FCLEAR ,LANTERN ,ONBIT>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT-TEXT "pitch black" <CO-RESUME ,CO "look">>
    <ASSERT "Light flashlight" <CO-RESUME ,CO "light flashlight" T> <FSET? ,FLASHLIGHT ,ONBIT>>
    <ASSERT-TEXT "Start Room" <CO-RESUME ,CO "look">>
    <ASSERT "Extinguish flashlight" <CO-RESUME ,CO "extinguish flashlight" T> <NOT <FSET? ,FLASHLIGHT ,ONBIT>>>
    <ASSERT-TEXT "pitch black" <CO-RESUME ,CO "look">>
    <ASSERT "Light flashlight again" <CO-RESUME ,CO "light flashlight" T> <FSET? ,FLASHLIGHT ,ONBIT>>
    <ASSERT "Take the lantern" <CO-RESUME ,CO "take lantern" T> <==? <LOC ,LANTERN> ,ADVENTURER>>
    <ASSERT-TEXT "flashlight" <CO-RESUME ,CO "inventory">>
    <TELL CR "All tests completed!" CR>>
