function private_lobby_ui_join_ip_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.idle)
			{
			menu_sound_play(snd_menu_select);
			var _inputter = string_inputter_get_string
				(
				"Enter the IP Address:", 
				GGMR_BLANK_IP, 
				function(_ip)
					{
					if (_ip != GGMR_BLANK_IP)
						{
						ggmr_lobby_join_request_send(_ip, obj_private_lobby_ui.target_port);
						}
					},
				undefined,
				15,
				valid_string_ip_address,
				6,
				);
			_inputter.inputter_hidden = !engine().online_show_connect_codes;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */