function private_lobby_ui_join_code_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.idle)
			{
			menu_sound_play(snd_menu_select);
			//Send a request to reserve the new code
			var _inputter = string_inputter_get_string
				(
				"Enter the connect code:", 
				"", 
				function(_code)
					{
					if (_code != "")
						{
						with (obj_private_lobby_ui)
							{
							server_send_packet(obj_ggmr_net.net_socket, packet, "private_lobby_find", _code);
							connect_code_state = "finding";
							connect_code_timer = 0;
							}
						}
					},
				undefined,
				online_connect_code_length_max,
				);
			_inputter.inputter_hidden = !engine().online_show_connect_codes;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */