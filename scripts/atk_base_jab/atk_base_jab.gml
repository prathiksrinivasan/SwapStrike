// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function atk_base_jab()
{
	//Jab for Scalar
	/*
	- Press the button multiple times to continue the combo
	- The first two hits can be canceled into tilts
	*/
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
				anim_sprite = spr_ground_jab;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 4;
				return;
				}
			//First Jab Startup
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 8;
					var _hitbox = hitbox_create_melee(104, -179, 2.25, 2.9, 3, 6, 1, 3, 170, 4, SHAPE.square, 0);
					}
				break;
				}
			//First Jab Active
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 3;
					
				//Cancel into tilts from first jab
				if (attack_connected() && stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
					
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 12;
					}
				break;
				}
			//First Jab Endlag
			case 2:
				{
			
				//Cancel into tilts from first jab
				if (stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
					
				//Continue to next jab
				if (input_pressed(INPUT.attack, 12)) || (attack_connected() && input_held(INPUT.attack))
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 6;
					}
				//Auto end
				else if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			//Second Jab Startup
			case 3:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 5;
					
				if (attack_frame == 0)
					{
					anim_frame = 6;
					attack_phase++;
					attack_frame = 10;
					var _hitbox = hitbox_create_melee(101, -109, 1.87, 4, 6, 12, 1, 5, 80, 4, SHAPE.square, 1);
					}
				break;
				}
			//Second Jab Active
			case 4:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 7;
					
				//Cancel into tilts from second jab
				if (attack_connected() && stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
				
			
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Second Jab Endlag
			case 5:
				{
				//Animation
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 10)
					anim_frame = 4;
					
				//Cancel into tilts from first jab
				if (stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
					
				if (input_pressed(INPUT.jump, 12))
					{
					run = false;
					break;
					}
					
				//Continue to next jab
				if (input_pressed(INPUT.attack, 12)) || (attack_connected() && input_held(INPUT.attack))
					{
					anim_frame = 8;
					attack_phase++;
					attack_frame = 12;
					}
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
				//third jab startup
			case 6:
				{
				if(attack_frame == 8)
					anim_frame = 9;
					
				if(attack_frame == 0)
				{
					anim_frame = 10;
					hitbox_create_melee(240,-180,3,3,14,16,1,10,25,4,SHAPE.circle,2)
					attack_phase++;
					attack_frame = 4;
					
				}
				break;
				}
				//third jab active
			case 7:
				{
				if(attack_frame == 0)
				{
					attack_phase++;
					anim_frame = 11;
					attack_frame = 30;
				}
				break;
				}
				//third jab endlag
			case 8:
				{
				if(attack_frame == 22)
					anim_frame = 12;
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
			
		}
	//Movement
	move_grounded();

	}