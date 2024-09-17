///@description Overlay Drawing
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	fade_shader_set();
	draw_sprite_ext(overlay_sprite, overlay_frame, x, y, abs(overlay_scale) * overlay_facing, overlay_scale, overlay_angle, overlay_color, 1);
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2024 Springroll Games / Yosi */