function online_css_start()
	{
	//Save the CSS data to be used by obj_game_online
	css_engine_player_data_save();
	
	//Private Lobbies
	if (engine().online_mode == ONLINE_MODE.private_lobby)
		{
		room_goto(rm_online_sss);
		}
	//Quickplay
	else if (engine().online_mode == ONLINE_MODE.quickplay)
		{
		game_begin(rm_online_css, false, true);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */