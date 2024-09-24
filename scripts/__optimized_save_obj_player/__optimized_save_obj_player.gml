function __optimized_save_obj_player()
	{
	var _b = argument[0];
	//Don't save variables marked as "static"
	if (!character_static_attacks)
		{
		buffer_write_struct(_b,my_attacks);
		}
	if (!character_static_sprites)
		{
		buffer_write(_b,buffer_f64,sprite_scale);
		buffer_write_struct(_b,my_sprites);
		}
	if (!character_static_states)
		{
		buffer_write_array(_b,my_states,buffer_s32);
		}
	if (!character_static_properties)
		{
		buffer_write(_b,buffer_s32,collision_box);
		
		buffer_write(_b,buffer_s32,hurtbox_sprite);
		buffer_write(_b,buffer_s32,hurtbox_crouch_sprite);

		buffer_write(_b,buffer_f64,weight_multiplier);

		buffer_write(_b,buffer_f64,grav);
		buffer_write(_b,buffer_f64,hitstun_grav);

		buffer_write(_b,buffer_f64,max_fall_speed);
		buffer_write(_b,buffer_f64,fastfall_speed);

		buffer_write(_b,buffer_f64,jumpsquat_time);
		buffer_write(_b,buffer_f64,jump_speed);
		buffer_write(_b,buffer_f64,jump_horizontal_accel);
		buffer_write(_b,buffer_f64,shorthop_speed);
		buffer_write(_b,buffer_f64,double_jump_speed);
		buffer_write(_b,buffer_f64,double_jump_horizontal_accel);
		buffer_write(_b,buffer_u8,max_double_jumps);
		buffer_write(_b,buffer_f64,land_time);

		buffer_write(_b,buffer_f64,air_accel);
		buffer_write(_b,buffer_f64,max_air_speed);
		buffer_write(_b,buffer_f64,max_air_speed_dash);
		buffer_write(_b,buffer_f64,air_friction);

		buffer_write(_b,buffer_f64,ground_friction);
		buffer_write(_b,buffer_f64,crouch_friction);
		buffer_write(_b,buffer_f64,slide_friction);
		buffer_write(_b,buffer_f64,hard_landing_friction);
		buffer_write(_b,buffer_f64,jostle_strength);

		buffer_write(_b,buffer_f64,walk_speed);
		buffer_write(_b,buffer_f64,walk_accel);
		buffer_write(_b,buffer_f64,walk_turn_time);

		buffer_write(_b,buffer_f64,dash_speed);
		buffer_write(_b,buffer_f64,dash_time);
		buffer_write(_b,buffer_f64,dash_accel);

		buffer_write(_b,buffer_f64,run_speed);
		buffer_write(_b,buffer_f64,run_accel);
		buffer_write(_b,buffer_f64,run_turn_time);
		buffer_write(_b,buffer_f64,run_turn_accel);
		buffer_write(_b,buffer_f64,run_stop_time);

		buffer_write(_b,buffer_f64,ledge_jump_vsp);
		buffer_write(_b,buffer_f64,ledge_jump_hsp);
		buffer_write(_b,buffer_f64,ledge_jump_time);
		buffer_write(_b,buffer_f64,ledge_getup_time);
		buffer_write(_b,buffer_s16,ledge_getup_finish_x);
		buffer_write(_b,buffer_s16,ledge_getup_finish_y);
		buffer_write(_b,buffer_f64,ledge_roll_time);
		buffer_write(_b,buffer_f64,ledge_attack_time);
		buffer_write(_b,buffer_s16,ledge_hang_relative_x);
		buffer_write(_b,buffer_s16,ledge_hang_relative_y);

		buffer_write(_b,buffer_f64,airdodge_speed);
		buffer_write(_b,buffer_f64,airdodge_startup);
		buffer_write(_b,buffer_f64,airdodge_active);
		buffer_write(_b,buffer_f64,airdodge_endlag);
		buffer_write(_b,buffer_f64,waveland_speed_boost);
		buffer_write(_b,buffer_f64,waveland_time);
		buffer_write(_b,buffer_f64,waveland_friction);
		buffer_write(_b,buffer_f64,airdodge_land_time);
		buffer_write(_b,buffer_f64,airdodge_dir_windup_speed);
		buffer_write(_b,buffer_f64,airdodge_dir_speed_min);
		buffer_write(_b,buffer_f64,airdodge_dir_speed_max);
		buffer_write(_b,buffer_f64,airdodge_dir_active);
		buffer_write(_b,buffer_f64,airdodge_dir_endlag_min);
		buffer_write(_b,buffer_f64,airdodge_dir_endlag_max);
		buffer_write(_b,buffer_f64,airdodge_dir_grav);

		buffer_write(_b,buffer_f64,shield_max_hp);
		buffer_write(_b,buffer_f64,shield_depeletion_rate);
		buffer_write(_b,buffer_f64,shield_recover_rate);
		buffer_write(_b,buffer_f64,shield_break_launch);
		buffer_write(_b,buffer_f64,shield_break_reset_hp);
		buffer_write(_b,buffer_f64,shield_size_multiplier);
		buffer_write(_b,buffer_f64,shield_shift_amount);
		buffer_write(_b,buffer_f64,shield_release_time);
		buffer_write(_b,buffer_f64,spot_dodge_startup);
		buffer_write(_b,buffer_f64,spot_dodge_active);
		buffer_write(_b,buffer_f64,spot_dodge_endlag);
		buffer_write(_b,buffer_f64,parry_press_startup);
		buffer_write(_b,buffer_f64,parry_press_active);
		buffer_write(_b,buffer_f64,parry_press_endlag);
		buffer_write(_b,buffer_f64,parry_press_trigger_time);
		buffer_write(_b,buffer_s32,parry_press_script);
		buffer_write_auto(_b,parry_shield_sprite);

		buffer_write(_b,buffer_f64,wall_jump_startup);
		buffer_write(_b,buffer_f64,wall_jump_time);
		buffer_write(_b,buffer_f64,wall_jump_hsp);
		buffer_write(_b,buffer_f64,wall_jump_vsp);
		buffer_write(_b,buffer_u16,max_wall_jumps);
		buffer_write(_b,buffer_bool,can_wall_cling);
		buffer_write(_b,buffer_bool,can_wall_jump);

		buffer_write(_b,buffer_f64,roll_speed);
		buffer_write(_b,buffer_f64,roll_startup);
		buffer_write(_b,buffer_f64,roll_active);
		buffer_write(_b,buffer_f64,roll_endlag);
		
		buffer_write(_b,buffer_f64,getup_active);
		buffer_write(_b,buffer_f64,getup_endlag);

		buffer_write(_b,buffer_f64,tech_active);
		buffer_write(_b,buffer_f64,tech_endlag);
		buffer_write(_b,buffer_f64,techroll_speed);
		buffer_write(_b,buffer_f64,techroll_startup);
		buffer_write(_b,buffer_f64,techroll_active);
		buffer_write(_b,buffer_f64,techroll_endlag);

		buffer_write(_b,buffer_f64,helpless_accel);
		buffer_write(_b,buffer_f64,helpless_max_speed);
		
		buffer_write(_b,buffer_f64,item_hold_x_default);
		buffer_write(_b,buffer_f64,item_hold_y_default);

		buffer_write(_b,buffer_s32,draw_script);
		}
	
	//Player variables - must be saved no matter what!
	buffer_write(_b,buffer_s16,character);
	buffer_write(_b,buffer_s32,character_script);
	buffer_write(_b,buffer_string,character_name);

	buffer_write(_b,buffer_s8,state);
	buffer_write(_b,buffer_s32,state_script);
	buffer_write(_b,buffer_f64,state_frame);
	buffer_write(_b,buffer_f64,state_time);
	buffer_write(_b,buffer_s32,state_phase);
	buffer_write(_b,buffer_s8,state_facing);

	buffer_write(_b,buffer_u8,player_number);
	buffer_write(_b,buffer_s8,player_color);
	buffer_write(_b,buffer_s32,player_outline_color);
	buffer_write(_b,buffer_s32,player_profile);
	buffer_write(_b,buffer_string,player_name);
	buffer_write(_b,buffer_s8,player_team);

	buffer_write(_b,buffer_bool,jump_is_shorthop);
	buffer_write(_b,buffer_bool,jump_is_midair_jump);
	buffer_write(_b,buffer_bool,jump_is_dash_jump);
	buffer_write(_b,buffer_bool,dash_prevent_jump);
	buffer_write(_b,buffer_bool,can_fastfall);
	buffer_write(_b,buffer_s8,double_jumps);
	buffer_write(_b,buffer_bool,landed_on_ground);
	buffer_write(_b,buffer_f64,footstool_cooldown);
	buffer_write(_b,buffer_u8,airdodges_max);
	buffer_write(_b,buffer_u8,airdodges);
	buffer_write(_b,buffer_bool,airdodge_is_directional);
	buffer_write(_b,buffer_f64,airdodge_direction);
	buffer_write(_b,buffer_f64,shield_shift_x);
	buffer_write(_b,buffer_f64,shield_shift_y);
	buffer_write(_b,buffer_f64,shield_hp);
	buffer_write(_b,buffer_f64,shieldstun);
	buffer_write(_b,buffer_f64,parry_stun_time);
	buffer_write(_b,buffer_bool,has_been_parried);
	buffer_write(_b,buffer_f64,heavyarmor_amount);
	buffer_write(_b,buffer_f64,magnet_goal_x);
	buffer_write(_b,buffer_f64,magnet_goal_y);
	buffer_write(_b,buffer_f64,magnet_snap_speed);
	buffer_write(_b,buffer_f64,tech_buffer);
	buffer_write(_b,buffer_f64,ledge_id);
	buffer_write(_b,buffer_f64,ledge_grab_timeout);
	buffer_write(_b,buffer_f64,ledge_grab_counter);
	buffer_write(_b,buffer_f64,ledge_tether_point_id);
	buffer_write(_b,buffer_f64,wall_cling_timeout);
	buffer_write(_b,buffer_f64,wall_jump_timeout);
	buffer_write(_b,buffer_s8,wall_jumps);
	buffer_write(_b,buffer_f64,self_hitlag_frame);
	buffer_write(_b,buffer_s32,attack_script);
	buffer_write(_b,buffer_s32,attack_frame);
	buffer_write(_b,buffer_s16,attack_phase);
	buffer_write(_b,buffer_string,simple_attack_name);
	buffer_write(_b,buffer_f64,charge);
	buffer_write(_b,buffer_f64,landing_lag);
	buffer_write(_b,buffer_s8,final_smash_uses);
	buffer_write(_b,buffer_f64,grab_hold_x);
	buffer_write(_b,buffer_f64,grab_hold_y);
	buffer_write(_b,buffer_bool,grab_hold_enable);
	buffer_write(_b,buffer_f64,grab_hold_id);
	buffer_write(_b,buffer_f64,grabbed_id);
	buffer_write(_b,buffer_f64,grab_regrab_frame);
	buffer_write(_b,buffer_f64,grab_break_buffer);
	buffer_write(_b,buffer_bool,throw_stick_has_reset);
	buffer_write(_b,buffer_bool,ignore_blastzones);

	buffer_write(_b,buffer_bool,is_cpu);
	buffer_write(_b,buffer_s8,cpu_type);
	buffer_write(_b,buffer_u32,cpu_inputs_bitflag);
	buffer_write(_b,buffer_s8,device);
	buffer_write(_b,buffer_s8,device_type);
	buffer_write(_b,buffer_f64,double_tap_run_frame);
	buffer_write(_b,buffer_f64,double_tap_fastfall_frame);
	buffer_write_array(_b,custom_controls,buffer_s16);
	buffer_write_array(_b,control_states_l,buffer_f64);
	buffer_write_array(_b,control_states_r,buffer_f64);
	buffer_write(_b,buffer_u32,control_tilted_l);
	buffer_write(_b,buffer_u32,control_tilted_r);
	buffer_write(_b,buffer_u32,control_flicked_l);
	buffer_write(_b,buffer_u32,control_flicked_r);
	buffer_write(_b,buffer_s8,right_stick_input);
	buffer_write_array(_b,scs,buffer_bool);
	buffer_write_array(_b,acs);
	buffer_write_array(_b,input_buffer,buffer_s16);
	buffer_write(_b,buffer_u32,paused_inputs_flag);

	buffer_write(_b,buffer_f64,hsp);
	buffer_write(_b,buffer_f64,vsp);
	buffer_write(_b,buffer_f64,hsp_frac);
	buffer_write(_b,buffer_f64,vsp_frac);
	buffer_write(_b,buffer_f64,hsp_moved);
	buffer_write(_b,buffer_f64,vsp_moved);
	buffer_write(_b,buffer_s32,collision_flags);
	buffer_write(_b,buffer_s8,facing);
	
	buffer_write(_b,buffer_f64,damage);
	buffer_write(_b,buffer_f64,knockback_dir);
	buffer_write(_b,buffer_f64,knockback_spd);
	buffer_write(_b,buffer_f64,stored_hitstun);
	buffer_write(_b,buffer_s8,stored_state);
	buffer_write(_b,buffer_bool,is_reeling);
	buffer_write(_b,buffer_f64,asdi_multiplier);
	buffer_write(_b,buffer_f64,drift_di_multiplier);
	buffer_write(_b,buffer_f64,di_angle);
	buffer_write(_b,buffer_f64,ko_property);
	buffer_write(_b,buffer_f64,player_id);
	buffer_write(_b,buffer_s16,stock);
	buffer_write(_b,buffer_s16,points);
	buffer_write(_b,buffer_s32,stamina);
	buffer_write(_b,buffer_bool,any_hitbox_has_hit);
	buffer_write(_b,buffer_bool,any_hitbox_has_been_blocked);
	buffer_write(_b,buffer_bool,can_hitfall);
	buffer_write(_b,buffer_bool,can_tech);
	buffer_write(_b,buffer_s16,combo_counter);
	buffer_write(_b,buffer_f64,combo_target);
	buffer_write(_b,buffer_s16,combo_break_timer);
	buffer_write(_b,buffer_f64,damage_attack_multiplier);
	buffer_write(_b,buffer_f64,damage_taken_multiplier);
	buffer_write(_b,buffer_f64,knockback_multiplier);

	buffer_write_array(_b,my_hitboxes,buffer_f64);
	buffer_write_array(_b,hitbox_groups);
	buffer_write(_b,buffer_f64,hurtbox_shield);

	buffer_write_auto(_b,anim_current);
	buffer_write(_b,buffer_s32,anim_sprite);
	buffer_write(_b,buffer_f64,anim_frame);
	buffer_write(_b,buffer_f64,anim_speed);
	buffer_write(_b,buffer_f64,anim_angle);
	buffer_write(_b,buffer_f64,anim_scale);
	buffer_write(_b,buffer_f64,anim_alpha);
	buffer_write(_b,buffer_s16,anim_offsetx);
	buffer_write(_b,buffer_f64,anim_offsety);
	buffer_write(_b,buffer_bool,anim_loop);
	buffer_write_auto(_b,anim_finish);
	buffer_write(_b,buffer_f64,renderer);
	buffer_write(_b,buffer_bool,invisible);
	buffer_write(_b,buffer_f64,fade_value);
	buffer_write(_b,buffer_s32,flash_color);
	buffer_write(_b,buffer_f64,flash_alpha);
	buffer_write(_b,buffer_f64,damage_text_random);

	buffer_write_array(_b,state_log,buffer_s8);

	buffer_write_struct(_b,attack_cooldowns,buffer_s16);
	buffer_write_struct(_b,attack_uses,buffer_s16);
	
	buffer_write(_b,buffer_f64,item_held);
	buffer_write(_b,buffer_f64,item_hold_x);
	buffer_write(_b,buffer_f64,item_hold_y);
	buffer_write(_b,buffer_bool,item_visible);
	buffer_write(_b,buffer_f64,item_throw_direction);

	buffer_write_struct(_b,custom_attack_struct);
	buffer_write_struct(_b,custom_passive_struct);
	buffer_write_struct(_b,custom_ids_struct);
	
	buffer_write_array(_b,callback_passive,buffer_s32);
	buffer_write_array(_b,callback_hud,buffer_s32);
	buffer_write_array(_b,callback_overhead,buffer_s32);
	buffer_write_array(_b,callback_draw_begin,buffer_s32);
	buffer_write_array(_b,callback_draw_end,buffer_s32);
	buffer_write_array(_b,callback_hit,buffer_s32);
	buffer_write_array(_b,callback_hurt,buffer_s32);

	buffer_write_struct(_b,palette_data);
	buffer_write_array(_b,palette_base,buffer_f64);
	buffer_write_array(_b,palette_swap,buffer_f64);
	
	buffer_write(_b,buffer_s32,portrait);
	buffer_write(_b,buffer_s32,render);
	buffer_write(_b,buffer_s32,stock_sprite);

	buffer_write(_b,buffer_f64,hurtbox);

	//Built-in variables
	buffer_write(_b,buffer_f32,x);
	buffer_write(_b,buffer_f32,y);
	buffer_write(_b,buffer_f32,xstart);
	buffer_write(_b,buffer_f32,ystart);
	buffer_write(_b,buffer_s32,mask_index);
	buffer_write(_b,buffer_f32,image_xscale);
	buffer_write(_b,buffer_s32,layer);

	//Sync ID
	buffer_write(_b,buffer_u32,sync_id);
	}
/* Copyright 2024 Springroll Games / Yosi */