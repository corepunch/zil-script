-- Test file for container interactions
-- Inspired by ZILF's test-containers.zil

return {
	name = "Container Interaction Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-containers.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Look at the starting room"
		},
		{
			input = "examine bucket",
			description = "Examine the bucket (open container)"
		},
		{
			input = "take apple",
			description = "Take the apple"
		},
		{
			input = "put apple in bucket",
			description = "Put apple in open container"
		},
		{
			input = "look in bucket",
			description = "Look inside the bucket"
		},
		{
			input = "take apple from bucket",
			description = "Take apple from bucket"
		},
		{
			input = "examine cage",
			description = "Examine the cage (openable container)"
		},
		{
			input = "open cage",
			description = "Open the cage"
		},
		{
			input = "put apple in cage",
			description = "Put apple in opened cage"
		},
		{
			input = "close cage",
			description = "Close the cage"
		},
		{
			input = "take apple",
			description = "Try to take apple from closed cage (should fail)"
		},
		{
			input = "open cage",
			description = "Open cage again"
		},
		{
			input = "take apple from cage",
			description = "Take apple from opened cage"
		},
	}
}
