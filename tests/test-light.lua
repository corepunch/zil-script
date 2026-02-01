-- Test file for light source mechanics
-- Inspired by ZILF's test-light.zil

return {
	name = "Light Source Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"tests.test-light",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"zork1.main",
	},
	commands = {
		{
			input = "look",
			text = "pitch black",
			description = "Look in the dark (should show darkness message)"
		},
		{
			input = "light flashlight",
			flag = "FLASHLIGHT ONBIT",
			description = "Light/turn on flashlight"
		},
		{
			input = "look",
			here = "STARTROOM",
			description = "Look with light (should see room description)"
		},
		{
			input = "extinguish flashlight",
			no_flag = "FLASHLIGHT ONBIT",
			description = "Extinguish flashlight"
		},
		{
			input = "look",
			text = "pitch black",
			description = "Look in darkness again"
		},
		{
			input = "light flashlight",
			flag = "FLASHLIGHT ONBIT",
			description = "Light flashlight again"
		},
		{
			input = "take lantern",
			take = "LANTERN",
			description = "Take the lantern"
		},
		{
			input = "inventory",
			text = "flashlight",
			description = "Check inventory"
		},
	}
}
