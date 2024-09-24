function private_lobby_ui_match_settings_button_step()
	{
	if (ggmr_lobby_is_leader())
		{
		ui_button_step();
	
		if (ui_clicked)
			{
			menu_sound_play(snd_menu_select);
			obj_private_lobby_ui.state = PRIVATE_LOBBY_STATE.match_settings;
			}
		}
	else
		{
		//Disable the button
		image_blend = c_dkgray;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */