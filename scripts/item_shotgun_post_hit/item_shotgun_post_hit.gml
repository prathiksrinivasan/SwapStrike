function item_shotgun_post_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	var _item = _hitbox.owner;

	//Bounce off opponents
	with (_item)
		{
		if (any_hitbox_has_hit || any_hitbox_has_been_blocked)
			{
			hsp *= -0.2;
			vsp = -3;
			
			//Get rid of the hitbox
			with (_hitbox) instance_destroy();
			
			//Hitlag
			self_hitlag_frame = 6;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */