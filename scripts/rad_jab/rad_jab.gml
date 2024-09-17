function rad_jab()
	{
	//Jab
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
				anim_sprite = spr_rad_jab;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 2;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
					attack_phase++;
					attack_frame = 2;
					game_sound_play(snd_swing0);
					var _hitbox = hitbox_create_melee(22, -6, 0.8, 0.8, 4, 9, 0.1, 5, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hitstun_scaling = 2;
					_hitbox.can_be_parried = false;
					_hitbox.shieldstun_scaling = 1.2;
					_hitbox.pre_hit_script = trip_pre_hit;
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
					attack_frame = attack_connected() ? 9 : 18;
					}
					
				//Special cancel
				if (attack_connected(true) && allow_special_attacks())
					{
					return;
					}
				}
			//Endlag
			case 2:
				{
				//Special cancel
				if (attack_connected(true) && allow_special_attacks())
					{
					return;
					}
				
				//Animation
				if (attack_frame == 13)
					anim_frame = 3;
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	}
/* Copyright 2024 Springroll Games / Yosi */