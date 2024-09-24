function private_lobby_ui_team_button_step()
	{
	//Only works if Teams are enabled
	if (setting().match_team_mode)
		{
		//Change button color
		var _teams = obj_ggmr_lobby.lobby_custom_data.teams;
		var _team = _teams[@ member_index];
		color_normal = player_color_get(_team);
		color_hover = merge_color(color_normal, c_black, 0.1);
		
		//You can only press it if you are the leader
		if (ggmr_lobby_is_leader())
			{
			ui_button_step();
	
			if (ui_clicked)
				{
				//Change the player's team
				menu_sound_play(snd_menu_alert);
				_team = modulo(_team + 1, max_teams);
				_teams[@ member_index] = _team;
				ggmr_lobby_sync_members();
				}
			}
		else
			{
			image_blend = color_normal;
			}
		
		//Update the text
		text = "Team " + string(_teams[@ member_index] + 1);
		}
	else
		{
		color_normal = $444444;
		color_hover = $666666;
		image_blend = color_normal;
		outline_alpha = 0.0;
		text = "";
		}
	}
/* Copyright 2024 Springroll Games / Yosi */