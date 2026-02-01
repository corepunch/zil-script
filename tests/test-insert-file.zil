<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

;"Include common test utilities"
<INSERT-FILE "test-utils">

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A test room.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN STARTROOM)
        (SYNONYM APPLE)
        (DESC "apple")
        (FLAGS TAKEBIT)>

<ROUTINE TEST-WITH-INSERT-FILE ()
    <TELL "Testing INSERT-FILE functionality..." CR CR>
    
    ;"Test that ADVENTURER is available from included file"
    <ASSERT-TRUE ,ADVENTURER "ADVENTURER object exists from included file">
    
    ;"Test that TEST-SETUP routine is available"
    <TEST-SETUP ,STARTROOM>
    <ASSERT-AT-LOCATION ,ADVENTURER ,STARTROOM "ADVENTURER at STARTROOM after TEST-SETUP">
    <ASSERT-EQUAL ,HERE ,STARTROOM "HERE is STARTROOM">
    
    ;"Test basic functionality"
    <ASSERT-AT-LOCATION ,APPLE ,STARTROOM "Apple in STARTROOM">
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT-IN-INVENTORY ,APPLE "Apple in inventory">
    
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <TEST-WITH-INSERT-FILE>>
