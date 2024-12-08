// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function atk_base_nair(){
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
				anim_sprite = spr_air_neutral;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				landing_lag = 14;
				speed_set(0, -1, true, true);
				
				return;
				}
			//Startup
			case 0:
				{
				if(attack_frame == 3){
					anim_frame = 1;
				}
				if (attack_frame == 0)
					{
					anim_speed = 0;
					attack_phase++;
					attack_frame = 25;
					anim_frame = 2;
					
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 24)
				{
					anim_frame = 3;
					hitbox_create_melee(115,-130,1.75,1.75,3,6,1,1,135,1,SHAPE.circle,0)
					hitbox_create_melee(-91,-140,1.75,1.75,3,6,1,1,45,1,SHAPE.circle,0)
				}
				if (attack_frame == 22)
				{
					anim_frame = 4;
				}
				if (attack_frame == 20)
				{
					anim_frame = 5;
				}
				if (attack_frame == 18)
				{
					anim_frame = 6;
					hitbox_create_melee(115,-130,1.75,1.75,3,6,1,1,135,1,SHAPE.circle,1)
					hitbox_create_melee(-91,-140,1.75,1.75,3,6,1,1,45,1,SHAPE.circle,1)
				}
				if (attack_frame == 16)
				{
					anim_frame = 7;
				}
				if (attack_frame == 14)
				{
					anim_frame = 2;
				}
				if (attack_frame == 12)
				{
					anim_frame = 3;
					hitbox_create_melee(115,-130,1.75,1.75,3,6,1,1,135,1,SHAPE.circle,2)
					hitbox_create_melee(-91,-140,1.75,1.75,3,6,1,1,45,1,SHAPE.circle,2)
				}
				if (attack_frame == 10)
				{
					anim_frame = 4;
				}
				if (attack_frame == 8)
				{
					anim_frame = 5;
				}
				if (attack_frame == 6)
				{
					anim_frame = 6;
					hitbox_create_melee(115,-130,1.75,1.75,4,10,1,1,30,4,SHAPE.circle,3)
					hitbox_create_melee(-91,-140,1.75,1.75,4,10,1,1,150,4,SHAPE.circle,3)
				}
				if (attack_frame == 4)
				{
					anim_frame = 7;
				}				
				if (attack_frame == 0)
					{
					anim_frame = 0;
					anim_speed = 0
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Endlag
			case 2:
				{
				
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