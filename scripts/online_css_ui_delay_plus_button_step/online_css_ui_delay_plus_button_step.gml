function online_css_ui_delay_plus_button_step()
	{
	ui_button_step();
	if (ui_clicked)
		{
		engine().online_input_delay = min(GGMR_INPUT_DELAY_MAX, engine().online_input_delay + 1);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */