///@description

var _c = custom_entity_struct;
_c.lifetime -= 1;

//Multihit
if (_c.lifetime % 10 == 0)
	{
	var _hitbox = hitbox_create_melee(0, -16, 1.0, 1.0, 1, 1, 0.0, 1, 90, 3, SHAPE.square, 0, FLIPPER.toward_hitbox_center);
	_hitbox.asdi_multiplier = 2;
	_hitbox.techable = false;
	_hitbox.hit_restriction = HIT_RESTRICTION.not_combo;
	_hitbox.custom_hitstun = 6;
	hitbox_group_reset(0);
	hitbox_group_whitelist_id(owner, 0);
	}

//Expiring
if (_c.lifetime <= 0)
	{
	hitbox_destroy_attached_all();
	instance_destroy();
	exit;
	}

//VFX
if (_c.lifetime % 4 == 0)
	{
	var _vfx = vfx_create(spr_fx_fire, 1, 0, 10, x, y + 32, 2, 270 + prng_number(1, 10, -10));
	_vfx.vfx_yscale = prng_choose(1, -2, 2);
	}
/* Copyright 2024 Springroll Games / Yosi */