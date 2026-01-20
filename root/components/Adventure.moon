package.path = package.path..";"..PROJECTDIR.."/zil/?.lua"

ui = require "orca.ui"
appwrite = require "appwrite.functions"
json = require "orca.parsers.json"
zil = require "zil.main"

system = "You are the Dungeon Master in a text-based Dungeons & Dragons adventure. Describe scenes vividly, present choices naturally, and react dynamically to player actions. Keep descriptions immersive but concise."
user = "Let's begin a new D&D adventure. Describe what my character sees as I awaken in a mysterious forest clearing, and ask me what I want to do next."

class Adventure extends ui.Form
	title: "Adventure"
	-- apply: => "flex-col w-full gap-2"
	body: =>
		-- respose = appwrite.test_openai system, user
		-- json = response\json!
		respose = {
			id: "chatcmpl-CZI3yEnk3yLR8yeySTdqTgJgNcKjI"
			object: "chat.completion"
			created: 1762526950
			model: "gpt-4o-mini-2024-07-18"
			choices: {
				{
					index: 0
					message: {
						role: "assistant"
						content: "{\"choices\":[\"Search the clearing for supplies\",\"Examine the unusual trees\",\"Listen for any sounds in the forest\",\"Try to remember how you got here\"],\"scene\":\"You awaken in a serene forest clearing, the sunlight filtering through a vibrant canopy of leaves above. The air is fresh, scented with pine and damp earth. Wildflowers pepper the ground, their colors dancing in the light breeze. A few yards away, a bubbling brook catches your attention, its crystal-clear water tumbling over smooth stones. You feel a sense of tranquility, but also an undercurrent of uncertainty; you cannot recall how you arrived here or what may lie beyond the thicket of trees that encircles the clearing.\"}"
						refusal: null
						annotations: {}
					},
					logprobs: null
					finish_reason: "stop"
				}
			}
			usage: {
				prompt_tokens: 149
				completion_tokens: 141
				total_tokens: 290
				prompt_tokens_details: {
					cached_tokens: 0
					audio_tokens: 0
				}
				completion_tokens_details: {
					reasoning_tokens: 0
					audio_tokens: 0
					accepted_prediction_tokens: 0
					rejected_prediction_tokens: 0
				}
			}
			service_tier: "default"
			system_fingerprint: "fp_560af6e559"
		}
		desc = json.parse(respose.choices[1].message.content)
		text = desc.scene
		text = string.gsub text, "\\n", "\n"
		p class: 'm-2', text
		for choice in *desc.choices
			select = -> @addChild p class: 'm-1', choice
			ui.Button class: 'm-1 py-1 px-2 text-blue-300 bg-muted hover:bg-primary hover:text-blue-100', onClick: select, choice
