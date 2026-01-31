<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

<ROOM SANITARIUM-GATE
      (IN ROOMS)
      (DESC "Sanitarium Gate")
      (LDESC "You stand before the rusted iron gates of an abandoned sanitarium. The structure looms against the darkening sky, its windows like hollow eye sockets. Weeds choke the gravel path leading north to the entrance.")
      (NORTH TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)>
<OBJECT BRASS-PLAQUE
        (IN SANITARIUM-GATE)
        (SYNONYM PLAQUE BRASS SIGN)
        (ADJECTIVE BRASS CORRODED)
        (DESC "brass plaque")
        (LDESC "A corroded brass plaque hangs askew on the gate.")
        (FLAGS READBIT TAKEBIT)
        (TEXT "The plaque reads: 'Blackwood Sanitarium - Est. 1898 - Closed by Order 1952'")
        (SIZE 5)>
<ROOM SANITARIUM-ENTRANCE
      (IN ROOMS)
      (DESC "Sanitarium Entrance Hall")
      (LDESC "The entrance hall reeks of mildew and decay. A grand staircase ascends to darkness in the east. To the west, a doorway leads to what might have been a reception area. North, you can make out an operating theater through a half-open door. A narrow staircase descends into the basement.")
      (SOUTH TO SANITARIUM-GATE)
      (WEST TO RECEPTION-ROOM)
      (NORTH TO OPERATING-THEATER)
      (EAST TO PATIENT-WARD)
      (DOWN TO BASEMENT-STAIRS)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT WALLPAPER
        (IN SANITARIUM-ENTRANCE)
        (SYNONYM WALLPAPER PAPER PLASTER)
        (ADJECTIVE PEELING)
        (DESC "peeling wallpaper")
        (LDESC "Peeling wallpaper reveals water-stained plaster beneath.")
        (TEXT "Victorian-era wallpaper depicting pastoral scenes, now grotesquely warped by moisture and black mold.")>
<ROOM RECEPTION-ROOM
      (IN ROOMS)
      (DESC "Reception Room")
      (LDESC "This cramped room once served as the sanitarium's reception. Filing cabinets line the opposite wall, their drawers hanging open like gaping mouths. Something glints among the papers scattered on the floor. A doorway to the east opens back to the entrance hall.")
      (EAST TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The desk has three drawers. The top two are broken and empty. The bottom drawer is intact but locked." CR>
                <RTRUE>)>>
<OBJECT OAK-DESK
        (IN RECEPTION-ROOM)
        (SYNONYM DESK)
        (ADJECTIVE HEAVY OAK)
        (DESC "oak desk")
        (LDESC "A heavy oak desk sits against one wall, its surface thick with dust.")
        (FLAGS CONTBIT OPENBIT SURFACEBIT)
        (TEXT "The desk has three drawers. The top two are broken and empty. The bottom drawer appears intact but is locked tight.")
        (ACTION DESK-F)>
<ROUTINE DESK-DRAWER-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,DESK-DRAWER ,OPENBIT>>>
                <TELL "The bottom drawer of the desk is locked. The keyhole has the number '3' engraved beside it." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,DESK-DRAWER ,OPENBIT>>
                <TELL "The drawer is open. " <COND (<IN? ,PATIENT-FILE ,DESK-DRAWER> <TELL "Inside is a file folder.">)(<ELSE> <TELL "It's empty now.">)> CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,DESK-DRAWER ,OPENBIT>>
                     <NOT <IN? ,BRASS-KEY ,WINNER>>>
                <TELL "The drawer is locked. You need a key with the number '3' on it." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,DESK-DRAWER ,OPENBIT>>
                     <IN? ,BRASS-KEY ,WINNER>>
                <TELL "You insert the brass key into the lock. It turns smoothly. The drawer slides open, revealing an old file folder inside." CR>
                <FSET ,DESK-DRAWER ,OPENBIT>
                <RTRUE>)>>
<OBJECT DESK-DRAWER
        (IN RECEPTION-ROOM)
        (SYNONYM DRAWER)
        (ADJECTIVE BOTTOM LOCKED DESK)
        (DESC "desk drawer")
        (LDESC "The bottom drawer of the oak desk is locked.")
        (FLAGS CONTBIT OPENABLEBIT)
        (CAPACITY 10)
        (ACTION DESK-DRAWER-F)>
<ROUTINE PATIENT-FILE-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "A file folder labeled 'Patient 189 - CONFIDENTIAL'. Inside are medical records and notes. 'Subject shows extraordinary resistance to pain. Mental state deteriorating. Recommending transfer to isolation wing. Dr. Mordecai has expressed personal interest in this case. Update: Patient transferred to chapel for experimental treatment. Nov 1, 1952.'" CR>
                <RTRUE>)>>
<OBJECT PATIENT-FILE
        (IN DESK-DRAWER)
        (SYNONYM FILE FOLDER RECORDS)
        (ADJECTIVE PATIENT CONFIDENTIAL)
        (DESC "patient file")
        (LDESC "A file folder marked 'Patient 189 - CONFIDENTIAL'.")
        (FLAGS TAKEBIT READBIT)
        (SIZE 3)
        (ACTION PATIENT-FILE-F)>
<OBJECT BRASS-KEY
        (IN RECEPTION-ROOM)
        (SYNONYM KEY)
        (ADJECTIVE BRASS SMALL)
        (DESC "brass key")
        (LDESC "A small brass key lies among the scattered papers on the floor, cold to the touch.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (TEXT "A small brass key with the number '3' engraved on its head. It's ice cold despite being indoors.")>
<ROOM OPERATING-THEATER
      (IN ROOMS)
      (DESC "Operating Theater")
      (LDESC "The circular theater has rusty surgical instruments scattered about. Rising tiers of benches circle the area, where students once observed procedures. The air here is thick with an oppressive dread.")
      (SOUTH TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT OPERATING-TABLE
        (IN OPERATING-THEATER)
        (SYNONYM TABLE)
        (ADJECTIVE OPERATING STAINED)
        (DESC "operating table")
        (LDESC "A stained operating table dominates the center of the room.")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)
        (TEXT "The operating table is covered in dark brown stains that you hope are just rust. Leather restraints dangle from all four corners. Deep gouges mar the metal surface, as if someone struggled violently against the bindings.")>
<ROUTINE CABINET-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The cabinet's glass doors are cracked but still intact. Inside, you can see various medical instruments, including a scalpel and a bottle." CR>
                <RTRUE>)>>
<OBJECT METAL-CABINET
        (IN OPERATING-THEATER)
        (SYNONYM CABINET)
        (ADJECTIVE METAL MEDICAL)
        (DESC "metal cabinet")
        (LDESC "A metal cabinet stands in the shadows, its door slightly ajar.")
        (FLAGS CONTBIT OPENBIT TRANSBIT)
        (ACTION CABINET-F)>
<ROOM PATIENT-WARD
      (IN ROOMS)
      (DESC "Patient Ward")
      (LDESC "A long corridor with tattered curtains hanging between areas, offering the ghost of privacy. The floor is littered with patient records and broken glass.")
      (WEST TO SANITARIUM-ENTRANCE)
      (NORTH TO MORGUE IF CHAINS-CUT-FLAG)
      (FLAGS RLANDBIT ONBIT)>
<OBJECT BED-FRAMES
        (IN PATIENT-WARD)
        (SYNONYM BEDS FRAMES BED FRAME)
        (ADJECTIVE RUSTED)
        (DESC "bed frames")
        (LDESC "Rusted bed frames line the corridor.")
        (TEXT "Dozens of bed frames line the walls. The mattresses have rotted away, leaving only rusted springs and metal frames. Some still have restraint straps attached.")>
<ROUTINE HEAVYDOOR-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The heavy door is secured with thick chains and a rusted padlock. Deep scratches cover its surface, made by fingernails. A tarnished plaque reads 'MORGUE'." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAINS-CUT-FLAG>
                <TELL "The door stands open, chains lying in a heap on the floor. Beyond lies darkness." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The door is secured with heavy chains. You need to cut through them." CR>
                <RTRUE>)
               (<VERB? KNOCK>
                <TELL "You knock on the door. The sound echoes hollowly. No response comes from within." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "You press your ear to the door. From beyond comes an eerie silence—too complete, too absolute." CR>
                <RTRUE>)>>
<OBJECT HEAVY-DOOR
        (IN PATIENT-WARD)
        (SYNONYM DOOR)
        (ADJECTIVE HEAVY SEALED LOCKED MORGUE)
        (DESC "heavy door")
        (LDESC "At the far end, a heavy door sealed with chains blocks further passage. Scratches cover the door's surface, as if made by desperate fingers.")
        (ACTION HEAVYDOOR-F)>
<ROUTINE CHAINS-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "Thick iron chains wrap around the door handles, secured with a massive rusted padlock. The chains look old but still strong." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK>
                     <NOT ,CHAINS-CUT-FLAG>
                     <NOT <IN? ,SCALPEL ,WINNER>>>
                <TELL "The chains are too strong to break with your bare hands. You need a sharp tool." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK>
                     <NOT ,CHAINS-CUT-FLAG>
                     <IN? ,SCALPEL ,WINNER>>
                <TELL "You saw through the rusty chains with the " D ,SCALPEL ". It takes several minutes of effort, but finally they fall away with a crash. The heavy door creaks open, revealing a passage north into darkness." CR>
                <SETG CHAINS-CUT-FLAG T>
                <REMOVE ,CHAINS>
                <RTRUE>)>>
<OBJECT CHAINS
        (IN PATIENT-WARD)
        (SYNONYM CHAINS CHAIN PADLOCK)
        (ADJECTIVE THICK)
        (DESC "chains")
        (LDESC "Thick chains secure the heavy door.")
        (ACTION CHAINS-F)>
<ROOM MORGUE
      (IN ROOMS)
      (DESC "Morgue")
      (LDESC "The temperature drops as you enter the morgue. Medical instruments hang on the wall. This place feels wrong, as though something lingers here still. The only exit is a passage leading south to the patient ward.")
      (SOUTH TO PATIENT-WARD)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE DRAWERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The refrigeration units line both walls. Most drawers are empty or contain only bones. One drawer is slightly ajar, a faint luminescent glow emanating from within." CR>
                <RTRUE>)>>
<OBJECT REFRIGERATED-DRAWERS
        (IN MORGUE)
        (SYNONYM DRAWERS DRAWER REFRIGERATOR)
        (ADJECTIVE REFRIGERATED METAL)
        (DESC "refrigerated drawers")
        (LDESC "Refrigerated drawers line both walls.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION DRAWERS-F)>
<ROUTINE DISTABLE-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The dissection table is made of stainless steel with drainage channels carved into its surface. Dark stains pool in the grooves. A canvas-wrapped bundle lies upon it." CR>
                <RTRUE>)>>
<OBJECT DISSECTION-TABLE
        (IN MORGUE)
        (SYNONYM TABLE)
        (ADJECTIVE DISSECTION AUTOPSY)
        (DESC "dissection table")
        (LDESC "In the center, a dissection table holds what appears to be a canvas-wrapped bundle.")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)
        (ACTION DISTABLE-F)>
<ROUTINE JOURNAL-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "Dr. Mordecai's personal journal. The final entry is dated October 31, 1952. The handwriting becomes increasingly erratic: 'The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.'" CR>
                <RTRUE>)>>
<OBJECT MORDECAI-JOURNAL
        (IN MORGUE)
        (SYNONYM JOURNAL DIARY NOTEBOOK BOOK)
        (ADJECTIVE DOCTOR MORDECAI)
        (DESC "doctor's journal")
        (LDESC "A journal rests on a small desk in the corner.")
        (FLAGS READBIT TAKEBIT)
        (TEXT "The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.")
        (SIZE 6)
        (ACTION JOURNAL-F)>
<ROOM BASEMENT-STAIRS
      (IN ROOMS)
      (DESC "Basement Stairs")
      (LDESC "A narrow stone staircase descends into darkness. The air grows colder with each step. Moisture drips from the ceiling, and the walls are slick with condensation. The stairs lead down into the basement, while the entrance hall lies to the south.")
      (UP TO SANITARIUM-ENTRANCE)
      (DOWN TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>
<ROOM BASEMENT-CORRIDOR
      (IN ROOMS)
      (DESC "Basement Corridor")
      (LDESC "The basement corridor is pitch black, stretching into shadow. Water pools on the cracked floor. Stone stairs climb upward into darkness. To the east, a passage leads toward the sound of dripping water. West lies what might have been storage. North, another corridor descends toward deeper chambers.")
      (UP TO BASEMENT-STAIRS)
      (EAST TO BOILER-ROOM)
      (WEST TO STORAGE-ROOM)
      (NORTH TO FLOODING-CHAMBER)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE PIPES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The pipes are ancient and corroded. Water drips steadily from cracks in the metal. One pipe has a valve." CR>
                <RTRUE>)>>
<OBJECT PIPES
        (IN BASEMENT-CORRIDOR)
        (SYNONYM PIPES PIPE CEILING)
        (ADJECTIVE RUSTED DRIPPING)
        (DESC "rusty pipes")
        (LDESC "Pipes run along the ceiling, rusted and dripping.")
        (ACTION PIPES-F)>
<ROUTINE VALVE-F ()
         <COND (<AND <VERB? TURN>
                     <NOT ,VALVE-TURNED-FLAG>>
                <TELL "You grip the " D ,VALVE " and turn with all your strength. It resists, then suddenly gives way with a shriek of metal. Steam hisses from somewhere below." CR>
                <SETG VALVE-TURNED-FLAG T>
                <RTRUE>)
               (<AND <VERB? TURN>
                     ,VALVE-TURNED-FLAG>
                <TELL "The " D ,VALVE " is already open. Steam continues to hiss somewhere in the basement." CR>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A large wheel valve covered in rust and grime." CR>
                <RTRUE>)>>
<OBJECT VALVE
        (IN BASEMENT-CORRIDOR)
        (SYNONYM VALVE WHEEL)
        (ADJECTIVE PIPE METAL)
        (DESC "metal valve")
        (LDESC "A wheel valve on one of the pipes, crusted with rust.")
        (FLAGS TURNBIT)
        (ACTION VALVE-F)>
<ROOM BOILER-ROOM
      (IN ROOMS)
      (DESC "Boiler Room")
      (LDESC "This dark room is thick with coal dust that covers everything. The room radiates a sense of dormant power, waiting to awaken. A narrow doorway to the west leads back out to the corridor.")
      (WEST TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE BOILER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The boiler is a hulking iron beast. Its door hangs open, revealing a chamber black with ancient soot. Inside, something gleams faintly." CR>
                <RTRUE>)>>
<OBJECT IRON-BOILER
        (IN BOILER-ROOM)
        (SYNONYM BOILER FURNACE)
        (ADJECTIVE IRON MASSIVE)
        (DESC "iron boiler")
        (LDESC "A massive iron boiler dominates the room, cold and silent.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION BOILER-F)>
<ROUTINE WORKBENCH-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The workbench is covered with ancient tools: hammers, wrenches, screwdrivers. Most are rusted solid. A flashlight lies among them." CR>
                <RTRUE>)>>
<OBJECT WORKBENCH
        (IN BOILER-ROOM)
        (SYNONYM BENCH TABLE WORKBENCH)
        (ADJECTIVE WORK)
        (DESC "workbench")
        (LDESC "A workbench sits against the far wall, covered with ancient tools.")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)
        (ACTION WORKBENCH-F)>
<ROOM STORAGE-ROOM
      (IN ROOMS)
      (DESC "Storage Room")
      (LDESC "This dark storage room is filled with old linens, rusted equipment, and unidentifiable containers in every space. A sour smell permeates the air. The exit lies to the east.")
      (EAST TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE SHELVES-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
                <TELL "You search through the shelves. Most items are ruined by time and moisture. Among the debris, you find a lantern, a medical bag, and some old medical records." CR>
                <RTRUE>)>>
<OBJECT SHELVES
        (IN STORAGE-ROOM)
        (SYNONYM SHELVES SHELF)
        (ADJECTIVE SAGGING)
        (DESC "shelves")
        (LDESC "Shelves line the walls, sagging under the weight of moldering supplies.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION SHELVES-F)>
<ROUTINE MEDICAL-BAG-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "An old leather doctor's bag, cracked and worn.">
                <COND (<FSET? ,MEDICAL-BAG ,OPENBIT>
                       <TELL " Looking inside, you can see">
                       <COND (<IN? ,BANDAGES ,MEDICAL-BAG>
                              <TELL " some bandages">)>
                       <COND (<AND <IN? ,MORPHINE-VIAL ,MEDICAL-BAG>
                                   <IN? ,BANDAGES ,MEDICAL-BAG>>
                              <TELL " and">)>
                       <COND (<IN? ,MORPHINE-VIAL ,MEDICAL-BAG>
                              <TELL " a vial">)>
                       <TELL ".">)>
                <CRLF>
                <RTRUE>)>>
<OBJECT MEDICAL-BAG
        (IN SHELVES)
        (SYNONYM BAG SATCHEL)
        (ADJECTIVE MEDICAL LEATHER DOCTOR)
        (DESC "medical bag")
        (LDESC "An old leather medical bag sits on one of the shelves.")
        (FLAGS CONTBIT OPENABLEBIT OPENBIT TAKEBIT)
        (CAPACITY 15)
        (SIZE 10)
        (ACTION MEDICAL-BAG-F)>
<ROUTINE BANDAGES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "Yellowed cloth bandages, surprisingly clean despite their age. They might still be useful." CR>
                <RTRUE>)>>
<OBJECT BANDAGES
        (IN MEDICAL-BAG)
        (SYNONYM BANDAGES BANDAGE CLOTH)
        (ADJECTIVE YELLOWED CLEAN)
        (DESC "bandages")
        (LDESC "Clean bandages wrapped in yellowed cloth.")
        (FLAGS TAKEBIT)
        (SIZE 3)
        (ACTION BANDAGES-F)>
<ROUTINE MORPHINE-VIAL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small glass vial labeled 'Morphine Sulfate - 10mg'. The seal is intact." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "You're not desperate enough to start taking random drugs from an abandoned sanitarium." CR>
                <RTRUE>)>>
<OBJECT MORPHINE-VIAL
        (IN MEDICAL-BAG)
        (SYNONYM VIAL MORPHINE BOTTLE)
        (ADJECTIVE GLASS SMALL)
        (DESC "morphine vial")
        (LDESC "A sealed glass vial of morphine.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION MORPHINE-VIAL-F)>
<ROOM FLOODING-CHAMBER
      (IN ROOMS)
      (DESC "Flooded Chamber")
      (LDESC "Water covers the floor to ankle depth. The chamber is vast and dark, with arched stone ceilings disappearing into shadow. The source of the water is unclear. To the north, a narrow passage disappears into darkness. The corridor lies to the south.")
      (SOUTH TO BASEMENT-CORRIDOR)
      (NORTH TO ISOLATION-WARD)
      (EAST TO HYDROTHERAPY-ROOM IF STEAM-DOOR-OPEN)
      (FLAGS RLANDBIT)>
<ROUTINE STANDING-WATER-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The water is cold and murky. You can't see the bottom through the darkness." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "The water smells foul. You decide against it." CR>
                <RTRUE>)>>
<OBJECT STANDING-WATER
        (IN FLOODING-CHAMBER)
        (SYNONYM WATER FLOOD PUDDLE)
        (ADJECTIVE STANDING ANKLE)
        (DESC "standing water")
        (LDESC "Cold water covering the floor.")
        (ACTION STANDING-WATER-F)>
<ROUTINE SEALED-DOOR-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,STEAM-DOOR-OPEN>>
                <TELL "The " D ,SEALED-DOOR " is sealed shut, corroded in place. Steam might loosen it." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,STEAM-DOOR-OPEN>
                <TELL "The " D ,SEALED-DOOR " stands open, steam still wisping from its edges." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,STEAM-DOOR-OPEN>
                     <NOT ,VALVE-TURNED-FLAG>>
                <TELL "The " D ,SEALED-DOOR " won't budge. It's corroded shut." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,STEAM-DOOR-OPEN>
                     ,VALVE-TURNED-FLAG>
                <TELL "The steam from the opened " D ,VALVE " has loosened the corrosion. With effort, you wrench the " D ,SEALED-DOOR " open. It leads to a hydrotherapy room." CR>
                <SETG STEAM-DOOR-OPEN T>
                <RTRUE>)>>
<OBJECT SEALED-DOOR
        (IN FLOODING-CHAMBER)
        (SYNONYM DOOR)
        (ADJECTIVE SEALED EAST METAL)
        (DESC "sealed door")
        (LDESC "A door to the east is sealed shut.")
        (ACTION SEALED-DOOR-F)>
<ROOM HYDROTHERAPY-ROOM
      (IN ROOMS)
      (DESC "Hydrotherapy Room")
      (LDESC "Rubber hoses dangle from fixtures overhead. The tiles are cracked and stained. A doorway to the west opens back into the flooded chamber.")
      (WEST TO FLOODING-CHAMBER)
      (FLAGS RLANDBIT)>
<ROUTINE TUBS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The tubs are large enough to immerse a full-grown person. Leather restraints are bolted to the sides. Dark stains ring the waterline. One tub contains a soggy notebook." CR>
                <RTRUE>)>>
<OBJECT PORCELAIN-TUBS
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM TUBS TUB BATH)
        (ADJECTIVE PORCELAIN)
        (DESC "porcelain tubs")
        (LDESC "Large porcelain tubs line the walls, each fitted with restraints.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION TUBS-F)>
<ROUTINE MEDICINE-CABINET-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The cabinet contains old medical supplies. Most are ruined, but a syringe and bandages remain usable." CR>
                <RTRUE>)>>
<OBJECT MEDICINE-CABINET
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM CABINET CUPBOARD)
        (ADJECTIVE MEDICINE MEDICAL)
        (DESC "medicine cabinet")
        (LDESC "A cabinet stands in the corner, its door hanging loose.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION MEDICINE-CABINET-F)>
<ROOM ISOLATION-WARD
      (IN ROOMS)
      (DESC "Isolation Ward")
      (LDESC "Small cells line both sides of a narrow corridor. Scratches cover the walls—thousands of them, as if someone counted the days. The corridor continues north to the electroshock theater.")
      (SOUTH TO FLOODING-CHAMBER)
      (NORTH TO ELECTROSHOCK-THEATER)
      (FLAGS RLANDBIT)>
<ROUTINE CELL-DOORS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Each door is solid metal with a small barred window. The cells beyond are empty save for scratches covering every surface. Someone marked time here, day after agonizing day." CR>
                <RTRUE>)>>
<OBJECT CELL-DOORS
        (IN ISOLATION-WARD)
        (SYNONYM DOORS DOOR CELLS)
        (ADJECTIVE CELL HEAVY BARRED)
        (DESC "cell doors")
        (LDESC "Heavy doors with barred windows stand open, revealing bare concrete rooms within.")
        (ACTION CELL-DOORS-F)>
<ROUTINE WALL-SCRATCHES-F ()
         <COND (<VERB? EXAMINE COUNT>
                <TELL "The scratches are too numerous to count. They cover every inch of the cell walls. Some form words: 'HELP ME' 'NO MORE' 'PLEASE'. One message is larger than the rest: 'PATIENT 189 STILL ALIVE IN THE CHAPEL'." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You run your fingers over the scratches. They're deep—gouged by fingernails over years of desperation." CR>
                <RTRUE>)
               (<VERB? READ>
                <TELL "Among the chaos of scratches, you can make out words: 'HELP ME' 'NO MORE' 'PLEASE'. The largest message reads: 'PATIENT 189 STILL ALIVE IN THE CHAPEL'." CR>
                <RTRUE>)>>
<OBJECT WALL-SCRATCHES
        (IN ISOLATION-WARD)
        (SYNONYM SCRATCHES MARKS TALLIES)
        (ADJECTIVE WALL)
        (DESC "wall scratches")
        (LDESC "Thousands of scratch marks covering the cell walls.")
        (ACTION WALL-SCRATCHES-F)>
<ROOM ELECTROSHOCK-THEATER
      (IN ROOMS)
      (DESC "Electroshock Theater")
      (LDESC "A concrete room. The walls are scorched in places. A viewing window overlooks the room from above. To the east, a stairway climbs upward. West, a heavy door stands ajar, revealing a padded cell beyond. A passage to the south leads out to the isolation ward.")
      (SOUTH TO ISOLATION-WARD)
      (EAST TO OBSERVATION-DECK)
      (WEST TO PADDED-CELL)
      (FLAGS RLANDBIT)>
<ROUTINE SHOCK-CHAIR-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The chair is bolted to the floor. Leather restraints hang from the arms and legs. Electrodes are positioned where they would contact a victim's temples. You feel sick looking at it." CR>
                <RTRUE>)
               (<VERB? BOARD>
                <TELL "You have no desire to sit in that terrible chair." CR>
                <RTRUE>)
               (<VERB? SIT>
                <TELL "You have no desire to sit in that terrible chair." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch the cold metal armrest. The leather restraints feel disturbingly well-worn. You pull your hand away quickly." CR>
                <RTRUE>)
               (<VERB? PUSH PULL>
                <TELL "The chair is bolted firmly to the floor. It doesn't budge." CR>
                <RTRUE>)>>
<OBJECT SHOCK-CHAIR
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM CHAIR)
        (ADJECTIVE SHOCK ELECTRIC METAL)
        (DESC "electroshock chair")
        (LDESC "A chair is bolted to the floor in the center of the room.")
        (ACTION SHOCK-CHAIR-F)>
<ROUTINE SHOCK-MACHINE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The machine has various dials and switches. Labels indicate voltage levels up to dangerous levels. The electrodes are stained dark." CR>
                <RTRUE>)
               (<VERB? TURN SWITCH-ON>
                <TELL "You reach for a switch, but think better of it. Who knows what might happen if you activated this nightmare device." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch one of the electrodes. It's cold and stained with something dark. You feel a faint tingle and quickly pull your hand away." CR>
                <RTRUE>)>>
<OBJECT SHOCK-MACHINE
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM MACHINE EQUIPMENT ELECTRODES)
        (ADJECTIVE SHOCK ELECTRIC)
        (DESC "shock machine")
        (LDESC "Electrodes dangle from a machine beside the chair.")
        (ACTION SHOCK-MACHINE-F)>
<ROOM PADDED-CELL
      (IN ROOMS)
      (DESC "Padded Cell")
      (LDESC "The small room reeks of decay. Something has been written on the walls in what looks like dried blood. The only way out is through the door to the east, leading to the electroshock theater.")
      (EAST TO ELECTROSHOCK-THEATER)
      (FLAGS RLANDBIT)>
<ROUTINE PADDING-F ()
         <COND (<VERB? EXAMINE READ>
                <TELL "The padding is torn and moldering. On one wall, written in what appears to be dried blood, are the words: 'THE CHAPEL BEYOND THE GARDEN. HE WAITS THERE. PATIENT 189.'." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You touch the rotting padding. It's damp and spongy, falling apart at the slightest pressure." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The padding reeks of mildew, decay, and something else—the sour smell of old fear." CR>
                <RTRUE>)
               (<VERB? PULL>
                <TELL "The padding tears away in chunks when you pull it, but there's nothing behind it but more rot." CR>
                <RTRUE>)>>
<OBJECT PADDING
        (IN PADDED-CELL)
        (SYNONYM PADDING WALLS)
        (ADJECTIVE ROTTING TORN)
        (DESC "padded walls")
        (LDESC "Every surface is covered in rotting padding, now torn and hanging in strips.")
        (ACTION PADDING-F)>
<ROUTINE STRAITJACKET-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy canvas straitjacket with multiple leather buckles and straps. Dark stains cover the fabric." CR>
                <RTRUE>)
               (<VERB? WEAR>
                <TELL "You'd rather not." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The straitjacket smells of sweat, fear, and something metallic—perhaps old blood." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "The canvas is rough and stiff. The stains feel crusty under your fingers." CR>
                <RTRUE>)>>
<OBJECT STRAITJACKET
        (IN PADDED-CELL)
        (SYNONYM STRAITJACKET JACKET)
        (ADJECTIVE STRAIT)
        (DESC "straitjacket")
        (LDESC "A straitjacket lies in the corner.")
        (FLAGS TAKEBIT)
        (SIZE 15)
        (ACTION STRAITJACKET-F)>
<ROOM OBSERVATION-DECK
      (IN ROOMS)
      (DESC "Observation Deck")
      (LDESC "A small room with chairs facing a window. This is where doctors watched their experiments. Stairs lead down to the west, and a door to the north opens to the administrative wing.")
      (WEST TO ELECTROSHOCK-THEATER)
      (NORTH TO ADMINISTRATIVE-WING)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE MIRROR-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Through the mirror, you can see the electroshock theater below. The shock chair sits in the center like a throne of suffering." CR>
                <RTRUE>)>>
<OBJECT ONE-WAY-MIRROR
        (IN OBSERVATION-DECK)
        (SYNONYM MIRROR WINDOW GLASS)
        (ADJECTIVE ONE-WAY)
        (DESC "one-way mirror")
        (LDESC "A one-way mirror overlooks the electroshock theater.")
        (ACTION MIRROR-F)>
<ROUTINE OBSERVATION-LOGBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The logbook contains clinical observations of treatments. One entry stands out: 'Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be someone else now. Dr. Mordecai pleased with results. Proceeding to next phase.'" CR>
                <RTRUE>)>>
<OBJECT OBSERVATION-LOGBOOK
        (IN OBSERVATION-DECK)
        (SYNONYM LOGBOOK LOG BOOK)
        (ADJECTIVE OBSERVATION)
        (DESC "observation logbook")
        (LDESC "A logbook rests on a desk.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be 'someone else' now. Dr. Mordecai pleased with results.")
        (SIZE 7)
        (ACTION OBSERVATION-LOGBOOK-F)>
<ROOM ADMINISTRATIVE-WING
      (IN ROOMS)
      (DESC "Administrative Wing")
      (LDESC "Offices line a carpeted corridor. Most doors hang open, revealing ransacked rooms. Filing cabinets are overturned. To the east lies the director's office. North leads to the staff quarters. South returns to the observation deck.")
      (SOUTH TO OBSERVATION-DECK)
      (EAST TO DIRECTORS-OFFICE)
      (NORTH TO STAFF-QUARTERS)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE SCATTERED-PAPERS-F ()
         <COND (<VERB? EXAMINE READ SEARCH>
                <TELL "You sort through the papers. Most are mundane: supply orders, staff schedules, building maintenance. One memo catches your eye: 'All staff reminded - Subject 189 is NOT to be released under any circumstances. Chapel is OFF LIMITS.'." CR>
                <RTRUE>)>>
<OBJECT SCATTERED-PAPERS
        (IN ADMINISTRATIVE-WING)
        (SYNONYM PAPERS FILES DOCUMENTS)
        (ADJECTIVE SCATTERED)
        (DESC "scattered papers")
        (LDESC "Papers are scattered everywhere.")
        (ACTION SCATTERED-PAPERS-F)>
<ROOM DIRECTORS-OFFICE
      (IN ROOMS)
      (DESC "Director's Office")
      (LDESC "A large office with wood paneling. Bookshelves line the walls, filled with medical texts and journals. A door to the west opens back to the administrative wing corridor.")
      (WEST TO ADMINISTRATIVE-WING)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE MASSIVE-DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The desk is made of dark wood, highly polished. The drawers contain mostly empty folders and pens. A hidden compartment in the top drawer holds a key." CR>
                <RTRUE>)>>
<OBJECT MASSIVE-DESK
        (IN DIRECTORS-OFFICE)
        (SYNONYM DESK)
        (ADJECTIVE MASSIVE WOOD)
        (DESC "massive desk")
        (LDESC "A massive desk dominates the room.")
        (FLAGS CONTBIT OPENBIT SURFACEBIT)
        (ACTION MASSIVE-DESK-F)>
<ROUTINE PORTRAIT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The portrait shows Dr. Mordecai, a gaunt man with piercing eyes and a cruel mouth. The nameplate reads: 'Dr. Heinrich Mordecai - Director 1935-1952'. His eyes seem to follow you around the room." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach out to touch the portrait. The paint feels oddly warm. You could swear the eyes moved." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "The portrait is securely fastened to the wall. Besides, you have no desire to carry that man's visage with you." CR>
                <RTRUE>)
               (<VERB? ATTACK>
                <TELL "You consider defacing the portrait, but something stops you. Those painted eyes seem to dare you to try." CR>
                <RTRUE>)>>
<OBJECT MORDECAI-PORTRAIT
        (IN DIRECTORS-OFFICE)
        (SYNONYM PORTRAIT PAINTING PICTURE)
        (ADJECTIVE MORDECAI)
        (DESC "portrait of Dr. Mordecai")
        (LDESC "A portrait of Dr. Mordecai hangs on the wall, his stern eyes seeming to follow you.")
        (ACTION PORTRAIT-F)>
<ROUTINE WALL-SAFE-F ()
         <COND (<AND <VERB? EXAMINE>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The safe is open. Inside you can see its contents." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>>
                <TELL "The safe is locked. It requires a key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The safe is already open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
                     <NOT <IN? ,SAFE-KEY ,WINNER>>>
                <TELL "The safe is locked. You need the key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
                     <IN? ,SAFE-KEY ,WINNER>>
                <TELL "You unlock the " D ,WALL-SAFE " with the " D ,SAFE-KEY ". Inside are Dr. Mordecai's private notes and a " D ,CHAPEL-KEY "." CR>
                <FSET ,WALL-SAFE ,OPENBIT>
                <RTRUE>)>>
<OBJECT WALL-SAFE
        (IN DIRECTORS-OFFICE)
        (SYNONYM SAFE)
        (ADJECTIVE WALL METAL)
        (DESC "wall safe")
        (LDESC "A safe is visible behind a moved painting.")
        (FLAGS CONTBIT)
        (ACTION WALL-SAFE-F)>
<ROOM STAFF-QUARTERS
      (IN ROOMS)
      (DESC "Staff Quarters")
      (LDESC "A dormitory with rows of narrow beds. The air smells of mildew and abandonment. To the west is the cafeteria. South returns to the administrative wing.")
      (SOUTH TO ADMINISTRATIVE-WING)
      (WEST TO CAFETERIA)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE LOCKERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
                <TELL "Most lockers are empty or contain rotted clothing. One locker holds a nurse's uniform and a photograph." CR>
                <RTRUE>)>>
<OBJECT LOCKERS
        (IN STAFF-QUARTERS)
        (SYNONYM LOCKERS LOCKER)
        (ADJECTIVE METAL)
        (DESC "lockers")
        (LDESC "Lockers line one wall. Most are open and empty, their contents long gone.")
        (FLAGS CONTBIT OPENBIT)
        (ACTION LOCKERS-F)>
<ROOM CAFETERIA
      (IN ROOMS)
      (DESC "Cafeteria")
      (LDESC "Long tables with attached benches fill the room. Trays and plates lie scattered about, covered in dust. A door to the north leads to the garden. East returns to the staff quarters.")
      (EAST TO STAFF-QUARTERS)
      (NORTH TO OVERGROWN-GARDEN)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE COUNTER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The serving counter is thick with dust. Old menus are still posted on the wall: 'Monday - Mystery Meat'. A bell for summoning kitchen staff sits on the counter." CR>
                <RTRUE>)>>
<OBJECT SERVING-COUNTER
        (IN CAFETERIA)
        (SYNONYM COUNTER)
        (ADJECTIVE SERVING)
        (DESC "serving counter")
        (LDESC "A serving counter separates the dining area from the kitchen beyond.")
        (FLAGS SURFACEBIT CONTBIT OPENBIT)
        (ACTION COUNTER-F)>
<ROOM OVERGROWN-GARDEN
      (IN ROOMS)
      (DESC "Overgrown Garden")
      (LDESC "Broken benches lie among the overgrowth. A stone path, barely visible, leads to a small chapel to the north. South returns to the cafeteria.")
      (SOUTH TO CAFETERIA)
      (NORTH TO CHAPEL IF CHAPEL-UNLOCKED)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE DEAD-GARDEN-F ()
         <COND (<VERB? EXAMINE SEARCH>
                <TELL "The garden has been dead for decades. Thorny vines choke what remains of flower beds. Among the weeds, you can see broken stone benches and a crumbling fountain." CR>
                <RTRUE>)
               (<AND <VERB? DIG>
                     <IN? ,COAL-SHOVEL ,WINNER>>
                <TELL "You dig into the dead earth with the shovel. The soil is dry and lifeless. After a few moments, you give up—nothing but rocks and roots here." CR>
                <RTRUE>)
               (<AND <VERB? DIG>
                     <NOT <IN? ,COAL-SHOVEL ,WINNER>>>
                <TELL "You'd need a shovel or similar tool to dig here." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "The garden smells of decay and rot, with an underlying odor of something else—something chemical and wrong." CR>
                <RTRUE>)>>
<OBJECT DEAD-GARDEN
        (IN OVERGROWN-GARDEN)
        (SYNONYM GARDEN WEEDS PLANTS)
        (ADJECTIVE DEAD OVERGROWN)
        (DESC "dead garden")
        (LDESC "What was once a therapeutic garden is now a wild tangle of weeds and dead plants.")
        (ACTION DEAD-GARDEN-F)>
<ROUTINE CHAPEL-DOOR-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAPEL-UNLOCKED>>
                <TELL "The door is made of thick oak bound with iron straps. A large iron lock secures it. Above the door, carved words read: 'HE WHO ENTERS ABANDONS HOPE'." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAPEL-UNLOCKED>
                <TELL "The door stands open, darkness visible beyond." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <NOT <IN? ,CHAPEL-KEY ,WINNER>>>
                <TELL "The door is locked. You need the " D ,CHAPEL-KEY "." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <IN? ,CHAPEL-KEY ,WINNER>>
                <TELL "You insert the " D ,CHAPEL-KEY " into the lock. It turns with a heavy clunk. The door swings open slowly, revealing darkness beyond. A foul wind rushes out, carrying the scent of decay." CR>
                <SETG CHAPEL-UNLOCKED T>
                <RTRUE>)
               (<VERB? READ>
                <TELL "The words carved above the door read: 'HE WHO ENTERS ABANDONS HOPE'." CR>
                <RTRUE>)
               (<VERB? KNOCK>
                <TELL "You knock on the heavy oak door. The sound echoes dully, and you think you hear something shift on the other side." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "You press your ear against the door. From within comes a faint sound—breathing? Or just the wind?" CR>
                <RTRUE>)>>
<OBJECT CHAPEL-DOOR
        (IN OVERGROWN-GARDEN)
        (SYNONYM DOOR)
        (ADJECTIVE CHAPEL HEAVY LOCKED)
        (DESC "chapel door")
        (LDESC "The chapel door is secured with a heavy lock.")
        (ACTION CHAPEL-DOOR-F)>
<ROOM CHAPEL
      (IN ROOMS)
      (DESC "Chapel")
      (LDESC "The chapel is small and dark. The air is thick and cold. South lies the exit.")
      (SOUTH TO OVERGROWN-GARDEN)
      (FLAGS RLANDBIT ONBIT)>
<ROUTINE PEWS-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The PEWS are ancient and rotting. Strange symbols are carved into the wood—symbols that hurt to look at." CR>
                <RTRUE>)
               (<VERB? BOARD SIT>
                <TELL "You sit on one of the pews. The wood is cold and uncomfortable. The symbols carved into it seem to pulse beneath your hands, and you quickly stand back up." CR>
                <RTRUE>)
               (<VERB? PRAY>
                <TELL "You bow your head and try to pray, but the words die in your throat. This place mocks faith." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You run your fingers over the carved symbols. They're strangely warm to the touch, and you quickly pull your hand away." CR>
                <RTRUE>)>>
<OBJECT PEWS
        (IN CHAPEL)
        (SYNONYM PEWS BENCHES)
        (ADJECTIVE WOODEN)
        (DESC "wooden pews")
        (LDESC "Pews face an altar.")
        (ACTION PEWS-F)>
<ROUTINE GREEN-CANDLES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The CANDLES burn with green flames that give off no heat. The light makes everything look diseased." CR>
                <RTRUE>)
               (<VERB? LAMP-OFF>
                <TELL "You try to extinguish the candles, but the green flames resist. No amount of blowing can put them out. They burn with an unnatural persistence." CR>
                <RTRUE>)
               (<VERB? BLOW>
                <TELL "You try to blow out the candles, but the green flames refuse to be extinguished." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach toward the flame, expecting heat. Instead, you feel only cold—a deep, bone-chilling cold that makes you recoil." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "The candles seem fixed in place, as if welded to their holders. They won't budge." CR>
                <RTRUE>)>>
<OBJECT GREEN-CANDLES
        (IN CHAPEL)
        (SYNONYM CANDLES FLAMES)
        (ADJECTIVE GREEN UNNATURAL)
        (DESC "green candles")
        (LDESC "Candles burn with an unnatural green flame.")
        (ACTION GREEN-CANDLES-F)>
<ROUTINE WOODEN-BOX-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>>
                <TELL "A small wooden box sits beneath the altar. It's locked tight with an iron clasp." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <FSET? ,WOODEN-BOX ,OPENBIT>>
                <TELL "The box is now open. " <COND (<IN? ,ANCIENT-RELIC ,WOODEN-BOX> <TELL "Inside is an ancient relic.">)(<ELSE> <TELL "It's empty.">)> CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>
                     <NOT <IN? ,SCALPEL ,WINNER>>>
                <TELL "The lock is rusted but holds fast. You need something to pry it open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT <FSET? ,WOODEN-BOX ,OPENBIT>>
                     <IN? ,SCALPEL ,WINNER>>
                <TELL "You use the scalpel to pry open the rusted clasp. The box opens with a creak, revealing an ancient relic inside." CR>
                <FSET ,WOODEN-BOX ,OPENBIT>
                <RTRUE>)>>
<OBJECT WOODEN-BOX
        (IN CHAPEL)
        (SYNONYM BOX CASE)
        (ADJECTIVE WOODEN LOCKED SMALL)
        (DESC "wooden box")
        (LDESC "A small wooden box sits beneath the altar, its surface carved with disturbing symbols.")
        (FLAGS CONTBIT OPENABLEBIT TAKEBIT)
        (CAPACITY 10)
        (SIZE 8)
        (ACTION WOODEN-BOX-F)>
<ROUTINE ANCIENT-RELIC-F ()
         <COND (<VERB? EXAMINE>
                <TELL "An ancient silver cross, tarnished black with age. Strange symbols are etched into its surface—symbols that seem to writhe when you look directly at them. Despite its age, it radiates a strange warmth." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "The cross feels unnaturally warm in your hand. The symbols seem to pulse under your touch." CR>
                <RTRUE>)
               (<VERB? PRAY>
                <TELL "You clutch the cross and try to pray. The symbols grow warmer, almost hot, as if responding to your faith—or mocking it." CR>
                <RTRUE>)
               (<VERB? THROW>
                <TELL "The cross seems too important to discard." CR>
                <RTRUE>)
               (<VERB? GIVE>
                <TELL "The cross seems too important to give away." CR>
                <RTRUE>)>>
<OBJECT ANCIENT-RELIC
        (IN WOODEN-BOX)
        (SYNONYM RELIC CROSS SILVER AMULET)
        (ADJECTIVE ANCIENT SILVER TARNISHED)
        (DESC "ancient relic")
        (LDESC "An ancient silver cross with writhing symbols etched into its surface.")
        (FLAGS TAKEBIT)
        (SIZE 4)
        (ACTION ANCIENT-RELIC-F)>
<ROUTINE PATIENT-189-F ()
         <COND (<VERB? EXAMINE>
                <TELL "PATIENT 189 stands impossibly still. Its skin is pale as death, its eyes glowing faintly green. It watches you with an intelligence that is distinctly not human. Dr. Mordecai's greatest achievement—and greatest horror." CR>
                <RTRUE>)
               (<VERB? ATTACK KILL>
                <TELL "You cannot bring yourself to approach it. Some primal instinct holds you back." CR>
                <RTRUE>)
               (<VERB? HELLO>
                <TELL "The figure tilts its head slightly. A voice like wind through dead leaves whispers: 'Free... at last... thank... you...' Then it turns to ash and crumbles to the floor. The green flames extinguish. Whatever held it here is finally broken." CR>
                <REMOVE ,PATIENT-189>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You reach toward Patient 189, but stop yourself. The air around it feels wrong—cold and electric." CR>
                <RTRUE>)
               (<VERB? GIVE>
                <TELL "Patient 189 shows no interest in earthly possessions. It simply watches you with those glowing eyes." CR>
                <RTRUE>)>>
<OBJECT PATIENT-189
        (IN CHAPEL)
        (SYNONYM PATIENT FIGURE BEING)
        (ADJECTIVE PATIENT 189)
        (DESC "Patient 189")
        (LDESC "A figure stands motionless at the altar. It turns to face you—its eyes glow faintly in the darkness. This is Patient 189, if you can still call it that.")
        (FLAGS ACTORBIT)
        (ACTION PATIENT-189-F)>
<ROUTINE DRAWER-F ()
         <COND (<AND <VERB? OPEN>
                     <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                <TELL "The drawer is already open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                     <NOT <IN? ,BRASS-KEY ,WINNER>>>
                <TELL "The drawer is locked. You need a key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                     <IN? ,BRASS-KEY ,WINNER>>
                <TELL "You unlock the " D ,BOTTOM-DRAWER " with the " D ,BRASS-KEY ". It slides open with a groan, revealing a leather-bound ledger inside." CR>
                <FCLEAR ,BOTTOM-DRAWER ,NDESCBIT>
                <FSET ,BOTTOM-DRAWER ,OPENBIT>
                <RTRUE>)>>
<OBJECT BOTTOM-DRAWER
        (IN OAK-DESK)
        (SYNONYM DRAWER)
        (ADJECTIVE BOTTOM)
        (DESC "bottom drawer")
        (LDESC "A sturdy drawer that seems to be locked.")
        (FLAGS CONTBIT SEARCHBIT NDESCBIT)
        (CAPACITY 10)
        (ACTION DRAWER-F)>
<ROUTINE LEDGER-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The ledger contains patient records spanning decades. The entries become more disturbing toward the end. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai. May God have mercy on us all.'" CR>
                <RTRUE>)>>
<OBJECT PATIENT-LEDGER
        (IN BOTTOM-DRAWER)
        (SYNONYM LEDGER BOOK)
        (ADJECTIVE PATIENT LEATHER)
        (DESC "patient ledger")
        (LDESC "A leather-bound ledger with names and dates. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.'")
        (FLAGS READBIT TAKEBIT)
        (TEXT "Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.")
        (SIZE 8)
        (ACTION LEDGER-F)>
<ROUTINE SCALPEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The scalpel's blade is rusty but still razor-sharp along one edge. The handle is stained with something dark." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "You carefully touch the blade. It's still very sharp—sharp enough to cut." CR>
                <RTRUE>)
               (<VERB? THROW>
                <TELL "You're not about to throw away a potentially useful tool." CR>
                <RTRUE>)>>
<OBJECT SCALPEL
        (IN METAL-CABINET)
        (SYNONYM SCALPEL KNIFE BLADE)
        (ADJECTIVE SURGICAL RUSTY)
        (DESC "rusty scalpel")
        (LDESC "A surgical scalpel, its blade dulled by rust but still sharp enough to cut.")
        (FLAGS TAKEBIT WEAPONBIT TOOLBIT)
        (SIZE 3)
        (ACTION SCALPEL-F)>
<ROUTINE ETHER-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A glass bottle with a faded label reading 'Ether - Handle with Care'. About a quarter of the liquid remains." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "That would be an extremely bad idea." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "You carefully sniff the bottle. The sweet, sickly smell of ether makes your head spin. You quickly cap it again." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "You carefully uncap the bottle. The smell of ether wafts out." CR>
                <RTRUE>)>>
<OBJECT ETHER-BOTTLE
        (IN METAL-CABINET)
        (SYNONYM BOTTLE ETHER CHLOROFORM)
        (ADJECTIVE GLASS)
        (DESC "bottle of ether")
        (LDESC "A glass bottle labeled 'Ether - Handle with Care'. Some liquid remains inside.")
        (FLAGS TAKEBIT)
        (SIZE 5)
        (ACTION ETHER-F)>
<ROUTINE BUNDLE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A human-shaped bundle wrapped in stained canvas. The fabric is rotted and discolored. You'd rather not investigate further, though part of you wonders if this is Patient 237." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "You have no desire to see what lies within. Some mysteries are better left undisturbed." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "You can't bring yourself to touch it." CR>
                <RTRUE>)
               (<VERB? SMELL>
                <TELL "Even from here, the smell of decay is overwhelming. You step back, fighting nausea." CR>
                <RTRUE>)
               (<VERB? RUB>
                <TELL "Your hand stops inches from the bundle. Every instinct screams at you not to touch it." CR>
                <RTRUE>)
               (<VERB? PUSH>
                <TELL "You cannot bring yourself to push the bundle. The thought of touching it fills you with dread." CR>
                <RTRUE>)>>
<OBJECT CANVAS-BUNDLE
        (IN DISSECTION-TABLE)
        (SYNONYM BUNDLE CANVAS BODY CORPSE)
        (ADJECTIVE WRAPPED)
        (DESC "canvas bundle")
        (LDESC "A human-shaped bundle wrapped in stained canvas. You'd rather not investigate further.")
        (FLAGS TAKEBIT)
        (SIZE 50)
        (ACTION BUNDLE-F)>
<ROUTINE SERUM-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A glass vial containing a faintly glowing liquid. The label reads 'Compound 237 - DO NOT USE'. The serum pulses with an unnatural light." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "You bring the vial to your lips but your survival instinct stops you. This substance killed Patient 237. You lower the vial, hands trembling." CR>
                <RTRUE>)>>
<OBJECT STRANGE-SERUM
        (IN REFRIGERATED-DRAWERS)
        (SYNONYM SERUM VIAL BOTTLE)
        (ADJECTIVE STRANGE GLOWING)
        (DESC "vial of serum")
        (LDESC "A glass vial containing luminescent liquid. The label reads 'Compound 237 - DO NOT USE'")
        (FLAGS TAKEBIT)
        (SIZE 4)
        (ACTION SERUM-F)>
<ROUTINE SHOVEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy coal shovel with a wooden handle. The blade is caked with ancient coal dust." CR>
                <RTRUE>)
               (<VERB? SWING>
                <TELL "You swing the shovel experimentally. It's heavy but well-balanced—could work as a weapon if needed." CR>
                <RTRUE>)
               (<VERB? DIG>
                <TELL "You'd need to specify what you want to dig. The shovel is ready." CR>
                <RTRUE>)>>
<OBJECT COAL-SHOVEL
        (IN IRON-BOILER)
        (SYNONYM SHOVEL SPADE)
        (ADJECTIVE COAL)
        (DESC "coal shovel")
        (LDESC "A sturdy coal shovel with a wooden handle.")
        (FLAGS TAKEBIT TOOLBIT)
        (SIZE 10)
        (ACTION SHOVEL-F)>
<ROUTINE FLASHLIGHT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy metal flashlight. The switch clicks but produces no light. The batteries are long dead." CR>
                <RTRUE>)
               (<VERB? LAMP-ON>
                <TELL "The batteries are dead. The flashlight doesn't work." CR>
                <RTRUE>)>>
<OBJECT FLASHLIGHT
        (IN WORKBENCH)
        (SYNONYM FLASHLIGHT LIGHT TORCH)
        (ADJECTIVE ELECTRIC)
        (DESC "flashlight")
        (LDESC "An old-fashioned electric flashlight, surprisingly heavy.")
        (FLAGS TAKEBIT LIGHTBIT)
        (SIZE 5)
        (ACTION FLASHLIGHT-F)>
<ROUTINE LANTERN-F ()
         <COND (<AND <VERB? LAMP-ON>
                     <NOT ,LANTERN-LIT-FLAG>>
                <TELL "You light the " D ,OIL-LANTERN ". A warm glow pushes back the darkness." CR>
                <SETG LANTERN-LIT-FLAG T>
                <FSET ,OIL-LANTERN ,ONBIT>
                <RTRUE>)
               (<AND <VERB? LAMP-ON>
                     ,LANTERN-LIT-FLAG>
                <TELL "The " D ,OIL-LANTERN " is already lit." CR>
                <RTRUE>)
               (<AND <VERB? LAMP-OFF>
                     ,LANTERN-LIT-FLAG>
                <TELL "You extinguish the " D ,OIL-LANTERN "." CR>
                <SETG LANTERN-LIT-FLAG <>>
                <FCLEAR ,OIL-LANTERN ,ONBIT>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A brass oil lantern with a glass chimney. It still contains fuel." CR>
                <RTRUE>)
               (<VERB? SHAKE>
                <TELL "You shake the lantern gently. You can hear oil sloshing inside." CR>
                <RTRUE>)>>
<OBJECT OIL-LANTERN
        (IN SHELVES)
        (SYNONYM LANTERN LAMP)
        (ADJECTIVE OIL)
        (DESC "oil lantern")
        (LDESC "An old oil lantern. It still has fuel inside.")
        (FLAGS TAKEBIT LIGHTBIT)
        (SIZE 8)
        (ACTION LANTERN-F)>
<ROUTINE RECORDS-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "You flip through the water-damaged records. Most are illegible, but one file remains clear: 'Patient 189 - Subject shows unusual resistance to sedation. Violent episodes increasing. Transferred to isolation ward for observation. Dr. Mordecai supervising.'" CR>
                <RTRUE>)>>
<OBJECT MEDICAL-RECORDS
        (IN SHELVES)
        (SYNONYM RECORDS FILES PAPERS)
        (ADJECTIVE MEDICAL OLD)
        (DESC "medical records")
        (LDESC "Yellowed files containing patient records from the 1940s.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "Most records are water-damaged, but one file remains legible: Patient 189 - Subject shows unusual resistance to sedation. Transferred to isolation ward for observation.")
        (SIZE 4)
        (ACTION RECORDS-F)>
<ROUTINE SOGGY-NOTEBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The notebook is badly water-damaged. You can make out fragments: '...water treatment...patients submerged for hours...screaming finally stopped...Dr. M approved extended sessions...'" CR>
                <RTRUE>)>>
<OBJECT SOGGY-NOTEBOOK
        (IN PORCELAIN-TUBS)
        (SYNONYM NOTEBOOK BOOK DIARY)
        (ADJECTIVE SOGGY WET)
        (DESC "soggy notebook")
        (LDESC "A water-damaged notebook, barely legible.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "...water treatment...hours submerged...screaming stopped...Dr. M approved extended sessions...")
        (SIZE 3)
        (ACTION SOGGY-NOTEBOOK-F)>
<ROUTINE SYRINGE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A medical syringe with a sharp steel needle. The glass chamber is empty." CR>
                <RTRUE>)>>
<OBJECT SYRINGE
        (IN MEDICINE-CABINET)
        (SYNONYM SYRINGE NEEDLE)
        (ADJECTIVE MEDICAL)
        (DESC "syringe")
        (LDESC "A glass syringe with a steel needle.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION SYRINGE-F)>
<ROUTINE SAFE-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small brass key with a tag reading 'S-001'. It looks like a safe key." CR>
                <RTRUE>)>>
<OBJECT SAFE-KEY
        (IN MASSIVE-DESK)
        (SYNONYM KEY)
        (ADJECTIVE SAFE SMALL)
        (DESC "safe key")
        (LDESC "A small key with a numbered tag: S-001.")
        (FLAGS TAKEBIT)
        (SIZE 1)
        (ACTION SAFE-KEY-F)>
<ROUTINE MORDECAI-NOTES-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The notes are written in a shaking hand: 'October 30, 1952 - The experiment succeeded beyond my wildest expectations. Patient 189 has transcended death itself. But the cost... the screaming never stops. I hear it in my sleep. The others want to shut down the sanitarium. Fools! They don't understand what we've achieved. The chapel must remain locked. What I've created must never escape.'" CR>
                <RTRUE>)>>
<OBJECT MORDECAI-NOTES
        (IN WALL-SAFE)
        (SYNONYM NOTES JOURNAL PAPERS)
        (ADJECTIVE PRIVATE MORDECAI)
        (DESC "Dr. Mordecai's notes")
        (LDESC "Personal notes in Dr. Mordecai's handwriting.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "The experiment succeeded beyond expectations. Patient 189 has transcended death itself. But the cost... the screaming never stops. I hear it in my sleep. The chapel must remain locked. What I've created must never escape.")
        (SIZE 5)
        (ACTION MORDECAI-NOTES-F)>
<ROUTINE CHAPEL-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy iron key with a cross engraved on its head. The key feels unnaturally cold." CR>
                <RTRUE>)>>
<OBJECT CHAPEL-KEY
        (IN WALL-SAFE)
        (SYNONYM KEY)
        (ADJECTIVE CHAPEL IRON)
        (DESC "chapel key")
        (LDESC "A large iron key with a cross engraved on the head.")
        (FLAGS TAKEBIT)
        (SIZE 6)
        (ACTION CHAPEL-KEY-F)>
<ROUTINE PHOTOGRAPH-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The photograph shows the sanitarium staff posed outside the building. Dr. Mordecai stands in the center, unsmiling. Written on the back: 'Staff photo 1950. Two years before they closed us down. Two years before everything went wrong.'" CR>
                <RTRUE>)>>
<OBJECT PHOTOGRAPH
        (IN LOCKERS)
        (SYNONYM PHOTOGRAPH PHOTO PICTURE)
        (ADJECTIVE OLD)
        (DESC "photograph")
        (LDESC "A faded photograph of the sanitarium staff.")
        (FLAGS TAKEBIT)
        (SIZE 1)
        (ACTION PHOTOGRAPH-F)>
<ROUTINE BELL-F ()
         <COND (<VERB? RING>
                <TELL "You ring the bell. The tinny sound echoes through the empty cafeteria. No one comes." CR>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A small brass bell with a button on top. It still works." CR>
                <RTRUE>)
               (<VERB? LISTEN>
                <TELL "The bell makes a clear ringing sound when struck." CR>
                <RTRUE>)
               (<VERB? SHAKE>
                <TELL "You shake the bell. It rings with a cheerful tone that seems out of place in this dead building." CR>
                <RTRUE>)>>
<OBJECT BELL
        (IN SERVING-COUNTER)
        (SYNONYM BELL)
        (ADJECTIVE SERVICE COUNTER)
        (DESC "service bell")
        (LDESC "A small brass bell for summoning staff.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION BELL-F)>
; Clock-driven atmospheric routines (I- style demons and interrupts)
<ROUTINE I-WHISPER ()
	<COND (<EQUAL? ,HERE ,SANITARIUM-ENTRANCE ,PATIENT-WARD ,MORGUE ,CHAPEL>
	       <TELL "You hear a faint, anguished whisper echoing through the halls..." CR>)>
	<RTRUE>>

<ROUTINE I-FOOTSTEPS ()
	<COND (<EQUAL? ,HERE ,SANITARIUM-ENTRANCE ,RECEPTION-ROOM ,OPERATING-THEATER>
	       <TELL "Distant footsteps echo from somewhere above you." CR>)>
	<RTRUE>>

<ROUTINE I-FLICKERING ()
	<COND (<AND ,LIT
	            <EQUAL? ,HERE ,BASEMENT-STAIRS ,BOILER-ROOM ,MORGUE>>
	       <TELL "The shadows seem to flicker and move of their own accord." CR>)>
	<RTRUE>>

<ROUTINE I-COLD-DRAFT ()
	<COND (<EQUAL? ,HERE ,MORGUE ,CHAPEL ,PATIENT-WARD>
	       <TELL "A cold draft makes you shiver, though there are no open windows." CR>)>
	<RTRUE>>

; Initialize clock-driven demons for atmospheric effects in GO routine
<ROUTINE GO ()
	<SETG HERE ,SANITARIUM-GATE>
	<THIS-IS-IT ,BRASS-PLAQUE>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<QUEUE I-WHISPER 8>
	<QUEUE I-FOOTSTEPS 12>
	<QUEUE I-FLICKERING 10>
	<QUEUE I-COLD-DRAFT 15>
      <V-LOOK>
      <MAIN-LOOP>
	<AGAIN>>
<GLOBAL VALVE-TURNED-FLAG <>>
<GLOBAL STEAM-DOOR-OPEN <>>
<GLOBAL LANTERN-LIT-FLAG <>>
<GLOBAL CHAPEL-UNLOCKED <>>
<GLOBAL CHAINS-CUT-FLAG <>>
