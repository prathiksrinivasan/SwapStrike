function random_matchmaking_start()
	{
	menu_sound_play(snd_menu_start);
	var _array = mis_devices_get_array();

	//Set up the player data (placeholder)
	profile_clean_auto();
	player_data_clear();
	spectator_data_clear();
	client_data_clear();
	var _order = engine().online_is_leader ? ["local", "remote"] : ["remote", "local"];

	for (var m = 0; m < array_length(_order); m++)
		{
		if (_order[@ m] == "local")
			{
			var _primary_device = _array[@ 0];
			var _device = mis_device_get(_primary_device, MIS_DEVICE_PROPERTY.port_number);
			var _device_type = mis_device_convert_to_game_device(mis_device_get(_primary_device, MIS_DEVICE_PROPERTY.device_type));
			var _name = engine().online_name;
			var _profile = -1;
			var _index = profile_find(engine().online_default_name);
			if (profile_exists(_index))
				{
				_profile = _index;
				}
			else
				{
				engine().online_default_name = "";
				_profile = profile_create
					(
					_name, 
					custom_controls_create(), 
					true,
					);
				}
			var _custom = 
				{
				device_id :		_primary_device,
				connection :	0,
				name :			_name,
				location :		GGMR_LOCATION_TYPE.local,
				client_type :	GGMR_CLIENT_TYPE.player,
				ready :			false,
				};
			player_data_create
				(
				character_find("Random"),
				1, 
				_device, 
				_device_type, 
				_profile,
				false, 
				false, 
				undefined, 
				-1, 
				_custom,
				);
			client_data_create(_name, 0, GGMR_LOCATION_TYPE.local, GGMR_CLIENT_TYPE.player);
			}
		else if (_order[@ m] == "remote")
			{
			/*Data for the other player has not been received yet*/
			var _device_id = -1;
			var _device = -1;
			var _device_type = DEVICE.none;
			var _name = "ANONYMOUS";
			var _custom = 
				{
				device_id :		_device_id,
				connection :	engine().random_match_connection,
				name :			_name,
				location :		GGMR_LOCATION_TYPE.remote,
				client_type :	GGMR_CLIENT_TYPE.player,
				ready :			false,
				};
			player_data_create
				(
				character_find("Random"),
				1, 
				_device, 
				_device_type, 
				profile_create
					(
					_name, 
					custom_controls_create(), 
					true,
					), 
				false, 
				false, 
				undefined, 
				-1, 
				_custom,
				);
			client_data_create(_name, engine().random_match_connection, GGMR_LOCATION_TYPE.remote, GGMR_CLIENT_TYPE.player);
			}
		}
		
	//Match settings
	match_settings_default(true);

	//Go to the CSS
	room_goto(rm_online_css);
	}
/* Copyright 2024 Springroll Games / Yosi */