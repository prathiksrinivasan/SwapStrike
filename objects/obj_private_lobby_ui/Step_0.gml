///@description
var _disable_cursor = false;
var _confirm = false;
var _confirm_hold = 0;
var _back = false;
var _start = false;
var _select = false;
var _stickh = false;
var _stickv = false;
var _rl = 0;
var _ud = 0;
var _gx = 0;
var _gy = 0;

#region Collect inputs from all MIS devices
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
		mis_last_device_used = i;
		}
	_confirm_hold = max(mis_device_input(_id, MIS_INPUT.confirm, true), _confirm_hold);
	if (mis_device_input(_id, MIS_INPUT.back))
		{
		_back = true;
		mis_last_device_used = i;
		}
	if (mis_device_input(_id, MIS_INPUT.start))
		{
		_start = true;
		mis_last_device_used = i;
		}
	if (mis_device_input(_id, MIS_INPUT.select))
		{
		_select = true;
		mis_last_device_used = i;
		}
	if (mis_device_stick_press_repeated(_id).x) then _stickh = true;
	if (mis_device_stick_press_repeated(_id).y) then _stickv = true;
	}
_gx = clamp(_gx, -1, 1);
_gy = clamp(_gy, -1, 1);
_rl = sign(_gx);
_ud = sign(_gy);
#endregion

//Disabling the cursor
if (popup_is_open() || 
	online_chat_is_open() || 
	obj_main_menu_sidebar_ui.menu_active || 
	join_request_list_show || 
	obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.joining ||
	state != PRIVATE_LOBBY_STATE.normal)
	{
	_disable_cursor = true;
	}

//If the connect code is being registered...
if (connect_code_state != "normal")
	{
	#region Connect code states
	switch (connect_code_state)
		{
		case "reserving":
			connect_code_timer++;
			connect_code_message = "Reserving connect code...";
			if (connect_code_timer > 60 * 5)
				{
				connect_code_message = "Could not connect to the matchmaking server!";
				connect_code_state = "failed";
				connect_code_reserved = false;
				}
			break;
		case "failed":
			if (_confirm || _back || _start)
				{
				connect_code_state = "normal";
				connect_code_timer = 0;
				}
			break;
		case "finding":
			connect_code_timer++;
			connect_code_message = "Searching for a lobby with the given connect code...";
			if (connect_code_timer > 60 * 5)
				{
				connect_code_message = "Could not connect to the matchmaking server!";
				connect_code_state = "failed";
				}
			break;
		default: crash("[obj_private_lobby_ui: Step] Invalid connect code state (", connect_code_state, ")"); break;
		}
	#endregion
	
	//Fade
	obj_ui_fade.fade_goal = 0.5;
	
	_disable_cursor = true;
	}
else
	{
	//Private Lobby States
	if (state == PRIVATE_LOBBY_STATE.normal)
		{
		//Lobby States
		if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.idle)
			{
			#region Join Requests
			if (join_request_list_show)
				{
				var _number_of_join_requests = ds_list_size(obj_ggmr_lobby.lobby_join_requests);
		
				//Join Request list animation
				join_request_list_x = lerp(join_request_list_x, 608, 0.2);
				ui_set_position(noone, join_request_list_x, 32, 1);
		
				//Fade
				obj_ui_fade.fade_goal = 0.5;
	
				//Scrolling
				if (_stickv && _number_of_join_requests > 0)
					{
					menu_sound_play(snd_menu_move);
					join_request_current = modulo(join_request_current + _ud, _number_of_join_requests);
		
					while (join_request_current > join_request_scroll + join_request_list_display_size - 1) 
						{
						join_request_scroll++;
						}
					while (join_request_current < join_request_scroll) 
						{
						join_request_scroll--;
						}
					}
		
				//Selecting a join request
				if (_confirm && _number_of_join_requests > 0)
					{
					menu_sound_play(snd_menu_select);
					ggmr_lobby_join_request_accept(join_request_scroll);
					join_request_list_show = false;
					exit;
					}
				//Cancel
				else if (_back)
					{
					join_request_list_show = false;
					join_request_current = 0;
					join_request_scroll = 0;
					}
				}
			#endregion
			#region Normal
			else if (state == PRIVATE_LOBBY_STATE.normal)
				{	
				//Replay list animation
				join_request_list_x = lerp(join_request_list_x, room_width + 32, 0.2);
				ui_set_position(noone, join_request_list_x, 32, 1);
		
				//Fade
				obj_ui_fade.fade_goal = 0;
		
				//Readying up
				if (_start && !popup_is_open())
					{
					menu_sound_play(snd_menu_start);
					ggmr_lobby_ready_up();
					private_lobby_ui_refresh();
					auto_spectator_ready = false;
					}
				//Auto spectator ready
				else if (auto_spectator_ready)
					{
					var _type = ggmr_lobby_member_get(obj_ggmr_lobby.lobby_member_number, GGMR_LOBBY_MEMBER.client_type);
					var _ready = ggmr_lobby_member_get(obj_ggmr_lobby.lobby_member_number, GGMR_LOBBY_MEMBER.ready);
					if (engine().private_lobby_spectator_ready && _type == GGMR_CLIENT_TYPE.spectator && !_ready)
						{
						ggmr_lobby_ready_up();
						private_lobby_ui_refresh();
						}
					}
				}
			#endregion
			
			#region Starting the game
			var _start_game = false;
			if (ggmr_lobby_is_leader()) 
				{
				if (ggmr_lobby_everyone_is_ready() && ggmr_lobby_status_code() == GGMR_LOBBY_STATUS.ok) 
					{
					//Make sure there are at least 2 teams, if teams are enabled
					var _valid_teams = false;
					if (setting().match_team_mode)
						{
						var _teams = obj_ggmr_lobby.lobby_custom_data.teams;
						for (var i = 1; i < ds_list_size(obj_ggmr_lobby.lobby_members); i++)
							{
							if (_teams[@ i - 1] != _teams[@ i])
								{
								_valid_teams = true;
								break;
								}
							}
						}
					else
						{
						_valid_teams = true;
						}
					
					if (_valid_teams)
						{
						//Start the session
						ggmr_lobby_session_start();
						engine().online_is_leader = true;
						engine().online_leader_connection = -1;
						_start_game = true;
						}
					}
				} 
			else 
				{
				//Check if the leader started the session
				if (ggmr_lobby_session_is_started()) 
					{
					engine().online_is_leader = false;
					engine().online_leader_connection = obj_ggmr_lobby.lobby_joined_connection;
					_start_game = true;
					}
				}
			
			//Call the function to leave the lobby
			if (_start_game)
				{
				private_lobby_start();
				exit;
				}
			#endregion
			}
		else if (obj_ggmr_lobby.lobby_state == GGMR_LOBBY_STATE.joining)
			{
			//Cancel
			if (_confirm || _back || _start)
				{
				ggmr_lobby_reset();
				}
			//Fade
			obj_ui_fade.fade_goal = 0.5;
			}
			
		//Match settings animation
		match_settings_y = lerp(match_settings_y, -256, 0.2);
		ui_set_position(noone, 320, match_settings_y, 0);
		}
	else if (state == PRIVATE_LOBBY_STATE.match_settings)
		{
		#region Match settings
		if (state == PRIVATE_LOBBY_STATE.match_settings)
			{
			//Scrolling
			if (_stickv)
				{
				menu_sound_play(snd_menu_move);
				match_settings_current = modulo(match_settings_current + _ud, array_length(match_settings_choices));
				}
		
			//Changing the settings
			if (_stickh)
				{
				menu_sound_play(snd_menu_select);
				var _choice = match_settings_choices[@ match_settings_current];
				switch (_choice)
					{
					case "Stock":
						setting().match_stock = modulo(setting().match_stock + _rl, stock_value_limit + 1);
						break;
					case "Time":
						setting().match_time = modulo(setting().match_time + _rl, time_value_limit + 1);
						break;
					case "Stamina":
						var _vals = stamina_valid_values;
						stamina_index = modulo(stamina_index + _rl, array_length(_vals));
						setting().match_stamina = _vals[@ stamina_index];
						break;
					case "Teams":
						setting().match_team_mode ^= true;
						break;
					case "Team Attack":
						setting().match_team_attack ^= true;
						break;
					case "Items":
						var _vals = items_frequency_valid_values;
						items_frequency_index = modulo(items_frequency_index + _rl, array_length(_vals));
						setting().match_items_frequency = _vals[@ items_frequency_index];
						setting().match_items_enable = (setting().match_items_frequency > 0);
						break;
					case "Final Smash Meter":
						setting().match_fs_meter ^= true;
						break;
					case "Screen Wrap":
						setting().match_screen_wrap ^= true;
						break;
					case "EX Meter":
						setting().match_ex_meter ^= true;
						break;
					default: crash("[obj_private_lobby_ui: Step] Unrecognized match settings choice (", _choice, ")"); break;
					}
				}
		
			//Cancel
			if (_back || _confirm)
				{
				state = CSS_STATE.normal;
				match_settings_current = 0;
				match_settings_selector = noone;
				css_ui_refresh();
				}
	
			//Match settings animation
			match_settings_y = lerp(match_settings_y, 160, 0.2);
			ui_set_position(noone, 320, match_settings_y, 0);
	
			//Fade
			obj_ui_fade.fade_goal = 0.75;
			
			//Set the custom data
			obj_ggmr_lobby.lobby_custom_data.match_settings = match_settings_save();
			}
		#endregion
		}

	//Auto refresh
	var _current = ds_list_size(obj_ggmr_lobby.lobby_members);
	if (previous_number_of_players != _current)
		{
		private_lobby_ui_refresh();
		previous_number_of_players = _current;
		}
		
	//Make sure to renew the lobby code reservation!
	connect_code_timer++;
	if (connect_code_timer >= 600)
		{
		connect_code_timer = 0;
		if (connect_code_reserved)
			{
			server_send_packet(obj_ggmr_net.net_socket, packet, "private_lobby_reserve", engine().online_connect_code);
			}
		}
	}
	
#region Cursor actions
if (!_disable_cursor)
	{
	var _x = ui_cursor_x(0);
	var _y = ui_cursor_y(0);

	//Cursor speed
	var _dir = point_direction(0, 0, _gx, _gy);
	var _len = ui_cursor_speed_calculate(_gx, _gy, menu_cursor_speed);
	_gx = lengthdir_x(_len, _dir);
	_gy = lengthdir_y(_len, _dir);

	ui_cursor_update
		(
		0,
		clamp(_x + _gx, 0, room_width - 1),
		clamp(_y + _gy, 0, room_height - 1),
		false,
		_confirm,
		_confirm_hold,
		);
	}
else
	{
	//Make sure the cursor doesn't register a click again
	ui_cursor_update
		(
		0,
		0,
		0,
		true,
		false,
		0,
		);
	}
#endregion
	
//Opening the chat
if (_select)
	{
	online_chat_open();
	}
	
//Sidebar fade
if (obj_main_menu_sidebar_ui.menu_active)
	{
	obj_ui_fade.fade_goal = 0.5;
	}
	
//Play sound effect when join requests are added
var _size = ds_list_size(obj_ggmr_lobby.lobby_join_requests)
if (_size > join_request_list_size)
	{
	menu_sound_play(snd_menu_alert);
	}
join_request_list_size = _size;

//Update the match settings if you aren't the leader
if (!ggmr_lobby_is_leader())
	{
	//Read the custom data
	var _struct = obj_ggmr_lobby.lobby_custom_data.match_settings;
	if (is_struct(_struct))
		{
		match_settings_load(_struct);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */