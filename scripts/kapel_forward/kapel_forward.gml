function kapel_forward()
	{
	//Forward Version
	/*
	-Jumps forward a bit
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions / Cancels
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
				anim_sprite = spr_spin_nofx;
				anim_frame = 0;
				anim_speed = 0;

				attack_frame = 13;

				reverse_b();

				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Throw
			case 0:
				{

				if (attack_frame == 8)
					{
					b_reverse();
					}

				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 2)
					anim_frame = 3;

				if (attack_frame == 0)
					{
					anim_frame = 4;

					speed_set(8 * facing, -10, false, false);


					//game_sound_play(snd_punch0);

					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;

					//Melee hit
					var _hitbox = hitbox_create_melee(32, 0, 0.6, 0.6, 4, 0, 0, 8, 0, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.custom_hitstun = 15;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.can_lock = true;
					var _hitbox = hitbox_create_melee(32, 0, 0.6, 0.6, 4, 0, 0.5, 8, 50, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;

					if (!input_held(INPUT.shield))
						{
						//Create the projectile 1 frame later, so if the melee hit lands the projectile will spawn after the hitlag
						attack_phase++;
						attack_frame = 33;
						}
					else
						{
						//Shield cancel
						attack_phase = 2
						attack_frame = 15;
						}
					}
				break;
				}
			//Throw -> Finish
			case 1:
				{
				//Projectile
				if (attack_frame == 32)
					{
					var _proj = hitbox_create_projectile_custom(obj_kapel, 24, -8, 2, 2, 10, 12, 0.4, 65, 180, SHAPE.circle, 0, 0);
					_proj.destroy_on_blocks = true;
					_proj.destroy_on_hit = true;
					_proj.grav = 0;
					_proj.base_hitlag = 14;
					_proj.custom_hitstun = 30;
					_proj.hit_sfx =  snd_hit_strong1;
					_proj.hit_vfx_style =[HIT_VFX.explosion, HIT_VFX.slash_medium, HIT_VFX.electric];
					_proj.knockback_state =PLAYER_STATE.balloon;
					_proj.can_lock = false;


					//Cooldown
					attack_cooldown_set(50);
					}

				//Animation
				if (attack_frame == 31)
					anim_frame = 5;
				if (attack_frame == 25)
					anim_frame = 6;
				if (attack_frame == 20)
					anim_frame = 7;
				if (attack_frame == 14)
					anim_frame = 8;
				if (attack_frame == 7)
					anim_frame = 9;

				if (attack_frame == 0)
					{
					discard_special();
					attack_stop();
					}
				break;
				}
			//Shield Cancel -> Finish
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 6;
				if (attack_frame == 11)
					anim_frame = 7;
				if (attack_frame == 7)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;

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