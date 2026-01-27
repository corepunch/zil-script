-- Test file for horror.zil failing conditions
-- Tests that certain actions fail when prerequisites haven't been met
-- Demonstrates the use of test:no-flag and test:start-location

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
		-- Test 1: Verify drawer cannot be opened without unlocking first
		{
			input = "look",
			description = "Start game at Sanitarium Gate"
		},
		{
			start_location = "RECEPTION_ROOM",
			description = "Set starting location to Reception Room"
		},
		{
			input = "look",
			description = "Look at reception room"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is NOT open initially"
		},
		{
			input = "open drawer",
			description = "Try to open locked drawer (should fail)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is still NOT open (locked)"
		},
		
		-- Test 2: Unlock the drawer with key, then verify it can be opened
		{
			input = "take key",
			description = "Take the brass key"
		},
		{
			input = "unlock drawer with key",
			description = "Unlock the drawer with the key"
		},
		{
			input = "open drawer",
			description = "Open the now-unlocked drawer"
		},
		{
			flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open"
		},
		
		-- Test 3: Verify ledger cannot be taken without opening drawer first
		-- Reset to fresh state by setting location again
		{
			start_location = "RECEPTION_ROOM",
			description = "Reset to Reception Room (fresh state)"
		},
		{
			input = "look",
			description = "Look at reception room"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is NOT open in fresh state"
		},
		{
			input = "take ledger",
			description = "Try to take ledger from closed drawer (should fail)"
		},
		{
			input = "test:location PATIENT_LEDGER BOTTOM_DRAWER",
			description = "Verify ledger is still in drawer (not in inventory)"
		},
		
		-- Test 4: Verify items in different starting locations
		{
			start_location = "SANITARIUM_GATE",
			description = "Set starting location to Sanitarium Gate"
		},
		{
			here = "SANITARIUM_GATE",
			description = "Verify we are at Sanitarium Gate"
		},
		{
			input = "look",
			description = "Look at gate"
		},
		{
			flag = "BRASS_PLAQUE TAKEBIT",
			description = "Verify brass plaque has TAKEBIT flag"
		},
		{
			input = "take plaque",
			description = "Take the plaque"
		},
		{
			take = "BRASS_PLAQUE",
			description = "Verify plaque is now in inventory"
		},
		
		-- Test 5: Start in Reception Room
		{
			start_location = "RECEPTION_ROOM",
			description = "Set starting location to Reception Room"
		},
		{
			here = "RECEPTION_ROOM",
			description = "Verify we are at Reception Room"
		},
		{
			input = "look",
			description = "Look around reception room"
		},
		
		-- Test 6: Verify key can be taken
		{
			input = "take key",
			description = "Take brass key from floor"
		},
		{
			take = "BRASS_KEY",
			description = "Verify brass key in inventory"
		},
		
		-- Test 7: Test that without key, drawer cannot be unlocked
		{
			start_location = "RECEPTION_ROOM",
			description = "Reset to Reception Room (no key in inventory)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer starts locked"
		},
		{
			input = "unlock drawer",
			description = "Try to unlock drawer without key (should fail)"
		},
		{
			no_flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is still locked"
		},
		
		-- Test 8: Now take key and unlock properly
		{
			input = "take key",
			description = "Take the brass key"
		},
		{
			input = "unlock drawer with key",
			description = "Unlock drawer with the key"
		},
		{
			input = "open drawer",
			description = "Open the drawer"
		},
		{
			flag = "BOTTOM_DRAWER OPENBIT",
			description = "Verify drawer is now open"
		},
	}
}
