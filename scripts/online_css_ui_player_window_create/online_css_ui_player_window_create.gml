function online_css_ui_player_window_create()
	{
	//Window variables
	state = CSS_PLAYER_WINDOW_STATE.select_character;

	half_width = 104;
	half_height = 76;

	custom_controls_current = 0;
	custom_controls_scroll = 0;
	custom_controls_struct = {};
	custom_controls_choosing = false;
	custom_controls_array = [];

	profile_current = 0;
	profile_scroll = 0;

	profile_new_name = "";
	profile_new_letter = 0;
	profile_valid_letters = valid_string_characters;
	
	surf = -1;
	}
/* Copyright 2024 Springroll Games / Yosi */