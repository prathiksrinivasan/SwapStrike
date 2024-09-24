function private_lobby_ui_type_button_step()
	{
	//You can only press it if you are the leader
	if (ggmr_lobby_is_leader())
		{
		ui_button_step();
	
		if (ui_clicked)
			{
			//Change the player type between player and spectator
			menu_sound_play(snd_menu_alert);
			ggmr_lobby_member_player_type_switch(member_index);
			ggmr_lobby_sync_members();
			}
		}
		
	//Update the text
	var _player_type = ggmr_lobby_member_get(member_index, GGMR_LOBBY_MEMBER.client_type);
	text = (_player_type == GGMR_CLIENT_TYPE.player) ? "Player" : "Spectator";
	}
/* Copyright 2024 Springroll Games / Yosi */