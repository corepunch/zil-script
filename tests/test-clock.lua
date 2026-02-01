-- Test file for clock/interrupt system functionality
-- Tests CLOCKER, QUEUE, INT, and interrupt/demon behavior

return {
	name = "Clock/Interrupt System Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"tests.test-clock",
		"zork1.parser",
		"zork1.verbs",
		"zork1.actions",
		"zork1.syntax",
		"zork1.dungeon",
		"zork1.actions",
		"zork1.main",
	},
	commands = {
		-- Basic test to verify clock is loaded
		{
			input = "test:global C_TABLE",
			description = "Verify C_TABLE global is defined"
		},
		{
			input = "test:global C_TABLELEN",
			description = "Verify C_TABLELEN constant is defined"
		},
		{
			input = "test:global C_DEMONS",
			description = "Verify C_DEMONS global is defined"
		},
		{
			input = "test:global C_INTS",
			description = "Verify C_INTS global is defined"
		},
		{
			input = "test:global MOVES",
			description = "Verify MOVES global is defined (from verbs.zil)"
		},
	}
}
