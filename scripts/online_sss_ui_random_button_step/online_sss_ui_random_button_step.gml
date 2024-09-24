function online_sss_ui_random_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_select);
		setting().match_stage = stage_choose_random();
		obj_online_sss_ui.stage_selected = true;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */