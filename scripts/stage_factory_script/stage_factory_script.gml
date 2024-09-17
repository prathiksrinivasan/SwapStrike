function stage_factory_script()
	{
	//Lava movement
	var _pool = background[@ 4];
	with (obj_player)
		{
		if (state == PLAYER_STATE.knocked_out)
			{
			if (_pool[@ BACK.y] > 120)
				{
				_pool[@ BACK.y] -= 0.5;
				}
			camera_shake(2, 2);
			break;
			}
		}
	var _percent = 1 - ((_pool[@ BACK.y] - 120) / 200);
	stage_tint = [lerp(0.1, 0.3, _percent), lerp(0, -0.2, _percent), lerp(0, -0.2, _percent)];
	
	//Don't create particles on performance mode, or during rollbacks
	if (setting().performance_mode) then return;
	if (game_is_in_rollback()) then return;
	
	var _part = stage_particle_types.stage_factory_wisp;
	var _scale = random_range(0.9, 1.1);
	part_type_direction(_part, -10, 10, 0, 1);
	part_type_speed(_part, 0, 2, 0, 0.1);
	part_type_orientation(_part, -5, 5, 0, 0, false);
	part_type_color1(_part, make_color_hsv(random_range(0, 40), 200, 255));
	part_type_scale(_part, _scale, _scale);
	repeat (round(lerp(1, 3, _percent)))
		{
		part_particles_create(Particle_System(), random(room_width), random(room_height), _part, 1);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */