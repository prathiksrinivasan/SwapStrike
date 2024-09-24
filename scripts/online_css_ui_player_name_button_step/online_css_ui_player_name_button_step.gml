function online_css_ui_player_name_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		with (obj_css_player_window)
			{
			menu_sound_play(snd_menu_select);
			state = CSS_PLAYER_WINDOW_STATE.select_profile;
			obj_online_css_ui.cursor_active = false;
			break;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */