function online_css_ready_up()
	{
	with (obj_online_css_ui)
		{
		menu_sound_play(snd_menu_start);
		//Players cannot unready
		var _custom = css_player_get(local_player_id, CSS_PLAYER.custom);
		_custom.ready = true;
		cursor_active = false;
			
		//Random character
		if (character_data_get(css_player_get(local_player_id, CSS_PLAYER.character), CHARACTER_DATA.name) == "Random")
			{
			css_player_set(local_player_id, CSS_PLAYER.character, character_choose_random());
			}
		
		//If you are NOT the leader, send a packet to the leader with the CSS data in it
		if (!engine().online_is_leader)
			{
			//Add the local player's CSS data + profile name + necessary custom controls
			buffer_reset(packet, false);
			var _profile = css_player_get(local_player_id, CSS_PLAYER.profile);
			var _profile_name = profile_get(_profile, PROFILE.name);
			var _custom_controls = profile_get(_profile, PROFILE.custom_controls);
			var _struct = 
				{
				packet_type : "ready_up_data",
				player_number : local_player_number,
				character : css_player_get(local_player_id, CSS_PLAYER.character),
				color : css_player_get(local_player_id, CSS_PLAYER.color),
				name : _profile_name,
				right_stick_input : _custom_controls.right_stick_input,
				scs : _custom_controls.scs,
				acs : _custom_controls.acs,
				};
			var _json = json_stringify(_struct);
			
			//Send
			buffer_write(packet, buffer_string, _json);
			buffer_resize(packet, buffer_tell(packet));
			ggmr_net_send_double(GGMR_PACKET_TYPE.custom_data, packet, engine().online_leader_connection);
			log("Sent a ready up data packet to the leader!");
			}
				
		//Regardless of if you are the leader or not, send a ready up packet WITHOUT data to everyone else in the party
		buffer_reset(packet, false);
		buffer_write(packet, buffer_string, json_stringify({ packet_type : "ready_up", player_number : local_player_number }));
		buffer_resize(packet, buffer_tell(packet));
			
		//Send packets to every client
		for (var i = 0; i < array_length(engine().client_data); i++)
			{
			var _client = engine().client_data[@ i];
			var _location = _client[@ CLIENT_DATA.location];
			var _connection_id = _client[@ CLIENT_DATA.connection];
				
			//Don't send packets to yourself, or to the leader
			if (_location != GGMR_LOCATION_TYPE.local && _connection_id != engine().online_leader_connection)
				{
				ggmr_net_send_double(GGMR_PACKET_TYPE.custom_data, packet, _connection_id);
				log("Sent a ready up packet to connection number ", _connection_id);
				}
			}
		}
	//Fade
	obj_ui_fade.fade_goal = 0.75;
	}
/* Copyright 2024 Springroll Games / Yosi */