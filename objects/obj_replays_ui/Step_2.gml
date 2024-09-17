///@description Actions
if (active && !popup_is_open())
	{
	//Inputs
	var _array = mis_devices_get_array();
	var _remove_any = false;
	for (var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		var _confirm = mis_device_input(_id, MIS_INPUT.confirm);
		var _start = mis_device_input(_id, MIS_INPUT.start);
		var _select = mis_device_input(_id, MIS_INPUT.select);
		var _back = mis_device_input(_id, MIS_INPUT.back);
		var _remove = mis_device_input(_id, MIS_INPUT.remove, true);
		var _stickv = (mis_device_stick_press_repeated(_id).y);
		var _ud = sign(mis_device_stick_values(_id).y);
		
		//If there are replays
		if (replays_count > 0)
			{
			//Scrolling
			if (_stickv)
				{
				menu_sound_play(snd_menu_move);
				replay_current = modulo(replay_current + _ud, replays_count);
				replay_delete_time = 0;
		
				while (replay_current > replay_scroll + replays_per_page - 1) 
					{
					replay_scroll++;
					}
				while (replay_current < replay_scroll) 
					{
					replay_scroll--;
					}
				}
		
			//Selecting a replay
			if (_confirm || _start)
				{
				menu_sound_play(snd_menu_start);
				replay_load(replay_array[@ replay_current]);
				game_begin(rm_replays, true, false);
				exit;
				}
			
			//Removing replays
			if (_remove)
				{
				_remove_any = true;
				replay_delete_time++;
				if (replay_delete_time > 60)
					{
					replay_delete_time = 0;
					popup_create
						(
						"Delete replay \"" + string(replay_array[@ replay_current]) + "\"?",
						["Yes", "No"],
						c_red,
						function(_choice)
							{
							if (_choice == "Yes")
								{
								obj_replays_ui.replay_delete = true;
								}
							},
						);
					}
				}
			
			//Renaming replays
			if (_select)
				{
				var _name = (web_export)
					? replay_array[@ replay_current]
					: version_string + "/" + replay_array[@ replay_current];
				string_inputter_get_string
					(
					"Enter the new name for the replay:",
					_name,
					function(_string, _args)
						{
						var _new_name = (web_export)
							? _string + ".pfe"
							: version_string + "/" + _string + ".pfe"
						
						if (file_exists(_args[@ 0]))
							{
							file_rename(_args[@ 0], _new_name);
							}
						
						//Web export must also change the names savefile
						if (web_export)
							{
							if (file_exists(savefile_replay_names))
								{
								var _json = string_file_load(savefile_replay_names);
								var _struct = json_parse(_json);
								var _array = _struct.replay_array;
								for (var m = 0; m < array_length(_array); m++)
									{
									if (_array[@ m] == _args[@ 0])
										{
										_array[@ m] = _new_name;
										}
									}
								string_file_save(savefile_replay_names, json_stringify(_struct));
								}
							}
						
						//Re-scan files
						with (obj_replays_ui)
							{
							replays_ui_scan();
							}
						},
					[_name],
					32,
					valid_string_replay_name,
					);
				exit;
				}
			
			//Metadata
			if (replay_metadata_current != replay_current && array_length(replay_array) > replay_current)
				{
				replay_metadata = replay_fetch_metadata(replay_array[@ replay_current]);
				replay_metadata_current = replay_current;
				}
			}
			
		//Open main menu
		if (_back)
			{
			active = false;
			main_menu_sidebar_activate(true);
			}
		}
	//Fade
	obj_ui_fade.fade_goal = 0;
	
	//Removing replays timer
	if (!_remove_any)
		{
		replay_delete_time = max(0, replay_delete_time - 3);
		}
	}
else
	{
	//Reactivate when the main menu is closed
	if (!obj_main_menu_sidebar_ui.menu_active)
		{
		active = true;
		}
	//Fade
	obj_ui_fade.fade_goal = 0.75;
	}

//Deleting replays
if (replay_delete)
	{
	replay_delete = false;
	try
		{
		var _name = (web_export)
			? replay_array[@ replay_current]
			: version_string + "/" + replay_array[@ replay_current];
		if (file_exists(_name))
			{
			file_delete(_name);
			}
		array_delete(replay_array, replay_current, 1);
						
		//Web export must also delete from the names savefile
		if (web_export)
			{
			if (file_exists(savefile_replay_names))
				{
				var _json = string_file_load(savefile_replay_names);
				var _struct = json_parse(_json);
				var _array = _struct.replay_array;
				for (var m = 0; m < array_length(_array); m++)
					{
					if (!file_exists(_array[@ m]))
						{
						array_delete(_array, m, 1);
						m--;
						}
					}
				string_file_save(savefile_replay_names, json_stringify(_struct));
				}
			}
				
		//Re-scan files
		replays_ui_scan();
						
		//Scroll
		replay_current -= 1;
		if (replay_current < 0 && replays_count > 0) then replay_current = 0;
		replay_scroll = max(0, --replay_scroll);
		if (replay_current > 0)
			{
			while (replay_current > replay_scroll + replays_per_page - 1) 
				{
				replay_scroll++;
				}
			while (replay_current < replay_scroll) 
				{
				replay_scroll--;
				}
			}
		}
	catch (_e)
		{
		log(_e);
		}
	}

/* Copyright 2024 Springroll Games / Yosi */