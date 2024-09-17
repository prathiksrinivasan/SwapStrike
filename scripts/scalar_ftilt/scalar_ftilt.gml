function scalar_ftilt()
	{
	//Forward Tilt for Scalar
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
				anim_sprite = spr_scalar_ftilt;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 9;
				
				hurtbox_anim_match();
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 6;
					
					game_sound_play(snd_punch1);
					
					//Strong & Weak hitboxes
					var _hitbox = hitbox_create_melee(62, -5, 1, 0.3, 11, 7, 1, 8, 40, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 12);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(13, 2, 0.57, 0.64, 10, 6, 0.8, 7, 45, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 0.5;
					
					//Armor hurtbox on the arm
					hurtbox_create(62, -5, 1.2, 0.45, 3, SHAPE.rotation, INV.superarmor, 12);
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 5;
				if (attack_frame == 6)
					anim_frame = 6;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
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