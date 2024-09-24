function __optimized_load_obj_block_moving()
	{
	var _b = argument[0];
	sync_id=buffer_read(_b,buffer_u32);
	collision_flags=buffer_read(_b,buffer_u16);
	next_point=buffer_read(_b,buffer_f64);
	start_x=buffer_read(_b,buffer_f64);
	start_y=buffer_read(_b,buffer_f64);
	time=buffer_read(_b,buffer_u32);
	x=buffer_read(_b,buffer_f32);
	y=buffer_read(_b,buffer_f32);
	hsp=buffer_read(_b,buffer_f64);
	vsp=buffer_read(_b,buffer_f64);
	hsp_frac=buffer_read(_b,buffer_f64);
	vsp_frac=buffer_read(_b,buffer_f64);
	hsp_moved=buffer_read(_b,buffer_f64);
	vsp_moved=buffer_read(_b,buffer_f64);
	image_xscale=buffer_read(_b,buffer_f64);
	image_yscale=buffer_read(_b,buffer_f64);
	image_angle=buffer_read(_b,buffer_f64);
	layer=buffer_read(_b,buffer_s32);
	custom_block_moving_struct=buffer_read_struct(_b);
	}
/* Copyright 2024 Springroll Games / Yosi */