///@description Choose the presets based on the room

//Create the instance of obj_ggmr_chat if there is none
ggmr_chat_init(engine().online_name, undefined, online_chat_preset_script, online_chat_messages_stored, false, false);

//Determine which presets to use
presets_text = undefined;
switch (room)
	{
	case rm_private_lobby:
		obj_ggmr_chat.chat_preset_messages =
			[
			"Hello!",
			"Wait a second...",
			"Funny!",
			"Oops...",
			"I want to play!", 
			"I want to spectate!",
			"Let's do a best of 3!",
			"Let's do teams!",
			"Good Game!",
			["WOW!", "WOAH!", "Amazing!", "Incredible!", "COOL!"],
			"Let's rematch!",
			"See ya!", 
			];
		presets_text =
			[
			["Hello!", [spr_chat_icons, 0]],
			["Wait a second...", [spr_chat_icons, 1]],
			["Funny!", [spr_chat_icons, 2]],
			["Oops...", [spr_chat_icons, 3]],
			["I want to play!"],
			["I want to spectate!"],
			["Let's do a best of 3!"],
			["Let's do teams!"],
			["Good Game!", [spr_chat_icons, 4]],
			["(Wow)", [spr_chat_icons, 5]],
			["Let's rematch!", [spr_chat_icons, 6]],
			["See ya!", [spr_chat_icons, 7]],
			];
		break;
	case rm_online_css:
		obj_ggmr_chat.chat_preset_messages =
			[
			"I'm setting my controls.", 
			"%Thinking of picking %!",
			"%I chose %!",
			"Let's play dittos!",
			"Give me a second...",
			"%I'm using % input delay!",
			"Bye!",
			];
		break;
	case rm_spectator_wait:
		obj_ggmr_chat.chat_preset_messages =
			[
			"Wait a second...",
			"I'm waiting...",
			];
		break;
	}
	
//Variables
display_chat = false;
current_preset = 0;
chat_surface = noone;
redraw = true;

/* Copyright 2024 Springroll Games / Yosi */