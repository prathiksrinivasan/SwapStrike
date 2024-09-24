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
		crash("[obj_private_lobby_ui: Async - Networking] Received a packet with an invalid type (", _type, ") or invalid data (", _data, ")");
		}
	
	//Different types of server response packets / player data packets
	switch (_type)
		{
		case "private_lobby_reserve_confirmation":
			//The code has been reserved
			if (connect_code_to_reserve != "")
				{
				engine().online_connect_code = connect_code_to_reserve;
				}
			connect_code_to_reserve = "";
			connect_code_state = "normal";
			connect_code_reserved = true;
			connect_code_timer = 0;
			connect_code_message = "";
			break;
		case "private_lobby_code_taken":
			//The code cannot be reserved
			connect_code_to_reserve = "";
			connect_code_state = "failed";
			connect_code_timer = 0;
			connect_code_message = "The connect code is already taken!\n(If this lobby was recently used, it may take up to 10 minutes before it is available again)";
			break;
		case "private_lobby_found":
			//The lobby has been found - send a join request
			connect_code_state = "normal";
			connect_code_timer = 0;
			var _struct = json_parse(_data);
			ggmr_net_connection_save(_struct.ip, _struct.port);
			ggmr_lobby_join_request_send(_struct.ip, _struct.port);
			break;
		case "private_lobby_not_found":
			//The lobby you tried to join does not exist
			connect_code_state = "failed";
			connect_code_timer = 0;
			connect_code_message = "No lobbies were found with the given connect code!";
			break;
		case "private_lobby_request":
			//Someone is trying to send a join request to your lobby
			var _struct = json_parse(_data);
			ggmr_net_connection_save(_struct.ip, _struct.port);
			break;
		case "private_lobby_free_confirmation":
			break;
		case "private_lobby_is_self":
			//You can't join your own lobby
			connect_code_state = "failed";
			connect_code_timer = 0;
			connect_code_message = "You can't join your own lobby!";
			break;
		case "incorrect_version":
			//The game is the wrong version
			if (!popup_is_open())
				{
				popup_create(string(_data), [], c_red);
				log("Matchmaking has been canceled");
				room_goto(rm_main_menu);
				}
			break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */