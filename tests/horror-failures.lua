-- Test file for horror.zil failing conditions
-- Tests that certain actions fail when prerequisites haven't been met
-- Demonstrates the use of test:no-flag and start command

return {
	name = "Horror.zil Failing Conditions Test",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		-- =================================================================
		-- Test 1: Drawer cannot be opened without unlocking first
		-- =================================================================
		{
			start = "RECEPTION_ROOM",
			description = "Start at Reception Room"
		},
		{
			input = "look",
			description = "Look at reception room"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is NOT open initially (precondition)"
		},
		{
			input = "open drawer",
			description = "Try to open locked drawer without unlocking (should fail)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is still NOT open after failed attempt"
		},
		
		-- =================================================================
		-- Test 2: With key, drawer can be unlocked and opened
		-- =================================================================
		{
			input = "take key",
			description = "Take the brass key from floor"
		},
		{
			input = "unlock drawer with key",
			description = "Unlock the drawer with the brass key"
		},
		{
			input = "open drawer",
			description = "Open the now-unlocked drawer"
		},
		{
			flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open (success condition)"
		},
		
		-- =================================================================
		-- Test 3: Start at different location - Sanitarium Gate
		-- =================================================================
		{
			start = "SANITARIUM_GATE",
			description = "Move to Sanitarium Gate"
		},
		{
			here = "SANITARIUM_GATE",
			description = "Verify we are at Sanitarium Gate"
		},
		{
			input = "look",
			description = "Look at gate area"
		},
		{
			flag = "BRASS_PLAQUE TAKEBIT",
			description = "Verify brass plaque has TAKEBIT flag"
		},
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		{
			take = "BRASS_PLAQUE",
			description = "Verify plaque is now in inventory"
		},
		
		-- =================================================================
		-- Test 4: Start at Reception Room again
		-- =================================================================
		{
			start = "RECEPTION_ROOM",
			description = "Move to Reception Room"
		},
		{
			here = "RECEPTION_ROOM",
			description = "Verify we are at Reception Room"
		},
		{
			input = "look",
			description = "Look around reception room"
		},
		
		-- =================================================================
		-- Test 5: Key can be taken from Reception Room floor
		-- =================================================================
		{
			input = "take key",
			description = "Take brass key from floor"
		},
		{
			take = "BRASS_KEY",
			description = "Verify brass key is in inventory"
		},
		
		-- =================================================================
		-- Test 6: Without key, drawer cannot be unlocked
		-- =================================================================
		{
			start = "RECEPTION_ROOM",
			description = "Reset to Reception Room (fresh state, no key)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer starts locked in fresh state"
		},
		{
			input = "unlock drawer",
			description = "Try to unlock drawer without key (should fail)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is still locked (no key to unlock with)"
		},
		
		-- =================================================================
		-- Test 7: Proper unlock sequence with key
		-- =================================================================
		{
			input = "take key",
			description = "Take the brass key"
		},
		{
			input = "unlock drawer with key",
			description = "Unlock drawer with the brass key"
		},
		{
			input = "open drawer",
			description = "Open the unlocked drawer"
		},
		{
			flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open (proper sequence)"
		},
		
		-- =================================================================
		-- Test 8: Start at Entrance Hall to test movement
		-- =================================================================
		{
			start = "SANITARIUM_ENTRANCE",
			description = "Move to Entrance Hall"
		},
		{
			here = "SANITARIUM_ENTRANCE",
			description = "Verify we are at Entrance Hall"
		},
		{
			input = "look",
			description = "Look at entrance hall"
		},
		
		-- =================================================================
		-- Test 9: Verify movement to dark room (Operating Theater)
		-- =================================================================
		{
			input = "north",
			description = "Move north to Operating Theater (dark room)"
		},
		{
			here = "OPERATING_THEATER",
			description = "Verify we moved to Operating Theater"
		},
	}
}
