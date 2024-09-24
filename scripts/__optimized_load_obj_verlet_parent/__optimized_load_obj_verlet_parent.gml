function __optimized_load_obj_verlet_parent()
	{
	var _b = argument[0];
	if (object_is(object_index, obj_verlet_point))
		{
		x=buffer_read(_b,buffer_f64);
		y=buffer_read(_b,buffer_f64);
		xprev=buffer_read(_b,buffer_f64);
		yprev=buffer_read(_b,buffer_f64);
		group=buffer_read(_b,buffer_s8);
		mask_index=buffer_read(_b,buffer_s32);
		}
	else if (object_is(object_index, obj_verlet_stick))
		{
		x=buffer_read(_b,buffer_f64);
		y=buffer_read(_b,buffer_f64);
		length=buffer_read(_b,buffer_f64);
		point1=buffer_read(_b,buffer_s32);
		point2=buffer_read(_b,buffer_s32);
		group=buffer_read(_b,buffer_s8);
		image_blend=buffer_read(_b,buffer_s32);
		}
	else
		{
		crash("[game_state_save] ", object_get_name(object_index), " has not been set up for rollback");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */