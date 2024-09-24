function online_css_calculate_input_delay()
	{
    var _delay = GGMR_INPUT_DELAY_DEFAULT;
    
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
		
	//Suggested input delay:
	if (_ping < 70)
	    _delay = 2;
	else if (_ping < 100)
		_delay = 3;
	else if (_ping < 150)
    	_delay = 4;
	else if (_ping < 190)
		_delay = 5;
	else if (_ping < 220)
		_delay = 6;
	else if (_ping < 250)
		_delay = 7;
	else if (_ping < 270)
		_delay = 8;
	else if (_ping < 290)
		_delay = 9;
	else
		_delay = 10;
		
	return _delay;
	}
/* Copyright 2024 Springroll Games / Yosi */