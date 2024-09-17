function stage_small_campground_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_campground_autumn0, 0, -15, 2, 0, 0),
		background_define(spr_stage_campground_autumn1, 0, -15, 2, 0.05, 0.05),
		background_define(spr_stage_campground_trees_autumn0, 0, 0, 2, 0.3, 0.3),
		background_define(spr_stage_campground_trees_autumn1, 0, 70, 2, 0.5, 0.5),
		background_define(spr_stage_campground_trees_autumn2, 0, 132, 2, 0.7, 0.7),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_set(song_stage_campground_remix, 144.0, 281.1);
	
	//Stage passive
	callback_stage_passive = [];
	
	//Color tint
	stage_tint = [0.2, 0.1, 0.0];
	
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
	cpu_up_b_distance = 440;
	cpu_main_stage_distance = 220;
	}
/* Copyright 2024 Springroll Games / Yosi */