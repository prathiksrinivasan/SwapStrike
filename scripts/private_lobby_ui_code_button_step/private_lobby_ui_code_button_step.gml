function private_lobby_ui_code_button_step()
	{
	ui_button_step();
	
	if (ui_clicked)
		{
		if (ggmr_lobby_is_leader())
			{
			menu_sound_play(snd_menu_select);
			with (obj_private_lobby_ui)
				{
				if (connect_code_state == "normal")
					{
					//Send a request to reserve the new code
					var _inputter = string_inputter_get_string
						(
						"Enter your custom connect code:", 
						"", 
						function(_code)
							{
							if (_code != "")
								{
								with (obj_private_lobby_ui)
									{
									connect_code_to_reserve = _code;
									connect_code_state = "reserving";
									connect_code_timer = 0;
									server_send_packet(obj_ggmr_net.net_socket, packet, "private_lobby_reserve", connect_code_to_reserve);
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
		}
	
	if (ggmr_lobby_is_leader())
		{
		if (engine().online_show_connect_codes)
			{
			text = to_string("Connect Code: ", engine().online_connect_code, (obj_private_lobby_ui.connect_code_reserved ? "" : "[Not Reserved]"));
			}
		else
			{
			text = to_string("Connect Code: ", (obj_private_lobby_ui.connect_code_reserved ? "[Hidden]" : "[Not Reserved]"));
			}
		}
	else
		{
		text = to_string(obj_ggmr_lobby.lobby_joined_name, "'s Lobby");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */