function rad_dspec_hurtbox_hit()
	{
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	if (!instance_exists(_hitbox) || !instance_exists(_hurtbox)) then return;
	
	//Check restrictions
	if (!calculate_hit_restriction(_hitbox, _hurtbox)) then return;
	
	//If the hitbox owner isn't the player who owns the gaze, or on the same team
	var _player = _hurtbox.owner.player_id;
	if (_hitbox.owner == _player) then return;
	if (setting().match_team_mode && !setting().match_team_attack && _hitbox.owner.player_team == _player.player_team) then return;

	//Give the attacking player hitlag
	if (object_is(_hitbox.owner.object_index, obj_player))
		{
		_hitbox.owner.self_hitlag_frame = 6;
		}

	//Destroy the gaze, and damage the owner
	camera_shake(4);
	apply_damage(_player, 4);
	
	//VFX
	var _vfx = vfx_create(spr_hit_normal_medium, 1, 0, 12, x, y, 1, prng_number(0, 360), "VFX_Layer_Below");
	_vfx.vfx_yscale *= prng_choose(1, -1, 1);
	_vfx.vfx_blend = $66e0ff;
	var _vfx = vfx_create_color(spr_rad_dspec_gaze_death, 1, 0, 24, x, y, 2, 0, "VFX_Layer_Below");
	_vfx.owner = _hurtbox.owner.player_id; //Make sure the VFX has the correct palette!
	
	instance_destroy();
	return;
	}
/* Copyright 2024 Springroll Games / Yosi */