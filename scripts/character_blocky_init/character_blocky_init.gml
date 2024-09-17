//Sets all of the variables for a character
function character_blocky_init()
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
		collision_box = spr_collision_mask_medium;
	
		//Hurtbox
		hurtbox_sprite = spr_blocky_hurtbox;
		hurtbox_crouch_sprite = spr_basic_hurtbox_crouch;
	
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
	if (_set_attacks)
		{
		my_attacks[$ "Jab"			] = chrom_jab;
		my_attacks[$ "Dash_Attack"	] = basic_dash_attack_claw;
		my_attacks[$ "Ftilt"		] = blocky_ftilt;
		my_attacks[$ "Utilt"		] = blocky_utilt;
		my_attacks[$ "Dtilt"		] = blocky_dtilt;
				 
		my_attacks[$ "Fsmash"		] = link_fsmash;
		my_attacks[$ "Usmash"		] = blocky_usmash;
		my_attacks[$ "Dsmash"		] = blocky_dsmash;
				 
		my_attacks[$ "Nair"			] = joker_nair;
		my_attacks[$ "Fair"			] = bayonetta_fair;
		my_attacks[$ "Bair"			] = "cloud_bair_sim";
		my_attacks[$ "Uair"			] = cloud_uair;
		my_attacks[$ "Dair"			] = shulk_dair;
				 
		my_attacks[$ "Nspec"		] = ryu_nspec_hadoken;
		my_attacks[$ "Fspec"		] = bayonetta_fspec_afterburner;
		my_attacks[$ "Uspec"		] = zss_uspec;
		my_attacks[$ "Dspec"		] = basic_dspec_falling_attack;
				 
		my_attacks[$ "Grab"			] = basic_grab;
		my_attacks[$ "Dash_Grab"	] = basic_dash_grab;
		my_attacks[$ "Pummel"		] = basic_pummel;
		my_attacks[$ "Zair"			] = -1;
				 
		my_attacks[$ "Fthrow"		] = blocky_fthrow;
		my_attacks[$ "Bthrow"		] = blocky_bthrow;
		my_attacks[$ "Uthrow"		] = basic_uthrow_combo;
		my_attacks[$ "Dthrow"		] = basic_dthrow_combo;
		
		my_attacks[$ "Getup_Attack"	] = basic_getup_attack;
		my_attacks[$ "Ledge_Attack"	] = basic_ledge_attack;
		my_attacks[$ "Item_Throw"	] = basic_item_throw;
		my_attacks[$ "Item_Attack"	] = basic_item_attack;
		my_attacks[$ "Taunt"		] = blocky_taunt;
		my_attacks[$ "Final_Smash"	] = blocky_final_smash;
		}
		
	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 2;
	
		my_sprites[$ "Entrance"			] = anim_define(spr_blocky_entrance, anim_define(spr_blocky_idle));
		my_sprites[$ "Idle"				] = spr_blocky_idle;
		my_sprites[$ "Crouch"			] = anim_define(spr_basic_crouch_begin, anim_define(spr_basic_crouch));
		my_sprites[$ "Walk"				] = spr_basic_walk;
		my_sprites[$ "Walk_Turn"		] = spr_basic_walk;
		my_sprites[$ "Dash"				] = spr_basic_run;
		my_sprites[$ "Run"				] = spr_basic_run;
		my_sprites[$ "Run_Turn"			] = spr_basic_run;
		my_sprites[$ "Run_Stop"			] = spr_basic_run_stop;
				 
		my_sprites[$ "Jumpsquat"		] = spr_basic_jumpsquat;
		my_sprites[$ "Jump_Rise"		] = spr_basic_jump_rise;
		my_sprites[$ "Jump_Mid"			] = spr_basic_jump_mid;
		my_sprites[$ "Jump_Fall"		] = spr_basic_jump_fall;
		my_sprites[$ "Fastfall"			] = spr_basic_fastfall;
		my_sprites[$ "DJump_Rise"		] = anim_define(spr_basic_djump_rise, anim_define(spr_basic_jump_fall));
		my_sprites[$ "DJump_Mid"		] = -1;
		my_sprites[$ "DJump_Fall"		] = -1;
		my_sprites[$ "DFastfall"		] = -1;
				 
		my_sprites[$ "Airdodge"			] = anim_define_ext(spr_basic_airdodge, 0, anim_calculate_speed(spr_basic_airdodge, airdodge_startup + airdodge_active + airdodge_endlag));
		my_sprites[$ "Waveland"			] = spr_basic_waveland;
		my_sprites[$ "Rolling"			] = spr_basic_rolling;
		my_sprites[$ "Shield"			] = anim_define(spr_basic_shield_start, anim_define(spr_basic_shield));
		my_sprites[$ "Shield_Release"	] = spr_basic_shield_release;
		my_sprites[$ "Shield_Break"		] = anim_define_ext(spr_basic_shield_break, 0, 0.12, 1, 0, 1, 0, 0, true, -1);
		my_sprites[$ "Parry_Stun"		] = spr_basic_parry_stun;
		my_sprites[$ "Spot_Dodge"		] = spr_basic_spot_dodge;
				 
		my_sprites[$ "Hitlag"			] = spr_basic_hitlag;
		my_sprites[$ "Hitstun"			] = spr_basic_hitstun;
		my_sprites[$ "Tumble"			] = spr_basic_tumble;
		my_sprites[$ "Helpless"			] = spr_basic_helpless;
		my_sprites[$ "Magnet"			] = spr_basic_hitlag;
		my_sprites[$ "Flinch"			] = spr_basic_crouch;
		my_sprites[$ "Landing_Lag"		] = spr_basic_crouch;
		my_sprites[$ "Balloon"			] = spr_basic_balloon;
		my_sprites[$ "Reeling"			] = spr_basic_reeling;
		my_sprites[$ "Knockdown"		] = anim_define_ext(spr_basic_knockdown, 2, 0.7, 1, 0, 1, 0, 0, false, anim_define_ext(spr_basic_knockdown, 6, 0));
		my_sprites[$ "Lock"				] = anim_define_ext(spr_basic_knockdown, 0, 0.5, 1, 0, 1, 0, 0, false, anim_define_ext(spr_basic_knockdown, 6, 0));
		my_sprites[$ "Getup"			] = anim_define_ext(spr_basic_getup, 0, anim_calculate_speed(spr_basic_getup, getup_active + getup_endlag));
	
		my_sprites[$ "Tech_Rolling"		] = spr_basic_rolling; 
		my_sprites[$ "Teching"			] = spr_basic_teching;
		my_sprites[$ "Teching_Wall"		] = spr_basic_teching;
		my_sprites[$ "Teching_Ceiling"	] = spr_basic_teching;
		my_sprites[$ "Tech_Wall_Jump"	] = spr_basic_wall_jump;
				 
		my_sprites[$ "Ledge_Snap"		] = spr_basic_ledge_snap;
		my_sprites[$ "Ledge_Hang"		] = spr_basic_ledge_hang;
		my_sprites[$ "Ledge_Getup"		] = spr_basic_ledge_getup;
		my_sprites[$ "Ledge_Jump"		] = spr_basic_ledge_jump;
		my_sprites[$ "Ledge_Roll"		] = spr_basic_ledge_jump;
		my_sprites[$ "Ledge_Attack"		] = spr_basic_ledge_attack_getup;
		my_sprites[$ "Ledge_Tether"		] = anim_define_ext(spr_basic_ledge_tether, 0, 0.3, 1, 0, 1, 0, 16, true, -1);
		my_sprites[$ "Ledge_Trump"		] = spr_basic_ledge_trump;
		my_sprites[$ "Wall_Cling"		] = -1;
		my_sprites[$ "Wall_Jump"		] = spr_basic_wall_jump;
	
		my_sprites[$ "Star_KO"			] = spr_basic_star_ko;
		my_sprites[$ "Screen_KO"		] = spr_basic_screen_ko;
				 
		my_sprites[$ "Grabbing"			] = spr_basic_grabbing;
		my_sprites[$ "Grabbed"			] = spr_basic_hitstun;
		my_sprites[$ "Grab_Release"		] = spr_basic_crouch;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */