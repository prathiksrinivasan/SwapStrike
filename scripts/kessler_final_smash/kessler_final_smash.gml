function kessler_final_smash()
	{
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
				anim_set(spr_kessler_final_smash, 0, 0.2);
				speed_set(0, 0, false, false);
				grabbed_id = noone;
				final_smash_startup_script();
				return;
				}
			//Grab / Miss
			case 0:
				{
				var _anim_frame = floor(anim_frame + anim_speed);
				var _first_frame = (_anim_frame != floor(anim_frame));
				
				//Grab hitboxes
				if (_anim_frame == 3 && _first_frame)
					{
					hitbox_create_detectbox(48, 5, 1.2, 0.2, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 4 && _first_frame)
					{
					hitbox_create_detectbox(157, 5, 2.2, 0.2, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 5 && _first_frame)
					{
					hitbox_create_detectbox(266, 0, 1.2, 0.3, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 6 && _first_frame)
					{
					hitbox_create_detectbox(338, 0, 1.0, 0.3, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 7 && _first_frame)
					{
					hitbox_create_detectbox(363, 0, 0.5, 0.3, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 8 && _first_frame)
					{
					hitbox_create_detectbox(372, -13, 0.7, 0.5, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 9 && _first_frame)
					{
					hitbox_create_detectbox(365, -19, 0.7, 0.5, 5, SHAPE.square, 0);
					}
				else if (_anim_frame == 10 && _first_frame)
					{
					hitbox_create_detectbox(362, 0, 0.9, 0.5, 5, SHAPE.square, 0);
					}
				
				//Move the grabbed opponent
				if (grabbed_id != noone && instance_exists(grabbed_id))
					{
					if (_anim_frame == 3)
						{
						grabbed_id.x = x + (76 * facing);
						grabbed_id.y = y + 5;
						}
					else if (_anim_frame == 4)
						{
						grabbed_id.x = x + (221 * facing);
						grabbed_id.y = y + 0;
						}
					else if (_anim_frame == 5)
						{
						grabbed_id.x = x + (295 * facing);
						grabbed_id.y = y + -5;
						}
					else if (_anim_frame == 6)
						{
						grabbed_id.x = x + (364 * facing);
						grabbed_id.y = y + -5;
						}
					else if (_anim_frame == 8)
						{
						grabbed_id.x = x + (374 * facing);
						grabbed_id.y = y + -13;
						}
					else if (_anim_frame == 9)
						{
						grabbed_id.x = x + (366 * facing);
						grabbed_id.y = y + -13;
						}
					else if (_anim_frame == 10)
						{
						grabbed_id.x = x + (376 * facing);
						grabbed_id.y = y + 0;
						}
					else if (_anim_frame == 11)
						{
						grabbed_id.x = x + (370 * facing);
						grabbed_id.y = y + 5;
						}
					else if (_anim_frame == 13)
						{
						grabbed_id.x = x + (365 * facing);
						grabbed_id.y = y + 0;
						}
					if (_anim_frame == 14)
						{
						grabbed_id.x = x + (347 * facing);
						grabbed_id.y = y + -47;
						}
					}
				
				//Change the animation if it hits or if it misses
				if (_anim_frame == 14)
					{
					if (attack_connected())
						{
						attack_phase = 1;
						}
					else
						{
						anim_frame = 45;
						}
					}
				
				//End the attack once it gets to this frame in the animation
				if (floor(anim_frame + anim_speed) >= 53)
					{
					attack_stop();
					}
				break;
				}
			//Grab detection
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
						//Grab the opponent
						command_grab(_target, 0, 0);
						with (_target)
							{
							player_move_to_back();
							}
						
						//Change target to face the player
						_target.facing = -facing;
						
						//Grab VFX
						var _dir = 65;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, _target.x, _target.y, 3, _dir, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, _target.x, _target.y, 3, _dir + 180, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						
						break;
					}
				return;
				}
			//On hit
			case 1:
				{
				var _anim_frame = floor(anim_frame + anim_speed);
				var _first_frame = (_anim_frame != floor(anim_frame));
				
				if (_anim_frame == 15)
					{
					grabbed_id.x = x + (345 * facing);
					grabbed_id.y = y + -57;
					}
				else if (_anim_frame == 16)
					{
					grabbed_id.x = x + (339 * facing);
					grabbed_id.y = y + -78;
					}
				else if (_anim_frame == 17)
					{
					grabbed_id.x = x + (347 * facing);
					grabbed_id.y = y + 10;
					}
				else if (_anim_frame == 19)
					{
					grabbed_id.x = x + (320 * facing);
					grabbed_id.y = y + 3;
					}
				else if (_anim_frame == 20)
					{
					grabbed_id.x = x + (300 * facing);
					grabbed_id.y = y + -27;
					}
				else if (_anim_frame == 21)
					{
					grabbed_id.x = x + (267 * facing);
					grabbed_id.y = y + -62;
					}
				else if (_anim_frame == 22)
					{
					grabbed_id.x = x + (235 * facing);
					grabbed_id.y = y + -88;
					}
				else if (_anim_frame == 23)
					{
					grabbed_id.x = x + (227 * facing);
					grabbed_id.y = y + -120;
					}
				else if (_anim_frame == 24)
					{
					grabbed_id.x = x + (222 * facing);
					grabbed_id.y = y + -134;
					}
				else if (_anim_frame == 25)
					{
					grabbed_id.x = x + (216 * facing);
					grabbed_id.y = y + -131;
					}
				else if (_anim_frame == 26)
					{
					grabbed_id.x = x + (217 * facing);
					grabbed_id.y = y + -136;
					}
				else if (_anim_frame == 27)
					{
					grabbed_id.x = x + (213 * facing);
					grabbed_id.y = y + -137;
					}
				else if (_anim_frame == 30)
					{
					grabbed_id.x = x + (217 * facing);
					grabbed_id.y = y + -133;
					}
				else if (_anim_frame == 31)
					{
					grabbed_id.x = x + (227 * facing);
					grabbed_id.y = y + -140;
					}
				else if (_anim_frame == 32)
					{
					grabbed_id.x = x + (224 * facing);
					grabbed_id.y = y + -136;
					}
				
				//Slam on the first frame of subimage 17
				if (_anim_frame == 17 && _first_frame)
					{
					self_hitlag_frame = 10;
					camera_shake(0, 15);
					apply_damage(grabbed_id, 20);
					game_sound_play(snd_hit_heavy1);
					var _vfx = vfx_create(spr_hit_normal_strong, 1, 0, 14, grabbed_id.x, grabbed_id.y, 1, 90);
					_vfx.vfx_blend = make_color_hsv(prng_number(0, 40, 25), 217, 255);
					var _vfx = vfx_create_color(spr_dust_impact, 1, 0, 22, x + (347 * facing), bbox_bottom, 2, 90, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -2, 2);
					var _vfx = vfx_create(spr_dust_land, 1, 0, 26, x + (347 * facing), bbox_bottom, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(1, -2, 2);
					}
				
				//Rip on the first frame of subimage 35
				if (_anim_frame == 35 && _first_frame)
					{
					obj_game.cam_auto = false;
					self_hitlag_frame = 60;
					background_clear_activate(61, c_red);
					vfx_create_action_lines(40, x + (224 * facing), y - 136, 0);
					with (grabbed_id)
						{
						knock_out();
						state_frame = 120;
						}
					}
				
				//End the attack once it gets to this frame in the animation
				if (floor(anim_frame + anim_speed) >= 45)
					{
					obj_game.cam_auto = true;
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