function __optimized_save_obj_entity()
	{
	var _b = argument[0];
	buffer_write(_b,buffer_u32,sync_id);
	buffer_write(_b,buffer_bool,any_hitbox_has_hit);
	buffer_write(_b,buffer_s8,facing);
	buffer_write(_b,buffer_s8,player_color);
	buffer_write(_b,buffer_s8,player_team);
	buffer_write(_b,buffer_f64,owner);
	buffer_write(_b,buffer_f64,player_id);
	buffer_write(_b,buffer_s32,collision_flags);
	buffer_write(_b,buffer_bool,any_hitbox_has_been_blocked);
	buffer_write(_b,buffer_f64,self_hitlag_frame);
	buffer_write(_b,buffer_s32,state);
	buffer_write_array(_b,palette_base,buffer_f64);
	buffer_write_array(_b,palette_swap,buffer_f64);
	buffer_write(_b,buffer_f64,fade_value);
	buffer_write(_b,buffer_f64,hsp);
	buffer_write(_b,buffer_f64,vsp);
	buffer_write(_b,buffer_f64,hsp_frac);
	buffer_write(_b,buffer_f64,vsp_frac);
	buffer_write(_b,buffer_f64,hsp_moved);
	buffer_write(_b,buffer_f64,vsp_moved);
	buffer_write(_b,buffer_f64,damage_attack_multiplier);
	buffer_write(_b,buffer_f64,knockback_multiplier);
	buffer_write(_b,buffer_f32,x);
	buffer_write(_b,buffer_f32,y);
	buffer_write(_b,buffer_f32,xstart);
	buffer_write(_b,buffer_f32,ystart);
	buffer_write(_b,buffer_s32,mask_index);
	buffer_write(_b,buffer_s32,sprite_index);
	buffer_write(_b,buffer_f64,image_index);
	buffer_write(_b,buffer_f64,image_speed);
	buffer_write(_b,buffer_f64,image_xscale);
	buffer_write(_b,buffer_f64,image_yscale);
	buffer_write(_b,buffer_f64,image_angle);
	buffer_write(_b,buffer_s32,image_blend);
	buffer_write(_b,buffer_f64,image_alpha);
	buffer_write(_b,buffer_s32,layer);
	buffer_write_struct(_b,palette_data);
	buffer_write_array(_b,hitbox_groups);
	buffer_write_struct(_b,custom_entity_struct);
	buffer_write_struct(_b,custom_ids_struct,buffer_f64);
	buffer_write_array(_b,my_hitboxes,buffer_s32);
	}
/* Copyright 2024 Springroll Games / Yosi */