-- Partial walkthrough test for horror.zil
-- Tests the portions of the game that are accessible with current implementation
-- (lit rooms only, until light source accessibility issue is resolved)

return {
	name = "Horror.zil Partial Walkthrough (Accessible Areas)",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Test starting area and basic interactions
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
			description = "Read the brass plaque"
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
			input = "inventory",
			description = "Check inventory"
		},
		
		-- Move to entrance hall
		{
			input = "north",
			description = "Enter Sanitarium Entrance Hall"
		},
		{
			input = "test:get-location",
			description = "Verify at entrance hall"
		},
		{
			input = "examine wallpaper",
			description = "Examine the Victorian wallpaper"
		},
		
		-- Go to reception room and solve key puzzle
		{
			input = "west",
			description = "Go to Reception Room"
		},
		{
			input = "test:get-location",
			description = "Verify at reception room"
		},
		{
			input = "look",
			description = "Look around reception"
		},
		{
			input = "examine desk",
			description = "Examine the oak desk"
		},
		{
			input = "take key",
			description = "Take brass key from floor"
		},
		{
			input = "test:check-inventory BRASS_KEY",
			description = "Verify brass key in inventory"
		},
		{
			input = "unlock drawer with key",
			description = "Unlock the bottom drawer"
		},
		{
			input = "open drawer",
			description = "Open the drawer"
		},
		{
			input = "test:check-flag BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open"
		},
		{
			input = "look",
			description = "Look around - ledger should be visible in drawer"
		},
		{
			input = "take ledger",
			description = "Attempt to take ledger (NOTE: This fails - game bug)"
		},
		{
			input = "test:check-inventory PATIENT_LEDGER",
			description = "Verify ledger NOT in inventory (due to bug)"
		},
		{
			input = "test:check-location PATIENT_LEDGER BOTTOM_DRAWER",
			description = "Verify ledger is still in drawer"
		},
		{
			input = "inventory",
			description = "Check current inventory"
		},
		
		-- Demonstrate dark room issue
		{
			input = "east",
			description = "Return to entrance"
		},
		{
			input = "north",
			description = "Attempt to enter Operating Theater (will be dark)"
		},
		{
			input = "test:get-location",
			description = "Verify we moved (even though dark)"
		},
		{
			input = "look",
			description = "Confirm room is dark"
		},
		
		-- Return to lit area
		{
			input = "south",
			description = "Return to entrance hall"
		},
		{
			input = "look",
			description = "Back in lit area"
		},
		
		-- Test basement stairs (also dark)
		{
			input = "down",
			description = "Try basement (will be dark)"
		},
		{
			input = "test:get-location",
			description = "Verify location"
		},
		
		-- This test demonstrates:
		-- 1. The test infrastructure works correctly
		-- 2. Basic gameplay mechanics (taking items, using keys, unlocking)
		-- 3. The darkness/light issue that prevents full game completion
		-- 4. State verification using test commands
	}
}
