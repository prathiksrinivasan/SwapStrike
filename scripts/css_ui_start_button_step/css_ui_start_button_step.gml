function css_ui_start_button_step()
	{
	ui_button_step();

	if (obj_css_ui.state == CSS_STATE.normal && css_can_start_match())
		{
		//Ready colors
		color_normal = make_color_hsv(105, 138 + (sin(current_time / 100) * 10), 178 + (sin(current_time / 200) * 5));
		color_hover = make_color_hsv(105, 200 + (sin(current_time / 100) * 10), 200 + (sin(current_time / 200) * 10));
		color_clicked = $7FB252;
		
		//Starting the game
		if (ui_clicked)
			{
			menu_sound_play(snd_menu_start);
			with (obj_css_ui)
				{
				css_engine_player_data_save();
				engine().mis_json = mis_devices_save();
				engine().load_css_data = true;
				room_goto(rm_sss);
				exit;
				}
			}
		}
	else
		{
		//Not ready colors
		color_normal = $444444;
		color_hover = $666666;
		color_clicked = $888888;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */