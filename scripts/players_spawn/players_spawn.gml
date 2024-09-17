///@category Gameplay
/*
Creates all of the player instances at the <obj_player_spawner> locations, and passes the necessary data to each.
*/
function players_spawn()
	{
	var _num_of_spawners = instance_number(obj_player_spawner);
	var _num_of_players = player_count();
	var _colors_taken = array_create(_num_of_players, undefined);
	var _character_data = character_data_get_all();
	
	//Loop through each non-random player and reserve their color, so random players can't steal them
	for (var i = 0; i < _num_of_players; i++)
		{
		var _data = engine().player_data[@ i];
		if (!_data[@ PLAYER_DATA.is_random])
			{
			var _color = _data[@ PLAYER_DATA.color];
			var _char = _data[@ PLAYER_DATA.character];
			//Make sure the color doesn't overlap with anyone else!
			var _already_taken = false;
			var _possible_colors = character_data_get(_char, CHARACTER_DATA.palette_data).columns;
			repeat (_possible_colors)
				{
				_already_taken = false;
				for (var m = 0; m < _num_of_players; m++)
					{
					var _other = _colors_taken[@ m];
					if (!is_undefined(_other) && _other.player_color == _color && _other.character == _char)
						{
						log("Same color as another player - switching colors");
						_already_taken = true;
						_color = modulo(_color + 1, _possible_colors);
						if (_color == 0) then _color++; //Can't choose the first column of a palette!
						break;
						}
					}
				if (!_already_taken) then break;
				}
			_colors_taken[@ i] = { player_color : _color, character : _char };
			}
		}
	
	//Loop through each random player and assign them colors
	for (var i = 0; i < _num_of_players; i++)
		{
		var _data = engine().player_data[@ i];
		if (_data[@ PLAYER_DATA.is_random])
			{
			var _color = _data[@ PLAYER_DATA.color];
			var _char = _data[@ PLAYER_DATA.character];
			//Make sure the color doesn't overlap with anyone else!
			var _already_taken = false;
			var _possible_colors = character_data_get(_char, CHARACTER_DATA.palette_data).columns;
			repeat (_possible_colors)
				{
				_already_taken = false;
				for (var m = 0; m < _num_of_players; m++)
					{
					var _other = _colors_taken[@ m];
					if (!is_undefined(_other) && _other.player_color == _color && _other.character == _char)
						{
						log("Random: Same color as another player - switching colors");
						_already_taken = true;
						_color = modulo(_color + 1, _possible_colors);
						if (_color == 0) then _color++; //Can't choose the first column of a palette!
						break;
						}
					}
				if (!_already_taken) then break;
				}
			_colors_taken[@ i] = { player_color : _color, character : _char };
			}
		}
	
	//Loop through each player in the match and spawn
	//If there are not enough player spawners in the room, then not all of the players will spawn
	for (var i = 0; i < min(_num_of_players, _num_of_spawners); i++)
		{
		var _s = instance_find(obj_player_spawner, i);
		with (instance_create_layer(_s.x, _s.y, _s.layer, obj_player))
			{
			//Pass in character script
			var _data = engine().player_data[@ i];
			var _character_number = _data[@ PLAYER_DATA.character];
			var _char = _character_data[@ _character_number];
			character = _character_number;
			character_script = _char[@ CHARACTER_DATA.script];
		
			//Assign Properties
			device = _data[@ PLAYER_DATA.device];
			device_type = _data[@ PLAYER_DATA.device_type];
			player_number = i;
			player_color = _colors_taken[@ i].player_color;
			player_profile = _data[@ PLAYER_DATA.profile];
			is_cpu = _data[@ PLAYER_DATA.is_cpu];
			cpu_type = _data[@ PLAYER_DATA.cpu_type];
			player_team = _data[@ PLAYER_DATA.team];
		
			//Custom controls
			var _cc = profile_get(player_profile, PROFILE.custom_controls);
			custom_controls = custom_controls_unpack(_cc, device_type);
			
			//Right stick input
			right_stick_input = _cc.right_stick_input;
			
			//Special Control Settings
			scs = _cc.scs;
			
			//Advanced Controller Settings
			acs = _cc.acs;
			
			//CPU Controls
			if (is_cpu)
				{
				custom_controls = [];
				scs = array_create(SCS.LENGTH, false);
				}
			
			//Player name
			player_name = profile_get(player_profile, PROFILE.name);
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */