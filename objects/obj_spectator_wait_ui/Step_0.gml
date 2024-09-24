//Exit if a popup is open
if (popup_is_open()) then exit;

//Get input from all MIS devices
var _confirm = false;
var _confirm_hold = 0;
var _back = false;
var _start = false;
var _select = false;
var _gx = 0;
var _gy = 0;
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
	if (!_confirm) then _confirm = mis_device_input(_id, MIS_INPUT.confirm);
	if (_confirm_hold == 0) then _confirm_hold = mis_device_input(_id, MIS_INPUT.confirm, true);
	if (!_back) then _back = mis_device_input(_id, MIS_INPUT.back);
	if (!_start) then _start = mis_device_input(_id, MIS_INPUT.start);
	if (!_select) then _select = mis_device_input(_id, MIS_INPUT.select);
	}
	
var _x = ui_cursor_x(0);
var _y = ui_cursor_y(0);

//Cursor speed
var _dir = point_direction(0, 0, _gx, _gy);
var _len = ui_cursor_speed_calculate(_gx, _gy, menu_cursor_speed);
_gx = lengthdir_x(_len, _dir);
_gy = lengthdir_y(_len, _dir);

//Update Cursor
if (!online_chat_is_open())
	{
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
	
//Opening the chat
if (_select)
	{
	online_chat_open();
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
/* Copyright 2024 Springroll Games / Yosi */