function ness_fspec_pk_fire()
	{
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer - count up
	attack_frame++;
	
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
		if (_phase == PHASE.start)
			{
			//Animation
			anim_sprite = spr_ness_fspec_pk_fire;
			anim_frame = 0;
			anim_speed = 0;
		
			attack_frame = 0;
			
			//Reverse B
			reverse_b();
			
			return;
			}
		else
			{
			//Animation
			if (attack_frame == 5) then anim_frame = 1;
			if (attack_frame == 12) then anim_frame = 2;
			if (attack_frame == 18) then anim_frame = 3;
			if (attack_frame == 25) then anim_frame = 4;
			if (attack_frame == 37) then anim_frame = 5;
			if (!on_ground())
				{
				anim_angle = -20 * facing;
				}
			else
				{
				anim_angle = 0;
				}
			
			//B reverse
			if (attack_frame == 6) then b_reverse();
			
			//Projectile
			if (attack_frame == 18)
				{
				var _proj = hitbox_create_projectile(32, 0, 0.5, 0.5, 6, 1, 0.0, 90, 19, SHAPE.square, 12, 0, FLIPPER.toward_hitbox_center);
				_proj.hit_vfx_style = HIT_VFX.normal_medium;
				_proj.hit_sfx = snd_hit_sizzle;
				_proj.techable = false;
				_proj.custom_hitstun = 7;
				_proj.destroy_on_blocks = true;
				_proj.destroy_on_hit = false;
				_proj.post_hit_script = ness_fspec_pk_fire_post_hit;
				if (!on_ground())
					{
					_proj.vsp = 6;
					hitbox_overlay_sprite_set(_proj, spr_ness_fspec_pk_fire_projectile, 0, 0, 2, -20 * facing, c_white, 1, facing);
					}
				else
					{
					hitbox_overlay_sprite_set(_proj, spr_ness_fspec_pk_fire_projectile, 0, 0, 2, 0, c_white, 1, facing);
					}
				
				//VFX
				var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * facing;
				
				//Cooldown
				attack_cooldown_set(50);
				}
			
			//End
			if (attack_frame == 55)
				{
				attack_stop();
				}
			}
		}
	
	//Movement
	if (on_ground())
		{
		move_grounded();
		}
	else
		{
		move();
		}
	}
/* Copyright 2024 Springroll Games / Yosi */