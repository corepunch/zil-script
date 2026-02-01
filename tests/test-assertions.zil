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
    <TELL "Testing assertion commands..." CR CR>
    
    ;"Start game"
    <CO-RESUME ,CO "look">
    
    ;"Test assert-inventory with false expectation (should pass - plaque not in inventory yet)"
    <ASSERT "Brass plaque NOT in inventory initially" <N==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Take the plaque"
    <ASSERT "Take brass plaque" <CO-RESUME ,CO "take plaque" T> <==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Test assert-inventory with true expectation (should pass - plaque now in inventory)"
    <ASSERT "Brass plaque IS in inventory after taking" <==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Move to reception room"
    <ASSERT "Enter sanitarium" <CO-RESUME ,CO "north" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "Go to reception room" <CO-RESUME ,CO "west" T> <==? ,HERE ,RECEPTION-ROOM>>
    
    ;"Take the key"
    <ASSERT "Take brass key" <CO-RESUME ,CO "take key" T> <==? <LOC ,BRASS-KEY> ,ADVENTURER>>
    
    ;"Check drawer is NOT open yet (should pass)"
    <ASSERT "Drawer is NOT open initially" <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
    
    ;"Unlock and open drawer - the unlock command both unlocks AND opens it"
    <ASSERT "Unlock drawer with key (opens it)" <CO-RESUME ,CO "unlock drawer with key" T> <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
    
    ;"Check ledger location (should pass - ledger should be in drawer)"
    <ASSERT "Ledger is in drawer" <==? <LOC ,PATIENT-LEDGER> ,BOTTOM-DRAWER>>
    
    <TELL CR "All assertion tests completed!" CR>>
