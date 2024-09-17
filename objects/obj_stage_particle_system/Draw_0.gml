///@description Particle System Render
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);

	fade_shader_set();
	
	part_system_drawit(Particle_System());
	
	shader_reset();

	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2024 Springroll Games / Yosi */