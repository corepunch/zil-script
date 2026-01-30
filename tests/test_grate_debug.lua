-- Debug test for grate opening issue

return {
	name = "Grate Opening Debug Test",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/actions.zil",
		"zork1/syntax.zil",
		"zork1/dungeon.zil",
		"zork1/actions.zil",
		"zork1/main.zil",
	},
	commands = {
		-- Start at GRATING-ROOM with lamp
		{ input="test:start-location GRATING_ROOM", description="Start at GRATING-ROOM" },
		{ input="test:take LAMP", description="Give player the lamp" },
		{ input="turn on lamp", text="The brass lantern is now on" },
		
		-- Check that we're at GRATING-ROOM
		{ input="look", text="Grating Room" },
		
		-- Unlock and open the grate
		{ input="unlock grate", text="grate", description="Unlock the grate" },
		{ input="open grate", text="The grating opens to reveal trees above you." },
		
		-- Verify grate is open
		{ input="test:global GRATE OPENBIT", description="Check GRATE has OPENBIT" },
		
		-- Try to go up
		{ input="walk up", text="Clearing", description="Walk up should show Clearing" },
		{ input="test:here GRATING_CLEARING", description="Should be at GRATING-CLEARING" },
	}
}
