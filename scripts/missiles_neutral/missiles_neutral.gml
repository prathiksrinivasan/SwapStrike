// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function missiles_neutral(){
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	var _proj2;
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
						var _proj = hitbox_create_projectile_custom(obj_basic_fspec_missile_projectile, 30, -80, .5, .5, 10, 4, 0.3, 90, 300, SHAPE.rotation, 0, 0);
						_proj.destroy_on_blocks = true;
						_proj.overlay_scale = 0.5;
						
						
						attack_frame=32;
						attack_phase++;
					}
					break;
				}
			case 1:
				{
					if(attack_frame == 16){
						anim_frame = 1;
					}
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