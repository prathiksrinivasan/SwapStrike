function __optimized_load_obj_hitbox_windbox()
	{
	var _b = argument[0];
	sync_id=buffer_read(_b,buffer_u32);
	owner=buffer_read(_b,buffer_f64);
	player_id=buffer_read(_b,buffer_f64);
	extra_hitlag=buffer_read(_b,buffer_f64);
	knockback_scaling=buffer_read(_b,buffer_f64);
	facing=buffer_read(_b,buffer_s8);
	windbox_multihit=buffer_read(_b,buffer_bool);
	angle=buffer_read(_b,buffer_f64);
	overlay_alpha=buffer_read(_b,buffer_f64);
	drawing_angle=buffer_read(_b,buffer_f64);
	windbox_lift=buffer_read(_b,buffer_bool);
	has_hit=buffer_read(_b,buffer_bool);
	base_knockback=buffer_read(_b,buffer_f64);
	destroy=buffer_read(_b,buffer_bool);
	angle_flipper=buffer_read(_b,buffer_s8);
	overlay_color=buffer_read(_b,buffer_s32);
	overlay_sprite=buffer_read(_b,buffer_s32);
	hitbox_group=buffer_read(_b,buffer_s8);
	windbox_max_speed=buffer_read(_b,buffer_f64);
	overlay_angle=buffer_read(_b,buffer_f64);
	has_been_blocked=buffer_read(_b,buffer_bool);
	damage=buffer_read(_b,buffer_f64);
	overlay_speed=buffer_read(_b,buffer_f64);
	owner_ystart=buffer_read(_b,buffer_f64);
	windbox_push=buffer_read(_b,buffer_bool);
	shieldstun_scaling=buffer_read(_b,buffer_f64);
	di_angle=buffer_read(_b,buffer_f64);
	overlay_scale=buffer_read(_b,buffer_f64);
	overlay_frame=buffer_read(_b,buffer_f64);
	owner_xstart=buffer_read(_b,buffer_s16);
	windbox_accelerate=buffer_read(_b,buffer_bool);
	check_first=buffer_read(_b,buffer_bool);
	overlay_facing=buffer_read(_b,buffer_s8);
	lifetime=buffer_read(_b,buffer_f64);
	can_be_parried=buffer_read(_b,buffer_bool);
	x=buffer_read(_b,buffer_f32);
	y=buffer_read(_b,buffer_f32);
	xstart=buffer_read(_b,buffer_f32);
	ystart=buffer_read(_b,buffer_f32);
	sprite_index=buffer_read(_b,buffer_s32);
	image_index=buffer_read(_b,buffer_f64);
	image_xscale=buffer_read(_b,buffer_f64);
	image_yscale=buffer_read(_b,buffer_f64);
	image_angle=buffer_read(_b,buffer_f64);
	hit_vfx_style=buffer_read_auto(_b);
	hit_sfx=buffer_read_auto(_b);
	hit_restriction=buffer_read(_b,buffer_s8);
	pre_hit_script=buffer_read(_b,buffer_s32);
	post_hit_script=buffer_read(_b,buffer_s32);
	hurtbox_hit_list=buffer_read_list(_b,buffer_f64);
	}
/* Copyright 2024 Springroll Games / Yosi */