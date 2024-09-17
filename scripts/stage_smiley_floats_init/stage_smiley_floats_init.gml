function stage_smiley_floats_init()
	{
		if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_smiley_floats_distant, 0, 0, 2, 0.15, 0.1),
		background_define(spr_stage_smiley_floats0, 0, 60, 2, 0.2, 0.15),
		background_define_script(spr_stage_smiley_floats1, 0, 0, 2, 0.25, 0.2, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		background_define_script(spr_stage_smiley_floats2, 0, 0, 2, 0.3, 0.25, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		background_define_script(spr_stage_smiley_floats3, 0, 0, 2, 0.35, 0.3, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		background_define_script(spr_stage_smiley_floats4, 0, 0, 2, 0.4, 0.35, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		background_define_script(spr_stage_smiley_floats5, 0, 0, 2, 0.45, 0.4, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		background_define_script(spr_stage_smiley_floats6, 0, 0, 2, 0.5, 0.45, 0, 0, false, 0, stage_smiley_floats_clouds_draw),
		back_clear,
		];
	
	//Foreground sprites
	foreground = [];
	
	//Music
	stage_music_random_set
		(
			[
			song_stage_islands, 56.0, 120.0,				20,
			song_stage_archive, 166.4, 332.8,				5,
			song_stage_haven, 0, 0,							10,
			song_stage_desert, 153.7, 300.0,				5,
			song_stage_clouds, 121.6, 224.0,				10,
			song_stage_factory, 0, 0,						5,
			song_stage_peak, 25.4, 94.5,					5,
			song_stage_campground, 0, 0,					5,
			song_stage_campground_remix, 144.0, 281.1,		5,
			song_stage_biosphere0, 0, 0,					5,
			song_stage_biosphere1, 201.0, 402.0,			20,
			]
		);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_smiley_floats_script, CALLBACK_TYPE.permanent);
	
	//Color tint
	stage_tint = [0.2, 0.2, 0.1];
	
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
	setting().background_is_static = false;
	setting().screen_shader_script = -1;
	
	//CPU Data
	cpu_up_b_distance = 540;
	cpu_main_stage_distance = 280;
	
	//Timer
	if (!variable_struct_exists(custom_stage_struct, "timer"))
		{
		custom_stage_struct.timer = 0;
		}
	
	//Get instance IDs for all blocks at the start of the game
	if (!variable_struct_exists(custom_ids_struct, "float_ids"))
		{
		custom_ids_struct.float_ids =
			[
			//1
			inst_63C02600_3,
			inst_72FDBD26,
			inst_B431676,
			//2
			inst_D761DDA,
			//3
			inst_3DC45483,
			inst_7F8FB6B7,
			//4
			inst_6870CF8A,
			inst_603BF274,
			//5
			inst_33532444,
			//6
			inst_7D039A5B,
			inst_26E2504A,
			//7
			inst_D32F0C0,
			inst_41B4F566,
			inst_306FCECC,
			//8
			inst_4D0C14B9,
			//9
			inst_69C5A1ED,
			inst_16D16548,
			inst_75F2E9BD,
			//10
			inst_717385F7,
			//11
			inst_3F872778,
			//12
			inst_D45B980,
			//13
			inst_25023E86,
			//14
			inst_7C8DE3B5,
			//15
			inst_7BD8AB23,
			];
		}
	}
/* Copyright 2024 Springroll Games / Yosi */