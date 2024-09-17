function diddy_dspec_banana()
	{
	//Down Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fox_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 20;
			
				reverse_b();
				return;
				}
			//Startu
			case 0:
				{
				if (on_ground()) then friction_gravity(ground_friction);
				else friction_gravity(air_friction, grav, max_fall_speed);
					
				if (attack_frame == 13) then b_reverse();
				if (attack_frame == 2) then anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 30;
				
					//Make sure a banana doesn't already exist
					var _already_exists = false;
					with (obj_item_diddy_dspec_banana)
						{
						if (custom_ids_struct.player_original == other.id)
							{
							_already_exists = true;
							break;
							}
						}
					
					if (!_already_exists)
						{
						//Pull out a banana
						var _item = item_create(x, y, obj_item_diddy_dspec_banana, id);
						_item.hsp = -4 * facing;
						_item.vsp = -10;
						_item.custom_ids_struct.player_original = id;
						}
					}
				break;
				}
			//Endlag
			case 1:
				{
				if (on_ground()) then friction_gravity(ground_friction);
				else friction_gravity(air_friction, grav, max_fall_speed);
				
				if (attack_frame == 27) then anim_frame = 3;
				if (attack_frame == 13) then anim_frame = 4;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	
	//Movement
	move_hit_platforms();
	}
/* Copyright 2024 Springroll Games / Yosi */