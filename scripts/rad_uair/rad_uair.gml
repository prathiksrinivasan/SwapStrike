function rad_uair()
	{
	//Up Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	allow_hitfall();
	fastfall_attack_try();
	aerial_drift();
	//Canceling
	if (run && cancel_ground_check()) then run = false;
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_rad_uair;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				attack_frame = 11;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 7)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 6;
					
					game_sound_play(snd_swing3);
					
					//Center hit
					var _hitbox = hitbox_create_melee(0, -26, 1.3, 0.7, 6, 8, 0.6, 10, 65, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_sfx = snd_hit_weak1;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					
					//Early spiking hitboxes
					var _hitbox = hitbox_create_melee(40, 0, 0.5, 0.8, 9, 6, 0.8, 14, 315, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_strong0;
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(40, 0, 0.5, 0.8, 9, 8, 0.8, 14, 290, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_strong1;
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.techable = false;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 3)
					{
					anim_frame = 3;
					
					//Late spiking hitboxes
					var _hitbox = hitbox_create_melee(40, 10, 0.5, 0.8, 6, 6, 0.6, 11, 315, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak1;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(40, 10, 0.5, 0.8, 6, 6, 0.6, 11, 290, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak0;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.techable = false;
					}

				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 15;
					landing_lag = 5;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 5;
				if (attack_frame == 8)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
					
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