///@description
var _complete_color = $FFAC30;
var _incomplete_color = $222222;
var _frames = 
	[
	0,
	4,
	1,
	4,
	2,
	4,
	3,
	];
var _length = array_length(_frames);
var _pad = 96;
var _x = round((room_width div 2) - (_pad * (_length / 2)) + (_pad / 2));
var _y = (room_height div 2);

if (engine().online_show_matchmaking)
	{
	for (var i = 0; i < _length; i++)	
		{
		if (i % 2 == 0 && progress > i)
			{
			draw_sprite_ext(spr_random_matchmaking_status, 0, _x, _y - 52, 2, 2, 0, c_white, 1);
			}
		draw_sprite_ext(spr_random_matchmaking_symbols, _frames[@ i], _x, _y, 2, 2, 0, (progress >= i) ? _complete_color : _incomplete_color, 1);
		_x += _pad;
		}
	
	//Message
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(room_width div 2, room_height div 2 + 64, state_message);
	}
else
	{
	//Message
	var _msg;
	if (state == RANDOM_MATCHMAKING_STATE.failed ||
		state == RANDOM_MATCHMAKING_STATE.canceling_match)
		{
		_msg = state_message;
		}
	else
		{
		_msg = "Matchmaking progress is hidden (Go to Options to change)"
		}
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text(room_width div 2, room_height div 2, _msg);
	}
/* Copyright 2024 Springroll Games / Yosi */