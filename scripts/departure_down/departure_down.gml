function departure_down()
	{
	//Down version of Departure. Spawns under player
	
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		aerial_drift();
		}
	
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_snake_dspec_c4;
				anim_frame = 0;
				anim_speed = 0;
			
				//Check if the spike exists already or not
				var _exists = false;
				with (obj_departure_down_spike)
					{
					if (owner == other.id)
						{
						_exists = true;
						break;
						}
					}
				if (_exists)
					{
					attack_phase = 2;
					attack_frame = 30;
					anim_frame = 5;
					game_sound_play(snd_snake_dspec_c4);
					}
				else
					{
					attack_frame = 10;
					}
					
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 15;
					show_debug_message("here")
					entity_create(x, y, obj_departure_down_spike, "Player_Front");
					
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;

				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Detonate
			case 2:
				{
				if (attack_frame == 30)
					anim_frame = 6;
				if (attack_frame == 26)
					anim_frame = 7;
				if (attack_frame == 20)
					anim_frame = 8;
				
				if (attack_frame == 15)
					{
					//Explode all the C4s you own
					with (obj_departure_down_spike)
						{
						var _s = custom_entity_struct;
						
						//If the C4 started to auto explode already, you can't explode it
						if (owner == other.id && _s.auto_explode_timer > (120 - 15))
							{
							_s.explosion_time = 10;
						
							//Sweetspot
							var _hitbox = hitbox_create_melee(0, 0, 2, 2, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
							_hitbox.hit_sfx = snd_hit_explosion3;
							_hitbox.hit_vfx_style = HIT_VFX.explosion;
							var _hitbox = hitbox_create_melee(0, -64, 1.5, 1.8, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
							_hitbox.hit_sfx = snd_hit_explosion3;
							_hitbox.hit_vfx_style = HIT_VFX.explosion;
							var _hitbox = hitbox_create_melee(0, -128, 1.25, 1.5, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
							_hitbox.hit_sfx = snd_hit_explosion3;
							_hitbox.hit_vfx_style = HIT_VFX.explosion;	
							var _hitbox = hitbox_create_melee(0, -164, 1, 1.25, 11, 7, 0.6, 11, 60, 10, SHAPE.circle, 0);
							_hitbox.hit_sfx = snd_hit_explosion3;
							_hitbox.hit_vfx_style = HIT_VFX.explosion;	
							//Weak hitbox
							//var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 3, 6, 0.5, 3, 90, 5, SHAPE.circle, 0);
							//_hitbox.hit_sfx = snd_hit_explosion3;
							//_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
							//_hitbox.custom_hitstun = 20;
						
							//Explosion VFX
							var _vfx = vfx_create(spr_snake_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
							_vfx.important = true;
							game_sound_play(snd_hit_explosion1);
							camera_shake(3);
							}
						}
					attack_cooldown_set(12);
					}
				
				if (attack_frame == 14)
					anim_frame = 9;
				if (attack_frame == 7)
					anim_frame = 10;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
	}
/* Copyright 2024 Springroll Games / Yosi */