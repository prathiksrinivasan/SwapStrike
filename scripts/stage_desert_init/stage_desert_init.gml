function stage_desert_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_desert_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_desert_clouds_moving0, 0, 364, 2, -0.9, -0.9, 2, 0, true),
		background_define(spr_stage_desert_clouds_moving0, 896 * 2, 364, 2, -0.9, -0.9, 2, 0, true),
		background_define(spr_stage_desert_rocks0, 0, 70, 2, 0.1, 0.1),
		background_define(spr_stage_desert_rocks1, 0, 105, 2, 0.2, 0.2),
		background_define(spr_stage_desert_rocks2, 0, 140, 2, 0.3, 0.3),
		back_clear,
		];
	
	//Foreground sprites
	foreground = 
		[
		background_define(spr_stage_desert_clouds_moving1, 0, 800, 2, 0.1, 0.1, 5, 0, true),
		background_define(spr_stage_desert_clouds_moving1, 992 * 2, 800, 2, 0.1, 0.1, 5, 0, true),
		];
	
	//Music
	stage_music_set(song_stage_desert, 153.7, 300.0);
	
	//Stage passive
	callback_stage_passive = [];
	
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
	setting().slope_collisions_enable = false;
	setting().background_is_static = true;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 430;
	cpu_main_stage_distance = 200;
	}
/* Copyright 2024 Springroll Games / Yosi */