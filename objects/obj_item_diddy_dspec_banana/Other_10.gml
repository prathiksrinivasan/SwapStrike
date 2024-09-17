///@description (Inherit at the end of the event)
var _s = custom_entity_struct;
var _ids = custom_ids_struct;

//Held items
if (_ids.item_holder != noone)
	{
	//Drop if the holder no longer exists, or if the holder swapped items
	if (!instance_exists(_ids.item_holder))
		{
		_ids.item_holder = noone;
		_s.item_thrown = true;
		}
	else if (_ids.item_holder.item_held != id)
		{
		_ids.item_holder = noone;
		_s.item_thrown = true;
		}
	else
		{
		//Change facing
		image_xscale = _ids.item_holder.facing * 2;
		facing = _ids.item_holder.facing;
		}
	}
//If the item is not being held
else
	{
	if (!on_ground())
		{
		//Movement
		hsp = approach(hsp, 0, 0.05);
		vsp = min(vsp + 0.35, 11);
		var _results = entity_move_simple(hsp, vsp, false, false);
		hsp = _results.hsp;
		vsp = _results.vsp;
		
		//Spin
		_s.angle -= hsp * 3;
		if (hsp == 0 && vsp != 0) then _s.angle -= 9;
		
		//Lifetime
		_s.lifetime -= 1;
		if (_s.lifetime <= 0)
			{
			//Poof VFX
			var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 1, 0, "VFX_Layer_Below");
			_vfx.vfx_xscale *= prng_choose(0, -1, 1);
			_vfx.vfx_yscale *= prng_choose(1, -1, 1);
	
			instance_destroy();
			exit;
			}

		//Destroy when outside the room
		if (blastzones_check())
			{
			instance_destroy();
			exit;
			}
		
		//Create the hitbox
		if (_ids.hitbox == noone || !instance_exists(_ids.hitbox))
			{
			any_hitbox_has_hit = false;
			any_hitbox_has_been_blocked = false;
			hitbox_group_reset(0);
			facing = owner.facing;
			var _hitbox = hitbox_create_melee(0, 0, 0.3, 0.3, 3, 4, 0.0, 3, 45, -1, SHAPE.circle, 0, FLIPPER.sakurai);
			_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
			_hitbox.hit_sfx = snd_hit_weak1;
			_hitbox.post_hit_script = item_diddy_dspec_banana_post_hit;
			_hitbox.hitlag_scaling = 0;
			_ids.hitbox = _hitbox;
			
			//Make sure the person who threw the banana doesn't get hit by it
			hitbox_group_whitelist_id(owner, 0);
			}
		}
	else
		{
		//Get rid of the hitbox
		with (_ids.hitbox) instance_destroy();
		
		_s.angle = 0;
		
		//Check collisions with hurtboxes
		var _list = temp_list_get();
		ds_list_clear(_list);
		var _num = instance_place_list(x, y, obj_hurtbox, _list, false);
	
		//Convert to an array so other code can use the <temp_list_get> without messing it up
		var _array = [];
		for (var i = 0; i < _num; i++)
			{
			array_push(_array, _list[| i]);
			}
		ds_list_clear(_list);
	
		//Loop over the array and trip the players
		for (var i = 0; i < _num; i++)
			{
			var _id = _array[@ i];
			if (_id.owner == noone || _id.owner == owner) then continue;
			if (_id.inv_type == INV.invincible ||
				_id.inv_type == INV.shielding ||
				_id.inv_type == INV.powershielding ||
				_id.inv_type == INV.parry_shield)
				{
				continue;
				}
			
			var _opponent = _id.owner;
			if (object_is(_opponent.object_index, obj_player))
				{
				//States that the opponent can be tripped from
				if (_opponent.state == PLAYER_STATE.attacking ||
					_opponent.state == PLAYER_STATE.crouching ||
					_opponent.state == PLAYER_STATE.dashing ||
					_opponent.state == PLAYER_STATE.flinch ||
					_opponent.state == PLAYER_STATE.grab_release ||
					_opponent.state == PLAYER_STATE.grabbing ||
					_opponent.state == PLAYER_STATE.idle ||
					_opponent.state == PLAYER_STATE.jumpsquat ||
					_opponent.state == PLAYER_STATE.landing_lag ||
					_opponent.state == PLAYER_STATE.magnetized ||
					_opponent.state == PLAYER_STATE.run_stop ||
					_opponent.state == PLAYER_STATE.run_turnaround ||
					_opponent.state == PLAYER_STATE.running ||
					_opponent.state == PLAYER_STATE.shield_release ||
					_opponent.state == PLAYER_STATE.walk_turnaround ||
					_opponent.state == PLAYER_STATE.walking ||
					_opponent.state == PLAYER_STATE.wavelanding)
					{
					with (_opponent)
						{
						if (on_ground())
							{
							state_set(PLAYER_STATE.knockdown);
							camera_shake(0, 4);
							
							//Destroy the banana
							_s.trips = 0;
							}
						}
					}
				}
			}
		}
	}

//Move
item_move_with_holder();

//Destroy if it tripped enough players already
if (_s.trips <= 0)
	{
	//Poof VFX
	var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 1, 0, "VFX_Layer_Below");
	_vfx.vfx_xscale *= prng_choose(0, -1, 1);
	_vfx.vfx_yscale *= prng_choose(1, -1, 1);
	
	instance_destroy();
	exit;
	}

/* Copyright 2024 Springroll Games / Yosi */