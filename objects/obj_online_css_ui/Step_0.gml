///@description
var _confirm = false;
var _confirm_hold = 0;
var _back = false;
var _remove = false;
var _start = false;
var _select = false;
var _stickv = false;
var _ud = 0;
var _gx = 0;
var _gy = 0;

//Collect inputs from all MIS devices
var _array = mis_devices_get_array();
for (var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i];
	var _values = mis_device_stick_values(_id);
	if (_values.hold > 0)
		{
		_gx += _values.x;
		_gy += _values.y;
		}
	if (mis_device_input(_id, MIS_INPUT.confirm)) 
		{
		_confirm = true;
		mis_last_device_used_id = _array[i];
		}
	_confirm_hold = max(mis_device_input(_id, MIS_INPUT.confirm, true), _confirm_hold);
	if (mis_device_input(_id, MIS_INPUT.back))
		{
		_back = true;
		mis_last_device_used_id = _array[i];
		}
	if (mis_device_input(_id, MIS_INPUT.remove))
		{
		_remove = true;
		mis_last_device_used_id = _array[i];
		}
	if (mis_device_input(_id, MIS_INPUT.start))
		{
		_start = true;
		mis_last_device_used_id = _array[i];
		}
	if (mis_device_input(_id, MIS_INPUT.select))
		{
		_select = true;
		mis_last_device_used_id = _array[i];
		}
	if (mis_device_stick_press_repeated(_id).y) then _stickv = true;
	}
_gx = clamp(_gx, -1, 1);
_gy = clamp(_gy, -1, 1);
_ud = sign(_gy);
	
//Update Cursor
if (cursor_active && !online_chat_is_open() && !popup_is_open())
	{
	var _x = ui_cursor_x(0);
	var _y = ui_cursor_y(0);

	//Cursor speed
	var _dir = point_direction(0, 0, _gx, _gy);
	var _len = ui_cursor_speed_calculate(_gx, _gy, menu_cursor_speed);
	_gx = lengthdir_x(_len, _dir);
	_gy = lengthdir_y(_len, _dir);

	//Restrict cursor
	ui_cursor_update
		(
		0,
		clamp(_x + _gx, 0, room_width - 1),
		clamp(_y + _gy, 0, room_height - 1),
		false,
		_confirm,
		_confirm_hold,
		);
		
	//Tokens
	if (token_held == noone)
		{
		if (_confirm)
			{
			if (point_distance(ui_cursor_x(0), ui_cursor_y(0), token.x, token.y) < 40)
				{
				token_held = local_player_id;
				}
			}
		else if (_back)
			{
			token_held = local_player_id;
			}
		}
	//If you are already holding a token
	else
		{
		//Putting down the token
		if (_confirm || _remove || _start)
			{
			//Selecting a character
			var _zone = instance_position(ui_cursor_x(0), ui_cursor_y(0), obj_css_zone);
			if (_zone != noone)
				{
				menu_sound_play(snd_menu_select);
				_zone.selected_animation_time = 1;
				css_player_set(token_held, CSS_PLAYER.character, _zone.character); 
				
				//Do NOT check if any other players already took the color
				var _min = 1;
				var _max = (character_data_get(_zone.character, CHARACTER_DATA.palette_data).columns - 1);
				css_player_set
					(
					token_held,
					CSS_PLAYER.color,
					clamp(css_player_get(token_held, CSS_PLAYER.color), _min, _max),
					);
				}
			token_held = noone;
			}
		else
			{
			//Restrict cursor coordinates, so you can't take tokens out of the middle area
			ui_cursor_set(0, UI_CURSOR.y, clamp(ui_cursor_y(0), 34, 302));
			//Moving the token
			token.x = ui_cursor_x(0);
			token.y = ui_cursor_y(0);
			//Highlight any character boxes that you move the token over, and select that character
			var _zone = instance_position(ui_cursor_x(0), ui_cursor_y(0), obj_css_zone);
			var _current_character = css_player_get(token_held, CSS_PLAYER.character);
			if (_zone != noone)
				{
				_zone.selected_animation_time = 0.5;
				//If the character is changed, also reset the color to prevent an out-of-bounds error if one character has less palette than another
				if (_zone.character != _current_character)
					{
					css_player_set(token_held, CSS_PLAYER.character, _zone.character);
					var _favorite_color = profile_get(css_player_get(local_player_id, CSS_PLAYER.profile), PROFILE.favorite_colors)[@ _zone.character];
					var _num_of_colors = character_data_get(_zone.character, CHARACTER_DATA.palette_data).columns;
					if (_favorite_color >= _num_of_colors)
						{
						_favorite_color = 1;
						}
					css_player_set(token_held, CSS_PLAYER.color, _favorite_color);
					}
				}
			}
		}
		
	//Ready up shortcut
	if (token_held == noone && _start)
		{
		online_css_ready_up();
		}
	}
else
	{
	ui_cursor_update(0, 0, 0, true, false, 0);
	}
	
//Change the player's stored device to match the last device they used
//This means the device players use in the game will be the device they press the "Ready!" button with
if (mis_last_device_used_id != undefined)
	{
	css_player_set(local_player_id, CSS_PLAYER.device,  mis_device_get(mis_last_device_used_id, MIS_DEVICE_PROPERTY.port_number));
	css_player_set(local_player_id, CSS_PLAYER.device_type, mis_device_convert_to_game_device(mis_device_get(mis_last_device_used_id, MIS_DEVICE_PROPERTY.device_type)));
	}
	
//If you are the leader, start the game when every player is ready
//Other players will start the game in the async event when receiving a start data packet from the leader
if (engine().online_is_leader)
	{
	//Loop through every player and check the ready property
	var _all_ready = true;
	var _count = player_count();
	for (var i = 0; i < _count; i++)
		{
		if (!engine().player_data[@ i][@ PLAYER_DATA.custom].ready)
			{
			_all_ready = false;
			break;
			}
		}
	if (_all_ready)
		{
		//Send the data of every player in the lobby in one packet
		var _overall_struct =
			{
			packet_type : "start_data",
			css_data : [],
			match_settings : undefined,
			};
			
		//Player data
		var _css_players = css_players_get_array();
		for (var i = 0; i < array_length(_css_players); i++)
			{
			var _player_id = _css_players[@ i];
			var _profile = css_player_get(_player_id, CSS_PLAYER.profile);
			var _profile_name = profile_get(_profile, PROFILE.name);
			var _custom_controls = profile_get(_profile, PROFILE.custom_controls);
			var _struct = 
				{
				character : css_player_get(_player_id, CSS_PLAYER.character),
				color : css_player_get(_player_id, CSS_PLAYER.color),
				name : _profile_name,
				right_stick_input : _custom_controls.right_stick_input,
				scs : _custom_controls.scs,
				acs : _custom_controls.acs,
				};
			array_push(_overall_struct.css_data, _struct);
			}
			
		//Quickplay only: Random stage selection
		if (engine().online_mode == ONLINE_MODE.quickplay)
			{
			setting().match_stage = stage_choose_random();
			}
			
		//Match settings
		_overall_struct.match_settings = match_settings_save();
		
		//Create & send the packet
		var _json = json_stringify(_overall_struct);
		buffer_reset(packet, false);
		buffer_write(packet, buffer_string, _json);
		buffer_resize(packet, buffer_tell(packet));
		
		//Send packets to every client
		//Also, create an array of remote players to send start times to
		var _remote_players = [];
		for (var i = 0; i < array_length(engine().client_data); i++)
			{
			var _client = engine().client_data[@ i];
			var _location = _client[@ CLIENT_DATA.location];
			var _connection_id = _client[@ CLIENT_DATA.connection];
				
			//Don't send packets to yourself
			if (_location != GGMR_LOCATION_TYPE.local)
				{
				array_push(_remote_players, _connection_id);
				ggmr_net_send_double(GGMR_PACKET_TYPE.custom_data, packet, _connection_id);
				log("Sent a start data packet to connection number ", _connection_id);
				}
			}
				
		//Calculate & send the starting times
		ggmr_net_calculate_session_start_time(_remote_players);
				
		//Start the game
		online_css_start();
		exit;
		}
	}
	
//Opening the chat
if (_select)
	{
	online_chat_open();
	}
	
//Timer
match_start_timer--;
if (match_start_timer % 60 == 0)
	{
	inst_6532887A.text = "Starting match in " + string(max(match_start_timer div 60, 0)) + " seconds...";
	}
if (match_start_timer == 0)
	{
	//Force the player to ready up
	online_css_ready_up();
	exit;
	}
	
//Disconnecting if the timer runs out
if (match_start_timer <= -90)
	{
	popup_create("Disconnected from opponent (Trigger: Match start timer)", [], c_red);
	room_goto(rm_main_menu);
	exit;
	}
	
//Disconnecting - check every 60 frames
if (match_start_timer % 60 == 0)
	{
	var _count = player_count();
	for (var i = 0; i < _count; i++)
		{
		var _player = engine().player_data[@ i];
		var _custom = _player[@ PLAYER_DATA.custom];
		if (_custom.location == GGMR_LOCATION_TYPE.remote)
			{
			if (ggmr_net_connection_silence(_custom.connection) > GGMR_SESSION_DISCONNECT_TIME)
				{
				popup_create("Disconnected from opponent (Trigger: Connection silence for player " + string(i) + ")", [], c_red);
				room_goto(rm_main_menu);
				exit;
				}
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */