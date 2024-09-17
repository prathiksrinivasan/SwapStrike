var _w = obj_game.cam_w;
var _h = obj_game.cam_h;
var _cam_dist_x = ((room_width / 2) - obj_game.cam_x - (_w / 2));
var _cam_dist_y = ((room_height / 2) - obj_game.cam_y - (_h / 2));
	
if (front)
	{
	fade_shader_set();
	draw_sprite_ext
		(
		sprite_index,
		anim_frame,
		x + (_cam_dist_x * 1.2),
		y + (_cam_dist_y * 1.2),
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha,
		);
	shader_reset();
	}
else
	{
	shader_reset();
	draw_sprite_ext
		(
		sprite_index,
		anim_frame,
		x + (_cam_dist_x * 0.4),
		y + (_cam_dist_y * 0.4),
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		background_get_clear_amount(),
		);
	}
/* Copyright 2024 Springroll Games / Yosi */