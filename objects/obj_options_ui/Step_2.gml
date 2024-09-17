///@description Actions
if (active && !popup_is_open())
	{
	//Inputs
	var _array = mis_devices_get_array();
	for (var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		var _confirm = mis_device_input(_id, MIS_INPUT.confirm);
		var _back = mis_device_input(_id, MIS_INPUT.back);
		var _stickv = (mis_device_stick_press_repeated(_id).y);
		var _ud = sign(mis_device_stick_values(_id).y);
	
		//Scrolling
		if (_stickv)
			{
			menu_sound_play(snd_menu_move);
			option_current = modulo(option_current + _ud, options_count);
			
			//Skip over section headers
			if (option_current != (options_count - 1) && is_string(options_array[@ option_current]))
				{
				option_current = modulo(option_current + _ud, options_count);
				}
		
			while (option_current > option_scroll + options_per_page - 1) 
				{
				option_scroll++;
				}
			while (option_current < option_scroll) 
				{
				option_scroll--;
				}
			}
		
		var _selected_back_button = false;
		
		//Selecting a option
		if (_confirm)
			{
			menu_sound_play(snd_menu_select);
			
			//Back button
			if (option_current == (options_count - 1))
				{
				_selected_back_button = true;
				}
			else
				{
				//Options
				var _option = options_array[@ option_current];
				switch (_option.name)
					{
					case "Toggle Fullscreen":
						if (window_get_fullscreen())
							{
							window_set_fullscreen(false);
							window_set_size(screen_width, screen_height);
							window_center();
							}
						else
							{
							window_set_fullscreen(true);
							}
						_option.current = window_get_fullscreen();
						break;
					case "Change Window Size":
						var _scale = (window_get_width() div screen_width);
						_scale = modulo(_scale, 4) + 1;
						var _ww = screen_width * _scale;
						var _wh = screen_height * _scale;
						window_set_size(_ww, _wh);
						//Center the window
						window_set_position
							(
							(display_get_width() div 2) - (_ww div 2),
							(display_get_height() div 2) - (_wh div 2),
							);
						_option.current = string(_scale) + "x";
						break;
					case "Custom Size":
						//Prompt for the width
						string_inputter_get_string
							(
							"Enter the width:", 
							"", 
							function(_string, _option_current)
								{
								if (_string == "") then return;
								var _width = round(real(_string));
								//Prompt for the height
								string_inputter_get_string
									(
									"Enter the height:",
									"",
									function(_string, _custom)
										{
										if (_string == "") then return;
										var _width = _custom.width;
										var _height = round(real(_string));
										//Make sure the values are within the limits
										if (_width >= screen_size_min && _width <= screen_size_max &&
											_height >= screen_size_min && _height <= screen_size_max)
											{
											//Resize the window
											window_set_size(_width, _height);
											//Center the window
											window_set_position
												(
												(display_get_width() div 2) - (_width div 2),
												(display_get_height() div 2) - (_height div 2),
												);
											//Change the displayed text
											with (obj_options_ui)
												{
												options_array[@ _custom.option_current].current = string(_width) + "x" + string(_height);
												}
											//Save the variables
											setting().screen_width_custom = _width;
											setting().screen_height_custom = _height;
											}
										},
									{ option_current : _option_current, width : _width },
									4,
									valid_string_numbers,
									);
								},
							option_current,
							4,
							valid_string_numbers,
							);
						break;
					case "Music Volume":
					case "Sound Effects Volume":
					case "Menu Volume":
						_option.current = modulo(_option.current + 0.25, 1.25);
						break;
					case "Stereo Sound Effects":
					case "Overhead Names":
					case "Overhead Damage":
					case "Overhead Arrows":
					case "Show HUD":
					case "Show Usernames":
					case "Show Connect Codes":
					case "Show Matchmaking Progress":
					case "Show Ping":
					case "Auto Ready when Spectating":
					case "Performance Mode":
					case "Disable Shaders":
					case "Combo Display":
					case "Frame Advantage Display":
					case "Damage Number VFX":
					case "Offscreen Radar":
					case "Knockback Cloud Trails":
					case "Record Replays":
					case "Record Clips":
					case "Hold to Pause":
					case "Debug Mode":
						_option.current ^= true;
						break;
					case "Username":
						string_inputter_get_string
							(
							"Enter your username:", 
							"", 
							function(_string, _option_current)
								{
								if (_string != "")
									{
									with (obj_options_ui)
										{
										options_array[@ _option_current].current = _string;
										}
									}
								},
							option_current,
							);
						break;
					case "Default Profile":
						//You can only select profiles that aren't autogenerated
						repeat (profile_count())
							{
							_option.current = modulo(++_option.current, profile_count());
							if (profile_exists(_option.current, true)) then break;
							}
						break;
					default: crash("[obj_options_ui: End Step] Selected option is invalid (", _option.name, ")"); 
					}
				}
			}
			
		//Open main menu
		if (_back || _selected_back_button)
			{
			//Store the previous volume to check if it was changed or not
			var _previous_volume = setting().volume_music;
			
			//Apply changes & save the options file
			for (var m = 0; m < (options_count - 1); m++)
				{
				var _option = options_array[@ m];
				if (is_string(_option)) then continue;
				var _v = _option.current;
				switch (_option.name)
					{
					case "Toggle Fullscreen": break;
					case "Change Window Size": break;
					case "Custom Size": break;
					case "Music Volume": setting().volume_music = _v; break;
					case "Sound Effects Volume": setting().volume_sound_effects = _v; break;
					case "Menu Volume": setting().volume_menu = _v; break;
					case "Stereo Sound Effects": setting().stereo_sound_effects = _v; break;
					case "Overhead Names": setting().show_overhead_name = _v; break;
					case "Overhead Damage": setting().show_overhead_damage = _v; break;
					case "Overhead Arrows": setting().show_overhead_arrow = _v; break;
					case "Show HUD": setting().show_hud = _v; break;
					case "Combo Display": setting().show_combos = _v; break;
					case "Frame Advantage Display": setting().show_frame_advantage = _v; break;
					case "Damage Number VFX": setting().show_damage_numbers = _v; break;
					case "Offscreen Radar": setting().show_offscreen_radar = _v; break;
					case "Knockback Cloud Trails": setting().knockback_trails_enable = _v; break;
					case "Performance Mode": setting().performance_mode = _v; break;
					case "Disable Shaders": setting().disable_shaders = _v; break;
					case "Record Replays": setting().replay_record = _v; break;
					case "Record Clips": setting().clip_record = _v; break;
					case "Hold to Pause": setting().pause_hold_input = _v; break;
					case "Debug Mode": setting().debug_mode_enable = _v; break;
					default: crash("[obj_options_ui: End Step] Option is invalid (", _option.name, ")"); 
					}
				}
			options_save();
			options_load();
			
			//Start up the menu theme again if the volume was changed
			if (setting().volume_music != _previous_volume)
				{
				audio_stop_all();
				audio_play_sound_adjusted(song_menu, 0, true, audiogroup_music);
				}
			
			//Open the sidebar
			active = false;
			main_menu_sidebar_activate(true);
			}
		}
	//Fade
	obj_ui_fade.fade_goal = 0;
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
/* Copyright 2024 Springroll Games / Yosi */