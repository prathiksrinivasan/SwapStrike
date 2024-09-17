function item_diddy_dspec_banana_post_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	var _item = _hitbox.owner;

	//Bounce off opponents
	with (_item)
		{
		if (any_hitbox_has_hit && !any_hitbox_has_been_blocked)
			{
			hsp *= -0.2;
			vsp *= -0.2;
			
			//Hitlag
			self_hitlag_frame = 3;
			
			//Trip the other player if they're grounded
			if (object_is(_hurtbox.owner.object_index, obj_player))
				{
				with (_hurtbox.owner)
					{
					state_set(PLAYER_STATE.knockdown);
					}
				}
			
			custom_entity_struct.trips -= 1;
			}
		else if (any_hitbox_has_been_blocked)
			{
			hsp *= -0.2;
			vsp *= -0.2;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */