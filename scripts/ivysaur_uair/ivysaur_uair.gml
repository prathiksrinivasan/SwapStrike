function ivysaur_uair()
	{
	//Up Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
	//Canceling
	if (run && cancel_ground_check())
		{
		//Camera shake while active
		if (_phase == 1)
			{
			camera_shake(0, 5);
			}
		run = false;
		}

	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_ivysaur_uair;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 3;
				speed_set(0, -1, true, true);
				attack_frame = 10;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 10;
					speed_set(0, 4, true, true);
					var _hitbox = hitbox_create_melee(2, -50, 0.5, 0.5, 10, 8, 1, 12, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong1;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					var _hitbox = hitbox_create_melee(2, -50, 1.5, 1.5, 9, 10, 0.4, 8, 90, 4, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak1;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					
					//Random chance to play a voiceline
					if (prng_number(0, 9) == 0)
						{
						//Choose a random voiceline
						game_sound_play(prng_choose(1, snd_hit_strong0, snd_hit_strong1, snd_hit_strong2));
						}
					game_sound_play(snd_hit_explosion3);
					vfx_create_color(spr_samus_fair_burst, 1, 0, 20, x, y - 50, 2, 0);
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 7)
					anim_frame = 3;
				if (attack_frame == 4)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 5;
			
					attack_phase++;
					attack_frame = attack_connected() ? 6 : 12;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
	}
/* Copyright 2024 Springroll Games / Yosi */