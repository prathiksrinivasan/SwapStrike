function private_lobby_ui_refresh()
	{
	//Destroys and recreates all of the necessary UI for the online lobby.
	var _list = obj_ggmr_lobby.lobby_members;
	var _number = ds_list_size(_list);

	with (obj_private_lobby_ui)
		{
		//Destroy existing UI
		for (var i = 0; i < max_players; i++)
			{
			var _group = group_start_number + i;
			ui_group_delete(_group);
			}
			
		//Create new UI
		for (var i = 0; i < _number; i++)
			{
			var _member = _list[| i];
			var _name = _member[@ GGMR_LOBBY_MEMBER.name];
			var _location = _member[@ GGMR_LOBBY_MEMBER.location];
			var _player_type = _member[@ GGMR_LOBBY_MEMBER.client_type];
			var _ready = _member[@ GGMR_LOBBY_MEMBER.ready];
			var _connection = _member[@ GGMR_LOBBY_MEMBER.connection];
		
			//Create new UI
			private_lobby_ui_create_member(i, _name, _location, _connection, _player_type, _ready);
			}
		
		log("Refreshed Online Lobby UI!");
		}
	}
/* Copyright 2024 Springroll Games / Yosi */