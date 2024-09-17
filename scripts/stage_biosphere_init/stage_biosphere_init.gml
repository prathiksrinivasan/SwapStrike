function stage_biosphere_init()
	{
	if (!object_is(object_index, obj_stage_manager))
		{
		crash("Trying to run a stage init script on an instance that is not obj_stage_manager!\n",
			"This may be caused by putting parentheses after a script name in stage_data.\n");
		}
	
	//Background sprites
	background = 
		[
		background_define(spr_stage_biosphere_distant, 0, 0, 2, 0.0, 0.0),
		background_define(spr_stage_biosphere_glass, 0, 56, 2, 0.05, 0.05),
		background_define(spr_stage_biosphere0, 0, -100, 2, 0.075, 0.05),
		background_define(spr_stage_biosphere1, 0, -100, 2, 0.15, 0.075),
		background_define(spr_stage_biosphere2, 0, -100, 2, 0.25, 0.1),
		background_define(spr_stage_biosphere3, 0, -75, 2, 0.35, 0.2),
		background_define(spr_stage_biosphere_sunbeams0, 0, 0, 2, 0.37, 0.25),
		background_define_script(spr_stage_biosphere_dots, 0, 0, -2.5, 0.4, 0.25, 0, 0, false, 0, stage_biosphere_dots_draw),
		background_define(spr_stage_biosphere4, 0, -48, 2, 0.5, 0.3),
		back_clear,
		];
	
	//Foreground sprites
	foreground = 
		[
		background_define(spr_stage_biosphere_sunbeams1, 0, -50, 2, 1.0, 1.0),
		background_define(spr_stage_biosphere5, 0, 110, 2, 1.1, 1.1),
		background_define_script(spr_stage_biosphere_dots, 0, 0, 2.5, 1.2, 1.2, 0, 0, false, 1, stage_biosphere_dots_draw),
		];
	
	//Music
	stage_music_random_set
		(
			[
			song_stage_biosphere0, 0, 0,			10,
			song_stage_biosphere1, 201.0, 402.0,	10,
			]
		);
	
	//Stage passive
	callback_add(callback_stage_passive, stage_biosphere_script, CALLBACK_TYPE.permanent);
	
	//Color tint
	stage_tint = [0.0, 0.2, 0.1];
	
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
	cpu_up_b_distance = 390;
	cpu_main_stage_distance = 260;
	
	//Butterflies
	repeat (4)
		{
		instance_create_layer(random(room_width), random(room_height), "Butterflies", obj_stage_biosphere_butterfly);
		}
	
	//Particles
	var _part = part_type_create();
	part_type_sprite(_part, spr_stage_biosphere_splash, true, true, false);
	part_type_life(_part, 20, 40);
	part_type_scale(_part, 2, 2);
	part_type_gravity(_part, 0.3, 270);
	stage_particle_types.stage_biosphere_splash = _part;
	}
/* Copyright 2024 Springroll Games / Yosi */