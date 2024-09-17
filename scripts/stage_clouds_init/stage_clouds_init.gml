function stage_clouds_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define_script(spr_stage_clouds_distant, 0, 0, 2, 0, 0, 0, 0, false, 0, stage_clouds_distant_draw),
		background_define(spr_stage_clouds0, 0, 70, 2, 0.2, 0.2),
		background_define(spr_stage_clouds1, 0, 105, 2, 0.3, 0.3),
		background_define(spr_stage_clouds2, 0, 140, 2, 0.4, 0.4),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_set(song_stage_clouds, 121.6, 224.0);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_clouds_lightning, CALLBACK_TYPE.permanent);
	
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
	setting().stage_background_color = $6D4F4C;
	setting().slope_collisions_enable = true;
	setting().background_is_static = true;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 460;
	cpu_main_stage_distance = 360;
	}
/* Copyright 2024 Springroll Games / Yosi */