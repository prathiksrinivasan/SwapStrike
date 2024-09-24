function sonic_fspec_spin_dash()
	{
	//Forward Special
	/*
	- Charge up by holding the Special button
	- Roll and jump around while curled up in a ball
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Variables
	var _on_ground = on_ground();
	var _max_charge = 105;
	var _charge_threshold = 60;
	
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_sonic_fspec_spin_dash;
				anim_frame = 0;
				anim_speed = 0;
				
				//Stop all movement
				speed_set(0, 0, false, false);
				
				//Change collision box
				collision_box_change(spr_sonic_fspec_spin_dash_collision_box, "bottom");
				
				charge = 0;
				attack_frame = 15;
				
				//VFX
				callback_add(callback_draw_begin, sonic_fspec_spin_dash_draw_begin);
				callback_add(callback_draw_end, sonic_fspec_spin_dash_draw_end);
				var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * facing;
				
				return;
				}
			//Startup
			case 0:
				{
				//Speeds
				if (!_on_ground)
					{
					aerial_drift();
					}
				friction_gravity(0, 0.4, 10);
				
				if (attack_frame == 0)
					{
					//Charging
					if (input_held(INPUT.special) && charge < _max_charge)
						{
						charge++;
						if (_on_ground)
							{
							speed_set(-1 * facing, 0, false, true);
							//Jump while charging
							if (input_pressed(INPUT.jump))
								{
								speed_set(0, -10, true, false);
								vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
								}
							}
						
						//VFX
						if (charge % 15 == 0)
							{
							var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
							_vfx.vfx_xscale = 2 * facing;
							}
						}
					else
						{
						attack_frame = 120;
						attack_phase = 1;
						
						//Zoom forward
						if (charge >= _charge_threshold)
							{
							speed_set(16 * facing, 0, false, false);
							}
						else
							{
							speed_set(10 * facing, 0, false, false);
							}
						
						//Hitbox
						var _damage = (charge >= _charge_threshold ? 10 : 4);
						var _hitbox = hitbox_create_melee(0, 0, 0.5, 0.5, _damage, 10, 0.5, 6, 45, -1, SHAPE.circle, 0, FLIPPER.sakurai);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hit_sfx = snd_hit_strong0;
						_hitbox.hitstun_scaling = 0.5;
					
						//Effects
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						game_sound_play(snd_dash);
						}
					}
				break;
				}
			//Active
			case 1:
				{
				//Speeds
				friction_gravity(0, 0.4, 10);
				if (charge >= _charge_threshold)
					{
					speed_set(4 * facing, 0, true, true);
					hsp = clamp(hsp, -16, 16);
					}
				else
					{
					speed_set(2 * facing, 0, true, true);
					hsp = clamp(hsp, -10, 10);
					}
				
				if (_on_ground)
					{
					//VFX
					if (attack_frame % 6 == 0)
						{
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						}
					
					//Jump
					if (input_pressed(INPUT.jump))
						{
						hitbox_group_reset(0);
						speed_set(0, -12, true, false);
						attack_phase = 3;
						attack_frame = 20;
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						break;
						}
					//Turn around
					if (stick_tilted(Lstick) && sign(stick_get_value(Lstick, DIR.horizontal)) != facing)
						{
						hitbox_group_reset(0);
						facing *= -1;
						attack_phase = 4;
						break;
						}
					}
				else
					{
					//Wall jump cancel
					if (check_wall_jump()) then return;
					
					//Jump cancel
					if (cancel_jump_check()) then return;
					}
				
				//Trail VFX
				if (attack_frame % 3 == 0)
					{
					var _vfx = vfx_create_color(spr_sonic_fspec_spin_dash, 0, 1, 12, x, y, sprite_scale, 0, "VFX_Layer_Below");
					_vfx.fade = true;
					}
				
				//Ending
				if (attack_frame == 0)
					{
					//Slow down and destroy the hitbox
					speed_set(8 * facing, 0, false, true);
					hitbox_destroy_attached_all();
					
					attack_phase = 2;
					attack_frame = 30;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Speeds
				if (_on_ground)
					{
					friction_gravity(0.3, 0.4, 10);
					}
				else
					{
					friction_gravity(0.04, 0.4, 10);
					}
	
				//Animation
				anim_frame = 1;
				
				if (attack_frame == 0)
					{
					attack_stop();
					run = false;
					}
				break;
				}
			//Jump attack
			case 3:
				{
				//Speeds
				if (_on_ground)
					{
					attack_stop();
					run = false;
					break;
					}
				else
					{
					friction_gravity(0, 0.4, 10);
					}
				
				//Canceling into other aerial attacks
				if (allow_smash_attacks()) then return;
				if (allow_special_attacks()) then return;
				if (allow_aerial_attacks()) then return;
				
				//Trail VFX
				if (attack_frame % 3 == 0)
					{
					var _vfx = vfx_create_color(spr_sonic_fspec_spin_dash, 0, 1, 12, x, y, sprite_scale, 0, "VFX_Layer_Below");
					_vfx.fade = true;
					}
				
				//Ending
				if (attack_frame == 0)
					{
					attack_stop();
					run = false;
					}
				break;
				}
			//Turnaround
			case 4:
				{
				//Accelerate in the other direction
				speed_set(1 * facing, 0, true, true);
				
				//Trail VFX
				if (attack_frame % 4 == 0)
					{
					var _vfx = vfx_create_color(spr_sonic_fspec_spin_dash, 0, 1, 12, x, y, sprite_scale, 0, "VFX_Layer_Below");
					_vfx.fade = true;
					}
				
				//Go back to the rolling phase once you've turned around enough, but reduce the amount of time you can continue rolling for
				if (sign(hsp) == sign(facing) || sign(hsp) == 0)
					{
					attack_phase = 1;
					attack_frame = max(0, attack_frame - 30);
					}
				break;
				}
			}
		}
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
	
	//Movement
	move();
	}
/* Copyright 2024 Springroll Games / Yosi */