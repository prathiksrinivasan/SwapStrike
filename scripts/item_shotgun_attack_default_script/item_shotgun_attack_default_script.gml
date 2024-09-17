function item_shotgun_attack_default_script()
	{
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Speeds
	if (on_ground())
		{
		friction_gravity(slide_friction, grav, max_fall_speed);
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
				anim_set(my_sprites[$ "Idle"]);
				custom_attack_struct.item_shotgun_frame = 4;
				attack_frame = 5;
				item_visible = false;
				callback_add(callback_draw_end, item_shotgun_attack_default_draw_script);
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 1)
					{
					b_reverse();
					}
				
				if (attack_frame == 0)
					{
					custom_attack_struct.item_shotgun_frame = 1;
					
					attack_phase++;
					attack_frame = 1;
					
					speed_set(-3 * facing, 0, true, true);
					
					//Projectiles
					var _proj = hitbox_create_projectile_custom(obj_item_shotgun_projectile, 20, 0, 0.1, 0.1, 4, 7, 1, 45, 7, SHAPE.square, 22, 0);
					_proj.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.explosion];
					_proj.hit_sfx = snd_hit_strong0;
					_proj.overlay_frame = 0;
					_proj.destroy_on_hit = true;
					_proj.knockback_state = PLAYER_STATE.balloon;
					var _proj = hitbox_create_projectile_custom(obj_item_shotgun_projectile, 18, 3, 0.1, 0.1, 4, 7, 1, 45, 7, SHAPE.square, 20, 2);
					_proj.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.explosion];
					_proj.hit_sfx = snd_hit_strong0;
					_proj.overlay_frame = 1;
					_proj.destroy_on_hit = true;
					_proj.knockback_state = PLAYER_STATE.balloon;
					var _proj = hitbox_create_projectile_custom(obj_item_shotgun_projectile, 18, -3, 0.1, 0.1, 4, 7, 1, 45, 7, SHAPE.square, 20, -2);
					_proj.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.explosion];
					_proj.hit_sfx = snd_hit_strong0;
					_proj.overlay_frame = 2;
					_proj.destroy_on_hit = true;
					_proj.knockback_state = PLAYER_STATE.balloon;
					
					//Effects
					game_sound_play(snd_hit_explosion1);
					camera_shake(6, 6);
					var _vfx = vfx_create(spr_dust_run, 1, 0, 14, x + (-16 * facing), (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 14, x + (16 * facing), y - 4, 1, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 1 * facing;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 15)
					custom_attack_struct.item_shotgun_frame = 2;
				if (attack_frame == 10)
					custom_attack_struct.item_shotgun_frame = 3;
				if (attack_frame == 5)
					custom_attack_struct.item_shotgun_frame = 4;
				
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