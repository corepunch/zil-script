<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/main">

<DIRECTIONS NORTH SOUTH EAST WEST>
<CONSTANT RELEASEID 1>

<ROOM STARTROOM
      (IN ROOMS)
      (WEST TO HALLWAY)
      (DESC "Start Room")
      (LDESC "A test room.")
      (FLAGS RLANDBIT ONBIT)>

<ROOM HALLWAY
      (IN ROOMS)
      (DESC "Hallway")
      (LDESC "A hallway.")
      (EAST TO STARTROOM)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE FRUIT)
        (DESC "apple")
        (FLAGS TAKEBIT EDIBLEBIT VOWELBIT)>

<OBJECT NAIL
        (IN STARTROOM)
        (SYNONYM NAIL)
        (ADJECTIVE RUSTY)
        (DESC "rusty nail")
        (FLAGS TAKEBIT)>

<OBJECT WALLET
        (IN ADVENTURER)
        (SYNONYM WALLET BILLFOLD)
        (DESC "wallet")
        (FLAGS TAKEBIT)>

<ROUTINE GO ()
    <SETG HERE ,STARTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT-TEXT "Start Room" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "wallet" <CO-RESUME ,CO "inventory">>
    <ASSERT "Take the apple" <CO-RESUME ,CO "take apple" T> <==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT "Take the nail" <CO-RESUME ,CO "take nail" T> <==? <LOC ,NAIL> ,ADVENTURER>>
    <ASSERT-TEXT "nail" <CO-RESUME ,CO "inventory">>
    <ASSERT-TEXT "apple" <CO-RESUME ,CO "examine apple">>
    <ASSERT "Drop the apple" <CO-RESUME ,CO "drop apple" T> <N==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT "Drop the nail" <CO-RESUME ,CO "drop nail" T> <N==? <LOC ,NAIL> ,ADVENTURER>>
    <ASSERT "Drop wallet" <CO-RESUME ,CO "drop wallet" T> <N==? <LOC ,WALLET> ,ADVENTURER>>
    <ASSERT "Move to hallway" <CO-RESUME ,CO "west" T> <==? ,HERE ,HALLWAY>>
    <ASSERT-TEXT "Hallway" <CO-RESUME ,CO "look">>
    <TELL CR "All tests completed!" CR>>
