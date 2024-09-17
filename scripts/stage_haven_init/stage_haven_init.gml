function stage_haven_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_haven_distant, 0, 0, 2, 0, 0),
		background_define(spr_stage_haven_falls0, 0, 0, 2, 0, 0),
		background_define(spr_stage_haven_spikes0, 0, 0, 2, 0.1, 0.1),
		background_define(spr_stage_haven_falls1, 0, 0, 2, 0.2, 0.2),
		background_define(spr_stage_haven_spikes1, 0, 0, 2, 0.3, 0.3),
		background_define(spr_stage_haven_spikes2, 0, 0, 2, 0.4, 0.4),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_set(song_stage_haven);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_haven_script, CALLBACK_TYPE.permanent);
	custom_stage_struct.haven_final_form = false;
	custom_stage_struct.haven_transform_frame = 0;
	
	//Color tint
	stage_tint = [-0.1, 0.1, 0.2];
	
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
	cpu_up_b_distance = 380;
	cpu_main_stage_distance = 240;
	}
/* Copyright 2024 Springroll Games / Yosi */