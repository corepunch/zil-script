-- Test file for clock/interrupt system functionality
-- Tests CLOCKER, QUEUE, INT, and interrupt/demon behavior

return {
	name = "Clock/Interrupt System Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"tests/test-clock.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"zork1/main.zil",
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
