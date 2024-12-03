function atk_base_dtilt()
	{
	//Jab
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_ground_down;
				anim_speed = 0.25;
				anim_frame = 0;
		
				attack_frame = 8;
				return;
				}
			//Startup -> Active
			case 0:
				{
				
				if (attack_frame == 0)
					{
					
					attack_phase++;
					attack_frame = 8;
				
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 0)
					{
						
					attack_phase++;
					
					
					//Whiff lag
					attack_frame = 12;
					}
				break;
				}
			//Finish
			case 2:
				{
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	}
/* Copyright 2024 Springroll Games / Yosi */