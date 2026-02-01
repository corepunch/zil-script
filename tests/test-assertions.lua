-- Test file to verify assertion commands work correctly
return {
	name = "Test Assertion Commands",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"adventure.horror",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"zork1.main",
	},
	commands = {
		{
			input = "look",
			description = "Start game"
		},
		-- Test assert-inventory with false expectation (should pass - plaque not in inventory yet)
		{
			input = "test:assert-inventory BRASS_PLAQUE false",
			description = "Assert brass plaque is NOT in inventory (should pass)"
		},
		-- Take the plaque
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		-- Test assert-inventory with true expectation (should pass - plaque now in inventory)
		{
			input = "test:assert-inventory BRASS_PLAQUE true",
			description = "Assert brass plaque IS in inventory (should pass)"
		},
		-- Test assert-inventory with false expectation (should fail - plaque IS in inventory)
		{
			input = "test:assert-inventory BRASS_PLAQUE false",
			description = "Assert brass plaque is NOT in inventory (should fail)"
		},
		-- Move to reception room
		{
			input = "north",
			description = "Enter sanitarium"
		},
		{
			input = "west",
			description = "Go to reception room"
		},
		-- Take the key
		{
			input = "take key",
			description = "Take brass key"
		},
		-- Check drawer is NOT open yet (should pass)
		{
			input = "test:assert-flag BOTTOM_DRAWER OPENBIT false",
			description = "Assert drawer is NOT open (should pass)"
		},
		-- Unlock and open drawer
		{
			input = "unlock drawer with key",
			description = "Unlock the bottom drawer"
		},
		{
			input = "open drawer",
			description = "Open the drawer"
		},
		-- Check drawer IS open now (should pass)
		{
			input = "test:assert-flag BOTTOM_DRAWER OPENBIT true",
			description = "Assert drawer IS open (should pass)"
		},
		-- Check ledger location (should pass - ledger should be in drawer)
		{
			input = "test:assert-location PATIENT_LEDGER BOTTOM_DRAWER",
			description = "Assert ledger is in drawer (should pass)"
		},
	}
}
