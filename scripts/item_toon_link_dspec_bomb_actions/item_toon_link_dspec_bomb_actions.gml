function item_toon_link_dspec_bomb_actions()
	{
	var _action = argument[0];
	var _s = custom_entity_struct;
	var _ids = custom_ids_struct;
	var _player = _ids.item_holder;
	
	switch (_action)
		{
		case ITEM_ACTION.picked_up:
			//Snap to the holder's location
			var _player = _ids.item_holder;
			x = _player.x + (_player.item_hold_x * _player.facing);
			y = _player.y + (_player.item_hold_y);
			_s.angle = 0;
			
			//Change the owner, so the explosion hitbox knows who the new owner is
			owner = _ids.item_holder;
			player_id = _ids.item_holder;
			break;
		case ITEM_ACTION.thrown:
			//Set the speed
			var _dir = _player.item_throw_direction;
			if (_dir == 0)
				{
				hsp = 8;
				vsp = -4;
				}
			else if (_dir == 180)
				{
				hsp = -8;
				vsp = -4;
				}
			else if (_dir == 90)
				{
				hsp = 0;
				vsp = -12;
				}
			else if (_dir == 270)
				{
				hsp = 0;
				vsp = 10;
				}
			else if (_dir == -1)
				{
				//Drop
				hsp = 0;
				vsp = 1;
				}
			_s.angle = 0;
			break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */