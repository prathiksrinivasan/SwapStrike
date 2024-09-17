function stage_peak_snow()
	{
	//Don't create particles on performance mode, or during rollbacks
	if (setting().performance_mode) then return;
	if (game_is_in_rollback()) then return;
	
	var _part = stage_particle_types.stage_peak_snow;
	part_type_direction(_part, 235, 315, 0, 1);
	part_type_speed(_part, 2, 4, 0, 0.1);
	part_type_orientation(_part, 0, 360, 0, 0, false);
	repeat (5)
		{
		part_particles_create(Particle_System(), random(room_width), random_range(0, obj_game.cam_y), _part, 1);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */