<INSERT-FILE "zork1/globals">
<INSERT-FILE "zork1/clock">
<INSERT-FILE "zork1/parser">
<INSERT-FILE "zork1/verbs">
<INSERT-FILE "zork1/actions">
<INSERT-FILE "zork1/syntax">
<INSERT-FILE "zork1/dungeon">
<INSERT-FILE "zork1/actions">
<INSERT-FILE "zork1/main">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <ASSERT-TEXT "Opening the small mailbox reveals a leaflet." <CO-RESUME ,CO "open mailbox">>
    <ASSERT-TEXT "(Taken)" <CO-RESUME ,CO "read leaflet">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop leaflet">>
    <ASSERT-TEXT "South of House" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "With great effort, you open the window far enough to allow entry." <CO-RESUME ,CO "open window">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "enter house">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take lamp">>
    <ASSERT-TEXT "With a great effort, the rug is moved to one side of the room, revealing the dusty cover of a closed trap door." <CO-RESUME ,CO "move rug">>
    <ASSERT-TEXT "The door reluctantly opens to reveal a rickety staircase descending into darkness." <CO-RESUME ,CO "open trap door">>
    <ASSERT-TEXT "The brass lantern is now on." <CO-RESUME ,CO "turn on lamp">>
    <ASSERT-TEXT "The trap door crashes shut, and you hear someone barring it." <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "East of Chasm" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Gallery" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take painting">>
    <ASSERT-TEXT "Studio" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "walk up chimney">>
    <ASSERT-TEXT "Attic" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take knife">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take rope">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Opened." <CO-RESUME ,CO "open case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put painting inside case">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop knife">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take sword">>
    <ASSERT-TEXT "The door reluctantly opens to reveal a rickety staircase descending into darkness." <CO-RESUME ,CO "open trap door">>
    <ASSERT-TEXT "The trap door crashes shut, and you hear someone barring it." <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk north">>
    <ASSERT "You are still recovering from that last blow, so your attack is ineffective." <CO-RESUME ,CO "kill troll with sword">>
    <ASSERT "Clang! Crash! The troll parries." <CO-RESUME ,CO "kill troll with sword">>
    <ASSERT "The troll is confused and can't fight back." <CO-RESUME ,CO "kill troll with sword">>
    <ASSERT "The troll is knocked out!" <CO-RESUME ,CO "kill troll with sword">>
    <ASSERT "The unarmed troll cannot defend himself: He dies." <CO-RESUME ,CO "kill troll with sword">>
    <ASSERT "The troll is knocked out!" <CO-RESUME ,CO "kill troll with sword" T> ,TROLL-FLAG>
    <ASSERT "Drop sword if present" <CO-RESUME ,CO "drop sword">>
    ;<ASSERT-TEXT "You are still recovering from that last blow, so your attack is ineffective." <CO-RESUME ,CO "kill troll with sword">>
    ;<ASSERT-TEXT "Clang! Crash! The troll parries." <CO-RESUME ,CO "kill troll with sword">>
    ;<ASSERT-TEXT "The troll is confused and can't fight back." <CO-RESUME ,CO "kill troll with sword">>
    ;<ASSERT-TEXT "The troll is knocked out!" <CO-RESUME ,CO "kill troll with sword">>
    ;<ASSERT-TEXT "The unarmed troll cannot defend himself: He dies." <CO-RESUME ,CO "kill troll with sword">>
    ;<ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop sword">>
    <ASSERT-TEXT "East-West Passage" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Round Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Engravings Cave" <CO-RESUME ,CO "walk southe">>
    <ASSERT-TEXT "Dome Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "The rope drops over the side and comes within ten feet of the floor." <CO-RESUME ,CO "tie rope to railing">>
    <ASSERT-TEXT "Torch Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Temple" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Egyptian Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take coffin">>
    <ASSERT-TEXT "Temple" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Altar" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Forest" <CO-RESUME ,CO "pray">>
    <ASSERT-TEXT "The brass lantern is now off." <CO-RESUME ,CO "turn off lamp">>
    <ASSERT-TEXT "Forest" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Clearing" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Canyon View" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Rocky Ledge" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Canyon Bottom" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "End of Rainbow" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop coffin">>
    <ASSERT-TEXT "The gold coffin opens." <CO-RESUME ,CO "open coffin">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take sceptre">>
    <ASSERT-TEXT "Suddenly, the rainbow appears to become solid and, I venture, walkable (I think the giveaway was the stairs and bannister)." <CO-RESUME ,CO "wave sceptre">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take gold">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take coffin">>
    <ASSERT-TEXT "Canyon Bottom" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Rocky Ledge" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Canyon View" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Clearing" <CO-RESUME ,CO "walk northwest">>
    <ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "enter house">>
    <ASSERT-TEXT "Opening the brown sack reveals a lunch, and a clove of garlic." <CO-RESUME ,CO "open bag">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take garlic">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put coffin in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put gold in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put sceptre in case">>
    <ASSERT-TEXT "The door reluctantly opens to reveal a rickety staircase descending into darkness." <CO-RESUME ,CO "open trap door">>
    <ASSERT-TEXT "The brass lantern is now on." <CO-RESUME ,CO "turn on lamp">>
    <ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "East-West Passage" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Chasm" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Reservoir South" <CO-RESUME ,CO "walk northe">>
    <ASSERT-TEXT "Dam" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Dam Lobby" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take matches">>
    <ASSERT-TEXT "Maintenance Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take wrench">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take screwdriver">>
    <ASSERT-TEXT "Click." <CO-RESUME ,CO "push yellow button">>
    <ASSERT-TEXT "Dam Lobby" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Dam" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "The sluice gates open and water pours through the dam." <CO-RESUME ,CO "turn bolt with wrench">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop wrench">>
    <ASSERT-TEXT "Deep Canyon" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Loud Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Engravings Cave", start="ROUND-ROOM" <CO-RESUME ,CO "walk southe">>
    <ASSERT-TEXT "Dome Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Torch Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take torch">>
    <ASSERT-TEXT "The brass lantern is now off." <CO-RESUME ,CO "turn off lamp">>
    <ASSERT-TEXT "Temple" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take bell">>
    <ASSERT-TEXT "Altar" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take candles">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take book">>
    <ASSERT-TEXT "Cave" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Entrance to Hades" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "The bell suddenly becomes red hot and falls to the ground." <CO-RESUME ,CO "ring bell">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take candles">>
    <ASSERT-TEXT "One of the matches starts to burn." <CO-RESUME ,CO "light match">>
    <ASSERT-TEXT "The candles are lit." <CO-RESUME ,CO "light candles with match">>
    <ASSERT-TEXT "Each word of the prayer reverberates through the hall in a deafening confusion." <CO-RESUME ,CO "read book">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop book">>
    <ASSERT-TEXT "Land of the Dead" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take skull">>
    <ASSERT-TEXT "Entrance to Hades" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Cave" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Mirror Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "There is a rumble from deep within the earth and the room shakes." <CO-RESUME ,CO "rub mirror">>
    <ASSERT-TEXT "Cold Passage" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Slide Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Mine Entrance" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Squeaky Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "You are carrying:" <CO-RESUME ,CO "inventory">>
    <ASSERT-TEXT "Bat Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Shaft Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put torch in basket">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put screwdriver in basket">>
    <ASSERT-TEXT "The brass lantern is now on." <CO-RESUME ,CO "turn on lamp">>
    <ASSERT-TEXT "Smelly Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Gas Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk northe">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk southe">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Ladder Top" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Ladder Bottom" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Dead End" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take coal">>
    <ASSERT-TEXT "Ladder Bottom" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Ladder Top" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Gas Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Smelly Room" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Shaft Room" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put coal in basket">>
    <ASSERT-TEXT "The basket is lowered to the bottom of the shaft." <CO-RESUME ,CO "lower basket">>
    <ASSERT-TEXT "Smelly Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Gas Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk northe">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk southe">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Ladder Top" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Ladder Bottom" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Timber Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "crystal skull: Dropped." <CO-RESUME ,CO "drop all">>
    <ASSERT-TEXT "Drafty Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take coal">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take screwdriver">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take torch">>
    <ASSERT-TEXT "Machine Room" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "The lid opens." <CO-RESUME ,CO "open lid">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put coal in machine">>
    <ASSERT-TEXT "The lid closes." <CO-RESUME ,CO "close lid">>
    <ASSERT-TEXT "The machine comes to life (figuratively) with a dazzling display of colored lights and bizarre noises. After a few moments, the excitement abates." <CO-RESUME ,CO "turn switch with screwdriver">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop screwdriver">>
    <ASSERT-TEXT "The lid opens, revealing a huge diamond." <CO-RESUME ,CO "open lid">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take diamond">>
    <ASSERT-TEXT "Drafty Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put torch in basket">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put diamond in basket">>
    <ASSERT-TEXT "Timber Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take skull">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take lamp">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take garlic">>
    <ASSERT-TEXT "Ladder Bottom" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Ladder Top" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Coal Mine" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Gas Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take bracelet">>
    <ASSERT-TEXT "Smelly Room" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Shaft Room" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "The basket is raised to the top of the shaft." <CO-RESUME ,CO "raise basket">>
    <ASSERT-TEXT "The basket contains:" <CO-RESUME ,CO "look in basket">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take diamond">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take torch">>
    <ASSERT-TEXT "The brass lantern is now off." <CO-RESUME ,CO "turn off lamp">>
    <ASSERT-TEXT "Bat Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take jade">>
    <ASSERT-TEXT "Squeaky Room" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Mine Entrance" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Slide Room" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "You are carrying:" <CO-RESUME ,CO "inventory">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put jade in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put diamond in case">>
    <ASSERT-TEXT "The brass lantern is now on." <CO-RESUME ,CO "turn on lamp">>
    <ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "East-West Passage" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Chasm" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Reservoir South" <CO-RESUME ,CO "walk northe">>
    <ASSERT-TEXT "Reservoir" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take trunk">>
    <ASSERT-TEXT "Reservoir North" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take pump">>
    <ASSERT-TEXT "Atlantis Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Your load is too heavy." <CO-RESUME ,CO "take trident">>
    <ASSERT-TEXT "You are carrying:" <CO-RESUME ,CO "inventory">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop torch">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take trident">>
    <ASSERT-TEXT "Reservoir North" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Reservoir" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Reservoir South" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Dam" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Dam Base" <CO-RESUME ,CO "walk east">>
    ;"replaced command to use new INFLAT syntax"
    <ASSERT-TEXT "The boat inflates and appears seaworthy." <CO-RESUME ,CO "inflat plastic with pump">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop pump">>
    <ASSERT-TEXT "You are now in the magic boat." <CO-RESUME ,CO "walk inside boat">>
    <ASSERT-TEXT "(magic boat)" <CO-RESUME ,CO "launch">>
    <ASSERT-TEXT "Time passes..." <CO-RESUME ,CO "wait">>
    <ASSERT-TEXT "Time passes..." <CO-RESUME ,CO "wait">>
    <ASSERT-TEXT "Time passes..." <CO-RESUME ,CO "wait">>
    <ASSERT-TEXT "Time passes..." <CO-RESUME ,CO "wait">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take buoy">>
    <ASSERT-TEXT "The magic boat comes to a rest on the shore." <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "You are on your own feet again." <CO-RESUME ,CO "leave boat">>
    <ASSERT-TEXT "Your load is too heavy." <CO-RESUME ,CO "take shovel">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop garlic">>
    <ASSERT-TEXT "Your load is too heavy." <CO-RESUME ,CO "take shovel">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop buoy">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take shovel">>
    <ASSERT-TEXT "Sandy Cave" <CO-RESUME ,CO "walk northe">>
    <ASSERT-TEXT "What do you want to dig?" <CO-RESUME ,CO "dig">>
    <ASSERT-TEXT "(with the shovel)" <CO-RESUME ,CO "sand">>
    <ASSERT-TEXT "(with the shovel)" <CO-RESUME ,CO "dig sand">>
    <ASSERT-TEXT "(with the shovel)" <CO-RESUME ,CO "dig sand">>
    <ASSERT-TEXT "(with the shovel)" <CO-RESUME ,CO "dig sand">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop shovel">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take scarab">>
    <ASSERT-TEXT "Sandy Beach" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Opening the red buoy reveals a large emerald." <CO-RESUME ,CO "open buoy">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take emerald">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take garlic">>
    <ASSERT-TEXT "Shore" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Aragain Falls" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "End of Rainbow" <CO-RESUME ,CO "cross rainbow">>
    <ASSERT-TEXT "The brass lantern is now off." <CO-RESUME ,CO "turn off lamp">>
    <ASSERT-TEXT "Canyon Bottom" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Rocky Ledge" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Canyon View" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Clearing" <CO-RESUME ,CO "walk northwest">>
    <ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "enter house">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "You are carrying:" <CO-RESUME ,CO "inventory">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put emerald in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put scarab in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put trident in case">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put jewels in case">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "North of House" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Forest Path" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Up a Tree" <CO-RESUME ,CO "climb tree">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take egg">>
    <ASSERT-TEXT "(tree)" <CO-RESUME ,CO "climb down">>
    <ASSERT-TEXT "North of House" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "enter house">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "The brass lantern is now on." <CO-RESUME ,CO "turn on lamp">>
    <ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk north">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take coins">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take key">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk southwest">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Cyclops Room" <CO-RESUME ,CO "walk southe">>
    <ASSERT-TEXT "The cyclops, hearing the name of his father's deadly nemesis, flees the room by knocking down the wall on the east of the room." <CO-RESUME ,CO "Ulysses">>
    <ASSERT "Move thief to Cyclops Room for testing" <CO-RESUME ,CO "test:move THIEF CYCLOPS-ROOM">>
    <ASSERT-TEXT "The thief is taken aback by your unexpected generosity, but accepts the jewel-encrusted egg and stops to admire its beauty." <CO-RESUME ,CO "give egg to thief">>
    <ASSERT-TEXT "Strange Passage" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk east">>
    <ASSERT-TEXT "Done." <CO-RESUME ,CO "put coins in case">>
    <ASSERT-TEXT "Taken." <CO-RESUME ,CO "take knife">>
    <ASSERT-TEXT "Strange Passage" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Cyclops Room" <CO-RESUME ,CO "walk west">>
    <ASSERT "Move thief to Treasure Room for encounter" <MOVE ,THIEF ,TREASURE-ROOM>>
    <ASSERT "Enter Treasure Room" <CO-RESUME ,CO "walk up"> <?== ,HERE ,TREASURE-ROOM>>
    ;<ASSERT-TEXT "The thief is disarmed by a subtle feint past his guard." <CO-RESUME ,CO "kill thief with knife">>
    ;<ASSERT-TEXT "You dodge as the thief comes in low." <CO-RESUME ,CO "kill thief with knife">>
    ;<ASSERT-TEXT "It's curtains for the thief as your nasty knife removes his head." <CO-RESUME ,CO "kill thief with knife">>
    <ASSERT "The thief is disarmed by a subtle feint past his guard." <CO-RESUME ,CO "kill thief with knife">>
    <ASSERT "You dodge as the thief comes in low." <CO-RESUME ,CO "kill thief with knife">>
    <ASSERT "It's curtains for the thief as your nasty knife removes his head." <CO-RESUME ,CO "kill thief with knife">>
    <ASSERT-TEXT "stiletto: Taken." <CO-RESUME ,CO "take all">>
    <ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop stiletto">>
    <ASSERT "Drop torch if present" <CO-RESUME ,CO "drop torch">>
    <ASSERT-TEXT "Cyclops Room" <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk northwest">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk west">>
    <ASSERT-TEXT "Maze" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "You won't be able to get back up to the tunnel you are going through when it gets to the next room." <CO-RESUME ,CO "walk down">>
    <ASSERT-TEXT "Grating Room" <CO-RESUME ,CO "walk northe">>
    ;[" <ASSERT-TEXT "grate" description="Unlock the grate" <CO-RESUME ,CO "unlock grate">> "]
    <CO-RESUME ,CO "unlock grate">
    <ASSERT-TEXT "The grating opens to reveal trees above you." <CO-RESUME ,CO "open grate">>
    <ASSERT-TEXT "Clearing" <CO-RESUME ,CO "walk up">>
    <ASSERT-TEXT "Forest Path" <CO-RESUME ,CO "walk south">>
    <ASSERT-TEXT "Up a Tree" <CO-RESUME ,CO "climb tree">>
    ;<ASSERT-TEXT "The canary chirps, slightly off-key, an aria from a forgotten opera. From out of the greenery flies a lovely songbird. It perches on a limb just over your head and opens its beak to sing. As it does so a beautiful brass bauble drops from its mouth, bounces off the top of your head, and lands glimmering in the grass. As the canary winds down, the songbird flies away." <CO-RESUME ,CO "wind up canary">>
    ;<ASSERT-TEXT "Forest Path" <CO-RESUME ,CO "walk down">>
    ;<ASSERT-TEXT "You're holding too many things already!" <CO-RESUME ,CO "take bauble">>
    ;<ASSERT-TEXT "Dropped." <CO-RESUME ,CO "drop knife">>
    ;<ASSERT-TEXT "Taken." <CO-RESUME ,CO "take bauble">>
    ;<ASSERT-TEXT "North of House" <CO-RESUME ,CO "walk south">>
    ;<ASSERT-TEXT "Behind House" <CO-RESUME ,CO "walk east">>
    ;<ASSERT-TEXT "Kitchen" <CO-RESUME ,CO "enter house">>
    ;<ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk west">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put bauble in case">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put chalice in case">>
    ;<ASSERT-TEXT "Taken." <CO-RESUME ,CO "take canary from egg">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put canary in case">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put egg in case">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put bracelet in case">>
    ;<ASSERT-TEXT "Done." <CO-RESUME ,CO "put skull in case">>
    ;<ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk down">>
    ;<ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk north">>
    ;<ASSERT-TEXT "East-West Passage" <CO-RESUME ,CO "walk east">>
    ;<ASSERT-TEXT "Round Room" <CO-RESUME ,CO "walk east">>
    ;<ASSERT-TEXT "Loud Room" <CO-RESUME ,CO "walk east">>
    ;<ASSERT-TEXT "The acoustics of the room change subtly." <CO-RESUME ,CO "echo">>
    ;<ASSERT-TEXT "Taken." <CO-RESUME ,CO "take bar">>
    ;<ASSERT-TEXT "Round Room" <CO-RESUME ,CO "walk west">>
    ;<ASSERT-TEXT "East-West Passage" <CO-RESUME ,CO "walk west">>
    ;<ASSERT-TEXT "The Troll Room" <CO-RESUME ,CO "walk west">>
    ;<ASSERT-TEXT "Cellar" <CO-RESUME ,CO "walk south">>
    ;<ASSERT-TEXT "Living Room" <CO-RESUME ,CO "walk up">>
    ;<ASSERT-TEXT "Done" <CO-RESUME ,CO "put bar in case">>

    <print "Tests are completed" CR>>
