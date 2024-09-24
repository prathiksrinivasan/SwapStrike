function online_css_ui_ping_image_step()
	{
	//Get the highest ping of all players
	var _ping = noone;
	var _count = player_count();
	for (var i = 0; i < _count; i++)
		{
		var _player = engine().player_data[@ i];
		if (_player[@ PLAYER_DATA.custom].location == GGMR_LOCATION_TYPE.remote)
			{
			_ping = max(_ping, ggmr_net_ping_average(_player[@ PLAYER_DATA.custom].connection));
			}
		else continue;
		}
	
	if (_ping == 0 || _ping == noone)
		{
		image_index = 1;
		}
	else if (_ping <= 70)
		{
		image_index = 4;
		}
	else if (_ping <= 150)
		{
		image_index = 3;
		}
	else
		{
		image_index = 2;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */