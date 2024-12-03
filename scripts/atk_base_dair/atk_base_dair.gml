// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function atk_base_dair(){
//Forward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
	
	//Canceling
	if (run && cancel_ground_check())
		{
		run = false;
		}
	
	//Properties
	var _tipper_damage = 13;
	var _normal_damage = 6;
	
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_air_down;
				anim_speed = 0;
				anim_frame = 1;
		
				attack_frame = 9;
				landing_lag = 14;
				speed_set(0, -1, true, true);
				
				return;
				}
			//Startup
			case 0:
				{
				if(attack_frame == 6)
				{
					anim_frame = 2;
				}
				if(attack_frame == 3)
				{
					anim_frame = 3;
				}
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 6;
					}
				break;
				}
			//Active
			case 1:
				{
				if(attack_frame == 5){
					h = hitbox_create_melee(9,-52,2.8,1.4,10,12,1,3,-135,5,SHAPE.square,0);
				}
				if (attack_frame == 0)
					{
					if(hitbox_connected(h,true)){
						hsp = 12*facing;
						vsp = -15;
					}
					anim_frame = 5;
					attack_phase++;
					attack_frame = 12;
					}
				break;
				}
			//Endlag
			case 2:
				{
				if(attack_frame == 6){
					anim_frame = 6;
				}
				//Autocancel
				if (attack_frame < 3)
					landing_lag = 4;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			}
		}
		
	//Movement
	move();
}