<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<OBJECT ADVENTURER
        (DESC "you")
        (SYNONYM ADVENTURER ME SELF)
        (FLAGS)>

<ROOM TESTROOM
      (IN ROOMS)
      (DESC "Test Room")
      (LDESC "A test room for pure ZIL testing.")
      (FLAGS RLANDBIT ONBIT)>

<OBJECT APPLE
        (IN TESTROOM)
        (SYNONYM APPLE FRUIT)
        (ADJECTIVE RED)
        (DESC "red apple")
        (FLAGS TAKEBIT VOWELBIT)
        (SIZE 5)>

<OBJECT BANANA
        (IN TESTROOM)
        (SYNONYM BANANA)
        (ADJECTIVE YELLOW)
        (DESC "yellow banana")
        (FLAGS TAKEBIT)
        (SIZE 5)>

<OBJECT ROCK
        (IN TESTROOM)
        (SYNONYM ROCK STONE)
        (DESC "heavy rock")
        (FLAGS )
        (SIZE 100)>

<ROUTINE TEST-ASSERTIONS ()
    <TELL "Running pure ZIL test assertions..." CR CR>
    
    ;"Test basic assertions"
    <ASSERT-TRUE T "Basic true assertion">
    <ASSERT-FALSE <> "Basic false assertion">
    <ASSERT-EQUAL 5 5 "Numbers are equal">
    <ASSERT-NOT-EQUAL 3 5 "Numbers are not equal">
    
    ;"Test object location assertions"
    <ASSERT-AT-LOCATION ,APPLE ,TESTROOM "Apple is in test room">
    <ASSERT-AT-LOCATION ,BANANA ,TESTROOM "Banana is in test room">
    
    ;"Test flag assertions"
    <ASSERT-HAS-FLAG ,APPLE ,TAKEBIT "Apple has TAKEBIT">
    <ASSERT-NOT-HAS-FLAG ,ROCK ,TAKEBIT "Rock does not have TAKEBIT">
    
    ;"Test inventory - initially nothing in inventory"
    <ASSERT-NOT-IN-INVENTORY ,APPLE "Apple not in inventory initially">
    
    ;"Move apple to inventory and test"
    <MOVE ,APPLE ,ADVENTURER>
    <ASSERT-IN-INVENTORY ,APPLE "Apple now in inventory">
    <ASSERT-AT-LOCATION ,APPLE ,ADVENTURER "Apple is with adventurer">
    
    ;"Move banana to inventory"
    <MOVE ,BANANA ,ADVENTURER>
    <ASSERT-IN-INVENTORY ,BANANA "Banana now in inventory">
    
    ;"Remove apple from inventory"
    <MOVE ,APPLE ,TESTROOM>
    <ASSERT-NOT-IN-INVENTORY ,APPLE "Apple removed from inventory">
    <ASSERT-IN-INVENTORY ,BANANA "Banana still in inventory">
    
    ;"Print summary and exit"
    <TEST-SUMMARY>>

<ROUTINE GO ()
    <SETG HERE ,TESTROOM>
    <SETG LIT T>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,ADVENTURER ,HERE>
    
    ;"Run the tests instead of starting the game loop"
    <TEST-ASSERTIONS>>
