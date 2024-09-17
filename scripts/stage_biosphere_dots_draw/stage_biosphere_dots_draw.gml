function stage_biosphere_dots_draw()
	{
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];
	
	if (_layer[@ BACK.imgspeed] == 1)
		{
		var _x_offset = (dcos(obj_game.current_frame) * 10);
		var _y_offset = (dsin(obj_game.current_frame) * 10);
		}
	else
		{
		var _x_offset = (dsin(obj_game.current_frame) * 5);
		var _y_offset = (dcos(obj_game.current_frame) * 5);
		}
	draw_sprite_ext
		(
		_layer[@ BACK.sprite],
		_layer[@ BACK.frame],
		_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]) + _x_offset,
		_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]) + _y_offset,
		_layer[@ BACK.scale],
		_layer[@ BACK.scale],
		0,
		c_white,
		1,
		);
	}

/* Copyright 2024 Springroll Games / Yosi */