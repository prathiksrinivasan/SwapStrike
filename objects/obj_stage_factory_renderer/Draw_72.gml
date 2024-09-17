///@description
if (surface_exists(obj_stage_factory_filter.surf))
	{
	surface_set_target(obj_stage_factory_filter.surf);
	
	draw_self();
	
	surface_reset_target();
	}
/* Copyright 2024 Springroll Games / Yosi */