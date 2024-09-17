function stage_factory_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_factory_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_factory_ball, 0, -100, 2, 0.1, 0.1),
		background_define_script(spr_stage_factory_falls, 0, 0, 2, 0.1, 0.1, 0, 0, false, 0, stage_factory_back_falls_draw),
		background_define(spr_stage_factory_pipes, 0, 0, 2, 0.2, 0.1),
		background_define_script(spr_stage_factory_pool, 0, 320, 2, 0.3, 0.2, 0, 0, false, 0, stage_factory_back_pool_draw),
		back_clear,
		];
	
	//Foreground sprites
	foreground = 
		[
		background_define(spr_stage_factory_smokestacks, 0, 250, 2, 1.1, 1.1),
		];
	
	//Music
	stage_music_set(song_stage_factory);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_factory_script, CALLBACK_TYPE.permanent);
	
	//Color tint
	stage_tint = [0.2, -0.1, -0.1];
	
	//Blastzones
	blastzones = 
		{
		left : 0, 
		top : 0, 
		right : room_width, 
		bottom : room_height,
		};
	
	//Stage settings
	setting().daynight_cycle_enable = false;
	setting().stage_background_color = c_white;
	setting().slope_collisions_enable = false;
	setting().background_is_static = true;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 370;
	cpu_main_stage_distance = 280;

	//Particles
	var _part = part_type_create();
	part_type_sprite(_part, spr_stage_factory_wisp, true, true, false);
	part_type_life(_part, 20, 60);
	part_type_gravity(_part, 0.1, 90);
	stage_particle_types.stage_factory_wisp = _part;
	}
/* Copyright 2024 Springroll Games / Yosi */