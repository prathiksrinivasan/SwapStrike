///@description
var _type = async_load[? "type"];
if (_type == network_type_data) 
	{
	var _buff = async_load[? "buffer"];
	buffer_seek(_buff, buffer_seek_start, 0);
	
	//Make sure the packet isn't a GGMR packet
	if (buffer_peek(_buff, buffer_tell(_buff), buffer_u8) != GGMR_PACKET_TYPE.ignore) then exit;
	var _json = buffer_read(_buff, buffer_text);
	var _packet = json_parse(_json);
	var _type = _packet.type;
	var _data = _packet.data;
	if (is_undefined(_type) || is_undefined(_data))
		{
		crash("[obj_random_matchmaking_ui: Async - Networking] Received a packet with an invalid type (", _type, ") or invalid data (", _data, ")");
		}
	
	//Different types of server response packets / player data packets
	switch (_type)
		{
		case "incorrect_version":
			//The game is the wrong version
			if (!popup_is_open())
				{
				popup_create(string(_data), [], c_red);
				state = RANDOM_MATCHMAKING_STATE.idle;
				state_frame = 0;
				log("Matchmaking has been canceled");
				room_goto(rm_main_menu);
				}
			break;
		case "random_matchmaking_confirmation":
			//The connection to the server has been confirmed, and the player must now wait for a match
			if (state == RANDOM_MATCHMAKING_STATE.connecting_to_server)
				{
				state = RANDOM_MATCHMAKING_STATE.waiting_for_match;
				state_frame = 0;
				log("Successfully connected to the server!");
				}
			break;
		case "random_matchmaking_found":
			//A match has been found
			//The game will still accept the match, even if you already tried to cancel
			if (state == RANDOM_MATCHMAKING_STATE.waiting_for_match || state == RANDOM_MATCHMAKING_STATE.canceling_match)
				{
				menu_sound_play(snd_menu_alert);
				state = RANDOM_MATCHMAKING_STATE.getting_holepunch_data;
				state_frame = 0;
				match_id = _data;
				log("The server found a match (", match_id, ")");
				}
			break;
		case "random_matchmaking_cancel_confirmation":
			//You have successfully canceled the random matchmaking
			if (state == RANDOM_MATCHMAKING_STATE.canceling_match)
				{
				state = RANDOM_MATCHMAKING_STATE.idle;
				state_frame = 0;
				log("Matchmaking has been canceled");
				}
			break;
		case "holepunching_confirmation":
			//The player has been added to the holepunching list, or is already in it
			if (state == RANDOM_MATCHMAKING_STATE.getting_holepunch_data)
				{
				log("The player has been added to the holepunching map!");
				}
			break;
		case "holepunching_found":
			//The server sent back the other player's data
			if (state == RANDOM_MATCHMAKING_STATE.getting_holepunch_data)
				{
				var _struct = json_parse(_data);
				holepunching_ip = _struct.ip;
				holepunching_port = _struct.port;
				engine().online_is_leader = _struct.is_leader;
				engine().online_leader_connection = -1;
				state = RANDOM_MATCHMAKING_STATE.holepunching;
				state_frame = 0;
				log("The server sent back the other player's data for holepunching!");
				}
			break;
		}
	time_since_last_packet = 0;
	}
/* Copyright 2024 Springroll Games / Yosi */