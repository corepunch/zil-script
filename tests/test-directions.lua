-- Test file for direction/movement commands
-- Inspired by ZILF's test-directions.zil

return {
	name = "Direction/Movement Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-directions.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Look at starting room"
		},
		{
			input = "north",
			description = "Move north to hallway"
		},
		{
			input = "look",
			description = "Look at hallway"
		},
		{
			input = "north",
			description = "Move north again to closet"
		},
		{
			input = "look",
			description = "Look at closet"
		},
		{
			input = "south",
			description = "Move south back to hallway"
		},
		{
			input = "south",
			description = "Move south to start room"
		},
		{
			input = "in",
			description = "Use IN direction (should go to hallway)"
		},
		{
			input = "out",
			description = "Use OUT direction (should return to start room)"
		},
	}
}
