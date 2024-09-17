function stage_islands_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_islands_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_islands_clouds_moving0, 0, 600, 2, -0.9, -0.9, 2, 0, true),
		background_define(spr_stage_islands_clouds_moving0, 896 * 2, 600, 2, -0.9, -0.9, 2, 0, true),
		background_define(spr_stage_islands_stone, 0, 50, 2, 0.3, 0.2),
		background_define(spr_stage_islands_clouds, 0, 75, 2, 0.8, 0.4),
		back_clear,
		background_define(spr_stage_islands_main, 608, 704, 2, 0, 0, 0, 0, true, 0),
		background_define(spr_stage_islands_main_stones, 608, 670, 2, 0, 0, 0, 0, true, 0),
		background_define(spr_stage_islands_grass, 620, 706, 2, 0, 0, 0, 0, true, 0.1),
		background_define(spr_stage_islands_grass, 860, 706, 2, 0, 0, 0, 0, true, 0.1),
		background_define(spr_stage_islands_grass, 980, 706, 2, 0, 0, 0, 0, true, 0.1),
		];
	
	//Foreground sprites
	foreground = 
		[
		background_define(spr_stage_islands_clouds_moving1, 0, 800, 2, 0.1, 0.1, 5, 0, true),
		background_define(spr_stage_islands_clouds_moving1, 896 * 2, 800, 2, 0.1, 0.1, 5, 0, true),
		];
	
	//Music
	stage_music_set(song_stage_islands, 56.0, 120.0);
	
	//Stage passive
	callback_stage_passive = [];
	callback_add(callback_stage_passive, stage_islands_script, CALLBACK_TYPE.permanent);
	
	//Color tint
	stage_tint = [0.0, 0.0, 0.0];
	
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
	setting().slope_collisions_enable = true;
	setting().background_is_static = true;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 540;
	cpu_main_stage_distance = 280;
	}
/* Copyright 2024 Springroll Games / Yosi */