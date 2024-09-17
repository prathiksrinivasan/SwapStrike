function ness_fspec_pk_fire_post_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	if (_hitbox.has_hit)
		{
		entity_create(_hitbox.x + _hitbox.hsp, _hitbox.y, obj_ness_fspec_pk_fire);
		instance_destroy(_hitbox);
		}
	else if (_hitbox.has_been_blocked)
		{
		instance_destroy(_hitbox);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */