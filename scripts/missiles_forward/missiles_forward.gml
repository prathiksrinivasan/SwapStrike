// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function missiles_forward(){
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
					anim_sprite = spr_raise_2;
					anim_frame = 0;
					anim_speed = 0;
		
					attack_frame = 16;
					return;
				}
			case 0:
				{
					if(attack_frame ==12) then anim_frame = 1;
					if(attack_frame == 8) then anim_frame = 2;
					if(attack_frame == 4) then anim_frame = 3;
					if(attack_frame == 0){
						anim_frame = 4
						var _proj = hitbox_create_projectile(30,-150,.5,.5,8,8,1,45,80,SHAPE.circle,12,-1.5)
						_proj.bounce_multiplier = 0.9;
						_proj.overlay_sprite = spr_arrow;
						_proj.follow_speed = true;
						_proj.overlay_scale = 0.5;
						
						var _proj2 = hitbox_create_projectile(30,-150,.5,.5,8,8,1,45,80,SHAPE.circle,12,.5)
						_proj2.bounce_multiplier = 0.9;
						_proj2.overlay_sprite = spr_arrow;
						_proj2.follow_speed = true;
						_proj2.overlay_scale = 0.5;
						
						attack_frame=12;
						attack_phase++;
					}
					break;
				}
			case 1:
				{
					if(attack_frame == 6) then anim_frame = 1;
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