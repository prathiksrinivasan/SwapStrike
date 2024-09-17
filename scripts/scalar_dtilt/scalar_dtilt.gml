function scalar_dtilt()
	{
	//Downward Tilt for Scalar
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
				anim_sprite = spr_scalar_dtilt;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				
				hurtbox_anim_match();
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 4;
					
					game_sound_play(snd_swing1);
					
					//Ledge hitbox
					var _hitbox = hitbox_create_melee(42, 30, 1, 0.4, 7, 10, 0.4, 7, 35, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong1;
					_hitbox.hitstun_scaling = 0.75;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
					
					//Normal hitbox
					var _hitbox = hitbox_create_melee(42, 20, 1, 0.4, 7, 10, 0.4, 7, 35, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong1;
					_hitbox.hitstun_scaling = 0.75;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 17;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 5;
				if (attack_frame == 10)
					anim_frame = 6;
					
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
		hurtbox_anim_match();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */