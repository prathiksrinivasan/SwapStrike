function __optimized_save_obj_verlet_parent()
	{
	var _b = argument[0];
	if (object_is(object_index, obj_verlet_point))
		{
		buffer_write(_b,buffer_f64,x);
		buffer_write(_b,buffer_f64,y);
		buffer_write(_b,buffer_f64,xprev);
		buffer_write(_b,buffer_f64,yprev);
		buffer_write(_b,buffer_s8,group);
		buffer_write(_b,buffer_s32,mask_index);
		}
	else if (object_is(object_index, obj_verlet_stick))
		{
		buffer_write(_b,buffer_f64,x);
		buffer_write(_b,buffer_f64,y);
		buffer_write(_b,buffer_f64,length);
		buffer_write(_b,buffer_s32,point1);
		buffer_write(_b,buffer_s32,point2);
		buffer_write(_b,buffer_s8,group);
		buffer_write(_b,buffer_s32,image_blend);
		}
	else
		{
		crash("[game_state_save] ", object_get_name(object_index), " has not been set up for rollback");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */