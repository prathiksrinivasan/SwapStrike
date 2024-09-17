///@category Player Actions
///@param {id} [item]				A specific item instance to pick up
///@param {real} [extra_range]		Any extra range that the player has for picking up items
/*
Attemps to pick up any nearby item, and returns the id of the item if one is picked up.
If the player already has a held item, they can't pick up another one.
You can supply the instance id of a particular item, and the player will only try to pick up that item.
You can also use the "extra_range" argument to add or subtract from the pick up range.
Please note: You can only pick up items with an ITEM_TYPE of:
	- melee
	- projectile
	- throwing
*/
function pick_up_item()
	{
	//If you already have a held item
	if (item_held != noone && instance_exists(item_held)) then return noone;
	
	//If no item is specified to be picked up
	var _item = argument_count > 0 ? argument[0] : noone;
	var _extra_range = argument_count > 1 ? argument[1] : 0.0;
	if (_item == noone)
		{
		var _args = 
			{ 
			extra_range : _extra_range, 
			item : noone,
			player : id,
			};
		
		//Loop through all items in order, and see if any are close enough
		with_synced_object
			(
			obj_entity, 
			function(_args)
				{
				if (!object_is(object_index, obj_item_parent)) then return;
				
				var _s = custom_entity_struct;
				var _ids = custom_ids_struct;
				
				//Make sure the item isn't held by someone else
				if (_ids.item_holder != noone) then return;
				
				//Make sure the item has the correct type
				if (_s.item_type != ITEM_TYPE.melee &&
					_s.item_type != ITEM_TYPE.projectile &&
					_s.item_type != ITEM_TYPE.throwing)
					{
					return;
					}
				
				//Check if the item is in range
				var _range = _s.item_pickup_range + _args.extra_range;
				if (point_distance(_args.player.x, _args.player.y, x, y) < _range)
					{
					//Store the item's id, but don't pick up anything yet
					_args.item = id;
					}
				},
			_args,
			);
			
		//Pick up the last item that was able to be picked up, if any
		_item = _args.item;
		}
	//If an item was specified to be picked up
	else
		{
		with (_item)
			{
			if (!object_is(object_index, obj_item_parent)) then break;
				
			var _s = custom_entity_struct;
			var _ids = custom_ids_struct;
				
			//Make sure the item isn't held by someone else
			if (_ids.item_holder != noone) then break;
				
			//Make sure the item has the correct type
			if (_s.item_type != ITEM_TYPE.melee &&
				_s.item_type != ITEM_TYPE.projectile &&
				_s.item_type != ITEM_TYPE.throwing)
				{
				break;
				}
				
			//Check if the item is in range
			var _range = _s.item_pickup_range + _extra_range;
			if (point_distance(other.x, other.y, x, y) < _range)
				{
				//Store the item's id, but don't pick up anything yet
				_item = id;
				}
			}
		}
	
	//If an item could be picked up
	if (_item != noone)
		{
		item_held = _item;
		item_hold_x = item_hold_x_default;
		item_hold_y = item_hold_y_default;
		
		with (_item)
			{
			var _s = custom_entity_struct;
			var _ids = custom_ids_struct;
			_ids.item_holder = other.id;
			_s.item_thrown = false;
			player_id = other.player_id;
				
			//VFX
			var _vfx = vfx_create(spr_shine_item_grab, 1, 0, 14, x, y, 1, 41, "VFX_Layer_Below");
			_vfx.vfx_xscale *= prng_choose(0, -1, 1);
			_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				
			//Run the item script with the pick up action, if it exists
			if (_s.item_actions != -1 && script_exists(_s.item_actions))
				{
				script_execute(_s.item_actions, ITEM_ACTION.picked_up);
				}
			}
		return _item;
		}
		
	//No item was picked up
	return noone;
	}
/* Copyright 2024 Springroll Games / Yosi */