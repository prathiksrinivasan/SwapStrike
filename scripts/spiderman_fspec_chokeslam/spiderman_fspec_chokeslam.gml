function spiderman_fspec_chokeslam()
	{
	//Forward Special
	/*
	- Lunges forward and grabs enemies, then slams them into the ground
	- If there is no ground underneath, both players will fall to the blastzone
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Phases
	if (run)
		{
		switch (_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_spiderman_fspec_chokeslam;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 20;
				
				speed_set(0, 0, false, false);
				
				//Draw script
				callback_add(callback_draw_begin, spiderman_fspec_chokeslam_draw);
				
				//Variable
				custom_attack_struct.chokeslam_anchor_x = undefined;
				custom_attack_struct.chokeslam_anchor_y = undefined;
				
				//VFX
				vfx_create(spr_shine_attack, 1, 0, 8, x + (-16 * facing), y + 4, 1, prng_number(0, 360));				

				return;
				}
			//Startup
			case 0:
				{
				//Physics
				if (attack_frame < 7)
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				//Animation
				if (attack_frame == 13)
					anim_frame = 1;
				if (attack_frame == 7)
					{
					anim_frame = 2;
					speed_set(7 * facing, -6, false, false);
					}
				if (attack_frame == 3)
					anim_frame = 3;
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 8;
					hitbox_create_detectbox(18, -2, 0.8, 0.4, 8, SHAPE.square, 0);
					}
				
				//Movement
				move();
				
				break;
				}
			//Lunge
			case 1:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 5;
				
				//Grab ledges
				if (check_ledge_grab()) then return;
				
				if (attack_frame == 0)
					{
					anim_frame = 6;
					
					attack_phase++;
					attack_frame = 20;
					speed_set(6 * facing, 0, false, false);
					}
				
				//Movement
				move();
				
				break;
				}
			//Endlag
			case 2:
				{
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				//Animation
				if (attack_frame == 14)
					anim_frame = 7;
				//Animation
				if (attack_frame == 7)
					anim_frame = 8;
			
				//Grab ledges
				if (check_ledge_grab()) then return;
			
				if (attack_frame == 0)
					{
					if (on_ground())
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						attack_stop(PLAYER_STATE.helpless);
						}
					}
				
				//Movement
				move();
				
				break;
				}
			//Detection
			case PHASE.detection:
				{
				var _target = argument[1];
				var _hitbox = argument[2];
				var _hurtbox = argument[3];
				
				if (!object_is(_target.object_index, obj_player)) then return;
				
				switch (_hurtbox.inv_type)
					{
					case INV.invincible:
					case INV.deactivate:
					case INV.reflector:
						break;
					default:
					case INV.normal:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.shielding:
					case INV.powershielding:
					case INV.heavyarmor:
					case INV.superarmor:
						//Animation
						anim_frame = 9;
						
						attack_phase = 3;
						attack_frame = 40;
						
						//Grab the opponent
						command_grab(_target, 47, -16);
						with (_target)
							{
							player_move_to_front();
							}
						
						//Speed
						speed_set(5.5 * facing, -10, false, false);
						
						//Change target to face the player
						_target.facing = -facing;
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
						
						//Grab VFX
						var _dir = 65;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir + 180, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						
						break;
					}
				return;
				}
			//Attack
			case 3:
				{
				friction_gravity(air_friction, 0.4, 1);
				
				//Animation
				if (attack_frame == 38)
					anim_frame = 10;
				if (attack_frame == 35)
					anim_frame = 11;
				if (attack_frame == 32)
					{
					anim_frame = 12;
					
					//Choose the anchor point
					var _results = collision_line_point(x, y, x + 400 * facing, y + 200, obj_solid, false, true);
					if (_results.id != noone)
						{
						var _s = custom_attack_struct;
						_s.chokeslam_anchor_x = _results.x;
						_s.chokeslam_anchor_y = _results.y;
						}
					}
				if (attack_frame == 28)
					anim_frame = 13;
				if (attack_frame == 22)
					anim_frame = 14;
				if (attack_frame == 15)
					anim_frame = 15;
				if (attack_frame == 10)
					anim_frame = 16;
				if (attack_frame == 6)
					anim_frame = 17;
				if (attack_frame == 3)
					anim_frame = 18;
				
				//Movement
				move();
				
				//Move grabbed opponents, even if they would go through a block
				if (anim_frame == 9)
					{
					grabbed_id.x = x + (47 * facing);
					grabbed_id.y = y + -16;
					}
				if (anim_frame == 10)
					{
					grabbed_id.x = x + (32 * facing);
					grabbed_id.y = y + -11;
					}
				if (anim_frame == 11)
					{
					grabbed_id.x = x + (0 * facing);
					grabbed_id.y = y + -2;
					}
				if (anim_frame == 12)
					{
					grabbed_id.x = x + (-30 * facing);
					grabbed_id.y = y + -7;
					}
				if (anim_frame == 13)
					{
					grabbed_id.x = x + (-34 * facing);
					grabbed_id.y = y + -11;
					}
				if (anim_frame == 14)
					{
					grabbed_id.x = x + (-34 * facing);
					grabbed_id.y = y + -16;
					}
				if (anim_frame == 15)
					{
					grabbed_id.x = x + (-26 * facing);
					grabbed_id.y = y + -26;
					}
				if (anim_frame == 16)
					{
					grabbed_id.x = x + (-7 * facing);
					grabbed_id.y = y + -33;
					}
				if (anim_frame == 17)
					{
					grabbed_id.x = x + (6 * facing);
					grabbed_id.y = y + -22;
					}
				if (anim_frame == 18)
					{
					grabbed_id.x = x + (12 * facing);
					grabbed_id.y = y + 0;
					}
					
				if (attack_frame == 0)
					{
					attack_phase++;
					
					//Drop quickly if there is no anchor point
					var _s = custom_attack_struct;
					if (is_undefined(_s.chokeslam_anchor_x) || is_undefined(_s.chokeslam_anchor_y))
						{
						speed_set(0, 30, true, false);
						}
					}
				
				break;
				}
			//Falling phase
			case 4:
				{
				//Move towards the anchor point if necessary
				var _anchor = false;
				var _s = custom_attack_struct;
				if (!is_undefined(_s.chokeslam_anchor_x) && !is_undefined(_s.chokeslam_anchor_y))
					{
					if (sign(_s.chokeslam_anchor_x - x) == facing && y < _s.chokeslam_anchor_y)
						{
						_anchor = true;
						speed_set_towards_point_accel(_s.chokeslam_anchor_x, _s.chokeslam_anchor_y, 4, 30);
						}
					else
						{
						speed_set(0, 20, true, false);
						}
					}
				
				if (!_anchor)
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}

				//Movement
				move();

				//Move grabbed opponent
				if (anim_frame == 18)
					{
					grabbed_id.x = x + (12 * facing);
					grabbed_id.y = y + 0;
					}

				//Hitting the ground
				if (on_ground())
					{
					anim_frame = 19;
					
					attack_phase++;
					attack_frame = 20;
					
					//Hitbox can also damage nearby opponents
					var _hitbox = hitbox_create_melee(0, 15, 1.2, 0.4, 20, 6, 1.5, 20, 65, 2, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_finishing_blow;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines, HIT_VFX.explosion];
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					speed_set(0, 0, false, false);
					
					//VFX
					var _vfx = vfx_create_color(spr_dust_impact, 1, 0, 22, x, bbox_bottom, 2, 90);
					_vfx.vfx_yscale = prng_choose(0, -2, 2);
					var _vfx = vfx_create(spr_dust_land, 1, 0, 26, x, bbox_bottom, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(1, -2, 2);
					}
				else if (collision(x + 1, y, [FLAG.solid]))
					{
					//Hitting a wall on the right
					attack_phase++;
					attack_frame = 20;
					
					//Hitbox can also damage nearby opponents
					var _hitbox = hitbox_create_melee(15, 0, 1, 1, 20, 3, 1.1, 20, 135, 2, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_finishing_blow;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines, HIT_VFX.explosion];
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					speed_set(0, 0, false, false);
					
					//VFX
					var _vfx = vfx_create_color(spr_dust_impact, 1, 0, 22, bbox_right, y, 2, 180);
					_vfx.vfx_yscale = prng_choose(0, -2, 2);
					var _vfx = vfx_create(spr_dust_land, 1, 0, 26, bbox_right, y, 2, 90, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(1, -2, 2);
					}
				else if (collision(x - 1, y, [FLAG.solid]))
					{
					//Hitting a wall on the left
					attack_phase++;
					attack_frame = 20;
					
					//Hitbox can also damage nearby opponents
					var _hitbox = hitbox_create_melee(15, 0, 1, 1, 20, 3, 1.1, 20, 135, 2, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_finishing_blow;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines, HIT_VFX.explosion];
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					speed_set(0, 0, false, false);
					
					//VFX
					var _vfx = vfx_create_color(spr_dust_impact, 1, 0, 22, bbox_left, y, 2, 0);
					_vfx.vfx_yscale = prng_choose(0, -2, 2);
					var _vfx = vfx_create(spr_dust_land, 1, 0, 26, bbox_left, y, 2, 270, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(1, -2, 2);
					}
				break;
				}
			//Hitting the ground or a wall
			case 5:
				{
				if (attack_frame == 15)
					anim_frame = 20;
				if (attack_frame == 7)
					anim_frame = 21;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				
				//Movement
				move_grounded();
				
				break;
				}
			}
		}
	}

/* Copyright 2024 Springroll Games / Yosi */