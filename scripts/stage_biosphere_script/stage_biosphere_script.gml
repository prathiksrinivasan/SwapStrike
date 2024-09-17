function stage_biosphere_script()
	{
	//Don't create particles on performance mode, or during rollbacks
	if (setting().performance_mode) then return;
	if (game_is_in_rollback()) then return;
	
	var _part = stage_particle_types.stage_biosphere_splash;
	repeat (2)
		{
		part_type_direction(_part, 0, 180, 0, 0);
		part_type_speed(_part, 0, 3, -0.2, 0);
		part_particles_create(Particle_System(), random_range(864, 994), random_range(886, 890), _part, 1);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */