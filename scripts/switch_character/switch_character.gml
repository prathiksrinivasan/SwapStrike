///@category Player Actions
///@param {int/string} character		The character's index, or name
///@param {bool} [clear_custom_data]	Whether the previous character's custom data should be cleared or not
/*
Changes the character of the calling player.
If the player's current color is not available on the new character, the color will be reset to the first color.
The "clear_custom_data" argument can be set to true, which will reset the following variables after the switch:
	- my_states
	- my_attacks
	- my_sprites
	- attack_cooldowns
	- attack_uses
	- custom_attack_struct
	- custom_passive_struct
	- custom_ids_struct
	- callback_passive
	- callback_hud
	- callback_overhead
	- callback_draw_begin
	- callback_draw_end
	- callback_hit
	- callback_hurt
Please note: This does NOT change the engine's player data, so the new character will NOT be changed outside of the match.
*/
function switch_character()
	{
	var _char = argument[0];
	var _clear_custom_data = argument_count > 1 ? argument[1] : false;
	var _total = character_count();
	
	//Find the character with the name
	if (is_string(_char))
		{
		_char = character_find(_char);
		if (_char == -1)
			{
			crash("[switch_character] No character exists with the given name: ", _char);
			}
		}
	
	if (_char >= 0 && _char < _total)
		{
		//Colors
		var _old_num = character_data_get(character, CHARACTER_DATA.palette_data).columns;
		var _new_num = character_data_get(_char, CHARACTER_DATA.palette_data).columns;
		if (_old_num > _new_num)
			{
			player_color = 1;
			}
		
		//Clear custom data
		if (_clear_custom_data)
			{
			//Player States
			my_states = [];
	
			//Attacks and Sprites
			my_attacks = {};
			my_sprites = {};
			attack_cooldowns = {};
			attack_uses = {};
	
			//Custom Variables in Attacks & the Custom Script
			custom_attack_struct = {};
			custom_passive_struct = {};
			custom_ids_struct = {};
	
			//Custom callback scripts
			callback_passive = [];
			callback_hud = [];
			callback_overhead = [];
			callback_draw_begin = [];
			callback_draw_end = [];
			callback_hit = [];
			callback_hurt = [];
			}
		
		//Set the character, then run player_init_end to properly set all variables
		character = _char;
		character_script = character_data_get(character, CHARACTER_DATA.script);
		instance_destroy(hurtbox);
		player_init_end(false);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */