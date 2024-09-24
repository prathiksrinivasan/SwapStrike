///@category Gameplay
///@param {buffer} buffer		The buffer to save the game state to
/*
Saves the current game state to a buffer.
This does not save external data (Player Data, Character Data, Custom Controls, etc.).

- Format:
	1. Object data
	2. Instance id map JSON
	3. <obj_game> and <obj_stage_manager> variables
	
- Buffer Write Types:
	Resource: s32
	Instance ID: f64
	Color: s32
	Enum: s8
	Facing: s8
	Builtin X and Y: f32
	Speeds: f64
	Position X and Y: s16
	String: string
	Undefined: buffer_custom_undefined
	Boolean: bool
	Frames: f64
		
	Everything else: f64
	
Please note: The macros <character_static_properties>, <character_static_states>, <character_static_attacks>, and <character_static_sprites> determine which variables are saved for players.
*/
function game_state_save()
	{
	//All actions are carried out from obj_game
	with (obj_game)
		{
		//Initialize variables
		var _b = argument[0];
		var _ids = ds_map_create();
		var _count = 0;
		
		buffer_reset(_b, false);

		#region Optimized Saving
		_count = game_state_save_object(obj_player, _b, _ids, _count, __optimized_save_obj_player);
		_count = game_state_save_object(obj_entity, _b, _ids, _count, __optimized_save_obj_entity);
		_count = game_state_save_object(obj_vfx, _b, _ids, _count, __optimized_save_obj_vfx);
		_count = game_state_save_object(obj_block_moving, _b, _ids, _count, __optimized_save_obj_block_moving);
		_count = game_state_save_object(obj_hitbox_detectbox, _b, _ids, _count, __optimized_save_obj_hitbox_detectbox);
		_count = game_state_save_object(obj_hitbox_magnetbox, _b, _ids, _count, __optimized_save_obj_hitbox_magnetbox);
		_count = game_state_save_object(obj_hitbox_melee, _b, _ids, _count, __optimized_save_obj_hitbox_melee);
		_count = game_state_save_object(obj_hitbox_grab, _b, _ids, _count, __optimized_save_obj_hitbox_grab);
		_count = game_state_save_object(obj_hitbox_windbox, _b, _ids, _count, __optimized_save_obj_hitbox_windbox);
		_count = game_state_save_object(obj_hitbox_targetbox, _b, _ids, _count, __optimized_save_obj_hitbox_targetbox);
		_count = game_state_save_object(obj_hitbox_projectile, _b, _ids, _count, __optimized_save_obj_hitbox_projectile);
		_count = game_state_save_object(obj_hurtbox, _b, _ids, _count, __optimized_save_obj_hurtbox);
		_count = game_state_save_object(obj_verlet_parent, _b, _ids, _count, __optimized_save_obj_verlet_parent);
		#endregion
		
		//End Flag
		buffer_write(_b, buffer_s16, noone);
	
		//Instance ID Struct
		var _json = json_encode(_ids);
		buffer_write(_b, buffer_string, _json);
	
		#region Save variables for obj_game
		buffer_write(_b, buffer_s8, state);
		buffer_write(_b, buffer_u32, current_frame);
		buffer_write(_b, buffer_u32, game_time);
		buffer_write_array(_b, prng_numbers, buffer_u64);
		buffer_write(_b, buffer_f64, cam_x_goal);
		buffer_write(_b, buffer_f64, cam_y_goal);
		buffer_write(_b, buffer_f64, cam_shake_h);
		buffer_write(_b, buffer_f64, cam_shake_v);
		buffer_write(_b, buffer_f64, cam_w_goal);
		buffer_write(_b, buffer_f64, cam_h_goal);
		buffer_write(_b, buffer_bool, cam_auto);
		buffer_write(_b, buffer_s16, countdown);
		buffer_write(_b, buffer_s16, game_end_frame);
		buffer_write(_b, buffer_f32, daynight_r);
		buffer_write(_b, buffer_f32, daynight_g);
		buffer_write(_b, buffer_f32, daynight_b);
		buffer_write(_b, buffer_f64, daynight_time);
		
		/*Do not save these camera variables, as they will make the camera stutter during rollbacks!
		buffer_write(_b, buffer_f64, cam_x);
		buffer_write(_b, buffer_f64, cam_y);
		buffer_write(_b, buffer_f64, cam_w);
		buffer_write(_b, buffer_f64, cam_h);
		//*/
		
		var _size = ds_list_size(player_depth_list);
		buffer_write(_b, buffer_u8, _size);
		for (var p = 0; p < _size; p++)
			{
			buffer_write(_b, buffer_s32, player_depth_list[| p]);
			}
		#endregion
		#region Save variables for obj_stage_manager
		with (obj_stage_manager)
			{
			buffer_write(_b, buffer_s16, background_clear_frame);
			buffer_write(_b, buffer_f64, background_clear_amount);
			buffer_write(_b, buffer_s32, background_clear_color);
			buffer_write(_b, buffer_s16, background_clear_direction);
			buffer_write(_b, buffer_f64, background_clear_fade_speed);
			buffer_write_array(_b, callback_stage_passive, buffer_s32);
			buffer_write_struct(_b, custom_stage_struct);
			buffer_write_struct(_b, custom_ids_struct);
			if (!setting().background_is_static)
				{
				buffer_write_array(_b, background);
				}
			buffer_write_array(_b, stage_tint, buffer_f64);
			}
		#endregion
		#region Save variables for obj_verlet_system
		with (obj_verlet_system)
			{
			buffer_write_array(_b, verlet_points, buffer_s32);
			buffer_write_array(_b, verlet_sticks, buffer_s32);
			}
		#endregion

		//Trim off extra bytes and return
		buffer_resize(_b, buffer_tell(_b));
		
		//Clean Up
		ds_map_destroy(_ids);
		_ids = noone;
		
		return _b;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */