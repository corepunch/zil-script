-- Test file for pronoun handling (IT, THEM, etc.)
-- Inspired by ZILF's test-pronouns.zil

return {
	name = "Pronoun Handling Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"tests.test-pronouns",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"zork1.main",
	},
	commands = {
		{
			input = "look",
			here = "STARTROOM",
			description = "Look at starting room"
		},
		{
			input = "inventory",
			text = "wallet",
			description = "Check starting inventory"
		},
		{
			input = "take apple",
			take = "APPLE",
			description = "Take the apple"
		},
		{
			input = "take nail",
			take = "NAIL",
			description = "Take the nail"
		},
		{
			input = "inventory",
			text = "nail",
			description = "Check inventory has both items"
		},
		{
			input = "examine apple",
			text = "apple",
			description = "Examine the apple"
		},
		{
			input = "drop apple",
			lose = "APPLE",
			description = "Drop the apple"
		},
		{
			input = "drop nail",
			lose = "NAIL",
			description = "Drop the nail"
		},
		{
			input = "drop wallet",
			lose = "WALLET",
			description = "Drop wallet"
		},
		{
			input = "west",
			here = "HALLWAY",
			description = "Move to hallway"
		},
		{
			input = "look",
			here = "HALLWAY",
			description = "Look in hallway"
		},
	}
}
