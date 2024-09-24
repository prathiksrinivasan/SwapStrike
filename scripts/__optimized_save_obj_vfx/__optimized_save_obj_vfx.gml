function __optimized_save_obj_vfx()
	{
	var _b = argument[0];
	buffer_write(_b,buffer_u32,sync_id);
	buffer_write(_b,buffer_f64,lifetime);
	buffer_write(_b,buffer_bool,vfx_allow_fade);
	buffer_write(_b,buffer_f64,vsp);
	buffer_write(_b,buffer_s32,vfx_sprite);
	buffer_write(_b,buffer_f64,fade);
	buffer_write(_b,buffer_f64,vfx_frame);
	buffer_write(_b,buffer_f64,total_life);
	buffer_write(_b,buffer_f64,spin);
	buffer_write(_b,buffer_f64,owner);
	buffer_write(_b,buffer_s32,follow);
	buffer_write(_b,buffer_f64,follow_offset_x);
	buffer_write(_b,buffer_f64,follow_offset_y);
	buffer_write(_b,buffer_f64,hsp);
	buffer_write(_b,buffer_f64,vfx_xscale);
	buffer_write(_b,buffer_f64,vfx_yscale);
	buffer_write(_b,buffer_f64,vfx_speed);
	buffer_write(_b,buffer_f64,shrink);
	buffer_write(_b,buffer_f64,vfx_angle);
	buffer_write(_b,buffer_bool,important);
	buffer_write(_b,buffer_f32,x);
	buffer_write(_b,buffer_f32,y);
	buffer_write(_b,buffer_f64,vfx_alpha);
	buffer_write(_b,buffer_s32,vfx_blend);
	buffer_write(_b,buffer_s32,layer);
	buffer_write_struct(_b,custom_vfx_struct);
	}
/* Copyright 2024 Springroll Games / Yosi */