function online_css_ui_ping_label_step()
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
	_ping = ceil(_ping);
	
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
	text = _ping;
	}
/* Copyright 2024 Springroll Games / Yosi */