function __optimized_load_obj_vfx()
	{
	var _b = argument[0];
	sync_id=buffer_read(_b,buffer_u32);
	lifetime=buffer_read(_b,buffer_f64);
	vfx_allow_fade=buffer_read(_b,buffer_bool);
	vsp=buffer_read(_b,buffer_f64);
	vfx_sprite=buffer_read(_b,buffer_s32);
	fade=buffer_read(_b,buffer_f64);
	vfx_frame=buffer_read(_b,buffer_f64);
	total_life=buffer_read(_b,buffer_f64);
	spin=buffer_read(_b,buffer_f64);
	owner=buffer_read(_b,buffer_f64);
	follow=buffer_read(_b,buffer_s32);
	follow_offset_x=buffer_read(_b,buffer_f64);
	follow_offset_y=buffer_read(_b,buffer_f64);
	hsp=buffer_read(_b,buffer_f64);
	vfx_xscale=buffer_read(_b,buffer_f64);
	vfx_yscale=buffer_read(_b,buffer_f64);
	vfx_speed=buffer_read(_b,buffer_f64);
	shrink=buffer_read(_b,buffer_f64);
	vfx_angle=buffer_read(_b,buffer_f64);
	important=buffer_read(_b,buffer_bool);
	x=buffer_read(_b,buffer_f32);
	y=buffer_read(_b,buffer_f32);
	vfx_alpha=buffer_read(_b,buffer_f64);
	vfx_blend=buffer_read(_b,buffer_s32);
	layer=buffer_read(_b,buffer_s32);
	custom_vfx_struct=buffer_read_struct(_b);
	}
/* Copyright 2024 Springroll Games / Yosi */