<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN TESTROOM)
        (SYNONYM APPLE)
        (DESC "apple")
        (FLAGS TAKEBIT)>

<ROUTINE GO ()
    <TELL "Testing ASSERT function..." CR CR>
    
    ;"Basic assertions using ASSERT"
    <ASSERT T "Basic true assertion">
    <ASSERT <NOT <>> "Basic false assertion">
    <ASSERT <==? 5 5> "Numbers are equal">
    <ASSERT <N==? 3 5> "Numbers are not equal">
    
    ;"Test object location"
    <SETG HERE ,TESTROOM>
    <SETG WINNER ,ADVENTURER>
    <MOVE ,ADVENTURER ,HERE>
    
    <ASSERT <==? <LOC ,ADVENTURER> ,TESTROOM> "Adventurer at test room">
    <ASSERT <==? ,HERE ,TESTROOM> "HERE is test room">
    
    ;"Test flag"
    <ASSERT <FSET? ,APPLE ,TAKEBIT> "Apple has TAKEBIT">
    
    ;"Test inventory"
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT <==? <LOC ,APPLE> ,ADVENTURER> "Apple in inventory">
    
    <TELL CR "All tests completed!" CR>>
