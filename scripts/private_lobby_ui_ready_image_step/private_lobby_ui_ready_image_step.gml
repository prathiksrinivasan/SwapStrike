function private_lobby_ui_ready_image_step()
	{
	if (member_index < ds_list_size(obj_ggmr_lobby.lobby_members))
		{
		if (obj_ggmr_lobby.lobby_members[| member_index][@ GGMR_LOBBY_MEMBER.ready])
			{
			frame = 1;
			}
		else
			{
			frame = 0;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */