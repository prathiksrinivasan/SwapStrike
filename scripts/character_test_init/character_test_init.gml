//Sets all of the variables for a character
function character_test_init()
	{
	if (!object_is(object_index, obj_player))
		{
		crash("Trying to run a character init script on an instance that is not an obj_player!\n",
			"This may be caused by putting parentheses after a script name in character_data.\n");
		}
		
	//Determine which variables to set
	var _set_properties = argument_count > 0 ? argument[0] : true;
	var _set_states = argument_count > 1 ? argument[1] : true;
	var _set_attacks = argument_count > 2 ? argument[2] : true;
	var _set_sprites = argument_count > 3 ? argument[3] : true;
	
	//Properties
	if (_set_properties)
		{
		//Collision box
		collision_box = spr_default_hurtbox;
	
		//Hurtbox
		hurtbox_sprite = spr_default_hurtbox;
		hurtbox_crouch_sprite = spr_default_hurtbox;
	
		//Weight
		weight_multiplier = 1;
	
		//Gravity
		grav = 0.5;
		hitstun_grav = 0.5;
	
		//Falling
		max_fall_speed = 10;
		fastfall_speed = 14;
	
		//Jumping
		jumpsquat_time = 3;
		jump_speed = 11.5;
		jump_horizontal_accel = 3;
		shorthop_speed = 6.5;
		double_jump_speed = 10.5;
		double_jump_horizontal_accel = 2;
		max_double_jumps = 1;
		land_time = 4;
	
		//Aerial Movment
		air_accel = 0.35;
		max_air_speed = 5.25;
		max_air_speed_dash = 6.75;
		air_friction = 0.04;
	
		//Ground Movement
		ground_friction = 0.75;
		crouch_friction = 1;
		slide_friction = 0.35;
		hard_landing_friction = 0.6;
		jostle_strength = jostle_strength_default;
	
		//Walking
		walk_speed = 3.25;
		walk_accel = 0.5;
		walk_turn_time = 6;
	
		//Dashing
		dash_speed = 8;
		dash_time = 9;
		dash_accel = 8;
	
		//Running
		run_speed = 7;
		run_accel = 0.8;
		run_turn_time = 5;
		run_turn_accel = 1;
		run_stop_time = 4;
	
		//Ledges
		ledge_jump_vsp = 12;
		ledge_jump_hsp = 2;
		ledge_jump_time = ledge_jump_time_default;
		ledge_getup_time = ledge_getup_time_default;
		ledge_getup_finish_x = 40;
		ledge_getup_finish_y = -46;
		ledge_roll_time = ledge_roll_time_default;
		ledge_attack_time = ledge_attack_time_default;
		//Some characters would not appear to grab the ledge
		//at the right spot due to sprite origin, so these
		//variables allow you to add an offset.
		ledge_hang_relative_x = -18;
		ledge_hang_relative_y = 22;
	
		//Airdodge Values
		if (airdodge_type == AIRDODGE_TYPE.momentum_stop)
			{
			airdodge_speed = 9;
			airdodge_startup = 2;
			airdodge_active = 10;
			airdodge_endlag = 20;
			waveland_speed_boost = 1;
			waveland_time = 8;
			waveland_friction = 0.24;
			}
		else if (airdodge_type == AIRDODGE_TYPE.momentum_keep)
			{
			airdodge_startup = 1;
			airdodge_active = 18;
			airdodge_endlag = 10;
			airdodge_land_time = 12;
			}
		else if (airdodge_type == AIRDODGE_TYPE.accelerate)
			{
			airdodge_startup = 3;
			airdodge_active = 27;
			airdodge_endlag = 17;
			airdodge_land_time = 10;
			airdodge_dir_windup_speed = 9;
			airdodge_dir_speed_min = 8;
			airdodge_dir_speed_max = 9;
			airdodge_dir_active = 18;
			airdodge_dir_endlag_min = 20;
			airdodge_dir_endlag_max = 45;
			airdodge_dir_grav = 0.2;
			}
		
		//Shield Values
		if (shield_type == SHIELD_TYPE.perfect_shield_start)
			{
			shield_max_hp = 55;
			shield_depeletion_rate = 0.14;
			shield_recover_rate = 0.14;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = shield_size_multiplier_default;
			shield_shift_amount = 10;
			shield_release_time = 4;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 15;
			}
		else if (shield_type == SHIELD_TYPE.parry_press)
			{
			parry_press_startup = 2;
			parry_press_active = 8;
			parry_press_endlag = 30;
			parry_press_trigger_time = 15;
			parry_press_script = basic_parry_press;
			}
		else if (shield_type == SHIELD_TYPE.parry_shield)
			{
			shield_max_hp = 55;
			shield_depeletion_rate = 0.14;
			shield_recover_rate = 0.12;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = shield_size_multiplier_default;
			shield_shift_amount = 10;
			shield_release_time = 11;
			parry_shield_sprite = spr_basic_shield_release;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 14;
			}
		
		//Wall jump Values
		if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
			{
			wall_jump_startup = 2;
			wall_jump_time = 8;
			wall_jump_hsp = 7;
			wall_jump_vsp = -8;
			max_wall_jumps = 1;
			can_wall_cling = false;
			}
		else if (wall_jump_type == WALL_JUMP_TYPE.stick_flick)
			{
			can_wall_jump = true;
			wall_jump_startup = 5;
			wall_jump_time = 8;
			wall_jump_hsp = 7;
			wall_jump_vsp = -9;
			can_wall_cling = false;
			}
	
		//Rolling
		roll_speed = 9;
		roll_startup = roll_startup_default;
		roll_active = roll_active_default;
		roll_endlag = roll_endlag_default;
		
		//Getup
		getup_active = getup_active_default;
		getup_endlag = getup_endlag_default;
	
		//Teching
		tech_active = tech_active_default;
		tech_endlag = tech_endlag_default;
		techroll_speed = 10;
		techroll_startup = techroll_startup_default;
		techroll_active = techroll_active_default;
		techroll_endlag = techroll_endlag_default;
	
		//Helpless
		helpless_accel = 0.5;
		helpless_max_speed = 3;
		
		//Items
		item_hold_x_default = 16;
		item_hold_y_default = -4;
		
		//Custom Scripts
		draw_script = -1;
		callback_add(callback_passive, bayonetta_fspec_afterburner_passive, CALLBACK_TYPE.permanent);
		}

	//States
	if (_set_states)
		{
		player_states_init();
		
		//You can set custom states for a character here, for example:
		//my_states[@ PLAYER_STATE.idle] = <some custom idle script>;
		}

	//Attacks
	// ---- HOW TO TEST ATTACKS ----
	// Replace an action here with the name of your attack script
	// do NOT include the parentheses when writing the script name
	if (_set_attacks)
		{
		my_attacks[$ "Jab"			] = chrom_jab;
		my_attacks[$ "Dash_Attack"	] = -1;
		my_attacks[$ "Ftilt"		] = -1;
		my_attacks[$ "Utilt"		] = -1;
		my_attacks[$ "Dtilt"		] = -1;
				 
		my_attacks[$ "Fsmash"		] = -1;
		my_attacks[$ "Usmash"		] = -1;
		my_attacks[$ "Dsmash"		] = -1;
				 
		my_attacks[$ "Nair"			] = -1;
		my_attacks[$ "Fair"			] = -1;
		my_attacks[$ "Bair"			] = -1;
		my_attacks[$ "Uair"			] = -1;
		my_attacks[$ "Dair"			] = -1;
				 
		my_attacks[$ "Nspec"		] = departure;
		my_attacks[$ "Fspec"		] = -1;
		my_attacks[$ "Uspec"		] = -1;
		my_attacks[$ "Dspec"		] = -1;
				 
		my_attacks[$ "Grab"			] = -1;
		my_attacks[$ "Dash_Grab"	] = -1;
		my_attacks[$ "Pummel"		] = -1;
		my_attacks[$ "Zair"			] = -1;
				 
		my_attacks[$ "Fthrow"		] = -1;
		my_attacks[$ "Bthrow"		] = -1;
		my_attacks[$ "Uthrow"		] = -1;
		my_attacks[$ "Dthrow"		] = -1;
		
		my_attacks[$ "Getup_Attack"	] = -1;
		my_attacks[$ "Ledge_Attack"	] = -1;
		my_attacks[$ "Item_Throw"	] = -1;
		my_attacks[$ "Item_Attack"	] = -1;
		my_attacks[$ "Taunt"		] = -1;
		my_attacks[$ "Final_Smash"	] = -1;
		}
		
	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 1;
	
		my_sprites[$ "Entrance"			] = spr_placeholder;
		my_sprites[$ "Idle"				] = anim_define_ext(spr_wiz_idle,0,.16);
		my_sprites[$ "Crouch"			] = spr_wiz_crouch;
		my_sprites[$ "Walk"				] = spr_placeholder;
		my_sprites[$ "Walk_Turn"		] = spr_placeholder;
		my_sprites[$ "Dash"				] = spr_wiz_dash;
		my_sprites[$ "Run"				] = spr_wiz_run;
		my_sprites[$ "Run_Turn"			] = spr_placeholder;
		my_sprites[$ "Run_Stop"			] = spr_placeholder;
				 
		my_sprites[$ "Jumpsquat"		] = spr_wiz_crouch;
		my_sprites[$ "Jump_Rise"		] = spr_wiz_jump;
		my_sprites[$ "Jump_Mid"			] = spr_wiz_jump;
		my_sprites[$ "Jump_Fall"		] = spr_wiz_fall;
		my_sprites[$ "Fastfall"			] = spr_wiz_fall;
		my_sprites[$ "DJump_Rise"		] = spr_wiz_jump;
		my_sprites[$ "DJump_Mid"		] = -1;
		my_sprites[$ "DJump_Fall"		] = spr_wiz_fall;
		my_sprites[$ "DFastfall"		] = -1;
				 
		my_sprites[$ "Airdodge"			] = spr_placeholder
		my_sprites[$ "Waveland"			] = spr_placeholder;
		my_sprites[$ "Rolling"			] = anim_define_ext(spr_wiz_roll,0,.5,1,0,1,0,0,0);
		my_sprites[$ "Shield"			] = spr_placeholder
		my_sprites[$ "Shield_Release"	] = spr_placeholder;
		my_sprites[$ "Shield_Break"		] = spr_placeholder
		my_sprites[$ "Parry_Stun"		] = spr_placeholder;
		my_sprites[$ "Spot_Dodge"		] = spr_placeholder;
				 
		my_sprites[$ "Hitlag"			] = spr_placeholder;
		my_sprites[$ "Hitstun"			] = spr_placeholder;
		my_sprites[$ "Tumble"			] = spr_placeholder;
		my_sprites[$ "Helpless"			] = spr_placeholder;
		my_sprites[$ "Magnet"			] = spr_placeholder;
		my_sprites[$ "Flinch"			] = spr_placeholder;
		my_sprites[$ "Landing_Lag"		] = spr_placeholder;
		my_sprites[$ "Balloon"			] = spr_placeholder;
		my_sprites[$ "Reeling"			] = spr_placeholder;
		my_sprites[$ "Knockdown"		] = spr_placeholder;
		my_sprites[$ "Lock"				] = spr_placeholder;
		my_sprites[$ "Getup"			] = spr_placeholder;
	
		my_sprites[$ "Tech_Rolling"		] = spr_placeholder; 
		my_sprites[$ "Teching"			] = spr_placeholder;
		my_sprites[$ "Teching_Wall"		] = spr_placeholder;
		my_sprites[$ "Teching_Ceiling"	] = spr_placeholder;
		my_sprites[$ "Tech_Wall_Jump"	] = spr_placeholder;
				 
		my_sprites[$ "Ledge_Snap"		] = spr_placeholder;
		my_sprites[$ "Ledge_Hang"		] = spr_placeholder;
		my_sprites[$ "Ledge_Getup"		] = spr_placeholder;
		my_sprites[$ "Ledge_Jump"		] = spr_placeholder;
		my_sprites[$ "Ledge_Roll"		] = spr_placeholder;
		my_sprites[$ "Ledge_Attack"		] = spr_placeholder;
		my_sprites[$ "Ledge_Tether"		] = spr_placeholder;
		my_sprites[$ "Ledge_Trump"		] = spr_placeholder;
		my_sprites[$ "Wall_Cling"		] = spr_placeholder;
		my_sprites[$ "Wall_Jump"		] = spr_placeholder;
	
		my_sprites[$ "Star_KO"			] = spr_placeholder;
		my_sprites[$ "Screen_KO"		] = spr_placeholder;
				 
		my_sprites[$ "Grabbing"			] = spr_placeholder;
		my_sprites[$ "Grabbed"			] = spr_placeholder;
		my_sprites[$ "Grab_Release"		] = spr_placeholder;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */