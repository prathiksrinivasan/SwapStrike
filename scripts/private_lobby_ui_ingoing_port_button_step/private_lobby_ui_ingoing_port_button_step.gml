function private_lobby_ui_ingoing_port_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.idle)
			{
			menu_sound_play(snd_menu_select);
			var _inputter = string_inputter_get_string
				(
				"Enter the Target Port:", 
				GGMR_BLANK_PORT, 
				function(_port)
					{
					if (_port == GGMR_BLANK_PORT)
						{
						ggmr_net_port_change(GGMR_PORT);
						}
					else
						{
						ggmr_net_port_change(_port);
						}
					},
				undefined,
				5,
				valid_string_numbers,
				6,
				);
			_inputter.inputter_hidden = !engine().online_show_connect_codes;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */