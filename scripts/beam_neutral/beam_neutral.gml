// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function beam_neutral(){
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		aerial_drift();
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
					//Animation
					anim_sprite = spr_beam;
					anim_frame = 0;
					anim_speed = 0;
		
					attack_frame = 36;
					return;
				}
			case 0:
				{
					if(attack_frame ==25) then anim_frame = 1;
					if(attack_frame ==14) then anim_frame = 2;
					if(attack_frame ==10) then anim_frame = 3;
					if(attack_frame == 6){
						anim_frame = 4
						hitbox_create_melee(380,-107,5,1.3,4,8,1,3,15,3,SHAPE.square,0);
					}
					if(attack_frame == 3){
						anim_frame = 5
						hitbox_create_melee(380,-107,7.1,1.3,4,8,1,3,15,3,SHAPE.square,1);
					}
					if(attack_frame == 0){
						anim_frame = 6
						hitbox_create_melee(380,-107,9.1,1.3,12,8,1,3,15,6,SHAPE.square,2);
						attack_frame=25;
						attack_phase++;
					}
					break;
				}
			case 1:
				{
					if(attack_frame == 15) then anim_frame = 7;
					if (attack_frame == 0)
					{
						discard_special();
						attack_stop();
					}
					break;
				}
			}
		}
	//Movement
	move();
}