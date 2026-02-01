<DIRECTIONS NORTH SOUTH EAST WEST UP DOWN IN OUT>
<CONSTANT RELEASEID 1>

;"Include common test utilities"
<INSERT-FILE "test-utils">

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
    <TELL "Testing direction/movement commands..." CR CR>
    
    ;"Setup initial state"
    <TEST-SETUP ,STARTROOM>
    
    ;"Test starting location"
    <ASSERT-AT-LOCATION ,ADVENTURER ,STARTROOM "Start at STARTROOM">
    
    ;"Note: This is a pure ZIL test - it tests the data structures"
    ;"not the actual parser/movement commands. For full parser testing,"
    ;"use the Lua wrapper test files like test-directions.lua"
    
    ;"Test room connections exist"
    <ASSERT-TRUE <GETPT ,STARTROOM ,PQNORTH> "STARTROOM has NORTH exit">
    <ASSERT-TRUE <GETPT ,HALLWAY ,PQSOUTH> "HALLWAY has SOUTH exit">
    <ASSERT-TRUE <GETPT ,CLOSET ,PQOUT> "CLOSET has OUT exit">
    
    ;"Test object locations"
    <ASSERT-AT-LOCATION ,APPLE ,STARTROOM "Apple in STARTROOM">
    
    ;"Test manual movement"
    <MOVE ,ADVENTURER ,HALLWAY>
    <SETG HERE ,HALLWAY>
    <ASSERT-AT-LOCATION ,ADVENTURER ,HALLWAY "Moved to HALLWAY">
    <ASSERT-EQUAL ,HERE ,HALLWAY "HERE is HALLWAY">
    
    <MOVE ,ADVENTURER ,CLOSET>
    <SETG HERE ,CLOSET>
    <ASSERT-AT-LOCATION ,ADVENTURER ,CLOSET "Moved to CLOSET">
    
    <MOVE ,ADVENTURER ,HALLWAY>
    <SETG HERE ,HALLWAY>
    <ASSERT-AT-LOCATION ,ADVENTURER ,HALLWAY "Back to HALLWAY">
    
    <MOVE ,ADVENTURER ,STARTROOM>
    <SETG HERE ,STARTROOM>
    <ASSERT-AT-LOCATION ,ADVENTURER ,STARTROOM "Back to STARTROOM">
    
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-DIRECTIONS>>
