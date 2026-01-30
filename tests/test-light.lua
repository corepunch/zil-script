-- Test file for light source mechanics
-- Inspired by ZILF's test-light.zil

return {
	name = "Light Source Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-light.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
	},
	commands = {
		{
			input = "look",
			description = "Look in the dark (should show darkness message)"
		},
		{
			input = "light flashlight",
			description = "Light/turn on flashlight"
		},
		{
			input = "look",
			description = "Look with light (should see room description)"
		},
		{
			input = "extinguish flashlight",
			description = "Extinguish flashlight"
		},
		{
			input = "look",
			description = "Look in darkness again"
		},
		{
			input = "light flashlight",
			description = "Light flashlight again"
		},
		{
			input = "take lantern",
			description = "Take the lantern"
		},
		{
			input = "inventory",
			description = "Check inventory"
		},
	}
}
