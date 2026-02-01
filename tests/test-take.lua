-- Test file for TAKE command functionality
-- Inspired by ZILF's test-take.zil

return {
	name = "TAKE Command Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"tests.test-take",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"zork1.main",
	},
	commands = {
		{
			input = "take apple",
			take = "APPLE",
			description = "Take a nearby object"
		},
		{
			input = "inventory",
			text = "apple",
			description = "Check inventory contains the apple"
		},
		{
			input = "drop apple",
			lose = "APPLE",
			description = "Drop the apple"
		},
		{
			input = "take banana",
			take = "BANANA",
			description = "Take another object"
		},
		{
			input = "take desk",
			text = "valiant",
			description = "Attempt to take an untakeable object (should fail)"
		},
		{
			input = "inventory",
			text = "banana",
			description = "Check inventory"
		},
	}
}
