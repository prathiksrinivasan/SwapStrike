function blocky_dtilt()
	{
	//Down Tilt for Blocky
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_blocky_dtilt;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 6;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 4;
					
					game_sound_play(snd_swing0);
					
					//Ledge hitbox
					var _hitbox = hitbox_create_melee(42, 26, 1, 0.4, 5, 7, 0.4, 3, 75, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hitstun_scaling = 3;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
					
					//Normal hitbox
					var _hitbox = hitbox_create_melee(42, 16, 1, 0.4, 5, 7, 0.4, 3, 75, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hitstun_scaling = 6.5;
					_hitbox.can_lock = true;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 7 : 18;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.crouching);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */