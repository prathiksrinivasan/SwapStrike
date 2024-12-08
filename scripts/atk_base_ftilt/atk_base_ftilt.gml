// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function atk_base_ftilt(){
//ftitlt
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
				anim_sprite = spr_ground_forward;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 9;
				
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Cancel in the air
				if (cancel_air_check()) then return;
				if (attack_frame = 4){
					anim_frame = 1;
				}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 9;
					speed_set(14 * facing, 0, false, false);
					
					hitbox_create_melee(145, -160, 2.5, 2.1, 9, 12, 1, 4, 35, 6, SHAPE.square, 0);
					
					//VFX
					//var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					//_vfx.vfx_xscale = 2 * facing;
					}
				//Movement
				move_grounded();
				break;
				}
			//Active
			case 1:
				{
				//Cancel in the air
				if (cancel_air_check()) then return;
				
				if(attack_frame == 5){
					anim_frame = 3;
				}
				if (attack_frame == 0)
					{		
					anim_frame = 4;
					attack_phase++;
					//Whiff lag
					attack_frame = 20;
					}
				//Movement
				move_grounded();
				break;
				}
			//Grounded finish
			case 2:
				{
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.crouching);
					run = false;
					}
				//Movement
				move_grounded();
				break;
				}
			}
		}
}