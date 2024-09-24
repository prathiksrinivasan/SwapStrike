///@description
state = PRIVATE_LOBBY_STATE.normal;

group_start_number = 10; //Make sure the UI group doesn't overlap with anything else!

//Match settings
match_settings_y = -224;
match_settings_choices =
	[
	"Stock",
	"Time",
	"Stamina",
	"Teams",
	"Team Attack",
	"Items",
	"Screen Wrap",
	"EX Meter",
	"Final Smash Meter",
	];
match_settings_current = 0;
match_settings_selector = noone;
var _vals = stamina_valid_values;
stamina_index = 0;
for (var i = 0; i < array_length(_vals); i++)
	{
	if (_vals[@ i] == setting().match_stamina)
		{
		stamina_index = i;
		break;
		}
	}
var _vals = items_frequency_valid_values;
items_frequency_index = 0;
for (var i = 0; i < array_length(_vals); i++)
	{
	if (_vals[@ i] == setting().match_items_frequency)
		{
		items_frequency_index = i;
		break;
		}
	}

//Only supports 1 player currently
ui_cursor_add(0, room_width div 2, room_height div 2);

//Menu Input System
mis_init();
mis_device_disconnect_all();
mis_auto_connect_enable(true);
mis_last_device_used = 0;

//Online
engine().is_online = true;
engine().online_mode = ONLINE_MODE.private_lobby;
ggmr_lobby_init
	(
	engine().online_name,
	function()
		{
		//Automatically refresh the lobby UI when the lobby is reset, to prevent errors
		private_lobby_ui_refresh();
		},
	);

//Background animation
menu_background_color_set($4E4EE5);

//Join requests
join_request_list_show = false;
join_request_list_x = room_width + 32;
join_request_current = -1;
join_request_scroll = 0;
join_request_list_display_size = 19;
join_request_list_size = 0;

//Networking
packet = buffer_create(1, buffer_grow, 1);
target_port = GGMR_PORT;

//Resuming the lobby
if (engine().private_lobby_resume)
	{
	engine().private_lobby_resume = false;
	
	//Load members
	ggmr_lobby_members_load(engine().private_lobby_json);
	
	//Renew the connect code
	connect_code_to_reserve = engine().online_connect_code; //The code you are trying to get
	connect_code_state = "reserving";
	connect_code_reserved = false;
	connect_code_timer = 0;
	connect_code_message = "";
	server_send_packet(obj_ggmr_net.net_socket, packet, "private_lobby_reserve", connect_code_to_reserve);
	}
else
	{
	//Connect code
	var _random_code = "";
	var _valid_chars = valid_string_auto_characters;
	repeat (irandom_range(3, 5))
		{
		_random_code += _valid_chars[@ irandom(array_length(_valid_chars) - 1)];
		}
	engine().online_connect_code = ""; //Your connect code
	connect_code_to_reserve = _random_code; //The code you are trying to get
	connect_code_state = "reserving";
	connect_code_reserved = false;
	connect_code_timer = 0;
	connect_code_message = "";
	server_send_packet(obj_ggmr_net.net_socket, packet, "private_lobby_reserve", connect_code_to_reserve);
	
	//Reset match settings
	match_settings_default();
	
	//Teams
	obj_ggmr_lobby.lobby_custom_data.teams = array_create(GGMR_PLAYERS_MAX, 0);
	obj_ggmr_lobby.lobby_custom_data.match_settings = match_settings_save();
	}
	
//Set up the UI
private_lobby_ui_refresh();

previous_number_of_players = 0;

auto_spectator_ready = true;

//Clear player data
player_data_clear();
spectator_data_clear();
client_data_clear();
/* Copyright 2024 Springroll Games / Yosi */