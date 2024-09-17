///@category Startup
/*
Sets up everything needed for the game to run (call before any menus).
*/
function engine_init()
	{
	//Randomize the Seed
	randomize();

	//Load Options
	options_load();
	
	//Load Stats
	stats_load();

	//Handle Saved Profiles
	profile_load_all();
	profile_clean_auto();
	
	//Add the Replay Buffer to the Data
	replay_data_get().buffer = buffer_create(1, buffer_grow, 1);

	//Global Particle System
	part_system_init();

	//Game Resizing
	surface_resize(application_surface, screen_width, screen_height);
	var _width = setting().screen_width_custom;
	var _height = setting().screen_height_custom;
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
		}
	else
		{
		window_set_size(screen_width, screen_height);
		window_center();
		}
	window_set_caption(game_name + " " + version_string);

	//Game Camera
	view_enabled = true;
	view_visible[0] = true;
	view_wport[0] = screen_width;
	view_hport[0] = screen_height;
	view_camera[0] = game_camera_get();

	//Audio Groups
	audio_group_load(audiogroup_music);
	audio_group_load(audiogroup_sound_effects);
	audio_group_load(audiogroup_menu);

	//Garbage collector
	gc_enable(true);
	if (!web_export)
		{
		//Doesn't work on HTML5
		gc_target_frame_time(1500);
		}
	
	//Surface disable depth
	surface_depth_disable(true);
	
	//Turn off double clicking
	device_mouse_dbclick_enable(false);
	
	//Live Values
	live_values_reload();
	
	//Simple Attack Predefinitions
	simple_attack_definitions();
	}
/* Copyright 2024 Springroll Games / Yosi */