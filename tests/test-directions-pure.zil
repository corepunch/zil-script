<DIRECTIONS NORTH SOUTH EAST WEST UP DOWN IN OUT>
<CONSTANT RELEASEID 1>

;"Define common test objects inline"
<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROUTINE TEST-SETUP (ROOM-OBJ)
    <SETG HERE .ROOM-OBJ>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,ADVENTURER ,HERE>>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room for directions.")
      (NORTH TO HALLWAY)
      (IN TO HALLWAY)
      (FLAGS RLANDBIT ONBIT)>

<ROOM HALLWAY
      (IN ROOMS)
      (DESC "Hallway")
      (LDESC "A long hallway.")
      (NORTH TO CLOSET)
      (SOUTH TO STARTROOM)
      (IN TO CLOSET)
      (OUT TO STARTROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Closet")
      (LDESC "A small closet.")
      (SOUTH TO HALLWAY)
      (OUT TO HALLWAY)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE FRUIT)
        (DESC "apple")
        (FLAGS TAKEBIT VOWELBIT)>

<ROUTINE TEST-DIRECTIONS ()
    <TELL "Testing direction/movement..." CR CR>
    
    ;"Setup initial state"
    <TEST-SETUP ,STARTROOM>
    
    ;"Test starting location"
    <ASSERT <==? <LOC ,ADVENTURER> ,STARTROOM> "Start at STARTROOM">
    
    ;"Note: This tests the data structures, not the parser/movement commands"
    ;"For full parser testing, use the Lua wrapper test files"
    
    ;"Test room connections exist"
    <ASSERT <GETPT ,STARTROOM ,PQNORTH> "STARTROOM has NORTH exit">
    <ASSERT <GETPT ,HALLWAY ,PQSOUTH> "HALLWAY has SOUTH exit">
    <ASSERT <GETPT ,CLOSET ,PQOUT> "CLOSET has OUT exit">
    
    ;"Test object locations"
    <ASSERT <==? <LOC ,APPLE> ,STARTROOM> "Apple in STARTROOM">
    
    ;"Test manual movement"
    <MOVE ,ADVENTURER ,HALLWAY>
    <SETG HERE ,HALLWAY>
    <ASSERT <==? <LOC ,ADVENTURER> ,HALLWAY> "Moved to HALLWAY">
    <ASSERT <==? ,HERE ,HALLWAY> "HERE is HALLWAY">
    
    <MOVE ,ADVENTURER ,CLOSET>
    <SETG HERE ,CLOSET>
    <ASSERT <==? <LOC ,ADVENTURER> ,CLOSET> "Moved to CLOSET">
    
    <MOVE ,ADVENTURER ,HALLWAY>
    <SETG HERE ,HALLWAY>
    <ASSERT <==? <LOC ,ADVENTURER> ,HALLWAY> "Back to HALLWAY">
    
    <MOVE ,ADVENTURER ,STARTROOM>
    <SETG HERE ,STARTROOM>
    <ASSERT <==? <LOC ,ADVENTURER> ,STARTROOM> "Back to STARTROOM">
    
    <TELL CR "All tests completed!" CR>>

<ROUTINE GO ()
    <TEST-DIRECTIONS>>
