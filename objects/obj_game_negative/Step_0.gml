///@description GGMR
//Running
if (meta_state == GAME_META_STATE.running || go_to_next_frame)
	{
	go_to_next_frame = false;

	//Advance the frame
	ggmr_session_advance_frame();
		
	//Clips - Save every other frame
	if ((current_frame + game_end_frame) % clip_save_interval == 0)
		{
		clip_should_save = true;
		}
	}
//Paused
else if (meta_state == GAME_META_STATE.paused)
	{
	//Input
	var _device_id = pause_menu_device_id;
	var _confirm = mis_device_input(_device_id, MIS_INPUT.confirm);
	var _start = mis_device_input(_device_id, MIS_INPUT.start);
	var _select = mis_device_input(_device_id, MIS_INPUT.select);
	var _back = mis_device_input(_device_id, MIS_INPUT.back);
	var _stickv = mis_device_stick_press_repeated(_device_id).y;
	var _ud = sign(mis_device_stick_values(_device_id).y);
	
	//Navigating the pause menu
	if (!frame_advance_active)
		{
		//Scrolling
		if (_stickv)
			{
			menu_sound_play(snd_menu_move);
			pause_menu_current = modulo(pause_menu_current + _ud, array_length(pause_menu_choices));
			}
			
		//Selecting choice
		if (_confirm)
			{
			menu_sound_play(snd_menu_select);
			switch (pause_menu_choices[@ pause_menu_current])
				{
				case "RESUME":
					meta_state = GAME_META_STATE.running;
					pause_menu_device_id = noone;
					break;
				case "FRAME ADVANCE":
					frame_advance_active = true;
					break;
				case "RESTART":
					game_reset();
					exit;
				case "SAVE CLIP":
					if (clip_can_record())
						{
						clip_save_start();
						}
					break;
				case "EXIT":
					//Skip over the win screen
					game_finish(engine().win_screen_next_room);
					exit;
				default: crash("[obj_game_negative: Step] Pause menu choice is not valid (", pause_menu_current, ")"); break;
				}
			}
			
		//Resuming
		else if (_back)
			{
			menu_sound_play(snd_menu_back);
			meta_state = GAME_META_STATE.running;
			pause_menu_device_id = noone;
			}
		}
	//Frame advance
	else
		{
		//Store paused inputs for each player
		with (obj_player)
			{
			input_paused_collect(paused_inputs_flag, id);
			}
			
		if (_select)
			{
			menu_sound_play(snd_menu_back);
			frame_advance_active = false;
			}
		else if (_start)
			{
			go_to_next_frame = true;
			frames_advanced++;
			}
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
		
		//Save and go back to being paused
		clip_save_finish(_name);
		meta_state = GAME_META_STATE.paused;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */