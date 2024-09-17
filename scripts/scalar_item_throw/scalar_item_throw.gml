function scalar_item_throw()
	{
	//Item Throw for Scalar
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Speeds
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		aerial_drift();
		}
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_scalar_item_throw;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 10;
				
				item_hold_x = -37;
				item_hold_y = 6;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 8)
					{
					anim_frame = 1;
					item_hold_x = -38;
					item_hold_y = 12;
					}
				if (attack_frame == 4)
					{
					anim_frame = 2;
					item_hold_x = -37;
					item_hold_y = -11;
					}
				if (attack_frame == 2)
					{
					anim_frame = 3;
					item_hold_x = -23;
					item_hold_y = -45;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 5;
					
					//Throw the item
					if (item_held != noone && instance_exists(item_held))
						{
						item_held.x = x + (30 * facing);
						item_held.y = y + (-45);
						throw_item();
						}
					}
				break;
				}
			//Finish
			case 1:
				{
				if (attack_frame == 3)
					anim_frame = 5;
				if (attack_frame == 1)
					anim_frame = 6;
			
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