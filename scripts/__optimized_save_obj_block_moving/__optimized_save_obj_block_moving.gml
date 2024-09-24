function __optimized_save_obj_block_moving()
	{
	var _b = argument[0];
	buffer_write(_b,buffer_u32,sync_id);
	buffer_write(_b,buffer_u16,collision_flags);
	buffer_write(_b,buffer_f64,next_point);
	buffer_write(_b,buffer_f64,start_x);
	buffer_write(_b,buffer_f64,start_y);
	buffer_write(_b,buffer_u32,time);
	buffer_write(_b,buffer_f32,x);
	buffer_write(_b,buffer_f32,y);
	buffer_write(_b,buffer_f64,hsp);
	buffer_write(_b,buffer_f64,vsp);
	buffer_write(_b,buffer_f64,hsp_frac);
	buffer_write(_b,buffer_f64,vsp_frac);
	buffer_write(_b,buffer_f64,hsp_moved);
	buffer_write(_b,buffer_f64,vsp_moved);
	buffer_write(_b,buffer_f64,image_xscale);
	buffer_write(_b,buffer_f64,image_yscale);
	buffer_write(_b,buffer_f64,image_angle);
	buffer_write(_b,buffer_s32,layer);
	buffer_write_struct(_b,custom_block_moving_struct);
	}
/* Copyright 2024 Springroll Games / Yosi */