function stage_peak_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_peak_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_peak_light, 0, -25, 2, 0.1, 0.1),
		background_define(spr_stage_peak_lighthouse, 0, -25, 2, 0.1, 0.1),
		background_define(spr_stage_peak_spikes0, 0, -10, 2, 0.1, 0.1),
		background_define(spr_stage_peak_spikes1, 0, 5, 2, 0.2, 0.2),
		background_define(spr_stage_peak_spikes2, 0, 25, 2, 0.3, 0.3),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_set(song_stage_peak, 25.4, 94.5);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_peak_snow, CALLBACK_TYPE.permanent);
	
	//Color tint
	stage_tint = [0.1, 0.1, 0.0];
	
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
	cpu_up_b_distance = 410;
	cpu_main_stage_distance = 300;
	
	//Particles
	var _part = part_type_create();
	part_type_sprite(_part, spr_stage_peak_snow, false, false, true);
	part_type_size(_part, 0.2, 1.5, -0.005, 0.01);
	part_type_life(_part, 600, 800);
	part_type_alpha2(_part, 1, 0);
	stage_particle_types.stage_peak_snow = _part;
	}
/* Copyright 2024 Springroll Games / Yosi */