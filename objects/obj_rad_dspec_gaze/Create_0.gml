GAME_STATE_OBJECT

event_inherited();

custom_entity_struct.frame = 105;
custom_entity_struct.phase = 0;
custom_entity_struct.laser_x = x;
custom_entity_struct.laser_y = y;
image_xscale = 2;
image_yscale = 2;
image_speed = 0;

var _hurtbox = hurtbox_create_permanent(sprite_index);
with (_hurtbox)
	{
	hurtbox_setup
		(
		rad_dspec_hurtbox_hit,
		rad_dspec_hurtbox_hit,
		-1,
		rad_dspec_hurtbox_hit,
		-1,
		-1,
		rad_dspec_hurtbox_hit,
		);
	}
/* Copyright 2024 Springroll Games / Yosi */