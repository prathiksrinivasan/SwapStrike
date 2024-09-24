///@description Watch the Replay
replay_frame++;

//Running
if (meta_state == GAME_META_STATE.running || go_to_next_frame)
	{
	go_to_next_frame = false;

	//Playback speeds
	var _number_of_frames = replay_playback_speed;
	if (replay_playback_speed == 1)
		{
		//Local frame skip
		if (setting().local_frame_skip)
			{
			frame_delta_time += (delta_time - 16666);
			if (frame_delta_time > 16666)
				{
				frame_delta_time = 0;
				_number_of_frames = 2;
				}
			}
		}
	else if (replay_playback_speed == 0.5)
		{
		if (replay_frame % 2 == 0) then _number_of_frames = 1;
		else _number_of_frames = 0;
		}
	
	repeat (_number_of_frames)
		{
		//Rewind saves
		if (replay_rewind_enable && current_frame % replay_rewind_interval == 0)
			{
			var _b = buffer_create(1, buffer_grow, 1);
			game_state_save(_b);
			var _p = buffer_tell(replay_data_get().buffer);
			array_push
				(
				replay_rewind_saves, 
					{
					buffer : _b,
					position : _p,
					frame : current_frame,
					},
				);
			if (array_length(replay_rewind_saves) > replay_rewind_saves_max)
				{
				array_delete(replay_rewind_saves, 0, 1);
				}
			}
			
		//Reading inputs from the replay buffer
		with_synced_object(obj_player, function() 
			{
			input_replay_load();
			});
		
		//Sync Test
		if (setting().debug_sync_test)
			{
			game_state_save(game_state_buffer);
			}

		//Advance the frame
		var _ended = game_advance_frame(player_inputs);
	
		//Sync Test
		if (setting().debug_sync_test)
			{
			//Check that the game hasn't ended
			if (state != GAME_STATE.ending)
				{
				//Compare the game states
				var _expected = game_state_hash();
				game_state_load(game_state_buffer);
				game_advance_frame(player_inputs);
				var _actual = game_state_hash();
				assert(_actual == _expected, "[obj_game: Step] Actual game state does not match the expected game state! Actual: ", _actual, " | Expected: ", _expected);
				}
			//Clear the paused inputs
			paused_inputs_flag = 0;
			}
		
		//Clips - Save every other frame
		if ((current_frame + game_end_frame) % clip_save_interval == 0)
			{
			clip_should_save = true;
			}
		
		//Replay controls
		var _devices = mis_devices_get_array();
		var _pause_input = false;
		var _rl = 0;
		var _ud = 0;
		var _page_next_hold = 0;
		var _page_last_hold = 0;
		for (var i = 0; i < array_length(_devices); i++)
			{
			if (!_pause_input)
				{
				if (mis_device_input(_devices[@ i], MIS_INPUT.option, false) || 
					mis_device_input(_devices[@ i], MIS_INPUT.start, false) ||
					mis_device_input(_devices[@ i], MIS_INPUT.confirm, false) ||
					mis_device_input(_devices[@ i], MIS_INPUT.back, false) || 
					mis_device_input(_devices[@ i], MIS_INPUT.remove, false) ||
					mis_device_input(_devices[@ i], MIS_INPUT.select, false))
					{
					_pause_input = true;
					}
				}
			var _values = mis_device_stick_values(_devices[@ i]);
			if (abs(_values.x) > stick_flick_amount) then _rl = sign(_values.x);
			if (abs(_values.y) > stick_flick_amount) then _ud = sign(_values.y);
			_page_next_hold = max(mis_device_input(_devices[@ i], MIS_INPUT.page_next, true), _page_next_hold);
			_page_last_hold = max(mis_device_input(_devices[@ i], MIS_INPUT.page_last, true), _page_last_hold);
			}
			
		//Camera
		if (replay_camera_mode)
			{
			var _spd = (replay_cam_w / 120);
			replay_cam_x += _rl * _spd;
			replay_cam_y += _ud * _spd;
			if (_page_last_hold)
				{
				replay_cam_w += camera_ratio * 4;
				replay_cam_h += 4;
				}
			else if (_page_next_hold)
				{
				replay_cam_w -= camera_ratio * 4;
				replay_cam_h -= 4;
				}
			cam_x = replay_cam_x - (replay_cam_w div 2);
			cam_y = replay_cam_y - (replay_cam_h div 2);
			cam_w = replay_cam_w;
			cam_h = replay_cam_h;
			camera_set_view_pos(cam, round(cam_x), round(cam_y));
			camera_set_view_size(cam, round(cam_w), round(cam_h));
			}
			
		//Pausing
		if (_pause_input)
			{
			meta_state = GAME_META_STATE.paused_replay;
			replay_draw_hud = true;
			exit;
			}
			
		//Break the loop early if the game already ended
		if (_ended) then break;
		}
	}
//Paused Replay
if (meta_state == GAME_META_STATE.paused_replay)
	{
	//Collect inputs
	var _devices = mis_devices_get_array();
	var _confirm = false;
	var _back = false;
	var _option = false;
	var _remove = false;
	var _start_hold = 0;
	var _select = false;
	var _rl = 0;
	var _ud = 0;
	var _page_next_hold = 0;
	var _page_last_hold = 0;
	var _rl_press = 0;
	var _ud_press = 0;
	for (var i = 0; i < array_length(_devices); i++)
		{
		if (mis_device_input(_devices[@ i], MIS_INPUT.confirm, false)) then _confirm = true;
		if (mis_device_input(_devices[@ i], MIS_INPUT.back, false)) then _back = true;
		if (mis_device_input(_devices[@ i], MIS_INPUT.option, false)) then _option = true;
		if (mis_device_input(_devices[@ i], MIS_INPUT.remove, false)) then _remove = true;
		_start_hold = max(mis_device_input(_devices[@ i], MIS_INPUT.start, true), _start_hold);
		if (mis_device_input(_devices[@ i], MIS_INPUT.select, false)) then _select = true;
		var _values = mis_device_stick_values(_devices[@ i]);
		if (abs(_values.x) > stick_flick_amount) then _rl = sign(_values.x);
		if (abs(_values.y) > stick_flick_amount) then _ud = sign(_values.y);
		_page_next_hold = max(mis_device_input(_devices[@ i], MIS_INPUT.page_next, true), _page_next_hold);
		_page_last_hold = max(mis_device_input(_devices[@ i], MIS_INPUT.page_last, true), _page_last_hold);
		if (mis_device_stick_press_repeated(_devices[@ i]).x)
			{
			_rl_press = sign(mis_device_stick_values(_devices[@ i]).x);
			}
		if (mis_device_stick_press_repeated(_devices[@ i]).y)
			{
			_ud_press = sign(mis_device_stick_values(_devices[@ i]).y);
			}
		}
	
	//Normal menu
	if (!replay_camera_mode && !replay_took_control)
		{
		//Visible HUD
		if (replay_draw_hud)
			{
			//Scrolling through the menu
			if (_ud_press != 0)
				{
				replay_menu_current = modulo(replay_menu_current + _ud_press, array_length(replay_menu_choices));
				}
			
			//Options that can be changed with the left stick
			var _choice = replay_menu_choices[@ replay_menu_current];
			if (_rl_press != 0)
				{
				if (_choice == "Take Control")
					{
					replay_control_player = modulo(replay_control_player + _rl_press, instance_number(obj_player));
					}
				}
		
			//Menu options
			if (_confirm)
				{
				switch (_choice)
					{
					case "Resume":
						meta_state = GAME_META_STATE.running;
						exit;
					case "Playback Speed":
						if (replay_playback_speed == 0.5) then replay_playback_speed = 1;
						else if (replay_playback_speed == 4) then replay_playback_speed = 0.5;
						else if (replay_playback_speed == 3) then replay_playback_speed = 4;
						else if (replay_playback_speed == 2) then replay_playback_speed = 3;
						else if (replay_playback_speed == 1) then replay_playback_speed = 2;
						break;
					case "Save Clip":
						if (clip_can_record())
							{
							clip_save_start();
							}
						exit;
					case "Camera Mode":
						replay_camera_mode ^= true;
						replay_cam_x = cam_x + (cam_w / 2);
						replay_cam_y = cam_y + (cam_h / 2);
						replay_cam_w = cam_w;
						replay_cam_h = cam_h;
						break;
					case "Hide HUD":
						replay_draw_hud = false;
						break;
					case "Frame Advance":
						go_to_next_frame = true;
						exit;
					case "Rewind":
						if (replay_rewind_enable)
							{
							//Load the last saved frame
							var _len = array_length(replay_rewind_saves);
							if (_len > 0)
								{
								var _struct = replay_rewind_saves[@ _len - 1];
								game_state_load(_struct.buffer);
								buffer_seek(replay_data_get().buffer, buffer_seek_start, _struct.position);
								array_delete(replay_rewind_saves, _len - 1, 1);
								}
								
							//Return control to the replay
							replay_took_control = false;
							}
						exit;
					case "Take Control":
						replay_took_control = true;
						
						//Find the device that pressed the button
						for (var m = 0; m < array_length(_devices); m++)
							{
							if (mis_device_input(_devices[@ m], MIS_INPUT.confirm, false))
								{
								replay_control_device = _devices[@ m];
								break;
								}
							}
						exit;
					case "Quit":
						game_finish(engine().win_screen_next_room);
						exit;
					default: crash("[obj_game_replay: Step] Unknown replay menu choice \"", _choice, "\"");
					}
				}
			}
		//Hidden HUD
		else
			{
			if (_confirm)
				{
				replay_draw_hud = true;
				}
			}

		//Resume
		if (_back)
			{
			meta_state = GAME_META_STATE.running;
			exit;
			}
		}
	//Camera Mode
	else if (replay_camera_mode)
		{
		//Moving around the camera
		var _spd = (replay_cam_w / 120);
		replay_cam_x += _rl * _spd;
		replay_cam_y += _ud * _spd;
		if (_page_last_hold)
			{
			replay_cam_w += camera_ratio * 4;
			replay_cam_h += 4;
			}
		else if (_page_next_hold)
			{
			replay_cam_w -= camera_ratio * 4;
			replay_cam_h -= 4;
			}
		cam_x = replay_cam_x - (replay_cam_w div 2);
		cam_y = replay_cam_y - (replay_cam_h div 2);
		cam_w = replay_cam_w;
		cam_h = replay_cam_h;
		camera_set_view_pos(cam, round(cam_x), round(cam_y));
		camera_set_view_size(cam, round(cam_w), round(cam_h));
		
		//Resume gameplay
		if (_back)
			{
			meta_state = GAME_META_STATE.running;
			exit;
			}
		else if (_remove)
			{
			replay_camera_mode = false;
			exit;
			}
			
		//Hide / Show the HUD
		if (_option)
			{
			replay_draw_hud ^= true;
			}
		}
	//Control one player
	else if (replay_took_control)
		{
		//Frame advance
		if (_start_hold == 1 || _start_hold > 30)
			{
			with_synced_object(obj_player, function()
				{
				//Make sure we haven't hit the end of the replay yet
				if (buffer_tell(replay_data_get().buffer) < buffer_get_size(replay_data_get().buffer))
					{
					//Load inputs, but don't check for desyncs!
					input_replay_load(true);
					}
				
				//Take inputs for the controlled player
				if (player_number == obj_game.replay_control_player)
					{
					device = mis_device_get(obj_game.replay_control_device, MIS_DEVICE_PROPERTY.port_number);
					device_type = mis_device_convert_to_game_device(mis_device_get(obj_game.replay_control_device, MIS_DEVICE_PROPERTY.device_type));
					
					//If there are no custom controls set, go to the default online profile
					if (array_equals(custom_controls, []))
						{
						var _profile = profile_find(engine().online_default_name);
						if (_profile != -1)
							{
							custom_controls = custom_controls_unpack(profile_get(_profile, PROFILE.custom_controls), device_type);
							}
						else
							{
							var _struct = custom_controls_create();
							custom_controls = custom_controls_unpack(_struct, device_type);
							}
						}
					
					//Get the inputs
					game_local_input(obj_game.player_inputs[@ player_number], id, paused_inputs_flag);
					paused_inputs_flag = 0;
					}
				});
			
			game_advance_frame(player_inputs);
			}
		//Store paused inputs
		else
			{
			with (obj_player)
				{
				if (player_number == other.replay_control_player)
					{
					input_paused_collect(paused_inputs_flag, id);
					break;
					}
				}
			}
		}
		
	//Frame advance
	if ((_start_hold == 1 || _start_hold > 30) && !replay_took_control)
		{
		go_to_next_frame = true;
		exit;
		}
		
	//Rewind
	if (_select)
		{
		if (replay_rewind_enable)
			{
			//Load the last saved frame
			var _len = array_length(replay_rewind_saves);
			if (_len > 0)
				{
				var _struct = replay_rewind_saves[@ _len - 1];
				game_state_load(_struct.buffer);
				buffer_seek(replay_data_get().buffer, buffer_seek_start, _struct.position);
				array_delete(replay_rewind_saves, _len - 1, 1);
				}
				
			//Return control to the replay
			replay_took_control = false;
			}
		exit;
		}
	}
//Saving Clips
else if (meta_state == GAME_META_STATE.saving_clip)
	{
	if (!clip_save_frame_add())
		{
		//Add the name of all characters to the GIF
		var _name = version_string + "/";
		with (obj_player)
			{
			_name += character_name + "_";
			}
		_name += timestamp_create();
		
		//Save and go back to the replay menu
		clip_save_finish(_name);
		meta_state = GAME_META_STATE.paused_replay;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */