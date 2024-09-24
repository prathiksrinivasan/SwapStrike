function __optimized_load_obj_hurtbox()
	{
	var _b = argument[0];
	sync_id=buffer_read(_b,buffer_u32);
	magnetbox_hit=buffer_read(_b,buffer_s32);
	inv_override=buffer_read(_b,buffer_bool);
	inv_type=buffer_read(_b,buffer_s8);
	targetbox_hit=buffer_read(_b,buffer_s32);
	windbox_hit=buffer_read(_b,buffer_s32);
	projectile_hit=buffer_read(_b,buffer_s32);
	owner=buffer_read(_b,buffer_f64);
	melee_hit=buffer_read(_b,buffer_s32);
	grab_hit=buffer_read(_b,buffer_s32);
	inv_frame=buffer_read(_b,buffer_f64);
	detectbox_hit=buffer_read(_b,buffer_s32);
	hurtbox_type=buffer_read(_b,buffer_s8);
	destroy=buffer_read(_b,buffer_bool);
	owner_xstart=buffer_read(_b,buffer_f64);
	owner_ystart=buffer_read(_b,buffer_f64);
	default_sprite=buffer_read(_b,buffer_s32);
	check_first=buffer_read(_b,buffer_bool);
	lifetime=buffer_read(_b,buffer_f64);
	x=buffer_read(_b,buffer_f32);
	y=buffer_read(_b,buffer_f32);
	xstart=buffer_read(_b,buffer_f32);
	ystart=buffer_read(_b,buffer_f32);
	sprite_index=buffer_read(_b,buffer_s32);
	image_index=buffer_read(_b,buffer_f64);
	image_xscale=buffer_read(_b,buffer_f64);
	image_yscale=buffer_read(_b,buffer_f64);
	image_angle=buffer_read(_b,buffer_f64);
	}
/* Copyright 2024 Springroll Games / Yosi */