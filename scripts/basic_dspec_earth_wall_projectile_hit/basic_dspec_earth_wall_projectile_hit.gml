function basic_dspec_earth_wall_projectile_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	//Don't register projectiles from the player who created the wall
	if (_hitbox.player_id == _hurtbox.owner.player_id) then return;
	
	//The earth wall is only ever a reflector, so it doesn't REALLY need to check the inv_type, but it's good practice
	switch (_hurtbox.inv_type)
		{
		default:
		case INV.reflector:
			//Don't register a hit
			//Check the projectile's damage
			if (_hitbox.damage <= reflector_damage_limit)
				{
				//Change owner to the entity's owner
				hitbox_owner_change(_hitbox, player_id);
				//Reflect
				_hitbox.hsp = -_hitbox.hsp * reflector_speed_multiplier;
				_hitbox.vsp = -_hitbox.vsp * reflector_speed_multiplier;
				_hitbox.damage = ceil(_hitbox.damage * reflector_damage_multiplier);
				_hitbox.lifetime += reflector_lifetime_extension;
				_hitbox.facing = -_hitbox.facing;
				_hurtbox.owner.lifetime = 0;
				//Effects
				hit_sfx_play(snd_parry);
				}
			break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */