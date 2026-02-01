-- Basic tests for Zork1
-- These tests verify basic game functionality using the Zork1 adventure
-- Based on the test commands from the original bootstrap.lua

return {
	name = "Zork1 Basic Tests",
	modules = {
		"zork1.globals",
		"zork1.clock",
		"zork1.parser",
		"zork1.verbs",
		"zork1.syntax",
		"adventure.horror",
		"zork1.main",
	},
	commands = {
		-- Test examining objects (from bootstrap.lua)
		{
			input = "examine mailbox",
			description = "Examine the mailbox at the starting location"
		},
		
		-- Additional test commands from original bootstrap.lua comments
		-- These can be uncommented and modified as needed
		
		-- {
		-- 	input = "open mailbox",
		-- 	description = "Open the mailbox to find items inside"
		-- },
		-- {
		-- 	input = "take leaflet",
		-- 	description = "Take the leaflet from the mailbox"
		-- },
		-- {
		-- 	input = "read leaflet",
		-- 	description = "Read the leaflet contents"
		-- },
		
		-- Movement tests (commented out in original bootstrap.lua)
		-- {
		-- 	input = "walk north",
		-- 	description = "Walk north from starting location"
		-- },
		-- {
		-- 	input = "walk north",
		-- 	description = "Walk north again"
		-- },
		-- {
		-- 	input = "walk up",
		-- 	description = "Walk up to higher location"
		-- },
		-- {
		-- 	input = "examine nest",
		-- 	description = "Examine the nest"
		-- },
	}
}
