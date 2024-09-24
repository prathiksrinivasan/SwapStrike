function private_lobby_ui_join_requests_button_step()
	{
	ui_button_step();

	var _num = ds_list_size(obj_ggmr_lobby.lobby_join_requests);
	if (_num > 0)
		{
		text = "Join Requests (" + string(_num) + ")";
		}
	else
		{
		text = "Join Requests";
		}

	if (ui_clicked)
		{
		if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.idle)
			{
			menu_sound_play(snd_menu_select);
			obj_private_lobby_ui.join_request_list_show ^= true;
			obj_private_lobby_ui.join_request_current = 0;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */