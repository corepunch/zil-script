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
    <TELL "Testing check commands behavior..." CR CR>
    
    ;"Start game"
    <CO-RESUME ,CO "look">
    
    ;"Test check-inventory when object is NOT in inventory (plaque not taken yet)"
    <ASSERT "Plaque NOT in inventory initially" <N==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Take the plaque"
    <ASSERT "Take brass plaque" <CO-RESUME ,CO "take plaque" T> <==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Test check-inventory when object IS in inventory"
    <ASSERT "Plaque IS in inventory after taking" <==? <LOC ,BRASS-PLAQUE> ,ADVENTURER>>
    
    ;"Move to reception room to test flags"
    <ASSERT "Enter sanitarium" <CO-RESUME ,CO "north" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "Go to reception room" <CO-RESUME ,CO "west" T> <==? ,HERE ,RECEPTION-ROOM>>
    
    ;"Test check-flag when flag is NOT set"
    <ASSERT "Drawer is NOT open initially" <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>>
    
    ;"Take the key"
    <ASSERT "Take brass key" <CO-RESUME ,CO "take key" T> <==? <LOC ,BRASS-KEY> ,ADVENTURER>>
    
    ;"Unlock and open drawer - the unlock command both unlocks AND opens it"
    <ASSERT "Unlock drawer with key (opens it)" <CO-RESUME ,CO "unlock drawer with key" T> <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
    
    ;"Test check-location when object is at the location"
    <ASSERT "Ledger is in drawer" <==? <LOC ,PATIENT-LEDGER> ,BOTTOM-DRAWER>>
    
    ;"Test check-location when object is NOT at the location"
    <ASSERT "Ledger is NOT at sanitarium gate" <N==? <LOC ,PATIENT-LEDGER> ,SANITARIUM-GATE>>
    
    <TELL CR "All check command tests completed!" CR>>
