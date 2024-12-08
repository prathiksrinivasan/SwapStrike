function atk_base_dtilt()
	{
	//Down Tilt
	/*
	- Press the attack button during the slide to do the jump kick
	*/
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
				anim_sprite = spr_ground_down2;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 7;
				
				game_sound_play(snd_hit_wind);
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Cancel in the air
				if (cancel_air_check()) then return;
				if (attack_frame = 6){
					anim_frame = 1;
				}
				if (attack_frame = 3){
					anim_frame = 2;
				}
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 18;
					speed_set(20 * facing, 0, false, false);
					
					hitbox_create_melee(110, -40, 2, 1, 7, 15, 1, 4, 75, 16, SHAPE.square, 0);
					
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
				
				if(attack_frame == 15){
					anim_frame = 4;
				}
				if(attack_frame == 12){
					anim_frame = 5;
					
				}	
				if(attack_frame < 12 and attack_frame > 4 and attack_connected())
				{
					attack_frame = 4;
				}
				
					
				if (attack_frame == 0)
					{				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 8 : 17;
					}
				//Movement
				move_grounded();
				break;
				}
			//Grounded finish
			case 2:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 2;
				if (attack_frame == 4)
					anim_frame = 1;
			
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
	
	//Hurtbox matching
	if (run)
		{
		hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */