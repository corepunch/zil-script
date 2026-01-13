<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

<ROOM SANITARIUM-GATE
      (IN ROOMS)
      (DESC "Sanitarium Gate")
      (LDESC "You stand before the rusted iron gates of an abandoned sanitarium. The structure looms against the darkening sky, its windows like hollow eye sockets. Weeds choke the gravel path leading north to the entrance. A corroded BRASS PLAQUE hangs askew on the gate.")
      (NORTH TO SANITARIUM-ENTRANCE)
      (FLAGS LIGHTBIT)>

<ROUTINE PLAQUE-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The plaque reads: 'Blackwood Sanitarium - Est. 1898 - Closed by Order 1952'" CR>
                <RTRUE>)>>

<OBJECT BRASS-PLAQUE
        (IN SANITARIUM-GATE)
        (SYNONYM PLAQUE BRASS SIGN)
        (ADJECTIVE BRASS CORRODED)
        (DESC "brass plaque")
        (LDESC "The plaque reads: 'Blackwood Sanitarium - Est. 1898 - Closed by Order 1952'")
        (FLAGS READBIT TAKEBIT)
        (TEXT "Blackwood Sanitarium - Est. 1898 - Closed by Order 1952")
        (SIZE 5)
        (ACTION PLAQUE-F)>

<ROOM SANITARIUM-ENTRANCE
      (IN ROOMS)
      (DESC "Sanitarium Entrance Hall")
      (LDESC "The entrance hall reeks of mildew and decay. Peeling WALLPAPER reveals water-stained plaster beneath. A grand staircase ascends to darkness in the east. To the west, a doorway leads to what might have been a reception area. North, you can make out an operating theater through a half-open door. A narrow staircase descends into the basement.")
      (SOUTH TO SANITARIUM-GATE)
      (WEST TO RECEPTION-ROOM)
      (NORTH TO OPERATING-THEATER)
      (EAST TO PATIENT-WARD)
      (DOWN TO BASEMENT-STAIRS)
      (FLAGS LIGHTBIT)>

<OBJECT WALLPAPER
        (IN SANITARIUM-ENTRANCE)
        (SYNONYM WALLPAPER PAPER PLASTER)
        (ADJECTIVE PEELING)
        (DESC "peeling wallpaper")
        (LDESC "Victorian-era wallpaper depicting pastoral scenes, now grotesquely warped by moisture.")
        (FLAGS NDESCBIT)
        (ACTION WALLPAPER-F)>

<ROUTINE WALLPAPER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Victorian-era wallpaper depicting pastoral scenes, now grotesquely warped by moisture and black mold." CR>
                <RTRUE>)>>

<ROOM RECEPTION-ROOM
      (IN ROOMS)
      (DESC "Reception Room")
      (LDESC "This cramped room once served as the sanitarium's reception. A heavy OAK DESK sits against one wall, its surface thick with dust. Filing cabinets line the opposite wall, their drawers hanging open like gaping mouths. Something glints among the papers scattered on the floor.")
      (EAST TO SANITARIUM-ENTRANCE)
      (FLAGS LIGHTBIT)>

<OBJECT OAK-DESK
        (IN RECEPTION-ROOM)
        (SYNONYM DESK)
        (ADJECTIVE HEAVY OAK)
        (DESC "oak desk")
        (LDESC "The desk has three drawers. Only the bottom drawer appears intact.")
        (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
        (ACTION DESK-F)>

<ROUTINE DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The desk has three drawers. The top two are broken and empty. The BOTTOM DRAWER appears intact but is locked tight." CR>
                <RTRUE>)>>

<OBJECT BOTTOM-DRAWER
        (IN OAK-DESK)
        (SYNONYM DRAWER)
        (ADJECTIVE BOTTOM)
        (DESC "bottom drawer")
        (LDESC "A sturdy drawer that seems to be locked.")
        (FLAGS CONTBIT NDESCBIT)
        (CAPACITY 10)
        (ACTION DRAWER-F)>

<ROUTINE DRAWER-F ()
         <COND (<AND <VERB? OPEN>
                     <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                <TELL "The DRAWER is already open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                     <NOT <IN? ,BRASS-KEY ,WINNER>>>
                <TELL "The DRAWER is locked. You need a key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,BOTTOM-DRAWER ,OPENBIT>>
                     <IN? ,BRASS-KEY ,WINNER>>
                <TELL "You unlock the " D ,BOTTOM-DRAWER " with the " D ,BRASS-KEY ". It slides open with a groan, revealing a leather-bound LEDGER inside." CR>
                <FCLEAR ,BOTTOM-DRAWER ,NDESCBIT>
                <FSET ,BOTTOM-DRAWER ,OPENBIT>
                <RTRUE>)>>

<OBJECT BRASS-KEY
        (IN RECEPTION-ROOM)
        (SYNONYM KEY)
        (ADJECTIVE BRASS SMALL)
        (DESC "brass key")
        (LDESC "A small brass key, cold to the touch.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION BRASSKEY-F)>

<ROUTINE BRASSKEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small BRASS KEY with the number '3' engraved on its head. It's ice cold despite being indoors." CR>
                <RTRUE>)>>

<OBJECT PATIENT-LEDGER
        (IN BOTTOM-DRAWER)
        (SYNONYM LEDGER BOOK JOURNAL)
        (ADJECTIVE PATIENT LEATHER)
        (DESC "patient ledger")
        (LDESC "A leather-bound ledger with names and dates. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.'")
        (FLAGS READBIT TAKEBIT)
        (TEXT "Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.")
        (SIZE 8)
        (ACTION LEDGER-F)>

<ROUTINE LEDGER-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The LEDGER contains patient records spanning decades. The entries become more disturbing toward the end. The final entry reads: 'Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai. May God have mercy on us all.'" CR>
                <RTRUE>)>>

<ROOM OPERATING-THEATER
      (IN ROOMS)
      (DESC "Operating Theater")
      (LDESC "The circular theater is dominated by a stained OPERATING TABLE in the center. Rusty surgical instruments lie scattered about. Rising tiers of benches circle the table, where students once observed procedures. A metal CABINET stands in the shadows, its door slightly ajar. The air here is thick with an oppressive dread.")
      (SOUTH TO SANITARIUM-ENTRANCE)
      (FLAGS LIGHTBIT)>

<OBJECT OPERATING-TABLE
        (IN OPERATING-THEATER)
        (SYNONYM TABLE)
        (ADJECTIVE OPERATING STAINED)
        (DESC "operating table")
        (LDESC "The table is covered in dark stains. Leather restraints dangle from its edges.")
        (FLAGS NDESCBIT SURFACEBIT)
        (ACTION OPTABLE-F)>

<ROUTINE OPTABLE-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The OPERATING TABLE is covered in dark brown stains that you hope are just rust. Leather restraints dangle from all four corners. Deep gouges mar the metal surface, as if someone struggled violently against the bindings." CR>
                <RTRUE>)>>

<OBJECT METAL-CABINET
        (IN OPERATING-THEATER)
        (SYNONYM CABINET)
        (ADJECTIVE METAL MEDICAL)
        (DESC "metal cabinet")
        (LDESC "A tall cabinet with glass doors, now cracked and clouded.")
        (FLAGS NDESCBIT CONTBIT OPENBIT TRANSBIT)
        (ACTION CABINET-F)>

<ROUTINE CABINET-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The CABINET's glass doors are cracked but still intact. Inside, you can see various medical instruments, including a SCALPEL and a bottle." CR>
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

<ROUTINE SCALPEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The SCALPEL's blade is rusty but still razor-sharp along one edge. The handle is stained with something dark." CR>
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

<ROUTINE ETHER-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A glass BOTTLE with a faded label reading 'Ether - Handle with Care'. About a quarter of the liquid remains." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "That would be an extremely bad idea." CR>
                <RTRUE>)>>

<ROOM PATIENT-WARD
      (IN ROOMS)
      (DESC "Patient Ward")
      (LDESC "A long corridor lined with rusted BED FRAMES. Tattered curtains hang between them, offering the ghost of privacy. At the far end, a heavy DOOR sealed with CHAINS blocks further passage. Scratches cover the door's surface, as if made by desperate fingers. The floor is littered with patient records and broken glass.")
      (WEST TO SANITARIUM-ENTRANCE)
      (NORTH TO MORGUE IF CHAINS-CUT-FLAG)
      (FLAGS LIGHTBIT)>

<OBJECT BED-FRAMES
        (IN PATIENT-WARD)
        (SYNONYM BEDS FRAMES BED FRAME)
        (ADJECTIVE RUSTED)
        (DESC "bed frames")
        (LDESC "Skeletal remains of hospital beds, springs poking through rotted mattresses.")
        (FLAGS NDESCBIT)
        (ACTION BEDS-F)>

<ROUTINE BEDS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Dozens of BED FRAMES line the walls. The mattresses have rotted away, leaving only rusted springs and metal frames. Some still have restraint straps attached." CR>
                <RTRUE>)>>

<OBJECT HEAVY-DOOR
        (IN PATIENT-WARD)
        (SYNONYM DOOR)
        (ADJECTIVE HEAVY SEALED LOCKED MORGUE)
        (DESC "heavy door")
        (LDESC "The door is secured with thick chains and a padlock. Deep scratches mar its surface.")
        (FLAGS NDESCBIT)
        (ACTION HEAVYDOOR-F)>

<ROUTINE HEAVYDOOR-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The heavy DOOR is secured with thick CHAINS and a rusted padlock. Deep scratches cover its surface, made by fingernails. A tarnished PLAQUE reads 'MORGUE'." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAINS-CUT-FLAG>
                <TELL "The DOOR stands open, CHAINS lying in a heap on the floor. Beyond lies darkness." CR>
                <RTRUE>)
               (<AND <VERB? OPEN>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "The DOOR is secured with heavy CHAINS. You need to cut through them." CR>
                <RTRUE>)>>

<OBJECT CHAINS
        (IN PATIENT-WARD)
        (SYNONYM CHAINS CHAIN PADLOCK)
        (ADJECTIVE THICK)
        (DESC "chains")
        (LDESC "Heavy chains secured with a rusted padlock.")
        (FLAGS NDESCBIT)
        (ACTION CHAINS-F)>

<ROUTINE CHAINS-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAINS-CUT-FLAG>>
                <TELL "Thick iron CHAINS wrap around the door handles, secured with a massive rusted padlock. The CHAINS look old but still strong." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK>
                     <NOT ,CHAINS-CUT-FLAG>
                     <NOT <IN? ,SCALPEL ,WINNER>>>
                <TELL "The CHAINS are too strong to break with your bare hands. You need a sharp tool." CR>
                <RTRUE>)
               (<AND <VERB? ATTACK>
                     <NOT ,CHAINS-CUT-FLAG>
                     <IN? ,SCALPEL ,WINNER>>
                <TELL "You saw through the rusty CHAINS with the " D ,SCALPEL ". It takes several minutes of effort, but finally they fall away with a crash. The heavy DOOR creaks open, revealing a passage north into darkness." CR>
                <SETG CHAINS-CUT-FLAG T>
                <REMOVE ,CHAINS>
                <RTRUE>)>>

<ROOM MORGUE
      (IN ROOMS)
      (DESC "Morgue")
      (LDESC "The temperature drops as you enter the morgue. Refrigerated DRAWERS line both walls. In the center, a DISSECTION TABLE holds what appears to be a canvas-wrapped BUNDLE. Medical instruments hang on the wall. A JOURNAL rests on a small desk in the corner. This place feels wrong, as though something lingers here still.")
      (SOUTH TO PATIENT-WARD)
      (FLAGS LIGHTBIT)>

<OBJECT REFRIGERATED-DRAWERS
        (IN MORGUE)
        (SYNONYM DRAWERS DRAWER REFRIGERATOR)
        (ADJECTIVE REFRIGERATED METAL)
        (DESC "refrigerated drawers")
        (LDESC "Most drawers are empty, but one is slightly open.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION DRAWERS-F)>

<ROUTINE DRAWERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The refrigeration units line both walls. Most DRAWERS are empty or contain only bones. One DRAWER is slightly ajar, a faint luminescent glow emanating from within." CR>
                <RTRUE>)>>

<OBJECT DISSECTION-TABLE
        (IN MORGUE)
        (SYNONYM TABLE)
        (ADJECTIVE DISSECTION AUTOPSY)
        (DESC "dissection table")
        (LDESC "A metal table with drainage channels carved into its surface.")
        (FLAGS NDESCBIT SURFACEBIT)
        (ACTION DISTABLE-F)>

<ROUTINE DISTABLE-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The DISSECTION TABLE is made of stainless steel with drainage channels carved into its surface. Dark stains pool in the grooves. A canvas-wrapped BUNDLE lies upon it." CR>
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

<ROUTINE BUNDLE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A human-shaped BUNDLE wrapped in stained canvas. The fabric is rotted and discolored. You'd rather not investigate further, though part of you wonders if this is Patient 237." CR>
                <RTRUE>)
               (<VERB? OPEN>
                <TELL "You have no desire to see what lies within. Some mysteries are better left undisturbed." CR>
                <RTRUE>)
               (<VERB? TAKE>
                <TELL "You can't bring yourself to touch it." CR>
                <RTRUE>)>>

<OBJECT MORDECAI-JOURNAL
        (IN MORGUE)
        (SYNONYM JOURNAL DIARY NOTEBOOK BOOK)
        (ADJECTIVE DOCTOR MORDECAI)
        (DESC "doctor's journal")
        (LDESC "Dr. Mordecai's personal journal. The final entry describes an experimental procedure that went terribly wrong. The handwriting becomes increasingly erratic.")
        (FLAGS READBIT TAKEBIT)
        (TEXT "The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. I have made a terrible mistake. God forgive me, I must seal this place.")
        (SIZE 6)
        (ACTION JOURNAL-F)>

<ROUTINE JOURNAL-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "Dr. Mordecai's personal JOURNAL. The final entry is dated October 31, 1952. The handwriting becomes increasingly erratic: 'The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.'" CR>
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

<ROUTINE SERUM-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A glass VIAL containing a faintly glowing liquid. The label reads 'Compound 237 - DO NOT USE'. The SERUM pulses with an unnatural light." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "You bring the VIAL to your lips but your survival instinct stops you. This substance killed Patient 237. You lower the VIAL, hands trembling." CR>
                <RTRUE>)>>

<ROOM BASEMENT-STAIRS
      (IN ROOMS)
      (DESC "Basement Stairs")
      (LDESC "A narrow stone staircase descends into darkness. The air grows colder with each step. Moisture drips from the ceiling, and the walls are slick with condensation. The stairs lead down into the basement, while the entrance hall lies to the south.")
      (UP TO SANITARIUM-ENTRANCE)
      (DOWN TO BASEMENT-CORRIDOR)
      (FLAGS LIGHTBIT)>

<ROOM BASEMENT-CORRIDOR
      (IN ROOMS)
      (DESC "Basement Corridor")
      (LDESC "The basement corridor stretches into shadow. Water pools on the cracked floor. PIPES run along the ceiling, rusted and dripping. A heavy DOOR to the east is marked 'BOILER ROOM'. To the west, another passage leads deeper into the basement. The stairs ascend to darkness above.")
      (UP TO BASEMENT-STAIRS)
      (EAST TO BOILER-ROOM)
      (WEST TO STORAGE-ROOM)
      (NORTH TO FLOODING-CHAMBER)
      (FLAGS LIGHTBIT)>

<OBJECT PIPES
        (IN BASEMENT-CORRIDOR)
        (SYNONYM PIPES PIPE CEILING)
        (ADJECTIVE RUSTED DRIPPING)
        (DESC "rusty pipes")
        (LDESC "Ancient pipes run along the ceiling, rusted through in places.")
        (FLAGS NDESCBIT)
        (ACTION PIPES-F)>

<ROUTINE PIPES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The PIPES are ancient and corroded. Water drips steadily from cracks in the metal. One PIPE has a VALVE." CR>
                <RTRUE>)>>

<OBJECT VALVE
        (IN BASEMENT-CORRIDOR)
        (SYNONYM VALVE WHEEL)
        (ADJECTIVE PIPE METAL)
        (DESC "metal valve")
        (LDESC "A wheel valve on one of the pipes, crusted with rust.")
        (FLAGS NDESCBIT)
        (ACTION VALVE-F)>

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
                <TELL "A large wheel VALVE covered in rust and grime." CR>
                <RTRUE>)>>

<ROOM BOILER-ROOM
      (IN ROOMS)
      (DESC "Boiler Room")
      (LDESC "The boiler room is dominated by a massive iron BOILER, cold and silent. Coal dust covers everything. A WORKBENCH sits against the far wall, covered with ancient tools. The room radiates a sense of dormant power, waiting to awaken.")
      (WEST TO BASEMENT-CORRIDOR)
      (FLAGS LIGHTBIT)>

<OBJECT IRON-BOILER
        (IN BOILER-ROOM)
        (SYNONYM BOILER FURNACE)
        (ADJECTIVE IRON MASSIVE)
        (DESC "iron boiler")
        (LDESC "A massive iron boiler, its door hanging open to reveal a dark interior.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION BOILER-F)>

<ROUTINE BOILER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The BOILER is a hulking iron beast. Its door hangs open, revealing a chamber black with ancient soot. Inside, something gleams faintly." CR>
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

<ROUTINE SHOVEL-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy coal SHOVEL with a wooden handle. The blade is caked with ancient coal dust." CR>
                <RTRUE>)>>

<OBJECT WORKBENCH
        (IN BOILER-ROOM)
        (SYNONYM BENCH TABLE WORKBENCH)
        (ADJECTIVE WORK)
        (DESC "workbench")
        (LDESC "A sturdy workbench covered in tools and coal dust.")
        (FLAGS NDESCBIT SURFACEBIT)
        (ACTION WORKBENCH-F)>

<ROUTINE WORKBENCH-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The WORKBENCH is covered with ancient tools: hammers, wrenches, screwdrivers. Most are rusted solid. A FLASHLIGHT lies among them." CR>
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

<ROUTINE FLASHLIGHT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy metal FLASHLIGHT. The switch clicks but produces no light. The batteries are long dead." CR>
                <RTRUE>)
               (<VERB? LAMP-ON>
                <TELL "The batteries are dead. The FLASHLIGHT doesn't work." CR>
                <RTRUE>)>>

<ROOM STORAGE-ROOM
      (IN ROOMS)
      (DESC "Storage Room")
      (LDESC "SHELVES line the walls, sagging under the weight of moldering supplies. Old linens, rusted equipment, and unidentifiable containers fill every space. A sour smell permeates the air. The exit lies to the east.")
      (EAST TO BASEMENT-CORRIDOR)
      (FLAGS LIGHTBIT)>

<OBJECT SHELVES
        (IN STORAGE-ROOM)
        (SYNONYM SHELVES SHELF)
        (ADJECTIVE SAGGING)
        (DESC "shelves")
        (LDESC "Wooden shelves overloaded with decades of accumulated supplies.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION SHELVES-F)>

<ROUTINE SHELVES-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
                <TELL "You search through the SHELVES. Most items are ruined by time and moisture. Among the debris, you find a LANTERN and some old medical records." CR>
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
                <TELL "A brass oil LANTERN with a glass chimney. It still contains fuel." CR>
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

<ROUTINE RECORDS-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "You flip through the water-damaged RECORDS. Most are illegible, but one file remains clear: 'Patient 189 - Subject shows unusual resistance to sedation. Violent episodes increasing. Transferred to isolation ward for observation. Dr. Mordecai supervising.'" CR>
                <RTRUE>)>>

<ROOM FLOODING-CHAMBER
      (IN ROOMS)
      (DESC "Flooded Chamber")
      (LDESC "Water covers the floor to ankle depth. The chamber is vast and dark, with arched stone ceilings disappearing into shadow. The source of the water is unclear. To the north, a passage leads deeper into the complex. A DOOR to the east is sealed shut.")
      (SOUTH TO BASEMENT-CORRIDOR)
      (NORTH TO ISOLATION-WARD)
      (EAST TO HYDROTHERAPY-ROOM IF STEAM-DOOR-OPEN)
      (FLAGS LIGHTBIT)>

<OBJECT STANDING-WATER
        (IN FLOODING-CHAMBER)
        (SYNONYM WATER FLOOD PUDDLE)
        (ADJECTIVE STANDING ANKLE)
        (DESC "standing water")
        (LDESC "Cold water covering the floor.")
        (FLAGS NDESCBIT)
        (ACTION STANDING-WATER-F)>

<ROUTINE STANDING-WATER-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The WATER is cold and murky. You can't see the bottom through the darkness." CR>
                <RTRUE>)
               (<VERB? DRINK>
                <TELL "The WATER smells foul. You decide against it." CR>
                <RTRUE>)>>

<OBJECT SEALED-DOOR
        (IN FLOODING-CHAMBER)
        (SYNONYM DOOR)
        (ADJECTIVE SEALED EAST METAL)
        (DESC "sealed door")
        (LDESC "A heavy metal door sealed tight with corrosion.")
        (FLAGS NDESCBIT)
        (ACTION SEALED-DOOR-F)>

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

<ROOM HYDROTHERAPY-ROOM
      (IN ROOMS)
      (DESC "Hydrotherapy Room")
      (LDESC "Large porcelain TUBS line the walls, each fitted with restraints. Rubber hoses dangle from fixtures overhead. The tiles are cracked and stained. A CABINET stands in the corner, its door hanging loose.")
      (WEST TO FLOODING-CHAMBER)
      (FLAGS LIGHTBIT)>

<OBJECT PORCELAIN-TUBS
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM TUBS TUB BATH)
        (ADJECTIVE PORCELAIN)
        (DESC "porcelain tubs")
        (LDESC "Large medical tubs with leather restraints attached.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION TUBS-F)>

<ROUTINE TUBS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The TUBS are large enough to immerse a full-grown person. Leather restraints are bolted to the sides. Dark stains ring the waterline. One TUB contains a soggy NOTEBOOK." CR>
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

<ROUTINE SOGGY-NOTEBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The NOTEBOOK is badly water-damaged. You can make out fragments: '...water treatment...patients submerged for hours...screaming finally stopped...Dr. M approved extended sessions...'" CR>
                <RTRUE>)>>

<OBJECT MEDICINE-CABINET
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM CABINET CUPBOARD)
        (ADJECTIVE MEDICINE MEDICAL)
        (DESC "medicine cabinet")
        (LDESC "A metal cabinet with a loose door. Medical supplies visible inside.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION MEDICINE-CABINET-F)>

<ROUTINE MEDICINE-CABINET-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The CABINET contains old medical supplies. Most are ruined, but a SYRINGE and bandages remain usable." CR>
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

<ROUTINE SYRINGE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A medical SYRINGE with a sharp steel needle. The glass chamber is empty." CR>
                <RTRUE>)>>

<ROOM ISOLATION-WARD
      (IN ROOMS)
      (DESC "Isolation Ward")
      (LDESC "Small cells line both sides of a narrow corridor. Heavy DOORS with barred windows stand open, revealing bare concrete rooms within. Scratches cover the walls—thousands of them, as if someone counted the days. The corridor continues north to the electroshock theater.")
      (SOUTH TO FLOODING-CHAMBER)
      (NORTH TO ELECTROSHOCK-THEATER)
      (FLAGS LIGHTBIT)>

<OBJECT CELL-DOORS
        (IN ISOLATION-WARD)
        (SYNONYM DOORS DOOR CELLS)
        (ADJECTIVE CELL HEAVY BARRED)
        (DESC "cell doors")
        (LDESC "Heavy metal doors with small barred windows.")
        (FLAGS NDESCBIT)
        (ACTION CELL-DOORS-F)>

<ROUTINE CELL-DOORS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Each DOOR is solid metal with a small barred window. The cells beyond are empty save for scratches covering every surface. Someone marked time here, day after agonizing day." CR>
                <RTRUE>)>>

<OBJECT WALL-SCRATCHES
        (IN ISOLATION-WARD)
        (SYNONYM SCRATCHES MARKS TALLIES)
        (ADJECTIVE WALL)
        (DESC "wall scratches")
        (LDESC "Thousands of scratch marks covering the cell walls.")
        (FLAGS NDESCBIT)
        (ACTION WALL-SCRATCHES-F)>

<ROUTINE WALL-SCRATCHES-F ()
         <COND (<VERB? EXAMINE COUNT>
                <TELL "The SCRATCHES are too numerous to count. They cover every inch of the cell walls. Some form words: 'HELP ME' 'NO MORE' 'PLEASE'. One message is larger than the rest: 'PATIENT 189 STILL ALIVE IN THE CHAPEL'." CR>
                <RTRUE>)>>

<ROOM ELECTROSHOCK-THEATER
      (IN ROOMS)
      (DESC "Electroshock Theater")
      (LDESC "A concrete room with a CHAIR bolted to the floor in the center. Electrodes dangle from a MACHINE beside it. The walls are scorched in places. A viewing window overlooks the room from above. To the east, a stairway leads up. West lies a padded cell.")
      (SOUTH TO ISOLATION-WARD)
      (EAST TO OBSERVATION-DECK)
      (WEST TO PADDED-CELL)
      (FLAGS LIGHTBIT)>

<OBJECT SHOCK-CHAIR
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM CHAIR)
        (ADJECTIVE SHOCK ELECTRIC METAL)
        (DESC "electroshock chair")
        (LDESC "A metal chair with leather restraints and electrode attachments.")
        (FLAGS NDESCBIT)
        (ACTION SHOCK-CHAIR-F)>

<ROUTINE SHOCK-CHAIR-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The CHAIR is bolted to the floor. Leather restraints hang from the arms and legs. Electrodes are positioned where they would contact a victim's temples. You feel sick looking at it." CR>
                <RTRUE>)
               (<VERB? BOARD>
                <TELL "You have no desire to sit in that terrible chair." CR>
                <RTRUE>)>>

<OBJECT SHOCK-MACHINE
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM MACHINE EQUIPMENT ELECTRODES)
        (ADJECTIVE SHOCK ELECTRIC)
        (DESC "shock machine")
        (LDESC "A boxy machine with dials, switches, and dangling electrodes.")
        (FLAGS NDESCBIT)
        (ACTION SHOCK-MACHINE-F)>

<ROUTINE SHOCK-MACHINE-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The MACHINE has various dials and switches. Labels indicate voltage levels up to dangerous levels. The electrodes are stained dark." CR>
                <RTRUE>)>>

<ROOM PADDED-CELL
      (IN ROOMS)
      (DESC "Padded Cell")
      (LDESC "Every surface is covered in rotting PADDING, now torn and hanging in strips. The small room reeks of decay. A STRAITJACKET lies in the corner. Something has been written on the PADDING in what looks like dried blood.")
      (EAST TO ELECTROSHOCK-THEATER)
      (FLAGS LIGHTBIT)>

<OBJECT PADDING
        (IN PADDED-CELL)
        (SYNONYM PADDING WALLS)
        (ADJECTIVE ROTTING TORN)
        (DESC "padded walls")
        (LDESC "Torn padding revealing concrete beneath. Writing covers one wall.")
        (FLAGS NDESCBIT)
        (ACTION PADDING-F)>

<ROUTINE PADDING-F ()
         <COND (<VERB? EXAMINE READ>
                <TELL "The PADDING is torn and moldering. On one wall, written in what appears to be dried blood, are the words: 'THE CHAPEL BEYOND THE GARDEN. HE WAITS THERE. PATIENT 189.'." CR>
                <RTRUE>)>>

<OBJECT STRAITJACKET
        (IN PADDED-CELL)
        (SYNONYM STRAITJACKET JACKET)
        (ADJECTIVE STRAIT)
        (DESC "straitjacket")
        (LDESC "A canvas straitjacket with leather buckles.")
        (FLAGS TAKEBIT)
        (SIZE 15)
        (ACTION STRAITJACKET-F)>

<ROUTINE STRAITJACKET-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy canvas STRAITJACKET with multiple leather buckles and straps. Dark stains cover the fabric." CR>
                <RTRUE>)
               (<VERB? WEAR>
                <TELL "You'd rather not." CR>
                <RTRUE>)>>

<ROOM OBSERVATION-DECK
      (IN ROOMS)
      (DESC "Observation Deck")
      (LDESC "A small room overlooking the electroshock theater through a one-way MIRROR. Chairs face the window. A LOGBOOK rests on a desk. This is where doctors watched their experiments. Stairs lead down to the west, and a door to the north opens to the administrative wing.")
      (WEST TO ELECTROSHOCK-THEATER)
      (NORTH TO ADMINISTRATIVE-WING)
      (FLAGS LIGHTBIT)>

<OBJECT ONE-WAY-MIRROR
        (IN OBSERVATION-DECK)
        (SYNONYM MIRROR WINDOW GLASS)
        (ADJECTIVE ONE-WAY)
        (DESC "one-way mirror")
        (LDESC "A large window providing a clear view of the electroshock theater below.")
        (FLAGS NDESCBIT)
        (ACTION MIRROR-F)>

<ROUTINE MIRROR-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "Through the MIRROR, you can see the electroshock theater below. The SHOCK CHAIR sits in the center like a throne of suffering." CR>
                <RTRUE>)>>

<OBJECT OBSERVATION-LOGBOOK
        (IN OBSERVATION-DECK)
        (SYNONYM LOGBOOK LOG BOOK)
        (ADJECTIVE OBSERVATION)
        (DESC "observation logbook")
        (LDESC "A logbook documenting electroshock treatments.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be 'someone else' now. Dr. Mordecai pleased with results.")
        (SIZE 7)
        (ACTION OBSERVATION-LOGBOOK-F)>

<ROUTINE OBSERVATION-LOGBOOK-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The LOGBOOK contains clinical observations of treatments. One entry stands out: 'Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be someone else now. Dr. Mordecai pleased with results. Proceeding to next phase.'" CR>
                <RTRUE>)>>

<ROOM ADMINISTRATIVE-WING
      (IN ROOMS)
      (DESC "Administrative Wing")
      (LDESC "Offices line a carpeted corridor. Most doors hang open, revealing ransacked rooms. Filing cabinets are overturned, PAPERS scattered everywhere. To the east lies the director's office. North leads to the staff quarters. South returns to the observation deck.")
      (SOUTH TO OBSERVATION-DECK)
      (EAST TO DIRECTORS-OFFICE)
      (NORTH TO STAFF-QUARTERS)
      (FLAGS LIGHTBIT)>

<OBJECT SCATTERED-PAPERS
        (IN ADMINISTRATIVE-WING)
        (SYNONYM PAPERS FILES DOCUMENTS)
        (ADJECTIVE SCATTERED)
        (DESC "scattered papers")
        (LDESC "Papers strewn across the floor, mostly administrative documents.")
        (FLAGS NDESCBIT)
        (ACTION SCATTERED-PAPERS-F)>

<ROUTINE SCATTERED-PAPERS-F ()
         <COND (<VERB? EXAMINE READ SEARCH>
                <TELL "You sort through the PAPERS. Most are mundane: supply orders, staff schedules, building maintenance. One memo catches your eye: 'All staff reminded - Subject 189 is NOT to be released under any circumstances. Chapel is OFF LIMITS.'." CR>
                <RTRUE>)>>

<ROOM DIRECTORS-OFFICE
      (IN ROOMS)
      (DESC "Director's Office")
      (LDESC "A large office with wood paneling and a massive DESK. Bookshelves line the walls, filled with medical texts and journals. A PORTRAIT of Dr. Mordecai hangs above the DESK, his stern eyes seeming to follow you. A SAFE is visible behind a moved painting.")
      (WEST TO ADMINISTRATIVE-WING)
      (FLAGS LIGHTBIT)>

<OBJECT MASSIVE-DESK
        (IN DIRECTORS-OFFICE)
        (SYNONYM DESK)
        (ADJECTIVE MASSIVE WOOD)
        (DESC "massive desk")
        (LDESC "An imposing wooden desk with multiple drawers.")
        (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
        (ACTION MASSIVE-DESK-F)>

<ROUTINE MASSIVE-DESK-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The DESK is made of dark wood, highly polished. The drawers contain mostly empty folders and pens. A hidden compartment in the top drawer holds a KEY." CR>
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

<ROUTINE SAFE-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A small brass KEY with a tag reading 'S-001'. It looks like a safe key." CR>
                <RTRUE>)>>

<OBJECT MORDECAI-PORTRAIT
        (IN DIRECTORS-OFFICE)
        (SYNONYM PORTRAIT PAINTING PICTURE)
        (ADJECTIVE MORDECAI)
        (DESC "portrait of Dr. Mordecai")
        (LDESC "An oil painting of a severe-looking man in a white coat.")
        (FLAGS NDESCBIT)
        (ACTION PORTRAIT-F)>

<ROUTINE PORTRAIT-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The PORTRAIT shows Dr. Mordecai, a gaunt man with piercing eyes and a cruel mouth. The nameplate reads: 'Dr. Heinrich Mordecai - Director 1935-1952'. His eyes seem to follow you around the room." CR>
                <RTRUE>)>>

<OBJECT WALL-SAFE
        (IN DIRECTORS-OFFICE)
        (SYNONYM SAFE)
        (ADJECTIVE WALL METAL)
        (DESC "wall safe")
        (LDESC "A small wall safe behind where the painting hung.")
        (FLAGS NDESCBIT CONTBIT)
        (ACTION WALL-SAFE-F)>

<ROUTINE WALL-SAFE-F ()
         <COND (<AND <VERB? EXAMINE>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The SAFE is open. Inside you can see its contents." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>>
                <TELL "The SAFE is locked. It requires a key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <FSET? ,WALL-SAFE ,OPENBIT>>
                <TELL "The SAFE is already open." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
                     <NOT <IN? ,SAFE-KEY ,WINNER>>>
                <TELL "The SAFE is locked. You need the key." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
                     <IN? ,SAFE-KEY ,WINNER>>
                <TELL "You unlock the " D ,WALL-SAFE " with the " D ,SAFE-KEY ". Inside are Dr. Mordecai's private NOTES and a " D ,CHAPEL-KEY "." CR>
                <FSET ,WALL-SAFE ,OPENBIT>
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

<ROUTINE MORDECAI-NOTES-F ()
         <COND (<VERB? READ EXAMINE>
                <TELL "The NOTES are written in a shaking hand: 'October 30, 1952 - The experiment succeeded beyond my wildest expectations. Patient 189 has transcended death itself. But the cost... the screaming never stops. I hear it in my sleep. The others want to shut down the sanitarium. Fools! They don't understand what we've achieved. The chapel must remain locked. What I've created must never escape.'" CR>
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

<ROUTINE CHAPEL-KEY-F ()
         <COND (<VERB? EXAMINE>
                <TELL "A heavy iron KEY with a cross engraved on its head. The KEY feels unnaturally cold." CR>
                <RTRUE>)>>

<ROOM STAFF-QUARTERS
      (IN ROOMS)
      (DESC "Staff Quarters")
      (LDESC "A dormitory with rows of narrow beds. LOCKERS line one wall. Most are open and empty, their contents long gone. The air smells of mildew and abandonment. To the west is the cafeteria. South returns to the administrative wing.")
      (SOUTH TO ADMINISTRATIVE-WING)
      (WEST TO CAFETERIA)
      (FLAGS LIGHTBIT)>

<OBJECT LOCKERS
        (IN STAFF-QUARTERS)
        (SYNONYM LOCKERS LOCKER)
        (ADJECTIVE METAL)
        (DESC "lockers")
        (LDESC "Metal lockers, most standing open and empty.")
        (FLAGS NDESCBIT CONTBIT OPENBIT)
        (ACTION LOCKERS-F)>

<ROUTINE LOCKERS-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
                <TELL "Most LOCKERS are empty or contain rotted clothing. One LOCKER holds a nurse's uniform and a PHOTOGRAPH." CR>
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

<ROUTINE PHOTOGRAPH-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The PHOTOGRAPH shows the sanitarium staff posed outside the building. Dr. Mordecai stands in the center, unsmiling. Written on the back: 'Staff photo 1950. Two years before they closed us down. Two years before everything went wrong.'" CR>
                <RTRUE>)>>

<ROOM CAFETERIA
      (IN ROOMS)
      (DESC "Cafeteria")
      (LDESC "Long tables with attached benches fill the room. A serving COUNTER separates the dining area from the kitchen beyond. Trays and plates lie scattered about, covered in dust. A door to the north leads to the garden. East returns to the staff quarters.")
      (EAST TO STAFF-QUARTERS)
      (NORTH TO OVERGROWN-GARDEN)
      (FLAGS LIGHTBIT)>

<OBJECT SERVING-COUNTER
        (IN CAFETERIA)
        (SYNONYM COUNTER)
        (ADJECTIVE SERVING)
        (DESC "serving counter")
        (LDESC "A long counter with a pass-through to the kitchen.")
        (FLAGS NDESCBIT SURFACEBIT)
        (ACTION COUNTER-F)>

<ROUTINE COUNTER-F ()
         <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "The serving COUNTER is thick with dust. Old menus are still posted on the wall: 'Monday - Mystery Meat'. A BELL for summoning kitchen staff sits on the COUNTER." CR>
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

<ROUTINE BELL-F ()
         <COND (<VERB? RING>
                <TELL "You ring the BELL. The tinny sound echoes through the empty cafeteria. No one comes." CR>
                <RTRUE>)
               (<VERB? EXAMINE>
                <TELL "A small brass BELL with a button on top. It still works." CR>
                <RTRUE>)>>

<ROOM OVERGROWN-GARDEN
      (IN ROOMS)
      (DESC "Overgrown Garden")
      (LDESC "What was once a therapeutic GARDEN is now a wild tangle of weeds and dead plants. Broken benches lie among the overgrowth. A stone path, barely visible, leads to a small chapel to the north. The CHAPEL DOOR is secured with a heavy lock. South returns to the cafeteria.")
      (SOUTH TO CAFETERIA)
      (NORTH TO CHAPEL IF CHAPEL-UNLOCKED)
      (FLAGS LIGHTBIT)>

<OBJECT DEAD-GARDEN
        (IN OVERGROWN-GARDEN)
        (SYNONYM GARDEN WEEDS PLANTS)
        (ADJECTIVE DEAD OVERGROWN)
        (DESC "dead garden")
        (LDESC "A chaotic mass of dead plants and weeds.")
        (FLAGS NDESCBIT)
        (ACTION DEAD-GARDEN-F)>

<ROUTINE DEAD-GARDEN-F ()
         <COND (<VERB? EXAMINE SEARCH>
                <TELL "The GARDEN has been dead for decades. Thorny vines choke what remains of flower beds. Among the weeds, you can see broken stone benches and a crumbling fountain." CR>
                <RTRUE>)>>

<OBJECT CHAPEL-DOOR
        (IN OVERGROWN-GARDEN)
        (SYNONYM DOOR)
        (ADJECTIVE CHAPEL HEAVY LOCKED)
        (DESC "chapel door")
        (LDESC "A heavy wooden door bound with iron, secured by a large lock.")
        (FLAGS NDESCBIT)
        (ACTION CHAPEL-DOOR-F)>

<ROUTINE CHAPEL-DOOR-F ()
         <COND (<AND <VERB? EXAMINE>
                     <NOT ,CHAPEL-UNLOCKED>>
                <TELL "The DOOR is made of thick oak bound with iron straps. A large iron lock secures it. Above the DOOR, carved words read: 'HE WHO ENTERS ABANDONS HOPE'." CR>
                <RTRUE>)
               (<AND <VERB? EXAMINE>
                     ,CHAPEL-UNLOCKED>
                <TELL "The DOOR stands open, darkness visible beyond." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <NOT <IN? ,CHAPEL-KEY ,WINNER>>>
                <TELL "The DOOR is locked. You need the " D ,CHAPEL-KEY "." CR>
                <RTRUE>)
               (<AND <VERB? OPEN UNLOCK>
                     <NOT ,CHAPEL-UNLOCKED>
                     <IN? ,CHAPEL-KEY ,WINNER>>
                <TELL "You insert the " D ,CHAPEL-KEY " into the lock. It turns with a heavy CLUNK. The DOOR swings open slowly, revealing darkness beyond. A foul wind rushes out, carrying the scent of decay." CR>
                <SETG CHAPEL-UNLOCKED T>
                <RTRUE>)
               (<VERB? READ>
                <TELL "The words carved above the DOOR read: 'HE WHO ENTERS ABANDONS HOPE'." CR>
                <RTRUE>)>>

<ROOM CHAPEL
      (IN ROOMS)
      (DESC "Chapel")
      (LDESC "The chapel is small and dark. PEWS face an altar where a figure stands motionless. The air is thick and cold. CANDLES burn with an unnatural green flame. The figure at the altar turns to face you—its eyes glow faintly in the darkness. This is PATIENT 189, if you can still call it that. South lies the exit.")
      (SOUTH TO OVERGROWN-GARDEN)
      (FLAGS LIGHTBIT)>

<OBJECT PEWS
        (IN CHAPEL)
        (SYNONYM PEWS BENCHES)
        (ADJECTIVE WOODEN)
        (DESC "wooden pews")
        (LDESC "Rotting wooden pews facing the altar.")
        (FLAGS NDESCBIT)
        (ACTION PEWS-F)>

<ROUTINE PEWS-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The PEWS are ancient and rotting. Strange symbols are carved into the wood—symbols that hurt to look at." CR>
                <RTRUE>)>>

<OBJECT GREEN-CANDLES
        (IN CHAPEL)
        (SYNONYM CANDLES FLAMES)
        (ADJECTIVE GREEN UNNATURAL)
        (DESC "green candles")
        (LDESC "Candles burning with sickly green flames.")
        (FLAGS NDESCBIT)
        (ACTION GREEN-CANDLES-F)>

<ROUTINE GREEN-CANDLES-F ()
         <COND (<VERB? EXAMINE>
                <TELL "The CANDLES burn with green flames that give off no heat. The light makes everything look diseased." CR>
                <RTRUE>)>>

<OBJECT PATIENT-189
        (IN CHAPEL)
        (SYNONYM PATIENT FIGURE BEING)
        (ADJECTIVE PATIENT 189)
        (DESC "Patient 189")
        (LDESC "A figure that was once human. Its eyes glow with an unholy light.")
        (FLAGS NDESCBIT ACTORBIT)
        (ACTION PATIENT-189-F)>

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
                <RTRUE>)>>

<GLOBAL VALVE-TURNED-FLAG <>>
<GLOBAL STEAM-DOOR-OPEN <>>
<GLOBAL LANTERN-LIT-FLAG <>>
<GLOBAL CHAPEL-UNLOCKED <>>
<GLOBAL CHAINS-CUT-FLAG <>>
<ROUTINE GO ()
	<SETG HERE ,SANITARIUM-GATE>
	<THIS-IS-IT ,BRASS-PLAQUE>
	<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
	       <V-VERSION>
	       <CRLF>)>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
      <V-LOOK>
      <MAIN-LOOP>
	<AGAIN>>