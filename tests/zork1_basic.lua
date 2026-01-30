-- Basic tests for Zork1
-- These tests verify basic game functionality using the Zork1 adventure
-- Based on the test commands from the original bootstrap.lua

return {
	name = "Zork1 Basic Tests",
	files = {
		"zork1/globals.zil",
		"zork1/clock.zil",
		"zork1/parser.zil",
		"zork1/verbs.zil",
		"zork1/syntax.zil",
		"adventure/horror.zil",
		"zork1/main.zil",
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
