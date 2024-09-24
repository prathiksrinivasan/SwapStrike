function private_lobby_ui_ping_image_step()
	{
	if (connection != "-1")
		{
		var _ping = ceil(ggmr_net_ping_average(connection));
		if (_ping == noone)
			{
			frame = 1;
			}
		else if (_ping <= 70)
			{
			frame = 4;
			}
		else if (_ping <= 150)
			{
			frame = 3;
			}
		else
			{
			frame = 2;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */