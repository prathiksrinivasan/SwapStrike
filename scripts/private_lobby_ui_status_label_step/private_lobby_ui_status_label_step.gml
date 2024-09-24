function private_lobby_ui_status_label_step()
	{
	if (ggmr_lobby_everyone_is_ready())
		{
		var _code = ggmr_lobby_status_code();
		switch (_code)
			{
			case GGMR_LOBBY_STATUS.ok:
				text = match_settings_string();
				break;
			case GGMR_LOBBY_STATUS.too_few_players:
				text = "There need to be at least 2 players to start a match!";
				break;
			case GGMR_LOBBY_STATUS.too_many_players:
				text = "There are too many players in the lobby to start a match! (Limit is " + string(GGMR_PLAYERS_MAX) + ")";
				break;
			case GGMR_LOBBY_STATUS.too_many_spectators:
				text = "There are too many spectators in the lobby to start a match! (Limit is " + string(GGMR_SPECTATORS_MAX) + ")";
				break;
			case GGMR_LOBBY_STATUS.too_many_members:
				text = "There are too many member in the lobby to start a match! (Limit is " + string(GGMR_MEMBERS_MAX) + ")";
				break;
			}
		}
	else
		{
		text = match_settings_string();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */