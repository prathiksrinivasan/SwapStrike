function private_lobby_ui_ready_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_start);
		ggmr_lobby_ready_up();
		private_lobby_ui_refresh();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */