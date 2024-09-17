///@description (Inherit at the end of the event)
var _s = custom_entity_struct;
var _ids = custom_ids_struct;
var _blow_up = false;
var _cannot_hit_owner = false;

//If the bomb hasn't blown up yet
if (_s.item_type != ITEM_TYPE.none)
	{
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
		//Movement
		hsp = approach(hsp, 0, 0.05);
		vsp = min(vsp + 0.3, 10);
		var _results = entity_move_simple(hsp, vsp, true);
		hsp = _results.hsp;
		vsp = _results.vsp;
	
		//Hitting blocks
		if (_results.destroy)
			{
			_blow_up = true;
			}
	
		_s.angle -= hsp;
		if (hsp == 0) then _s.angle -= 3;
	
		//Check collisions with hurtboxes
		var _list = temp_list_get();
		ds_list_clear(_list);
		var _num = instance_place_list(x, y, obj_hurtbox, _list, false);
		if (_num > 0)
			{
			for (var i = 0; i < _num; i++)
				{
				var _id = _list[| i];
				if (_id.owner == noone || _id.owner == owner) then continue;
				if (_id.inv_type == INV.invincible) then continue;
		
				_blow_up = true;
				_cannot_hit_owner = true;
				break;
				}
			}
		ds_list_clear(_list);
		}

	//Move
	item_move_with_holder();

	//VFX
	var _draw_smoke = true;
	var _player = custom_ids_struct.item_holder;
	if (_player != noone && instance_exists(_player))
		{
		//Held item visibility
		if (!_player.item_visible) then _draw_smoke = false;
		}
	
	if (_draw_smoke && _s.lifetime % 2 == 0)
		{
		var _angle = _s.angle + 90 - (20 * facing);
		var _vfx = vfx_create(spr_item_toon_link_dspec_bomb_smoke, 1, 4, 16, x + lengthdir_x(26, _angle), y + lengthdir_y(26, _angle), random_range(0.25, 0.35), irandom(360), "VFX_Layer_Below");
		_vfx.fade = true;
		_vfx.vsp = -1;
		}

	//Lifetime
	_s.lifetime -= 1;
	if (_s.lifetime <= 0)
		{
		_blow_up = true;
		}
	if (custom_entity_struct.lifetime < 120)
		{
		if ((obj_game.current_frame div 6) % 2 == 0)
			{
			image_blend = c_red;
			}
		else
			{
			image_blend = c_white;
			}
		}

	//Destroy when outside the room
	if (blastzones_check())
		{
		_blow_up = true;
		}

	//Blowing up
	if (_blow_up)
		{
		//Switch the item type so it can't be picked up
		_s.item_type = ITEM_TYPE.none;
	
		//Create a projectile hitbox
		var _hitbox = hitbox_create_projectile(0, 0, 1.75, 1.75, 8, 5, 0.8, 75, 5, SHAPE.circle, 0, 0, FLIPPER.from_hitbox_center_horizontal);
		_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
	
		//Whitelist the owner
		if (_cannot_hit_owner) then array_push(_hitbox.hitbox_group_array, owner);
	
		//Explosion Effects
		game_sound_play(snd_hit_strong2);
		camera_shake(3);
		repeat (20)
			{
			var _dir = irandom(360);
			var _len = sqrt(random(1)) * 40;
			var _vfx = vfx_create(spr_item_toon_link_dspec_bomb_smoke, 1, 0, 24, x + lengthdir_x(_len, _dir), y + lengthdir_y(_len, _dir), random_range(1, 1.5), irandom(360));
			_vfx.hsp = lengthdir_x(2, _dir);
			_vfx.vsp = lengthdir_x(2, _dir);
			_vfx.shrink = random_range(0.9, 1.0);
			_vfx.spin = random_range(5, 6);
			_vfx.vsp = -random(1);
			}
	
		//Timer
		_s.blow_up_frame = 10;
		}
	}

//Destroy
if (_s.item_type == ITEM_TYPE.none)
	{
	_s.blow_up_frame -= 1;
	if (_s.blow_up_frame <= 0)
		{
		instance_destroy();
		exit;
		}
	}

/* Copyright 2024 Springroll Games / Yosi */