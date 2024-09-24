function private_lobby_ui_kick_button_step()
	{
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_back);
		
		//Remove from the data structure
		ggmr_lobby_member_kick(member_index);
		
		//Unready all players to prevent a match from starting
		with (obj_ggmr_lobby)
			{
			if (!is_lobby_leader) then break;
			for (var i = 0; i < ds_list_size(lobby_members); i++)
				{
				lobby_members[| i][@ GGMR_LOBBY_MEMBER.ready] = false;
				}
			}
		ggmr_lobby_sync_members();
		
		//Remake the UI
		private_lobby_ui_refresh();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */