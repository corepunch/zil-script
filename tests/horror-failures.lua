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
		-- Test 1: Drawer cannot be opened without unlocking first
		{start="RECEPTION_ROOM",input="open drawer",no_flag="BOTTOM_DRAWER OPENBIT",description="Try to open locked drawer (should fail)"},
		
		-- Test 2: With key, drawer can be unlocked and opened
		{input="take key",description="Take the brass key"},
		{input="unlock drawer with key",description="Unlock drawer with key"},
		{input="open drawer",flag="BOTTOM_DRAWER OPENBIT",description="Open drawer successfully"},
		
		-- Test 3: Test at different location - Sanitarium Gate
		{start="SANITARIUM_GATE",here="SANITARIUM_GATE",description="Move to Sanitarium Gate"},
		{flag="BRASS_PLAQUE TAKEBIT",description="Verify plaque has TAKEBIT flag"},
		{input="take plaque",take="BRASS_PLAQUE",description="Take the brass plaque"},
		
		-- -- Test 4: Return to Reception Room
		-- {start="RECEPTION_ROOM",here="RECEPTION_ROOM",description="Move to Reception Room"},
		-- {input="take key",take="BRASS_KEY",description="Take brass key"},
		
		-- -- Test 5: Test drawer without key (reset scenario)
		-- {start="RECEPTION_ROOM",no_flag="BOTTOM_DRAWER OPENBIT",description="Reset to Reception Room, drawer locked"},
		-- {input="unlock drawer",description="Try to unlock without key (should fail)"},
		-- {no_flag="BOTTOM_DRAWER OPENBIT",description="Verify drawer still locked"},
		
		-- -- Test 6: Proper unlock sequence
		-- {input="take key",description="Take the key"},
		-- {input="unlock drawer with key",description="Unlock drawer"},
		-- {input="open drawer",flag="BOTTOM_DRAWER OPENBIT",description="Open drawer successfully"},
		
		-- -- Test 7: Test movement to different rooms
		-- {start="SANITARIUM_ENTRANCE",here="SANITARIUM_ENTRANCE",description="Move to Entrance Hall"},
		-- {input="north",here="OPERATING_THEATER",description="Move to Operating Theater"},
	}
}
