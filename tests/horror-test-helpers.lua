-- Minimal test to verify test helper functions work
return {
	name = "Horror.zil Test Helpers Verification",
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
		{input="look",here="SANITARIUM-GATE",description="Start at Sanitarium Gate"},
		{input="examine plaque",description="Learn about Blackwood Sanitarium"},
		{input="take plaque",inventory="BRASS-PLAQUE",description="Take the brass plaque"},
		{input="north",here="SANITARIUM-ENTRANCE",description="Enter Sanitarium Entrance Hall"},
	}
}
