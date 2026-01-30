-- Test file to verify that test:check-flag and test:check-inventory
-- properly return "ok" or "fail" based on actual game state.
--
-- This test addresses the issue where these commands always returned "ok"
-- even when the tested condition was false, making it impossible to detect
-- test failures. After the fix:
-- - test:check-inventory returns "ok" when object IS in inventory, "fail" when NOT
-- - test:check-flag returns "ok" when flag IS set, "fail" when NOT set
--
-- Note: Object names use hyphens (e.g., BOTTOM-DRAWER) which are automatically
-- converted to underscores internally for ZIL naming conventions.
return {
	name = "Test Check Commands (ok/fail behavior)",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Start game"
		},
		-- Test check-inventory when object is NOT in inventory (should show fail)
		{
			input = "test:check-inventory BRASS-PLAQUE",
			description = "Check if plaque is in inventory (should fail - not taken yet)"
		},
		-- Take the plaque
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		-- Test check-inventory when object IS in inventory (should show ok)
		{
			input = "test:check-inventory BRASS-PLAQUE",
			description = "Check if plaque is in inventory (should be ok - just taken)"
		},
		-- Move to reception room to test flags
		{
			input = "north",
			description = "Enter sanitarium"
		},
		{
			input = "west",
			description = "Go to reception room"
		},
		-- Test check-flag when flag is NOT set (should show fail)
		{
			input = "test:check-flag BOTTOM-DRAWER OPENBIT",
			description = "Check if drawer is open (should fail - not opened yet)"
		},
		-- Take the key
		{
			input = "take key",
			description = "Take brass key"
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
		-- Test check-flag when flag IS set (should show ok)
		{
			input = "test:check-flag BOTTOM-DRAWER OPENBIT",
			description = "Check if drawer is open (should be ok - just opened)"
		},
		-- Test check-location when object is at the location (should show ok)
		{
			input = "test:check-location PATIENT-LEDGER BOTTOM-DRAWER",
			description = "Check if ledger is in drawer (should be ok)"
		},
		-- Test check-location when object is NOT at the location (should show fail)
		{
			input = "test:check-location PATIENT-LEDGER SANITARIUM-GATE",
			description = "Check if ledger is at gate (should fail - it's in the drawer)"
		},
	}
}
