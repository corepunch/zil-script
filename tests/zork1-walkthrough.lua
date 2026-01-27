-- Test file for Zork I complete walkthrough
-- Based on standard Zork I walkthrough - tests major game progression  
-- Uses text assertions with first word of expected response (lowercase)
-- Object/room names from dungeon.zil

return {
	name = "Zork I Complete Walkthrough Test",
	files = {
		"zork1/globals.zil",
		"zork1/dungeon.zil",
		"zork1/actions.zil",
		"zork1/macros.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Beginning - mailbox and leaflet
		{input="open mailbox",text="opening",description="Open the mailbox"},
		{input="read leaflet",text="welcome",description="Read the welcome leaflet"},
		{input="take leaflet",text="taken",description="Take the leaflet"},
		{input="read leaflet",text="welcome",description="Read it again"},
		{input="drop leaflet",text="dropped",description="Drop the leaflet"},
		
		-- Navigate around the white house
		{input="south",here="SOUTH-OF-HOUSE",description="Go south of house"},
		{input="look",text="south",description="Look around south of house"},
		{input="west",here="WEST-OF-HOUSE",description="Go west of house"},
		{input="look",text="west",description="Look at west of house"},
		{input="examine house",text="house",description="Examine the white house"},
		{input="examine mailbox",text="mailbox",description="Examine the mailbox"},
		
		-- Continue exploring around house
		{input="north",here="NORTH-OF-HOUSE",description="Go north of house"},
		{input="look",text="north",description="Look at north of house"},
		{input="east",here="EAST-OF-HOUSE",description="Go to east of house (behind house)"},
		{input="look",text="behind",description="Look at behind house"},
		{input="examine window",text="window",description="Examine the kitchen window"},
		
		-- Go to the forest path
		{input="north",here="NORTH-OF-HOUSE",description="Go back to north of house"},
		{input="north",here="PATH",description="Go to the forest path"},
		{input="look",text="path",description="Look at the forest path"},
		{input="examine tree",text="tree",description="Examine the large tree"},
		
		-- Climb up the tree
		{input="up",text="tree",description="Climb up the tree"},
		{input="look",text="tree",description="Look around up in the tree"},
		{input="down",text="path",description="Climb back down"},
		
		-- Go to grating clearing
		{input="north",text="clearing",description="Go north to grating clearing"},
		{input="look",text="clearing",description="Look at the clearing"},
		{input="examine grating",text="grating",description="Examine the grating"},
		{input="open grating",text="grating",description="Open the grating"},
		{input="close grating",text="closed",description="Close the grating"},
		{input="open grating",text="grating",description="Open it again"},
		
		-- Return to house
		{input="south",text="path",description="Go back south"},
		{input="south",here="NORTH-OF-HOUSE",description="Go to north of house"},
		{input="south",here="WEST-OF-HOUSE",description="Go to west of house"},
		
		-- Explore south
		{input="south",here="SOUTH-OF-HOUSE",description="Go to south of house"},
		{input="east",here="EAST-OF-HOUSE",description="Go to east of house"},
		{input="east",text="clearing",description="Go east to clearing"},
		{input="look",text="clearing",description="Look at clearing"},
		{input="examine leaves",text="leaves",description="Examine the leaves"},
		
		-- Check what we can do with leaves
		{input="take leaves",text="taken",description="Take some leaves"},
		{input="drop leaves",text="dropped",description="Drop the leaves"},
		{input="take leaves",text="taken",description="Take them again"},
		
		-- Return to house again
		{input="west",here="EAST-OF-HOUSE",description="Go back to behind house"},
		{input="west",here="SOUTH-OF-HOUSE",description="Go to south of house"},
		{input="north",here="WEST-OF-HOUSE",description="Go to west of house"},
		
		-- Final look around
		{input="inventory",text="carrying",description="Check inventory"},
		{input="look",text="west",description="Final look at west of house"},
		
		-- Note: This walkthrough explores the exterior locations of Zork I
		-- and demonstrates object manipulation, navigation, and basic commands
		-- The full game includes entering the house and underground areas
		-- which require more complex interactions not yet fully supported
	}
}
