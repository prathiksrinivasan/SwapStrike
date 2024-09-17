function toon_link_dspec_bomb()
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
				//Cancel the attack if the player already has an item
				if (item_held != noone)
					{
					attack_stop();
					return;
					}
				
				//Animation
				anim_sprite = spr_fox_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 17;
			
				reverse_b();
				return;
				}
			//Startup
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
					attack_frame = 17;
				
					//Pull out a bomb
					pick_up_item(item_create(x, y, obj_item_toon_link_dspec_bomb, id));
					}
				break;
				}
			//Endlag
			case 1:
				{
				if (on_ground()) then friction_gravity(ground_friction);
				else friction_gravity(air_friction, grav, max_fall_speed);
				
				if (attack_frame == 14) then anim_frame = 3;
				if (attack_frame == 9) then anim_frame = 4;
			
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