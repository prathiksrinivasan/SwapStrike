function __optimized_load_obj_player()
	{
	var _b = argument[0];
	//Don't save variables marked as "static"
	if (!character_static_attacks)
		{
		my_attacks=buffer_read_struct(_b);
		}
	if (!character_static_sprites)
		{
		sprite_scale=buffer_read(_b,buffer_f64);
		my_sprites=buffer_read_struct(_b);
		}
	if (!character_static_states)
		{
		my_states=buffer_read_array(_b,buffer_s32);
		}
	if (!character_static_properties)
		{
		collision_box=buffer_read(_b,buffer_s32);
		
		hurtbox_sprite=buffer_read(_b,buffer_s32);
		hurtbox_crouch_sprite=buffer_read(_b,buffer_s32);

		weight_multiplier=buffer_read(_b,buffer_f64);

		grav=buffer_read(_b,buffer_f64);
		hitstun_grav=buffer_read(_b,buffer_f64);

		max_fall_speed=buffer_read(_b,buffer_f64);
		fastfall_speed=buffer_read(_b,buffer_f64);

		jumpsquat_time=buffer_read(_b,buffer_f64);
		jump_speed=buffer_read(_b,buffer_f64);
		jump_horizontal_accel=buffer_read(_b,buffer_f64);
		shorthop_speed=buffer_read(_b,buffer_f64);
		double_jump_speed=buffer_read(_b,buffer_f64);
		double_jump_horizontal_accel=buffer_read(_b,buffer_f64);
		max_double_jumps=buffer_read(_b,buffer_u8);
		land_time=buffer_read(_b,buffer_f64);

		air_accel=buffer_read(_b,buffer_f64);
		max_air_speed=buffer_read(_b,buffer_f64);
		max_air_speed_dash=buffer_read(_b,buffer_f64);
		air_friction=buffer_read(_b,buffer_f64);

		ground_friction=buffer_read(_b,buffer_f64);
		crouch_friction=buffer_read(_b,buffer_f64);
		slide_friction=buffer_read(_b,buffer_f64);
		hard_landing_friction=buffer_read(_b,buffer_f64);
		jostle_strength=buffer_read(_b,buffer_f64);

		walk_speed=buffer_read(_b,buffer_f64);
		walk_accel=buffer_read(_b,buffer_f64);
		walk_turn_time=buffer_read(_b,buffer_f64);

		dash_speed=buffer_read(_b,buffer_f64);
		dash_time=buffer_read(_b,buffer_f64);
		dash_accel=buffer_read(_b,buffer_f64);

		run_speed=buffer_read(_b,buffer_f64);
		run_accel=buffer_read(_b,buffer_f64);
		run_turn_time=buffer_read(_b,buffer_f64);
		run_turn_accel=buffer_read(_b,buffer_f64);
		run_stop_time=buffer_read(_b,buffer_f64);

		ledge_jump_vsp=buffer_read(_b,buffer_f64);
		ledge_jump_hsp=buffer_read(_b,buffer_f64);
		ledge_jump_time=buffer_read(_b,buffer_f64);
		ledge_getup_time=buffer_read(_b,buffer_f64);
		ledge_getup_finish_x=buffer_read(_b,buffer_s16);
		ledge_getup_finish_y=buffer_read(_b,buffer_s16);
		ledge_roll_time=buffer_read(_b,buffer_f64);
		ledge_attack_time=buffer_read(_b,buffer_f64);
		ledge_hang_relative_x=buffer_read(_b,buffer_s16);
		ledge_hang_relative_y=buffer_read(_b,buffer_s16);

		airdodge_speed=buffer_read(_b,buffer_f64);
		airdodge_startup=buffer_read(_b,buffer_f64);
		airdodge_active=buffer_read(_b,buffer_f64);
		airdodge_endlag=buffer_read(_b,buffer_f64);
		waveland_speed_boost=buffer_read(_b,buffer_f64);
		waveland_time=buffer_read(_b,buffer_f64);
		waveland_friction=buffer_read(_b,buffer_f64);
		airdodge_land_time=buffer_read(_b,buffer_f64);
		airdodge_dir_windup_speed=buffer_read(_b,buffer_f64);
		airdodge_dir_speed_min=buffer_read(_b,buffer_f64);
		airdodge_dir_speed_max=buffer_read(_b,buffer_f64);
		airdodge_dir_active=buffer_read(_b,buffer_f64);
		airdodge_dir_endlag_min=buffer_read(_b,buffer_f64);
		airdodge_dir_endlag_max=buffer_read(_b,buffer_f64);
		airdodge_dir_grav=buffer_read(_b,buffer_f64);

		shield_max_hp=buffer_read(_b,buffer_f64);
		shield_depeletion_rate=buffer_read(_b,buffer_f64);
		shield_recover_rate=buffer_read(_b,buffer_f64);
		shield_break_launch=buffer_read(_b,buffer_f64);
		shield_break_reset_hp=buffer_read(_b,buffer_f64);
		shield_size_multiplier=buffer_read(_b,buffer_f64);
		shield_shift_amount=buffer_read(_b,buffer_f64);
		shield_release_time=buffer_read(_b,buffer_f64);
		spot_dodge_startup=buffer_read(_b,buffer_f64);
		spot_dodge_active=buffer_read(_b,buffer_f64);
		spot_dodge_endlag=buffer_read(_b,buffer_f64);
		parry_press_startup=buffer_read(_b,buffer_f64);
		parry_press_active=buffer_read(_b,buffer_f64);
		parry_press_endlag=buffer_read(_b,buffer_f64);
		parry_press_trigger_time=buffer_read(_b,buffer_f64);
		parry_press_script=buffer_read(_b,buffer_s32);
		parry_shield_sprite=buffer_read_auto(_b);

		wall_jump_startup=buffer_read(_b,buffer_f64);
		wall_jump_time=buffer_read(_b,buffer_f64);
		wall_jump_hsp=buffer_read(_b,buffer_f64);
		wall_jump_vsp=buffer_read(_b,buffer_f64);
		max_wall_jumps=buffer_read(_b,buffer_u16);
		can_wall_cling=buffer_read(_b,buffer_bool);
		can_wall_jump=buffer_read(_b,buffer_bool);

		roll_speed=buffer_read(_b,buffer_f64);
		roll_startup=buffer_read(_b,buffer_f64);
		roll_active=buffer_read(_b,buffer_f64);
		roll_endlag=buffer_read(_b,buffer_f64);
		
		getup_active=buffer_read(_b,buffer_f64);
		getup_endlag=buffer_read(_b,buffer_f64);

		tech_active=buffer_read(_b,buffer_f64);
		tech_endlag=buffer_read(_b,buffer_f64);
		techroll_speed=buffer_read(_b,buffer_f64);
		techroll_startup=buffer_read(_b,buffer_f64);
		techroll_active=buffer_read(_b,buffer_f64);
		techroll_endlag=buffer_read(_b,buffer_f64);

		helpless_accel=buffer_read(_b,buffer_f64);
		helpless_max_speed=buffer_read(_b,buffer_f64);
		
		item_hold_x_default=buffer_read(_b,buffer_f64);
		item_hold_y_default=buffer_read(_b,buffer_f64);

		draw_script=buffer_read(_b,buffer_s32);
		}
	
	//Player variables - must be saved no matter what!
	character=buffer_read(_b,buffer_s16);
	character_script=buffer_read(_b,buffer_s32);
	character_name=buffer_read(_b,buffer_string);

	state=buffer_read(_b,buffer_s8);
	state_script=buffer_read(_b,buffer_s32);
	state_frame=buffer_read(_b,buffer_f64);
	state_time=buffer_read(_b,buffer_f64);
	state_phase=buffer_read(_b,buffer_s32);
	state_facing=buffer_read(_b,buffer_s8);

	player_number=buffer_read(_b,buffer_u8);
	player_color=buffer_read(_b,buffer_s8);
	player_outline_color=buffer_read(_b,buffer_s32);
	player_profile=buffer_read(_b,buffer_s32);
	player_name=buffer_read(_b,buffer_string);
	player_team=buffer_read(_b,buffer_s8);

	jump_is_shorthop=buffer_read(_b,buffer_bool);
	jump_is_midair_jump=buffer_read(_b,buffer_bool);
	jump_is_dash_jump=buffer_read(_b,buffer_bool);
	dash_prevent_jump=buffer_read(_b,buffer_bool);
	can_fastfall=buffer_read(_b,buffer_bool);
	double_jumps=buffer_read(_b,buffer_s8);
	landed_on_ground=buffer_read(_b,buffer_bool);
	footstool_cooldown=buffer_read(_b,buffer_f64);
	airdodges_max=buffer_read(_b,buffer_u8);
	airdodges=buffer_read(_b,buffer_u8);
	airdodge_is_directional=buffer_read(_b,buffer_bool);
	airdodge_direction=buffer_read(_b,buffer_f64);
	shield_shift_x=buffer_read(_b,buffer_f64);
	shield_shift_y=buffer_read(_b,buffer_f64);
	shield_hp=buffer_read(_b,buffer_f64);
	shieldstun=buffer_read(_b,buffer_f64);
	parry_stun_time=buffer_read(_b,buffer_f64);
	has_been_parried=buffer_read(_b,buffer_bool);
	heavyarmor_amount=buffer_read(_b,buffer_f64);
	magnet_goal_x=buffer_read(_b,buffer_f64);
	magnet_goal_y=buffer_read(_b,buffer_f64);
	magnet_snap_speed=buffer_read(_b,buffer_f64);
	tech_buffer=buffer_read(_b,buffer_f64);
	ledge_id=buffer_read(_b,buffer_f64);
	ledge_grab_timeout=buffer_read(_b,buffer_f64);
	ledge_grab_counter=buffer_read(_b,buffer_f64);
	ledge_tether_point_id=buffer_read(_b,buffer_f64);
	wall_cling_timeout=buffer_read(_b,buffer_f64);
	wall_jump_timeout=buffer_read(_b,buffer_f64);
	wall_jumps=buffer_read(_b,buffer_s8);
	self_hitlag_frame=buffer_read(_b,buffer_f64);
	attack_script=buffer_read(_b,buffer_s32);
	attack_frame=buffer_read(_b,buffer_s32);
	attack_phase=buffer_read(_b,buffer_s16);
	simple_attack_name=buffer_read(_b,buffer_string);
	charge=buffer_read(_b,buffer_f64);
	landing_lag=buffer_read(_b,buffer_f64);
	final_smash_uses=buffer_read(_b,buffer_s8);
	grab_hold_x=buffer_read(_b,buffer_f64);
	grab_hold_y=buffer_read(_b,buffer_f64);
	grab_hold_enable=buffer_read(_b,buffer_bool);
	grab_hold_id=buffer_read(_b,buffer_f64);
	grabbed_id=buffer_read(_b,buffer_f64);
	grab_regrab_frame=buffer_read(_b,buffer_f64);
	grab_break_buffer=buffer_read(_b,buffer_f64);
	throw_stick_has_reset=buffer_read(_b,buffer_bool);
	ignore_blastzones=buffer_read(_b,buffer_bool);

	is_cpu=buffer_read(_b,buffer_bool);
	cpu_type=buffer_read(_b,buffer_s8);
	cpu_inputs_bitflag=buffer_read(_b,buffer_u32);
	device=buffer_read(_b,buffer_s8);
	device_type=buffer_read(_b,buffer_s8);
	double_tap_run_frame=buffer_read(_b,buffer_f64);
	double_tap_fastfall_frame=buffer_read(_b,buffer_f64);
	custom_controls=buffer_read_array(_b,buffer_s16);
	control_states_l=buffer_read_array(_b,buffer_f64);
	control_states_r=buffer_read_array(_b,buffer_f64);
	control_tilted_l=buffer_read(_b,buffer_u32);
	control_tilted_r=buffer_read(_b,buffer_u32);
	control_flicked_l=buffer_read(_b,buffer_u32);
	control_flicked_r=buffer_read(_b,buffer_u32);
	right_stick_input=buffer_read(_b,buffer_s8);
	scs=buffer_read_array(_b,buffer_bool);
	acs=buffer_read_array(_b);
	input_buffer=buffer_read_array(_b,buffer_s16);
	paused_inputs_flag=buffer_read(_b,buffer_u32);

	hsp=buffer_read(_b,buffer_f64);
	vsp=buffer_read(_b,buffer_f64);
	hsp_frac=buffer_read(_b,buffer_f64);
	vsp_frac=buffer_read(_b,buffer_f64);
	hsp_moved=buffer_read(_b,buffer_f64);
	vsp_moved=buffer_read(_b,buffer_f64);
	collision_flags=buffer_read(_b,buffer_s32);
	facing=buffer_read(_b,buffer_s8);
	
	damage=buffer_read(_b,buffer_f64);
	knockback_dir=buffer_read(_b,buffer_f64);
	knockback_spd=buffer_read(_b,buffer_f64);
	stored_hitstun=buffer_read(_b,buffer_f64);
	stored_state=buffer_read(_b,buffer_s8);
	is_reeling=buffer_read(_b,buffer_bool);
	asdi_multiplier=buffer_read(_b,buffer_f64);
	drift_di_multiplier=buffer_read(_b,buffer_f64);
	di_angle=buffer_read(_b,buffer_f64);
	ko_property=buffer_read(_b,buffer_f64);
	player_id=buffer_read(_b,buffer_f64);
	stock=buffer_read(_b,buffer_s16);
	points=buffer_read(_b,buffer_s16);
	stamina=buffer_read(_b,buffer_s32);
	any_hitbox_has_hit=buffer_read(_b,buffer_bool);
	any_hitbox_has_been_blocked=buffer_read(_b,buffer_bool);
	can_hitfall=buffer_read(_b,buffer_bool);
	can_tech=buffer_read(_b,buffer_bool);
	combo_counter=buffer_read(_b,buffer_s16);
	combo_target=buffer_read(_b,buffer_f64);
	combo_break_timer=buffer_read(_b,buffer_s16);
	damage_attack_multiplier=buffer_read(_b,buffer_f64);
	damage_taken_multiplier=buffer_read(_b,buffer_f64);
	knockback_multiplier=buffer_read(_b,buffer_f64);

	my_hitboxes=buffer_read_array(_b,buffer_f64);
	hitbox_groups=buffer_read_array(_b);
	hurtbox_shield=buffer_read(_b,buffer_f64);

	anim_current=buffer_read_auto(_b);
	anim_sprite=buffer_read(_b,buffer_s32);
	anim_frame=buffer_read(_b,buffer_f64);
	anim_speed=buffer_read(_b,buffer_f64);
	anim_angle=buffer_read(_b,buffer_f64);
	anim_scale=buffer_read(_b,buffer_f64);
	anim_alpha=buffer_read(_b,buffer_f64);
	anim_offsetx=buffer_read(_b,buffer_s16);
	anim_offsety=buffer_read(_b,buffer_f64);
	anim_loop=buffer_read(_b,buffer_bool);
	anim_finish=buffer_read_auto(_b);
	renderer=buffer_read(_b,buffer_f64);
	invisible=buffer_read(_b,buffer_bool);
	fade_value=buffer_read(_b,buffer_f64);
	flash_color=buffer_read(_b,buffer_s32);
	flash_alpha=buffer_read(_b,buffer_f64);
	damage_text_random=buffer_read(_b,buffer_f64);

	state_log=buffer_read_array(_b,buffer_s8);

	attack_cooldowns=buffer_read_struct(_b,buffer_s16);
	attack_uses=buffer_read_struct(_b,buffer_s16);
	
	item_held=buffer_read(_b,buffer_f64);
	item_hold_x=buffer_read(_b,buffer_f64);
	item_hold_y=buffer_read(_b,buffer_f64);
	item_visible=buffer_read(_b,buffer_bool);
	item_throw_direction=buffer_read(_b,buffer_f64);

	custom_attack_struct=buffer_read_struct(_b);
	custom_passive_struct=buffer_read_struct(_b);
	custom_ids_struct=buffer_read_struct(_b);
	
	callback_passive=buffer_read_array(_b,buffer_s32);
	callback_hud=buffer_read_array(_b,buffer_s32);
	callback_overhead=buffer_read_array(_b,buffer_s32);
	callback_draw_begin=buffer_read_array(_b,buffer_s32);
	callback_draw_end=buffer_read_array(_b,buffer_s32);
	callback_hit=buffer_read_array(_b,buffer_s32);
	callback_hurt=buffer_read_array(_b,buffer_s32);

	palette_data=buffer_read_struct(_b);
	palette_base=buffer_read_array(_b,buffer_f64);
	palette_swap=buffer_read_array(_b,buffer_f64);
	
	portrait=buffer_read(_b,buffer_s32);
	render=buffer_read(_b,buffer_s32);
	stock_sprite=buffer_read(_b,buffer_s32);

	hurtbox=buffer_read(_b,buffer_f64);

	//Built-in variables
	x=buffer_read(_b,buffer_f32);
	y=buffer_read(_b,buffer_f32);
	xstart=buffer_read(_b,buffer_f32);
	ystart=buffer_read(_b,buffer_f32);
	mask_index=buffer_read(_b,buffer_s32);
	image_xscale=buffer_read(_b,buffer_f32);
	layer=buffer_read(_b,buffer_s32);

	//Sync ID
	sync_id=buffer_read(_b,buffer_u32);
	}
/* Copyright 2024 Springroll Games / Yosi */