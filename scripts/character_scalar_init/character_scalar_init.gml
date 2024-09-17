//Sets all of the variables for a character
function character_scalar_init()
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
		collision_box = spr_collision_mask_large;
	
		//Hurtbox
		hurtbox_sprite = spr_scalar_hurtbox;
		hurtbox_crouch_sprite = spr_scalar_hurtbox_crouch;
	
		//Weight
		weight_multiplier = 0.8;
	
		//Gravity
		grav = 0.7;
		hitstun_grav = 0.6;
	
		//Falling
		max_fall_speed = 10;
		fastfall_speed = 17;
	
		//Jumping
		jumpsquat_time = 4;
		jump_speed = 14;
		jump_horizontal_accel = 5;
		shorthop_speed = 9;
		double_jump_speed = 13;
		double_jump_horizontal_accel = 4;
		max_double_jumps = 1;
		land_time = 5;
	
		//Aerial Movment
		air_accel = 0.25;
		max_air_speed = 5.75;
		max_air_speed_dash = 6.5;
		air_friction = 0.03;
	
		//Ground Movement
		ground_friction = 1.0;
		crouch_friction = 1.5;
		slide_friction = 0.4;
		hard_landing_friction = 0.7;
		jostle_strength = 1.4;
	
		//Walking
		walk_speed = 2.5;
		walk_accel = 0.5;
		walk_turn_time = 6;
	
		//Dashing
		dash_speed = 9;
		dash_time = 9;
		dash_accel = 3;
	
		//Running
		run_speed = 8;
		run_accel = 0.8;
		run_turn_time = 5;
		run_turn_accel = 1;
		run_stop_time = 10;
	
		//Ledges
		ledge_jump_vsp = 15;
		ledge_jump_hsp = 3;
		ledge_jump_time = ledge_jump_time_default;
		ledge_getup_time = ledge_getup_time_default;
		ledge_getup_finish_x = 66;
		ledge_getup_finish_y = -64;
		ledge_roll_time = ledge_roll_time_default;
		ledge_attack_time = ledge_attack_time_default;
		//Some characters would not appear to grab the ledge
		//at the right spot due to sprite origin, so these
		//variables allow you to add an offset.
		ledge_hang_relative_x = -36;
		ledge_hang_relative_y = 38;
	
		//Airdodge Values
		if (airdodge_type == AIRDODGE_TYPE.momentum_stop)
			{
			airdodge_speed = 11;
			airdodge_startup = 2;
			airdodge_active = 10;
			airdodge_endlag = 20;
			waveland_speed_boost = 0;
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
			airdodge_dir_speed_min = 9;
			airdodge_dir_speed_max = 10;
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
			shield_recover_rate = 0.12;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = 1.4;
			shield_shift_amount = 15;
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
			shield_recover_rate = 0.14;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = 1.4;
			shield_shift_amount = 15;
			shield_release_time = 11;
			parry_shield_sprite = spr_basic_shield_release;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 14;
			}
		
		//Wall jump Values
		if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
			{
			wall_jump_startup = 4;
			wall_jump_time = 10;
			wall_jump_hsp = 7;
			wall_jump_vsp = -14;
			max_wall_jumps = 1;
			can_wall_cling = false;
			}
		else if (wall_jump_type == WALL_JUMP_TYPE.stick_flick)
			{
			can_wall_jump = true;
			wall_jump_startup = 5;
			wall_jump_time = 8;
			wall_jump_hsp = 7;
			wall_jump_vsp = -10;
			max_wall_jumps = 1;
			can_wall_cling = false;
			}
		
		//Rolling
		roll_speed = 11;
		roll_startup = roll_startup_default;
		roll_active = roll_active_default;
		roll_endlag = roll_endlag_default;
		
		//Getup
		getup_active = getup_active_default;
		getup_endlag = getup_endlag_default;
	
		//Teching
		tech_active = tech_active_default;
		tech_endlag = tech_endlag_default;
		techroll_speed = 12;
		techroll_startup = techroll_startup_default;
		techroll_active = techroll_active_default;
		techroll_endlag = techroll_endlag_default;
	
		//Helpless
		helpless_accel = 0.4;
		helpless_max_speed = 3;
		
		//Items
		item_hold_x_default = 4;
		item_hold_y_default = -20;
		
		//Custom Scripts
		draw_script = -1;
		callback_add(callback_passive, scalar_passive, CALLBACK_TYPE.permanent);
		}

	//States
	if (_set_states)
		{
		player_states_init();
		
		//You can set custom states for a character here, for example:
		//my_states[@ PLAYER_STATE.idle] = <some custom idle script>;
		}

	//Attacks
	if (_set_attacks)
		{
		my_attacks[$ "Jab"			] = scalar_jab;
		my_attacks[$ "Dash_Attack"	] = scalar_dash_attack;
		my_attacks[$ "Ftilt"		] = scalar_ftilt;
		my_attacks[$ "Utilt"		] = scalar_utilt;
		my_attacks[$ "Dtilt"		] = scalar_dtilt;
				 
		my_attacks[$ "Fsmash"		] = scalar_fsmash;
		my_attacks[$ "Usmash"		] = scalar_usmash;
		my_attacks[$ "Dsmash"		] = scalar_dsmash;
				 
		my_attacks[$ "Nair"			] = scalar_nair;
		my_attacks[$ "Fair"			] = bowser_fair;
		my_attacks[$ "Bair"			] = scalar_bair;
		my_attacks[$ "Uair"			] = scalar_uair;
		my_attacks[$ "Dair"			] = scalar_dair;
				 
		my_attacks[$ "Nspec"		] = scalar_nspec;
		my_attacks[$ "Fspec"		] = scalar_fspec;
		my_attacks[$ "Uspec"		] = scalar_uspec;
		my_attacks[$ "Dspec"		] = scalar_dspec;
				 
		my_attacks[$ "Grab"			] = scalar_grab;
		my_attacks[$ "Dash_Grab"	] = scalar_grab;
		my_attacks[$ "Pummel"		] = scalar_pummel;
		my_attacks[$ "Zair"			] = -1;
				 
		my_attacks[$ "Fthrow"		] = scalar_fthrow;
		my_attacks[$ "Bthrow"		] = scalar_bthrow;
		my_attacks[$ "Uthrow"		] = scalar_uthrow;
		my_attacks[$ "Dthrow"		] = scalar_dthrow;
				 
		my_attacks[$ "Getup_Attack"	] = scalar_getup_attack;
		my_attacks[$ "Ledge_Attack"	] = scalar_ledge_attack;
		my_attacks[$ "Item_Throw"	] = scalar_item_throw;
		my_attacks[$ "Item_Attack"	] = scalar_item_attack;
		my_attacks[$ "Taunt"		] = scalar_taunt;
		my_attacks[$ "Final_Smash"	] = scalar_final_smash;
		}

	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 2;
	
		my_sprites[$ "Entrance"			] = anim_define_ext(spr_scalar_idle, 0, 0.18);
		my_sprites[$ "Idle"				] = anim_define_ext(spr_scalar_idle, 0, 0.18);
		my_sprites[$ "Crouch"			] = spr_scalar_crouch;
		my_sprites[$ "Walk"				] = anim_define_ext(spr_scalar_run, 0, 0.18);
		my_sprites[$ "Walk_Turn"		] = anim_define_ext(spr_scalar_run, 0, 0.18);
		my_sprites[$ "Dash"				] = spr_scalar_run;
		my_sprites[$ "Run"				] = spr_scalar_run;
		my_sprites[$ "Run_Turn"			] = spr_scalar_run;
		my_sprites[$ "Run_Stop"			] = anim_define_ext(spr_scalar_run, 0, 0.18);
				 
		my_sprites[$ "Jumpsquat"		] = spr_scalar_crouch;
		my_sprites[$ "Jump_Rise"		] = spr_scalar_jump_rise;
		my_sprites[$ "Jump_Mid"			] = spr_scalar_jump_fall;
		my_sprites[$ "Jump_Fall"		] = spr_scalar_jump_fall;
		my_sprites[$ "Fastfall"			] = spr_scalar_fastfall;
		my_sprites[$ "DJump_Rise"		] = spr_scalar_jump_rise;
		my_sprites[$ "DJump_Mid"		] = spr_scalar_jump_fall;
		my_sprites[$ "DJump_Fall"		] = spr_scalar_jump_fall;
		my_sprites[$ "DFastfall"		] = spr_scalar_fastfall;
				 
		my_sprites[$ "Airdodge"			] = anim_define_ext(spr_scalar_airdodge, 0, anim_calculate_speed(spr_scalar_airdodge, airdodge_startup + airdodge_active + airdodge_endlag));
		my_sprites[$ "Waveland"			] = spr_scalar_crouch;
		my_sprites[$ "Rolling"			] = spr_scalar_rolling;
		my_sprites[$ "Shield"			] = anim_define(spr_scalar_shield_start, anim_define(spr_scalar_idle));
		my_sprites[$ "Shield_Release"	] = spr_scalar_idle;
		my_sprites[$ "Shield_Break"		] = anim_define_ext(spr_scalar_shield_break, 0, 0.12);
		my_sprites[$ "Parry_Stun"		] = spr_scalar_crouch;
		my_sprites[$ "Spot_Dodge"		] = anim_define_ext(spr_scalar_spot_dodge, 0, anim_calculate_speed(spr_scalar_spot_dodge, 32));
				 
		my_sprites[$ "Hitlag"			] = spr_scalar_hitlag;
		my_sprites[$ "Hitstun"			] = spr_scalar_hitstun;
		my_sprites[$ "Tumble"			] = spr_scalar_helpless;
		my_sprites[$ "Helpless"			] = spr_scalar_helpless;
		my_sprites[$ "Magnet"			] = spr_scalar_hitlag;
		my_sprites[$ "Flinch"			] = spr_scalar_crouch;
		my_sprites[$ "Landing_Lag"		] = spr_scalar_crouch;
		my_sprites[$ "Balloon"			] = spr_scalar_hitstun;
		my_sprites[$ "Reeling"			] = spr_scalar_reeling;
		my_sprites[$ "Knockdown"		] = anim_define_ext(spr_scalar_knockdown, 4, 0.6, 1, 0, 1, 0, 0, false, anim_define_ext(spr_scalar_knockdown, 7, 0));
		my_sprites[$ "Lock"				] = anim_define_ext(spr_scalar_knockdown, 0, 0.5, 1, 0, 1, 0, 0, false, anim_define_ext(spr_scalar_knockdown, 7, 0));
		my_sprites[$ "Getup"			] = anim_define_ext(spr_scalar_getup, 0, anim_calculate_speed(spr_scalar_getup, getup_active + getup_endlag));
	
		my_sprites[$ "Tech_Rolling"		] = spr_scalar_rolling;
		my_sprites[$ "Teching"			] = spr_scalar_idle;
		my_sprites[$ "Teching_Wall"		] = spr_scalar_idle;
		my_sprites[$ "Teching_Ceiling"	] = spr_scalar_idle;
		my_sprites[$ "Tech_Wall_Jump"	] = spr_scalar_jump_rise;
				 
		my_sprites[$ "Ledge_Snap"		] = spr_scalar_ledge_snap;
		my_sprites[$ "Ledge_Hang"		] = anim_define_ext(spr_scalar_ledge_hang, 0, 0.1);
		my_sprites[$ "Ledge_Getup"		] = spr_scalar_ledge_getup;
		my_sprites[$ "Ledge_Jump"		] = spr_scalar_ledge_jump;
		my_sprites[$ "Ledge_Roll"		] = spr_scalar_ledge_jump;
		my_sprites[$ "Ledge_Attack"		] = spr_scalar_ledge_jump;
		my_sprites[$ "Ledge_Tether"		] = -1;
		my_sprites[$ "Ledge_Trump"		] = -1;
		my_sprites[$ "Wall_Cling"		] = -1;
		my_sprites[$ "Wall_Jump"		] = spr_scalar_jump_rise;
	
		my_sprites[$ "Star_KO"			] = spr_scalar_helpless;
		my_sprites[$ "Screen_KO"		] = spr_scalar_helpless;
				 
		my_sprites[$ "Grabbing"			] = spr_scalar_grabbing;
		my_sprites[$ "Grabbed"			] = spr_scalar_hitstun;
		my_sprites[$ "Grab_Release"		] = spr_scalar_crouch;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */