///@category Gameplay
///@param {buffer} buffer		The buffer to load the game state from
/*
Loads the game state from a buffer.
This involves destroying and recreating all game objects.
Warning: Any instance id references that are not properly stored in the buffer and set in this function will break!

- Buffer Write Types:
	Asset / Instance ID: s32
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
	Sync IDs: u32
		
	Everything else: f64
*/
function game_state_load()
	{
	//All actions are carried out from obj_game
	with (obj_game)
		{
		//Change the loading variable
		is_loading = true;
	
		//Initialize variables
		var _b = argument[0];
		var _ids = undefined;
		var _new_ids = ds_map_create();
		
		#region Optimized Loading
		//Destroy all objects in the game state
		instance_destroy(obj_player);
		instance_destroy(obj_entity);
		instance_destroy(obj_vfx);
		instance_destroy(obj_block_moving);
		instance_destroy(obj_hitbox);
		instance_destroy(obj_hurtbox);
		instance_destroy(obj_verlet_parent);
	
		//Recreate all objects
		game_state_load_objects_spawn(_b, _new_ids);
		
		//Re-initialize all variables
		var _custom_load_scripts = {};
		_custom_load_scripts[$ obj_player			] = __optimized_load_obj_player;
		_custom_load_scripts[$ obj_entity			] = __optimized_load_obj_entity;
		_custom_load_scripts[$ obj_vfx				] = __optimized_load_obj_vfx;
		_custom_load_scripts[$ obj_block_moving		] = __optimized_load_obj_block_moving;
		_custom_load_scripts[$ obj_hitbox_detectbox	] = __optimized_load_obj_hitbox_detectbox;
		_custom_load_scripts[$ obj_hitbox_grab		] = __optimized_load_obj_hitbox_grab;
		_custom_load_scripts[$ obj_hitbox_magnetbox	] = __optimized_load_obj_hitbox_magnetbox;
		_custom_load_scripts[$ obj_hitbox_melee		] = __optimized_load_obj_hitbox_melee;
		_custom_load_scripts[$ obj_hitbox_projectile] = __optimized_load_obj_hitbox_projectile;
		_custom_load_scripts[$ obj_hitbox_targetbox	] = __optimized_load_obj_hitbox_targetbox;
		_custom_load_scripts[$ obj_hitbox_windbox	] = __optimized_load_obj_hitbox_windbox;
		_custom_load_scripts[$ obj_hurtbox			] = __optimized_load_obj_hurtbox;
		_custom_load_scripts[$ obj_verlet_parent	] = __optimized_load_obj_verlet_parent;
		var _struct_keys = variable_struct_get_names(_custom_load_scripts);
		game_state_load_objects_init(_b, _new_ids, _custom_load_scripts, _struct_keys);
		#endregion
		
		//Skip the JSON struct
		_ids = json_decode(buffer_read(_b, buffer_string));
		
		#region Load variables for obj_game
		state = buffer_read(_b, buffer_s8);
		current_frame = buffer_read(_b, buffer_u32);
		game_time = buffer_read(_b, buffer_u32);
		prng_numbers = buffer_read_array(_b, buffer_u64);
		cam_x_goal = buffer_read(_b, buffer_f64);
		cam_y_goal = buffer_read(_b, buffer_f64);
		cam_shake_h = buffer_read(_b, buffer_f64);
		cam_shake_v = buffer_read(_b, buffer_f64);
		cam_w_goal = buffer_read(_b, buffer_f64);
		cam_h_goal = buffer_read(_b, buffer_f64);
		cam_auto = buffer_read(_b, buffer_bool);
		countdown = buffer_read(_b, buffer_s16);
		game_end_frame = buffer_read(_b, buffer_s16);
		daynight_r = buffer_read(_b, buffer_f32);
		daynight_g = buffer_read(_b, buffer_f32);
		daynight_b = buffer_read(_b, buffer_f32);
		daynight_time = buffer_read(_b, buffer_f64);
		
		/*Camera variables are not saved, as they will make the camera stutter during rollbacks!
		cam_x = buffer_read(_b, buffer_f64);
		cam_y = buffer_read(_b, buffer_f64);
		cam_w = buffer_read(_b, buffer_f64);
		cam_h = buffer_read(_b, buffer_f64);
		//*/
		
		var _size = buffer_read(_b, buffer_u8);
		for (var p = 0; p < _size; p++)
			{
			player_depth_list[| p] = buffer_read(_b, buffer_s32);
			}
		#endregion
		#region Load variables for obj_stage_manager
		with (obj_stage_manager)
			{
			background_clear_frame = buffer_read(_b, buffer_s16);
			background_clear_amount = buffer_read(_b, buffer_f64);
			background_clear_color = buffer_read(_b, buffer_s32);
			background_clear_direction = buffer_read(_b, buffer_s16);
			background_clear_fade_speed = buffer_read(_b, buffer_f64);
			callback_stage_passive = buffer_read_array(_b, buffer_s32);
			custom_stage_struct = buffer_read_struct(_b);
			custom_ids_struct = buffer_read_struct(_b);
			if (!setting().background_is_static)
				{
				background = buffer_read_array(_b);
				}
			stage_tint = buffer_read_array(_b, buffer_f64);
			
			//Correct IDs
			for (var i = 0, _names = variable_struct_get_names(custom_ids_struct); i < array_length(_names); i++)
				{
				//Handle 1 layer of nested arrays
				var _data = custom_ids_struct[$ _names[@ i]];
				if (is_array(_data))
					{
					var _length = array_length(_data);
					for (var m = 0; m < _length; m++)
						{
						_data[@ m] = game_state_find_new_id(_ids, _new_ids, _data[@ m]);
						}
					}
				else
					{
					custom_ids_struct[$ _names[@ i]] = game_state_find_new_id(_ids, _new_ids, _data);
					}
				}
			}
		#endregion
		#region Load variables for obj_verlet_system
		with (obj_verlet_system)
			{
			verlet_points = buffer_read_array(_b, buffer_s32);
			verlet_sticks = buffer_read_array(_b, buffer_s32);
			}
		#endregion
		
		#region Instance ID Correction
		//Correct all variables storing IDs of objects that were recreated / Init extra variables
		with (obj_player)
			{
			sync_id_register();
			
			//Static values
			//If any values are set as "static" with the character macros, then they will NOT be saved/loaded
			//This means the character script needs to be run to set the values when the game is loaded
			var _any_static = false;
			if (character_static_states)
				{
				_any_static = true;
				my_states = [];
				}
			if (character_static_attacks)
				{
				_any_static = true;
				my_attacks = {};
				}
			if (character_static_sprites)
				{
				_any_static = true;
				my_sprites = {};
				}
			if (character_static_properties) 
				{
				_any_static = true;
				}
			if (_any_static)
				{
				//Run the character init script, but only set up necessary variables!
				script_execute
					(
					character_script, 
					character_static_properties, 
					character_static_states, 
					character_static_attacks, 
					character_static_sprites
					);
				}
			
			//Correct IDs
			ledge_tether_point_id = game_state_find_new_id(_ids, _new_ids, ledge_tether_point_id);
			grab_hold_id = game_state_find_new_id(_ids, _new_ids, grab_hold_id);
			grabbed_id = game_state_find_new_id(_ids, _new_ids, grabbed_id);
			ko_property = game_state_find_new_id(_ids, _new_ids, ko_property);
			player_id = game_state_find_new_id(_ids, _new_ids, player_id);
			combo_target = game_state_find_new_id(_ids, _new_ids, combo_target);
			hurtbox = game_state_find_new_id(_ids, _new_ids, hurtbox);
			hurtbox_shield = game_state_find_new_id(_ids, _new_ids, hurtbox_shield);
			item_held = game_state_find_new_id(_ids, _new_ids, item_held);
			
			for (var i = 0; i < array_length(my_hitboxes); i++)
				{
				my_hitboxes[@ i] = game_state_find_new_id(_ids, _new_ids, my_hitboxes[@ i]);
				}
			for (var i = 0; i < array_length(hitbox_groups); i++)
				{
				for (var m = 0; m < array_length(hitbox_groups[@ i]); m++)
					{
					hitbox_groups[@ i][@ m] = game_state_find_new_id(_ids, _new_ids, hitbox_groups[@ i][@ m]);
					}
				}
			for (var i = 0, _names = variable_struct_get_names(custom_ids_struct); i < array_length(_names); i++)
				{
				//Handle 1 layer of nested arrays
				var _data = custom_ids_struct[$ _names[@ i]];
				if (is_array(_data))
					{
					var _length = array_length(_data);
					for (var m = 0; m < _length; m++)
						{
						_data[@ m] = game_state_find_new_id(_ids, _new_ids, _data[@ m]);
						}
					}
				else
					{
					custom_ids_struct[$ _names[@ i]] = game_state_find_new_id(_ids, _new_ids, _data);
					}
				}
			for (var i = 0; i < array_length(callback_passive); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_passive[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_passive[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_hud); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_hud[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_hud[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_overhead); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_overhead[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_overhead[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_draw_begin); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_draw_begin[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_draw_begin[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_draw_end); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_draw_end[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_draw_end[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_hit); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_hit[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_hit[@ i + CALLBACK_SCRIPT.target]);
				}
			for (var i = 0; i < array_length(callback_hurt); i += CALLBACK_SCRIPT.LENGTH)
				{
				callback_hurt[@ i + CALLBACK_SCRIPT.target] = game_state_find_new_id(_ids, _new_ids, callback_hurt[@ i + CALLBACK_SCRIPT.target]);
				}
				
			//Remake the HUD player list for obj_game
			obj_game.ordered_player_list[| player_number] = id;
			}
		
		with (obj_vfx)
			{
			sync_id_register();
			
			//Correct IDs
			follow = game_state_find_new_id(_ids, _new_ids, follow);
			owner = game_state_find_new_id(_ids, _new_ids, owner);
			}
			
		with (obj_block_moving)
			{
			sync_id_register();
			
			//Correct IDs
			next_point = game_state_find_new_id(_ids, _new_ids, next_point);
			}
			
		with (obj_entity)
			{
			sync_id_register();
			
			//Correct IDs
			owner = game_state_find_new_id(_ids, _new_ids, owner);
			player_id = game_state_find_new_id(_ids, _new_ids, player_id);
			for (var i = 0; i < array_length(my_hitboxes); i++)
				{
				my_hitboxes[@ i] = game_state_find_new_id(_ids, _new_ids, my_hitboxes[@ i]);
				}
			for (var i = 0; i < array_length(hitbox_groups); i++)
				{
				for (var m = 0; m < array_length(hitbox_groups[@ i]); m++)
					{
					hitbox_groups[@ i][@ m] = game_state_find_new_id(_ids, _new_ids, hitbox_groups[@ i][@ m]);
					}
				}
			for (var i = 0, _names = variable_struct_get_names(custom_ids_struct); i < array_length(_names); i++)
				{
				variable_struct_set(custom_ids_struct, _names[i], game_state_find_new_id(_ids, _new_ids, variable_struct_get(custom_ids_struct, _names[i])));
				}
			}
		
		with (obj_hitbox)
			{
			sync_id_register();
			
			//Correct IDs
			owner = game_state_find_new_id(_ids, _new_ids, owner);
			player_id = game_state_find_new_id(_ids, _new_ids, player_id);
			
			//Targetboxes
			if (object_index == obj_hitbox_targetbox)
				{
				target = game_state_find_new_id(_ids, _new_ids, target);
				}
			//Projectiles
			else if (object_is(object_index, obj_hitbox_projectile))
				{
				for (var i = 0; i < array_length(hitbox_group_array); i++)
					{
					hitbox_group_array[@ i] = game_state_find_new_id(_ids, _new_ids, hitbox_group_array[@ i]);
					}
				}
			}
		
		with (obj_hurtbox)
			{
			sync_id_register();
			
			//Correct IDs
			owner = game_state_find_new_id(_ids, _new_ids, owner);
			}
			
		with (obj_verlet_parent)
			{
			sync_id_register();
			
			//Correct IDs
			if (object_index == obj_verlet_stick)
				{
				point1 = game_state_find_new_id(_ids, _new_ids, point1);
				point2 = game_state_find_new_id(_ids, _new_ids, point2);
				}
			}
		
		with (obj_game)
			{
			//Correct Sync Grid IDs
			for (var i = 0; i < ds_grid_height(obj_sync_id_system.sync_grid); i++)
				{
				var _array = obj_sync_id_system.sync_grid[# SYNC_GRID.structs, i];
				for (var m = 0; m < array_length(_array); m++)
					{
					_array[@ m].instance = game_state_find_new_id(_ids, _new_ids, _array[m].instance);
					}
				}
			
			//Since the number of players shouldn't change, the depth list does not need to be saved or loaded
			for (var i = 0; i < ds_list_size(player_depth_list); i++)
				{
				player_depth_list[| i] = game_state_find_new_id(_ids, _new_ids, player_depth_list[| i]);
				}
			}
			
		with (obj_verlet_system)
			{
			for (var i = 0; i < array_length(verlet_points); i++)
				{
				verlet_points[@ i] = game_state_find_new_id(_ids, _new_ids, verlet_points[@ i]);
				}
			for (var i = 0; i < array_length(verlet_sticks); i++)
				{
				verlet_sticks[@ i] = game_state_find_new_id(_ids, _new_ids, verlet_sticks[@ i]);
				}
			}
		#endregion
		
		//Sort the Sync IDs
		sync_id_grid_sort();
		
		//Clean Up
		ds_map_destroy(_ids);
		ds_map_destroy(_new_ids);
		_ids = noone;
		_new_ids = noone;
		
		//Reset loading variable
		is_loading = false;
		
		return;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */