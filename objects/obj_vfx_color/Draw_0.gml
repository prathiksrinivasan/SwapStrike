///@description
if (setting().performance_mode && !important) then exit;

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	if (vfx_allow_fade)
		{
		var _f = background_get_clear_amount();
		palette_shader_rgb_set(owner.palette_base, owner.palette_swap, 0.0, 1.0, _f, false); 
		}
		
	var _alpha = fade ? lerp(0, vfx_alpha, lifetime / total_life) : vfx_alpha;
	draw_sprite_ext(vfx_sprite, vfx_frame, floor(x), floor(y), vfx_xscale, vfx_yscale, vfx_angle, vfx_blend, _alpha);
	
	if (vfx_allow_fade)
		{
		shader_reset();
		}
		
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2024 Springroll Games / Yosi */