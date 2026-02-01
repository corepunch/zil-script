<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "adventure/horror">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/main">

<CONSTANT RELEASEID 1>

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <TELL "Testing horror.zil failing conditions..." CR CR>
    
    ;"Test 1: Drawer cannot be opened without unlocking first"
    ;"Start at Reception Room"
    <SETG HERE ,RECEPTION-ROOM>
    <MOVE ,WINNER ,HERE>
    
    ;"Try opening locked drawer - command should fail, drawer remains closed (no OPENBIT)"
    <ASSERT "Try to open locked drawer (should fail - drawer is locked)" 
        <CO-RESUME ,CO "open drawer" T> 
        <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
    
    ;"Test 2: With key, drawer can be unlocked and opened"
    <ASSERT "Take the brass key" 
        <CO-RESUME ,CO "take key" T> 
        <==? <LOC ,BRASS-KEY> ,ADVENTURER>>
    
    ;"In horror.zil, the 'unlock' command both unlocks AND opens the drawer (sets OPENBIT)"
    <ASSERT "Unlock drawer with key (opens it)" 
        <CO-RESUME ,CO "unlock drawer with key" T> 
        <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
    
    ;"Test 3: Test at different location - Sanitarium Gate"
    <SETG HERE ,SANITARIUM-GATE>
    <MOVE ,WINNER ,HERE>
    
    <ASSERT "Move to Sanitarium Gate" 
        <CO-RESUME ,CO "look" T> 
        <==? ,HERE ,SANITARIUM-GATE>>
    
    <ASSERT "Verify plaque has TAKEBIT flag" 
        <FSET? ,BRASS-PLAQUE ,TAKEBIT>>
    
    <ASSERT "Take the brass plaque" 
        <CO-RESUME ,CO "take plaque" T> 
        <==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    <TELL CR "All horror failing conditions tests completed!" CR>>
