///@description
GAME_STATE_OBJECT

event_inherited();

custom_entity_struct.timer = 0;
custom_entity_struct.phase = 0;
custom_entity_struct.mode = 0;
custom_entity_struct.count = 1;

image_speed = 0;

var _hurtbox = hurtbox_create_permanent(sprite_index);
with (_hurtbox)
	{
	image_xscale = 2 * other.facing;
	image_yscale = 2;
	hurtbox_setup
		(
		poly_fspec_hurtbox_hit,
		poly_fspec_hurtbox_hit,
		-1,
		poly_fspec_hurtbox_hit,
		-1,
		-1,
		poly_fspec_hurtbox_hit,
		);
	}
/* Copyright 2024 Springroll Games / Yosi */