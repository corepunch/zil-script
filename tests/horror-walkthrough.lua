-- Test file for horror.zil complete walkthrough
-- Based on horror-walkthrough.md - tests that the game is winnable

return {
	name = "Horror.zil Complete Walkthrough Test",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Act 1: Entrance and Upper Floors
		-- Note: Object names use underscores (e.g., BRASS_PLAQUE) because ZIL hyphens
		-- are converted to underscores during Lua compilation
		{
			input = "look",
			description = "Start at Sanitarium Gate"
		},
		{
			input = "test:get-location",
			description = "Verify starting location"
		},
		{
			input = "examine plaque",
			description = "Learn about Blackwood Sanitarium"
		},
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		{
			input = "test:check-inventory BRASS_PLAQUE",
			description = "Verify plaque is in inventory"
		},
		{
			input = "north",
			description = "Enter Sanitarium Entrance Hall"
		},
		{
			input = "test:get-location",
			description = "Verify at entrance"
		},
		{
			input = "examine wallpaper",
			description = "Notice the Victorian-era decay"
		},
		{
			input = "west",
			description = "Go to Reception Room"
		},
		{
			input = "take key",
			description = "Take brass key from scattered papers"
		},
		{
			input = "test:check-inventory BRASS_KEY",
			description = "Verify brass key in inventory"
		},
		{
			input = "examine desk",
			description = "Notice the bottom drawer is locked"
		},
		{
			input = "unlock drawer",
			description = "Unlock bottom drawer with brass key"
		},
		{
			input = "test:check-flag BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open"
		},
		{
			input = "take ledger",
			description = "Take patient ledger from drawer"
		},
		{
			input = "test:check-inventory PATIENT_LEDGER",
			description = "Verify ledger in inventory"
		},
		{
			input = "read ledger",
			description = "Learn about Patient 237 and Dr. Mordecai"
		},
		{
			input = "east",
			description = "Return to Entrance Hall"
		},
		{
			input = "north",
			description = "Go to Operating Theater"
		},
		{
			input = "examine table",
			description = "See the gruesome operating table"
		},
		{
			input = "examine cabinet",
			description = "Notice the medical cabinet"
		},
		{
			input = "take scalpel",
			description = "Take scalpel - important tool"
		},
		{
			input = "test:check-inventory SCALPEL",
			description = "Verify scalpel in inventory"
		},
		{
			input = "take bottle",
			description = "Take ether bottle"
		},
		{
			input = "south",
			description = "Return to Entrance Hall"
		},
		{
			input = "east",
			description = "Go to Patient Ward"
		},
		{
			input = "examine beds",
			description = "See the deteriorated ward"
		},
		{
			input = "examine door",
			description = "Notice chains blocking morgue"
		},
		{
			input = "attack chains",
			description = "Cut through chains with scalpel"
		},
		{
			input = "north",
			description = "Enter Morgue"
		},
		{
			input = "test:get-location",
			description = "Verify at morgue"
		},
		{
			input = "examine drawers",
			description = "Find glowing contents"
		},
		{
			input = "take serum",
			description = "Take strange glowing serum (Compound 237)"
		},
		{
			input = "test:check-inventory GLOWING_SERUM",
			description = "Verify serum in inventory"
		},
		{
			input = "examine bundle",
			description = "See canvas-wrapped body"
		},
		{
			input = "take journal",
			description = "Take Dr. Mordecai's journal"
		},
		{
			input = "read journal",
			description = "Learn about the terrible experiment"
		},
		
		-- Act 2: Basement Exploration
		{
			input = "south",
			description = "Return to Patient Ward"
		},
		{
			input = "west",
			description = "Return to Entrance Hall"
		},
		{
			input = "down",
			description = "Descend to Basement Stairs"
		},
		{
			input = "down",
			description = "Continue to Basement Corridor"
		},
		{
			input = "examine pipes",
			description = "Notice the valve"
		},
		{
			input = "turn valve",
			description = "Release steam - important for later"
		},
		{
			input = "east",
			description = "Enter Boiler Room"
		},
		{
			input = "examine boiler",
			description = "See the massive iron furnace"
		},
		{
			input = "open boiler",
			description = "Open the boiler"
		},
		{
			input = "take shovel",
			description = "Take coal shovel"
		},
		{
			input = "examine workbench",
			description = "Find tools"
		},
		{
			input = "take flashlight",
			description = "Take flashlight (dead batteries)"
		},
		{
			input = "west",
			description = "Return to Basement Corridor"
		},
		{
			input = "west",
			description = "Enter Storage Room"
		},
		{
			input = "examine shelves",
			description = "Find supplies"
		},
		{
			input = "take lantern",
			description = "Take oil lantern - working light"
		},
		{
			input = "test:check-inventory OIL_LANTERN",
			description = "Verify lantern in inventory"
		},
		{
			input = "light lantern",
			description = "Illuminate the darkness"
		},
		{
			input = "test:check-flag OIL_LANTERN ONBIT",
			description = "Verify lantern is lit"
		},
		{
			input = "take records",
			description = "Take medical records"
		},
		{
			input = "read records",
			description = "Learn about Patient 189"
		},
		{
			input = "east",
			description = "Return to Basement Corridor"
		},
		{
			input = "north",
			description = "Enter Flooding Chamber"
		},
		{
			input = "examine water",
			description = "Cold ankle-deep water"
		},
		{
			input = "examine door",
			description = "Sealed door to east - needs steam"
		},
		{
			input = "open door",
			description = "Steam has loosened it - access Hydrotherapy"
		},
		{
			input = "east",
			description = "Enter Hydrotherapy Room"
		},
		{
			input = "examine tubs",
			description = "See restraint-equipped tubs"
		},
		{
			input = "look in tubs",
			description = "Find notebook"
		},
		{
			input = "take notebook",
			description = "Take soggy notebook"
		},
		{
			input = "read notebook",
			description = "Learn about water torture"
		},
		{
			input = "examine cabinet",
			description = "Medicine cabinet"
		},
		{
			input = "take syringe",
			description = "Take syringe"
		},
		{
			input = "west",
			description = "Return to Flooding Chamber"
		},
		{
			input = "north",
			description = "Enter Isolation Ward"
		},
		{
			input = "examine doors",
			description = "See the cell doors"
		},
		{
			input = "examine scratches",
			description = "Critical clue: PATIENT 189 STILL ALIVE IN THE CHAPEL"
		},
		{
			input = "north",
			description = "Enter Electroshock Theater"
		},
		{
			input = "examine chair",
			description = "The terrible shock chair"
		},
		{
			input = "examine machine",
			description = "Electroshock equipment"
		},
		{
			input = "west",
			description = "Enter Padded Cell"
		},
		{
			input = "examine padding",
			description = "Blood message about chapel and Patient 189"
		},
		{
			input = "take jacket",
			description = "Take straitjacket (optional)"
		},
		{
			input = "east",
			description = "Return to Electroshock Theater"
		},
		
		-- Act 3: Administrative Wing and Final Confrontation
		{
			input = "east",
			description = "Climb to Observation Deck"
		},
		{
			input = "examine mirror",
			description = "One-way mirror overlooking theater"
		},
		{
			input = "take logbook",
			description = "Take observation logbook"
		},
		{
			input = "read logbook",
			description = "Learn about Patient 189's treatment"
		},
		{
			input = "north",
			description = "Enter Administrative Wing"
		},
		{
			input = "examine papers",
			description = "Find memo about Patient 189 and chapel"
		},
		{
			input = "east",
			description = "Enter Director's Office"
		},
		{
			input = "examine portrait",
			description = "See Dr. Heinrich Mordecai's portrait"
		},
		{
			input = "examine desk",
			description = "Find hidden compartment"
		},
		{
			input = "take key",
			description = "Take safe key"
		},
		{
			input = "test:check-inventory SAFE_KEY",
			description = "Verify safe key in inventory"
		},
		{
			input = "examine safe",
			description = "Notice wall safe"
		},
		{
			input = "unlock safe",
			description = "Open safe with safe key"
		},
		{
			input = "test:check-flag WALL_SAFE OPENBIT",
			description = "Verify safe is open"
		},
		{
			input = "take notes",
			description = "Take Dr. Mordecai's private notes"
		},
		{
			input = "read notes",
			description = "Learn Patient 189 transcended death"
		},
		{
			input = "take key",
			description = "Take chapel key (iron key with cross)"
		},
		{
			input = "test:check-inventory CHAPEL_KEY",
			description = "Verify chapel key in inventory"
		},
		{
			input = "west",
			description = "Return to Administrative Wing"
		},
		{
			input = "north",
			description = "Enter Staff Quarters"
		},
		{
			input = "examine lockers",
			description = "Find personal items"
		},
		{
			input = "take photograph",
			description = "Take staff photo from 1950"
		},
		{
			input = "examine photograph",
			description = "See the sanitarium staff"
		},
		{
			input = "west",
			description = "Enter Cafeteria"
		},
		{
			input = "examine counter",
			description = "Old service area"
		},
		{
			input = "take bell",
			description = "Take service bell (optional)"
		},
		{
			input = "north",
			description = "Enter Overgrown Garden"
		},
		{
			input = "examine garden",
			description = "Wild tangle of dead plants"
		},
		{
			input = "examine door",
			description = "Chapel door with ominous message"
		},
		{
			input = "unlock door",
			description = "Use chapel key to unlock final area"
		},
		{
			input = "north",
			description = "Enter Chapel - Final Location"
		},
		{
			input = "test:get-location",
			description = "Verify at chapel - final location"
		},
		{
			input = "examine pews",
			description = "Strange carved symbols"
		},
		{
			input = "examine candles",
			description = "Unnatural green flames"
		},
		{
			input = "examine patient",
			description = "Patient 189 - Dr. Mordecai's achievement"
		},
		{
			input = "hello",
			description = "WIN CONDITION - Patient 189 speaks and crumbles to ash"
		},
	}
}
