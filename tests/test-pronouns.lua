-- Test file for pronoun handling (IT, THEM, etc.)
-- Inspired by ZILF's test-pronouns.zil

return {
	name = "Pronoun Handling Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-pronouns.zil",
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
			input = "inventory",
			description = "Check starting inventory"
		},
		{
			input = "take apple",
			description = "Take the apple"
		},
		{
			input = "take nail",
			description = "Take the nail"
		},
		{
			input = "inventory",
			description = "Check inventory has both items"
		},
		{
			input = "examine apple",
			description = "Examine the apple"
		},
		{
			input = "drop apple",
			description = "Drop the apple"
		},
		{
			input = "drop nail",
			description = "Drop the nail"
		},
		{
			input = "drop wallet",
			description = "Drop wallet"
		},
		{
			input = "west",
			description = "Move to hallway"
		},
		{
			input = "look",
			description = "Look in hallway"
		},
	}
}
