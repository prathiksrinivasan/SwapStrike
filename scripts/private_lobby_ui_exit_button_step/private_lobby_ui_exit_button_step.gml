function private_lobby_ui_exit_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		ggmr_lobby_reset();
		main_menu_sidebar_activate(true);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */