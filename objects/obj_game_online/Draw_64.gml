///@description Ping, Input Delay HUD

//Inherit the parent event
event_inherited();

//Ping
if (engine().online_show_ping)
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
		
	var _subimage = 1;
	var _color = c_black;
	if (_ping == noone)
		{
		}
	else if (_ping <= 70)
		{
		_subimage = 4;
		_color = $82E549;
		}
	else if (_ping <= 150)
		{
		_subimage = 3;
		_color = $30EDFF;
		}
	else
		{
		_subimage = 2;
		_color = $4e4Ee5;
		}
		
	draw_set_alpha(0.4);
	draw_set_color(c_black);
	draw_rectangle(8, screen_height - 8, 60, screen_height - 24, false);
	draw_rectangle(64, screen_height - 8, 128, screen_height - 24, false);
	draw_set_alpha(1);
	draw_sprite(spr_ping, _subimage, 16, screen_height - 16); 
	draw_set_color(_color);
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(32, screen_height - 16, string(_ping));
	draw_set_color(c_white);
	draw_text(68, screen_height - 16, string(obj_ggmr_session.session_debug_stats.rollback_average_frames) + " RB");
	}
/* Copyright 2024 Springroll Games / Yosi */