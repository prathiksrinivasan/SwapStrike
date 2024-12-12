// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function grenade_down(){
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
					anim_sprite = spr_raise_1;
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
						var _proj = hitbox_create_projectile(30,-150,.5,.5,15,18,1,45,210,SHAPE.circle,5,20)
						_proj.hbounce = true;
						_proj.vbounce = true;
						_proj.bounce_multiplier = 0.9;
						_proj.grav = 0.6;
						_proj.overlay_sprite = proj_potion;
						_proj.overlay_speed = 0.2;
						_proj.overlay_scale = 0.5;
						
						attack_frame=32;
						attack_phase++;
					}
					break;
				}
			case 1:
				{
					if(attack_frame == 16) then anim_frame = 1;
					if(attack_frame == 8) then anim_frame = 0;
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