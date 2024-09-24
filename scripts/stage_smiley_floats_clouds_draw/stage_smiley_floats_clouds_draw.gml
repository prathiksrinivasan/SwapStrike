function stage_smiley_floats_clouds_draw()
	{
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];
	
	var _x_off = dsin(obj_game.current_frame / 2) * 48 * _layer[@ BACK.parallax_x];
	var _y_off = dcos(obj_game.current_frame / 2) * 48 * _layer[@ BACK.parallax_y];
	
	draw_sprite_ext
		(
		_layer[@ BACK.sprite],
		0,
		_draw_x + _x_off + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
		_draw_y + _y_off + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
		_layer[@ BACK.scale],
		_layer[@ BACK.scale],
		0,
		c_white,
		1,
		);
	}
/* Copyright 2024 Springroll Games / Yosi */