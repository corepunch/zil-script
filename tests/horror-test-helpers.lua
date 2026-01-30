-- Minimal test to verify test helper functions work
return {
	name = "Horror.zil Test Helpers Verification",
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
		{input="look",here="SANITARIUM-GATE",description="Start at Sanitarium Gate"},
		{input="examine plaque",description="Learn about Blackwood Sanitarium"},
		{input="take plaque",inventory="BRASS-PLAQUE",description="Take the brass plaque"},
		{input="north",here="SANITARIUM-ENTRANCE",description="Enter Sanitarium Entrance Hall"},
	}
}
