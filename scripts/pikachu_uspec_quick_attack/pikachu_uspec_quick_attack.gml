function pikachu_uspec_quick_attack()
	{
	//Up Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Main Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_pikachu_uspec_quick_attack;
				anim_speed = 0;
				anim_frame = 0;
				anim_angle = 90;
				
				custom_attack_struct.quick_attack_dir = 90;
				
				landing_lag = 15;
				speed_set(0, 0, false, false);
				attack_frame = 15;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (stick_tilted(Lstick))
					{
					custom_attack_struct.quick_attack_dir = stick_get_direction(Lstick);
					change_facing();
					anim_angle = (facing == 1) ? stick_get_direction(Lstick) : stick_get_direction(Lstick) - 180;
					}
				
				//First Dash
				if (attack_frame == 0)
					{
					anim_frame = 1;
					
					//Speed
					var _len = 55;
					var _dir = custom_attack_struct.quick_attack_dir;
					speed_set(lengthdir_x(_len, _dir), lengthdir_y(_len, _dir), false, false);
					
					//Hitbox
					var _hitbox = hitbox_create_melee(0, 0, 1.5, 0.3, 2, 3, 0.9, 5, 90, 4, SHAPE.rotation, 0, FLIPPER.sakurai);
					hitbox_sprite_angle_set(_hitbox, _dir, true);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.electric_weak];
					_hitbox.hit_sfx = snd_hit_weak1;
					
					attack_frame = 14;
					attack_phase++;
					}
				break;
				}
			//Inbetween
			case 1:
				{
				//Animation
				if (attack_frame == 13) then anim_frame = 2;
				if (attack_frame == 12) then anim_frame = 3;
				if (attack_frame == 11) then anim_frame = 4;
				if (attack_frame == 10) then anim_frame = 5;
				if (attack_frame == 9) then anim_frame = 6;
				if (attack_frame == 8) then anim_frame = 7;
				if (attack_frame == 7) then anim_frame = 8;
				if (attack_frame <= 6)
					{
					if (stick_tilted(Lstick))
						{
						change_facing();
						anim_angle = (facing == 1) ? stick_get_direction(Lstick) : stick_get_direction(Lstick) - 180;
						anim_frame = 0;
						}
					else if (anim_frame == 8)
						{
						anim_frame = 9;
						}
					}
				
				//Ledge Grab
				if (check_ledge_grab()) then return;
				
				//Speed
				var _len = 55;
				var _dir = custom_attack_struct.quick_attack_dir;
				speed_set(lengthdir_x(_len, _dir), lengthdir_y(_len, _dir), false, false);
				
				//Landing on the ground
				if (vsp > 0 && (on_solid() || on_plat()))
					{
					attack_stop(PLAYER_STATE.landing_lag);
					
					//It's possible that the player could go into parry stun, so double check that they are actually in landing lag
					if (state == PLAYER_STATE.landing_lag)
						{
						state_frame = landing_lag;
						}
					
					speed_set(hsp / 4, 0, false, false);
					
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					return;
					}
				
				if (attack_frame <= 10)
					{
					//Reset the speed
					speed_set(0, 0, false, false);
					}
				else
					{
					//Create VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x, y, 1, prng_number(0, 360));
					}
				
				//Second Dash
				if (attack_frame == 0)
					{
					//Make sure the second dash is in a different direction
					var _dir = stick_get_direction(Lstick);
					if (stick_tilted(Lstick) && abs(angle_difference(custom_attack_struct.quick_attack_dir, _dir)) >= 30)
						{
						anim_frame = 1;
						
						//Speed
						var _len = 55;
						custom_attack_struct.quick_attack_dir = _dir;
						speed_set(lengthdir_x(_len, _dir), lengthdir_y(_len, _dir), false, false);
						
						//Hitbox
						var _hitbox = hitbox_create_melee(0, 0, 1.5, 0.3, 2, 3, 0.9, 5, 90, 4, SHAPE.rotation, 1, FLIPPER.sakurai);
						hitbox_sprite_angle_set(_hitbox, _dir, true);
						_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.electric_weak];
						_hitbox.hit_sfx = snd_hit_weak0;
						
						attack_frame = 14;
						attack_phase++;
						}
					else
						{
						//No Second Dash
						attack_stop(PLAYER_STATE.helpless);
						run = false;
						break;
						}
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Speed
				if (attack_frame == 10)
					{
					speed_set(0, 0, false, false);
					}
				else if (attack_frame < 10)
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					aerial_drift();
					}
				else
					{
					var _len = 55;
					var _dir = custom_attack_struct.quick_attack_dir;
					speed_set(lengthdir_x(_len, _dir), lengthdir_y(_len, _dir), false, false);
					}
				
				//Landing on the ground
				if (vsp > 0 && (on_solid() || on_plat()))
					{
					attack_stop(PLAYER_STATE.landing_lag);
					
					//It's possible that the player could go into parry stun, so double check that they are actually in landing lag
					if (state == PLAYER_STATE.landing_lag)
						{
						state_frame = landing_lag;
						}
					
					speed_set(hsp / 4, 0, false, false);
					
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					return;
					}
				
				//Animation
				if (attack_frame == 13) then anim_frame = 2;
				if (attack_frame == 12) then anim_frame = 3;
				if (attack_frame == 11) then anim_frame = 4;
				if (attack_frame == 10) then anim_frame = 5;
				if (attack_frame == 8) then anim_frame = 6;
				if (attack_frame == 6) then anim_frame = 7;
				if (attack_frame == 4) then anim_frame = 8;
				if (attack_frame == 2) then anim_frame = 9;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					run = false;
					}
				break;
				}
			}
		}
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_pikachu_uspec_quick_attack_hurtbox);
		}
	
	//Movement
	move_hit_platforms();
	}
/* Copyright 2024 Springroll Games / Yosi */