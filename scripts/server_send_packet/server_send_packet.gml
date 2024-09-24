///@category Server
///@param {int} socket					The socket to send the packet from
///@param {buffer} buffer				The buffer to use for the packet
///@param {string} type					The type of packet to send
///@param {any} [data]					The data to add to the buffer
/*
Sends a packet with the given type and data to the server from the given socket.
This function also needs a buffer to be cleared and used for the packet (to avoid creating new buffers every time a packet is sent).
The location of the server must be predetermined in the macros <server_ip_address> and <server_port>. Additionally, the game's <version> and <server_key_random_matchmaking>/<server_key_private_lobby> must match that of the server.

The "type" can be any one of the following strings:
	- "random_matchmaking_begin": 
		Tells the server to add the player to the random matchmaking list. 
		If the player is already in the list, the server will update the timestamp on the player's entry so they won't time out.
	- "random_matchmaking_cancel": 
		Tells the server to remove the player from the random matchmaking list.
	- "holepunching_begin": 
		The "match_id" previously received from the server must be sent in the data. The server will check if there is another player sending a request with the same match_id, and if so, it will send back that player's IP and port.
	- "holdpunching_cancel":
		The "match_id" previously received from the server must be sent in the data. Tells the server to remove the player from the holepunching map.
	- "private_lobby_reserve":
		Attempts to reserve a lobby with the code sent in the data. If the player already reserved the lobby, the lobby timeout is reset.
	- "private_lobby_find":
		Checks the server for a lobby with the code sent in the data. If that lobby exists, the server sends the IP addresses and ports to both players.
	- "private_lobby_free":
		Tells the server to free all lobbies reserved by the player.
	- "fetch_news":
		Asks the server for any PFE news or announcements.
	
If the server receives the packet and the packet has the correct key, the server can send back packets with any of the following types:
	- "incorrect_version":
		The player's game version string does not match any of the server's supported version strings.
	- "random_matchmaking_confirmation":
		Either the server has been able to add the player to the matchmaking list successfully, or the player was already in the matchmaking list.
	- "random_matchmaking_found":
		The server has found another player to match with. The data contains the "match_id" number that should be used for holepunching.
	- "random_matchmaking_cancel_confirmation":
		The server has removed the player from the random matchmaking list.
	- "holepunching_confirmation":
		Either the server has been able to add the player to the holepuncing map successfully, or the player was already in the holepunching map.
	- "holepunching_found":
		The server found someone else with the same match_id in the holepunching map.
		The data is a struct with the IP and port.
	- "holepunching_cancel_confirmation":
		The server has removed the player from the holepunching map.
	- "private_lobby_reserve_confirmation":
		The server was able to reserve the entered lobby code for the player.
	- "private_lobby_code_taken":
		The server has already reserved the lobby code for someone else.
	- "private_lobby_found":
		The server found the lobby for the player to join. The data contains the IP and port of the player who reserved the lobby.
	- "private_lobby_not_found":
		The server could not find a lobby with the given code.
	- "private_lobby_is_self":
		The code you tried to join is a code you currently have reserved.
	- "private_lobby_request":
		Someone is trying to join the server. The data contains their IP and port.
	- "private_lobby_free_confirmation":
		The server was able to free the player's reserved lobby.
	- "news":
		Any PFE news or announcements stored on the server.
*/
function server_send_packet()
	{
	var _socket = argument[0];
	var _b = argument[1];
	var _type = argument[2];
	var _data = argument_count > 3 ? argument[3] : 0;
	var _total_data = { type : _type, data : _data };
	
	//Clear the buffer
	buffer_reset(_b, false);
	
	//Add the server key and the version
	_total_data[$ "version"] = version_string;
	_total_data[$ "keys"] = server_keys();
	
	//Convert to json
	var _json = json_stringify(_total_data);
	buffer_write(_b, buffer_text, _json);
	buffer_resize(_b, buffer_tell(_b));
	
	//Send the packet to the server
	var _result = network_send_udp_raw(_socket, server_ip_address, server_port, _b, buffer_get_size(_b));
	if (_result > 0)
		{
		return true;
		}
	else
		{
		log("Could not send the packet to the server!");
		return false;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */