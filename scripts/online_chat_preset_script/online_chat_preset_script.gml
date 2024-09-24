///@category Menus
///@param {string} message		The string of the preset message that will be dynamically changed
/*
This is the script assigned to <obj_ggmr_chat> in <ggmr_chat_init> that changes the text in dynamic preset messages.
*/
function online_chat_preset_script()
	{
	//Double check that the string is a dynamic preset message (has a % in front)
	var _s = argument[0];
	if (string_char_at(_s, 1) == "%")
		{
		//Cut off the leading %
		_s = string_copy(_s, 2, string_length(_s) - 1);
		
		//Dynamic replacement
		if (_s == "I'm using % input delay!")
			{
			if (instance_exists(obj_online_css_ui) && obj_online_css_ui.cursor_active)
				{
				_s = "I'm choosing my input delay...";
				}
			else
				{
				_s = string_replace(_s, "%", string(engine().online_input_delay));
				}
			}
		else if (_s == "Thinking of picking %!")
			{
			var _player_id = obj_online_css_ui.local_player_id;
			var _char = css_player_get(_player_id, CSS_PLAYER.character);
			_s = string_replace(_s, "%", character_data_get(_char, CHARACTER_DATA.name));
			}
		else if (_s == "I chose %!")
			{
			if (instance_exists(obj_online_css_ui) && obj_online_css_ui.cursor_active)
				{
				_s = "I'm choosing a character...";
				}
			else
				{
				var _player_id = obj_online_css_ui.local_player_id;
				var _char = css_player_get(_player_id, CSS_PLAYER.character);
				_s = string_replace(_s, "%", character_data_get(_char, CHARACTER_DATA.name));
				}
			}
		return _s;
		}
	else
		{
		return _s;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */