-- Test for torch light source issue
-- The torch should provide light when carried by the player

return {
	name = "Torch Light Source Test",
	files = {
		"zork1/globals.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/actions.zil",
		"zork1/syntax.zil",
		"zork1/dungeon.zil",
		"zork1/main.zil",
	},
	commands = {
		-- This is a minimal test to verify torch provides light
		-- We'll navigate to where we can get both lamp and torch,
		-- then verify the torch works as a light source
		
		-- Get the lamp
		{ input="walk south", text="South of House" },
		{ input="walk east", text="Behind House" },
		{ input="open window", text="With great effort, you open the window far enough to allow entry." },
		{ input="enter house", text="Kitchen" },
		{ input="walk west", text="Living Room" },
		{ input="take lamp", text="Taken." },
		{ input="move rug", text="With a great effort, the rug is moved to one side of the room, revealing the dusty cover of a closed trap door." },
		{ input="turn on lamp", text="The brass lantern is now on." },
		{ input="open trap door", text="The door reluctantly opens to reveal a rickety staircase descending into darkness." },
		{ input="walk down", text="Cellar" },
		
		-- Navigate to torch room
		{ input="walk north", text="The Troll Room" },
		{ input="walk east", text="East-West Passage" },
		{ input="walk east", text="Round Room" },
		{ input="walk southe", text="Engravings Cave" },
		{ input="walk east", text="Dome Room" },
		{ input="walk down", text="Torch Room" },
		
		-- Take the torch (it has ONBIT set by default)
		{ input="take torch", text="Taken." },
		
		-- Turn off the lamp - now ONLY the torch should provide light
		{ input="turn off lamp", text="The brass lantern is now off." },
		
		-- This is the critical test: with lamp off and only torch,
		-- we should still be able to see the room
		{ input="look", text="Torch Room", description="CRITICAL: Torch must provide light!" },
		
		-- Move to a different dark room to further verify
		{ input="walk south", text="Temple", description="Torch provides light in Temple" },
	}
}
