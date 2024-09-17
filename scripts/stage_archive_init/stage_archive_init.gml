function stage_archive_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_archive_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_archive_pillars, 0, 0, 2, 0.05, 0.05),
		background_define(spr_stage_archive_shelves0, 0, 0, 2, 0.1, 0.1),
		background_define(spr_stage_archive_shelves1, 0, 0, 2, 0.2, 0.2),
		background_define(spr_stage_archive_shelves2, 0, 0, 2, 0.3, 0.3),
		background_define(spr_stage_archive_abyss0, 0, 156, 2, 0.3, 0.3),
		background_define(spr_stage_archive_abyss1, 0, 36, 2, 0.3, 0.3),
		background_define(spr_stage_archive_lantern, 0, -110, 2, 0.4, 0.4),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_set(song_stage_archive, 166.4, 332.8);
	
	//Stage passive
	callback_stage_passive = [];
	
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
	setting().slope_collisions_enable = true;
	setting().background_is_static = true;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 560;
	cpu_main_stage_distance = 330;
	}
/* Copyright 2024 Springroll Games / Yosi */