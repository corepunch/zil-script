<DIRECTIONS NORTH SOUTH EAST WEST>
<CONSTANT RELEASEID 1>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room for the TAKE command.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE FRUIT)
        (ADJECTIVE RED)
        (DESC "red apple")
        (LDESC "A shiny red apple.")
        (FLAGS TAKEBIT EDIBLEBIT VOWELBIT)
        (SIZE 5)>

<OBJECT BANANA
        (IN STARTROOM)
        (SYNONYM BANANA FRUIT)
        (ADJECTIVE YELLOW)
        (DESC "yellow banana")
        (LDESC "A ripe yellow banana.")
        (FLAGS TAKEBIT EDIBLEBIT)
        (SIZE 5)>

<OBJECT DESK
        (IN STARTROOM)
        (SYNONYM DESK TABLE)
        (ADJECTIVE WOODEN)
        (DESC "wooden desk")
        (LDESC "A sturdy wooden desk.")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)>

<OBJECT BUCKET
        (IN STARTROOM)
        (SYNONYM BUCKET PAIL)
        (ADJECTIVE METAL)
        (DESC "metal bucket")
        (LDESC "A metal bucket.")
        (FLAGS CONTBIT OPENBIT TAKEBIT)
        (SIZE 10)>

<OBJECT CAGE
        (IN STARTROOM)
        (SYNONYM CAGE)
        (ADJECTIVE WIRE)
        (DESC "wire cage")
        (LDESC "A wire cage with a door.")
        (FLAGS CONTBIT TRANSBIT OPENABLEBIT TAKEBIT)
        (SIZE 15)>

<ROUTINE GO ()
    <SETG HERE ,STARTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>
