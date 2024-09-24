///@description Actions
if (active)
	{
	var _confirm = false;
	var _back = false;
	var _start = false;
	
	//Collect inputs from all MIS devices
	var _array = mis_devices_get_array();
	for (var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		if (mis_device_input(_id, MIS_INPUT.confirm)) then _confirm = true;
		if (mis_device_input(_id, MIS_INPUT.start)) then _start = true;
		if (mis_device_input(_id, MIS_INPUT.back)) then _back = true;
		}
		
	switch (state)
		{
		case RANDOM_MATCHMAKING_STATE.idle:
			state_message = "Press B on controller / Enter on keyboard to start matchmaking!";
			progress = -1;
			
			if (!popup_is_open())
				{
				//Open main menu
				if (_back)
					{
					active = false;
					main_menu_sidebar_activate(true);
					}
				//Starting the matchmaking process
				else if (_confirm || _start)
					{
					menu_sound_play(snd_menu_select);
					state = RANDOM_MATCHMAKING_STATE.connecting_to_server;
					state_frame = 0;
					time_since_last_packet = 0;
					}
				}
			break;
		case RANDOM_MATCHMAKING_STATE.failed:
			state_message = "The matchmaking failed :(  Please try again in a few seconds";
			progress = -1;
			
			if (!popup_is_open())
				{
				//Open main menu
				if (_back)
					{
					active = false;
					main_menu_sidebar_activate(true);
					}
				//Return to the idle state after 3 seconds
				else if (state_frame > 60 * 3)
					{
					state = RANDOM_MATCHMAKING_STATE.idle;
					state_frame = 0;
					time_since_last_packet = 0;
					}
				}
			break;
		case RANDOM_MATCHMAKING_STATE.connecting_to_server:
			state_message = "Connecting to the matchmaking server...";
			progress = 1;
			if (timer % 30 == 0)
				{
				//Send a packet to the server
				server_send_packet(obj_ggmr_net.net_socket, packet, "random_matchmaking_begin", 0);
				}
			break;
		case RANDOM_MATCHMAKING_STATE.waiting_for_match:
			state_message = "Waiting for a match...";
			progress = 3;
			if (timer % 60 == 0)
				{
				//Send a packet to the server
				server_send_packet(obj_ggmr_net.net_socket, packet, "random_matchmaking_begin", 0);
				}
			
			if (!popup_is_open())
				{
				//Cancel matchmaking
				if (_back)
					{
					state = RANDOM_MATCHMAKING_STATE.canceling_match;
					state_frame = 0;
					time_since_last_packet = 0;
					}
				}
			break;
		case RANDOM_MATCHMAKING_STATE.canceling_match:
			state_message = "Canceling matchmaking...";
			progress = 3;
			if (timer % 60 == 0)
				{
				//Send a packet to the server
				server_send_packet(obj_ggmr_net.net_socket, packet, "random_matchmaking_cancel", 0);
				}
			break;
		case RANDOM_MATCHMAKING_STATE.getting_holepunch_data:
			state_message = "Getting the other player's data from the server...";
			progress = 4;
			if (timer % 60 == 0)
				{
				//Send a packet to the server
				server_send_packet(obj_ggmr_net.net_socket, packet, "holepunching_begin", match_id);
				}
			break;
		case RANDOM_MATCHMAKING_STATE.holepunching:
			state_message = "Trying to connect to the other player...";
			progress = 5;
			if (timer % 30 == 0)
				{
				//Save the connection
				var _connection = ggmr_net_connection_save(holepunching_ip, holepunching_port);
				engine().random_match_connection = _connection;
				if (!engine().online_is_leader)
					{
					engine().online_leader_connection = _connection;
					}
				
				random_matchmaking_start();
				exit;
				}
			break;
		default: crash("[obj_random_matchmaking_ui: End Step] Invalid state (", state, ")"); break;
		}
		
	state_frame++;
		
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
	
//Timers
timer++;
time_since_last_packet++;

if (time_since_last_packet > fail_timeout && state != RANDOM_MATCHMAKING_STATE.failed && state != RANDOM_MATCHMAKING_STATE.idle)
	{
	state = RANDOM_MATCHMAKING_STATE.failed;
	state_frame = 0;
	exit;
	}
/* Copyright 2024 Springroll Games / Yosi */