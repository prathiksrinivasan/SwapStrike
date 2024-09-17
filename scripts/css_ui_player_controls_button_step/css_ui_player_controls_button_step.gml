function css_ui_player_controls_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		with (obj_css_player_window)
			{
			if (player_id == other.player_id)
				{
				menu_sound_play(snd_menu_select);
				state = CSS_PLAYER_WINDOW_STATE.controls;
				custom_controls_struct = profile_get(css_player_get(player_id, CSS_PLAYER.profile), PROFILE.custom_controls);
				css_player_get(player_id, CSS_PLAYER.custom).cursor_active = false;
				break;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */