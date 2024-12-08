// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function atk_base_bair(){
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
				anim_sprite = spr_air_back;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 15;
				landing_lag = 14;
				speed_set(0, -1, true, true);
				
				return;
				}
			//Startup
			case 0:
				{
				if(attack_frame == 10)
				{
					anim_frame = 1;
				}
				if(attack_frame == 5)
				{
					anim_frame = 2;
				}
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 5;
					}
				break;
				}
			//Active
			case 1:
				{
				if(attack_frame == 4){
					hitbox_create_melee(-90,-80,1.8,3,10,14,1,4,135,4,SHAPE.square,0);
				}
				if(attack_frame == 2){
					anim_frame = 4;
				}
				if (attack_frame == 0)
					{
					anim_frame = 5;
					hitbox_create_melee(-33,-65,2.4,1.5,10,14,1,3,200,3,SHAPE.square,0);
					attack_phase++;
					attack_frame = 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
				if(attack_frame == 12){
					anim_frame = 6;
				}
				
				if(attack_frame == 8){
					anim_frame = 7;
				}
				
				if(attack_frame == 4){
					anim_frame = 8;
				}
				//Autocancel
				if (attack_frame < 6)
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