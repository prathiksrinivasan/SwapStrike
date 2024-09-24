function online_css_ui_delay_minus_button_step()
	{
	ui_button_step();
	if (ui_clicked)
		{
		//In Quickplay, the minimum input delay is higher
		if (engine().online_mode == ONLINE_MODE.quickplay)
			{
			engine().online_input_delay = max(0, GGMR_INPUT_DELAY_DEFAULT, engine().online_input_delay - 1);
			}
		else
			{
			engine().online_input_delay = max(0, GGMR_INPUT_DELAY_MIN, engine().online_input_delay - 1);
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */