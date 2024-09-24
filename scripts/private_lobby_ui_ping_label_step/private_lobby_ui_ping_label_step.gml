function private_lobby_ui_ping_label_step()
	{
	if (connection != "-1")
		{
		var _ping = ceil(ggmr_net_ping_average(connection));
		if (_ping == noone)
			{
			text = "";
			return;
			}
		else if (_ping <= 70)
			{
			image_blend = $82E549;
			}
		else if (_ping <= 150)
			{
			image_blend = $30EDFF;
			}
		else
			{
			image_blend = $4e4Ee5;
			}
		text = string(_ping);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */