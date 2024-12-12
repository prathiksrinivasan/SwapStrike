function saw_post_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	if (_hitbox.has_hit)
		{
		entity_create(_hitbox.x + _hitbox.hsp, _hitbox.y, obj_sawblade);
		instance_destroy(_hitbox);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */