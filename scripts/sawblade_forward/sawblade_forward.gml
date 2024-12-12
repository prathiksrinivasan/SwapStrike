// Script assets have changed for v2.3.0 see
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sawblade_forward(){
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
					anim_sprite = spr_spin_raise;
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
						var _proj = hitbox_create_projectile(30,-150,1.2,1.2,1,3,1,15,180,SHAPE.circle,8,-8,FLIPPER.toward_hitbox_center)
						_proj.overlay_sprite = spr_saw;
						_proj.overlay_speed = 0.2;
						_proj.hbounce = false;
						_proj.vbounce = false;
						_proj.grav = 0.2;
						_proj.bounce_multiplier = 0.7;
						_proj.post_hit_script = saw_post_hit;
						
						attack_frame=45;
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