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
      (LDESC "A test room for containers.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE FRUIT)
        (DESC "apple")
        (FLAGS TAKEBIT EDIBLEBIT VOWELBIT)
        (SIZE 5)>

<OBJECT BANANA
        (IN STARTROOM)
        (SYNONYM BANANA FRUIT)
        (DESC "banana")
        (FLAGS TAKEBIT EDIBLEBIT)
        (SIZE 5)>

<OBJECT DESK
        (IN STARTROOM)
        (SYNONYM DESK TABLE)
        (DESC "desk")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)>

<OBJECT BUCKET
        (IN STARTROOM)
        (SYNONYM BUCKET PAIL)
        (DESC "bucket")
        (FLAGS CONTBIT OPENBIT TAKEBIT)
        (CAPACITY 20)>

<OBJECT CAGE
        (IN STARTROOM)
        (SYNONYM CAGE)
        (DESC "cage")
        (FLAGS CONTBIT TRANSBIT OPENABLEBIT TAKEBIT)
        (CAPACITY 20)>

<OBJECT BOX
        (IN STARTROOM)
        (SYNONYM BOX)
        (DESC "box")
        (FLAGS CONTBIT OPENABLEBIT TAKEBIT)
        (CAPACITY 20)>

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
    <ASSERT-TEXT "bucket" <CO-RESUME ,CO "examine bucket">>
    <ASSERT "Take the apple" <CO-RESUME ,CO "take apple" T> <==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT-TEXT "Done" <CO-RESUME ,CO "put apple in bucket">>
    <ASSERT-TEXT "apple" <CO-RESUME ,CO "look in bucket">>
    <ASSERT "Take apple from bucket" <CO-RESUME ,CO "take apple from bucket" T> <==? <LOC ,APPLE> ,ADVENTURER>>
    <ASSERT-TEXT "cage" <CO-RESUME ,CO "examine cage">>
    <ASSERT "Open the cage" <CO-RESUME ,CO "open cage" T> <FSET? ,CAGE ,OPENBIT>>
    <ASSERT-TEXT "Done" <CO-RESUME ,CO "put apple in cage">>
    <ASSERT "Close the cage" <CO-RESUME ,CO "close cage" T> <NOT <FSET? ,CAGE ,OPENBIT>>>
    <ASSERT-TEXT "closed" <CO-RESUME ,CO "take apple">>
    <ASSERT "Open cage again" <CO-RESUME ,CO "open cage" T> <FSET? ,CAGE ,OPENBIT>>
    <ASSERT "Take apple from opened cage" <CO-RESUME ,CO "take apple from cage" T> <==? <LOC ,APPLE> ,ADVENTURER>>
    <TELL CR "All tests completed!" CR>>
