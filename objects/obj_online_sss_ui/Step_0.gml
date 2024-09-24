///@description Only the Leader can choose a stage!
if (engine().online_is_leader && !stage_selected && !popup_is_open())
	{
	//Get input from all MIS devices
	var _confirm = false;
	var _confirm_hold = 0;
	var _back = false;
	var _start = false;
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
		}
	
	var _x = ui_cursor_x(0);
	var _y = ui_cursor_y(0);

	//Cursor speed
	var _dir = point_direction(0, 0, _gx, _gy);
	var _len = ui_cursor_speed_calculate(_gx, _gy, menu_cursor_speed);
	_gx = lengthdir_x(_len, _dir);
	_gy = lengthdir_y(_len, _dir);

	//Update Cursor
	ui_cursor_update
		(
		0,
		clamp(_x + _gx, 0, room_width - 1),
		clamp(_y + _gy, 0, room_height - 1),
		false,
		_confirm,
		_confirm_hold,
		);
	
	//Hovering over stages
	var _inst = instance_position(ui_cursor_x(0), ui_cursor_y(0), obj_sss_zone);
	if (_inst != noone)
		{
		_inst.selected_animation_time = 1;
		
		//Name
		if (_inst.stage != noone)
			{
			stage_name_label.text = stage_data_get(_inst.stage, STAGE_DATA.name);
			stage_preview_image.sprite = stage_data_get(_inst.stage, STAGE_DATA.sprite);
			stage_preview_image.frame = stage_data_get(_inst.stage, STAGE_DATA.frame);
			}
		else
			{
			stage_name_label.text = "Random";
			stage_preview_image.sprite = spr_stage_random_button;
			stage_preview_image.frame = 0;
			}
		
		//Selecting a stage
		if (_confirm || _start)
			{
			menu_sound_play(snd_menu_select);
			if (_inst.stage != noone)
				{
				setting().match_stage = _inst.stage;
				}
			else
				{
				setting().match_stage = stage_choose_random();
				}
			stage_selected = true;
			}
		}
	}
//Waiting for the host to choose a stage...
else
	{
	obj_ui_fade.fade_goal = 0.75;
	}
	
//When a stage has been selected
if (stage_selected)
	{
	//Create & send the packet
	var _overall_struct = 
		{
		packet_type : "stage_data",
		stage : setting().match_stage,
		};
	buffer_reset(packet, false);
	buffer_write(packet, buffer_string, json_stringify(_overall_struct));
	buffer_resize(packet, buffer_tell(packet));
		
	//Send packets to every client
	for (var i = 0; i < array_length(engine().client_data); i++)
		{
		var _client = engine().client_data[@ i];
		var _location = _client[@ CLIENT_DATA.location];
		var _connection_id = _client[@ CLIENT_DATA.connection];
				
		//Don't send packets to yourself
		if (_location != GGMR_LOCATION_TYPE.local)
			{
			ggmr_net_send_double(GGMR_PACKET_TYPE.custom_data, packet, _connection_id);
			log("Sent a stage data packet to connection number ", _connection_id);
			}
		}
			
	//Start the game
	online_sss_start();
	exit;
	}
	
//Timer
stage_select_timer--;
if (stage_select_timer % 60 == 0)
	{
	stage_select_timer_label.text = "Starting in " + string(max(stage_select_timer div 60, 0)) + " seconds...";
	}	
if (stage_select_timer == 0)
	{
	//Choose a random stage
	if (engine().online_is_leader && !stage_selected)
		{
		menu_sound_play(snd_menu_select);
		setting().match_stage = stage_choose_random();
		stage_selected = true;
		exit;
		}
	}

//Disconnecting if the timer runs out
if (stage_select_timer <= -90)
	{
	popup_create("Disconnected from opponent (Trigger: Stage select timer)", [], c_red);
	room_goto(rm_main_menu);
	exit;
	}

//Disconnecting - check every 60 frames
if (stage_select_timer % 60 == 0)
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