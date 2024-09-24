function __optimized_save_obj_hurtbox()
	{
	var _b = argument[0];
	buffer_write(_b,buffer_u32,sync_id);
	buffer_write(_b,buffer_s32,magnetbox_hit);
	buffer_write(_b,buffer_bool,inv_override);
	buffer_write(_b,buffer_s8,inv_type);
	buffer_write(_b,buffer_s32,targetbox_hit);
	buffer_write(_b,buffer_s32,windbox_hit);
	buffer_write(_b,buffer_s32,projectile_hit);
	buffer_write(_b,buffer_f64,owner);
	buffer_write(_b,buffer_s32,melee_hit);
	buffer_write(_b,buffer_s32,grab_hit);
	buffer_write(_b,buffer_f64,inv_frame);
	buffer_write(_b,buffer_s32,detectbox_hit);
	buffer_write(_b,buffer_s8,hurtbox_type);
	buffer_write(_b,buffer_bool,destroy);
	buffer_write(_b,buffer_f64,owner_xstart);
	buffer_write(_b,buffer_f64,owner_ystart);
	buffer_write(_b,buffer_s32,default_sprite);
	buffer_write(_b,buffer_bool,check_first);
	buffer_write(_b,buffer_f64,lifetime);
	buffer_write(_b,buffer_f32,x);
	buffer_write(_b,buffer_f32,y);
	buffer_write(_b,buffer_f32,xstart);
	buffer_write(_b,buffer_f32,ystart);
	buffer_write(_b,buffer_s32,sprite_index);
	buffer_write(_b,buffer_f64,image_index);
	buffer_write(_b,buffer_f64,image_xscale);
	buffer_write(_b,buffer_f64,image_yscale);
	buffer_write(_b,buffer_f64,image_angle);
	}
/* Copyright 2024 Springroll Games / Yosi */