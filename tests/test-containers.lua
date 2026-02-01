-- Test file for container interactions
-- Inspired by ZILF's test-containers.zil

return {
	name = "Container Interaction Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"tests.test-containers",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"zork1.main",
	},
	commands = {
		{
			input = "look",
			here = "STARTROOM",
			description = "Look at the starting room"
		},
		{
			input = "examine bucket",
			text = "bucket",
			description = "Examine the bucket (open container)"
		},
		{
			input = "take apple",
			take = "APPLE",
			description = "Take the apple"
		},
		{
			input = "put apple in bucket",
			text = "Done",
			description = "Put apple in open container"
		},
		{
			input = "look in bucket",
			text = "apple",
			description = "Look inside the bucket"
		},
		{
			input = "take apple from bucket",
			take = "APPLE",
			description = "Take apple from bucket"
		},
		{
			input = "examine cage",
			text = "cage",
			description = "Examine the cage (openable container)"
		},
		{
			input = "open cage",
			flag = "CAGE OPENBIT",
			description = "Open the cage"
		},
		{
			input = "put apple in cage",
			text = "Done",
			description = "Put apple in opened cage"
		},
		{
			input = "close cage",
			no_flag = "CAGE OPENBIT",
			description = "Close the cage"
		},
		{
			input = "take apple",
			text = "closed",
			description = "Try to take apple from closed cage (should fail)"
		},
		{
			input = "open cage",
			flag = "CAGE OPENBIT",
			description = "Open cage again"
		},
		{
			input = "take apple from cage",
			take = "APPLE",
			description = "Take apple from opened cage"
		},
	}
}
