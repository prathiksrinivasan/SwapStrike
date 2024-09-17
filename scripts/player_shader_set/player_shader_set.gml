///@category Player Engine Scripts
///@param {bool} [no_palette_swap]		Whether to disable the palette swapping part of the shader
/*
Sets the palette shader with specific values.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.

If the "no_palette_swap" argument is true, the shader will not run the palette swap part, but everything else will still be run, including the outline, lighting, and fade.
*/
function player_shader_set()
	{
	var _no_palette_swap = argument_count > 0 ? argument[0] : false;
	var _palette_base = _no_palette_swap ? [0, 0, 0, 0] : palette_base;
	var _palette_swap = _no_palette_swap ? [0, 0, 0, 0] : palette_swap;
	
	//Light change and alpha change
	var _light = 0.0, _alpha = 1.0;
	
	if (hurtbox.inv_type == INV.invincible && !is_knocked_out())
		{
		_light = 0.5;
		_alpha = 0.5;
		}
		
	_alpha *= anim_alpha;

	//Set up the shader
	var _outline_color = setting().match_team_mode ? player_color_get(player_team) : player_outline_color;
	palette_shader_set(_palette_base, _palette_swap, _light, _alpha, fade_value, player_outline, _outline_color, -1, -1, object_surface_get(), flash_color, flash_alpha);
	}
/* Copyright 2024 Springroll Games / Yosi */