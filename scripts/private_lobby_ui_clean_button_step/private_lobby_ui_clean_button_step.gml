function private_lobby_ui_clean_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		gc_collect();
		log(gc_get_stats());
		}
	}
/* Copyright 2024 Springroll Games / Yosi */