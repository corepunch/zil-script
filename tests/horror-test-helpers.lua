-- Minimal test to verify test helper functions work
return {
	name = "Horror.zil Test Helpers Verification",
	files = {
		"zork1/globals.zil",
		"adventure/horror.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Start at Sanitarium Gate"
		},
		{
			input = "test:get-location",
			description = "Verify starting location is SANITARIUM_GATE"
		},
		{
			input = "examine plaque",
			description = "Look at the plaque"
		},
		{
			input = "take plaque",
			description = "Take the brass plaque"
		},
		{
			input = "test:check-inventory BRASS_PLAQUE",
			description = "Verify plaque is in inventory"
		},
		{
			input = "north",
			description = "Move north"
		},
		{
			input = "test:get-location",
			description = "Verify we moved to a new location"
		},
	}
}
