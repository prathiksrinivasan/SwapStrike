
group_start_number = 10; //make sure the UI group doesn't overlap with anything else!

//Only supports 1 player currently
cursor_active = true;
ui_cursor_add(0, room_width div 2, room_height div 2);
token = { x : room_width div 2, y : room_height div 2 };
token_held = noone;

//Menu Input System
mis_init();
mis_auto_connect_enable(true);
mis_last_device_used_id = undefined;

//Online Input Delay
if (engine().online_mode == ONLINE_MODE.quickplay)
	{
	//In Quickplay, the minimum input delay is higher
	engine().online_input_delay = max(GGMR_INPUT_DELAY_DEFAULT, engine().online_input_delay);
	}
	
//Timer
inst_6532887A.text = "Starting match in 30 seconds...";
match_start_timer = 30 * 60;

//GGMR Custom
packet = buffer_create(1, buffer_grow, 1);
timer = 0;
ggmr_custom_init
	(
	//Step
	function()
		{
		return;
		},
		
	//Async
	function()
		{
		//When receiving ready up data from other players
		var _async_load = argument[0];
		var _buffer = _async_load[? "buffer"];
		var _struct = json_parse(buffer_read(_buffer, buffer_string));
		switch (_struct.packet_type)
			{
			case "ready_up_data":
				assert(engine().online_is_leader, "[obj_online_css_ui: Room Start] Cannot receive a 'ready_up_data' packet when not the leader!");
				menu_sound_play(snd_menu_alert);
				//Set the player's data
				var _player_number = _struct.player_number;
				var _player = engine().css_player_data[@ _player_number];
				_player[@ CSS_PLAYER.character] = _struct.character;
				_player[@ CSS_PLAYER.color] = _struct.color;
				var _cc = custom_controls_create();
				_cc.right_stick_input = _struct.right_stick_input;
				_cc.scs = _struct.scs;
				_cc.acs = _struct.acs;
				
				//Profile
				var _opponent_name = _struct.name;
				if (!engine().online_show_names)
					{
					_opponent_name = "---";
					}
				_player[@ CSS_PLAYER.profile] = profile_create
					(
					_opponent_name,
					_cc,
					true,
					);
					
				//Set the player's ready property
				_player[@ CSS_PLAYER.custom].ready = true;
					
				//Change the UI to show the player is ready
				var _connection = ggmr_net_connection_find(ggmr_net_ip_address_convert(_async_load[? "ip"]), _async_load[? "port"]);
				with (obj_ui_image)
					{
					if (name == _connection && sprite_index == spr_ready_up)
						{
						frame = 1;
						break;
						}
					}
				break;
			case "ready_up":
				assert(!engine().online_is_leader, "[obj_online_css_ui: Room Start] Received a 'ready_up' packet despite being the leader!");
				//Set the player's ready property
				var _player_number = _struct.player_number;
				var _player = engine().css_player_data[@ _player_number];
				_player[@ CSS_PLAYER.custom].ready = true;
					
				//Change the UI to show the player is ready
				var _connection = ggmr_net_connection_find(ggmr_net_ip_address_convert(_async_load[? "ip"]), _async_load[? "port"]);
				with (obj_ui_image)
					{
					if (name == _connection && sprite_index == spr_ready_up)
						{
						frame = 1;
						break;
						}
					}
				break;
			case "start_data":
				assert(!engine().online_is_leader, "[obj_online_css_ui: Room Start] Received a 'start_data' packet despite being the leader!");
				
				//Player data
				var _css_data = _struct.css_data;
				var _num = array_length(_css_data);
				assert(_num == css_players_count(), "[obj_online_css_ui: Room Start] Number of players in the received start data (", _num, ") != the local CSS data (", css_players_count(), ")");
				for (var i = 0; i < _num; i++)
					{
					//Don't overwrite your own data!
					if (i == local_player_number) then continue;
					
					var _data = _css_data[@ i];
					var _player = engine().css_player_data[@ i];
					_player[@ CSS_PLAYER.character] = _data.character;
					_player[@ CSS_PLAYER.color] = _data.color;
					var _cc = custom_controls_create();
					_cc.right_stick_input = _data.right_stick_input;
					_cc.scs = _data.scs;
					_cc.acs = _data.acs;
					
					//Profile
					var _opponent_name = _data.name;
					if (!engine().online_show_names)
						{
						_opponent_name = "---";
						}
					_player[@ CSS_PLAYER.profile] = profile_create
						(
						_opponent_name,
						_cc,
						true,
						);
					}
					
				//Match settings
				match_settings_load(_struct.match_settings);
				
				//Start
				online_css_start();
				break;
			case "disconnect":
				popup_create("Disconnected from opponent (Trigger: Disconnect packet)", [], c_red);
				engine().private_lobby_resume = false;
				room_goto(rm_main_menu);
				break;
			default: log("[obj_online_css_ui: Room Start] Received a packet with an unrecognized packet_type: ", _struct.packet_type); break;
			}
		}
	);
	
ggmr_logger_init();
ggmr_logger_display(true);

//Background animation
menu_background_color_set($FFAC30);

//Add the CSS players based on the Engine Player Data
css_players_clear();
var _num = player_count();
assert(_num > 0, "[obj_online_css_ui: Room Start] There is no data in engine().player_data for the online CSS to load!");

local_player_id = noone;
local_player_number = -1;
for (var i = 0; i < _num; i++)
	{
	var _player = engine().player_data[@ i];
	var _custom = _player[@ PLAYER_DATA.custom];
	_custom.ready = false;
	
	var _player_type = _custom.client_type;
	switch (_player_type)
		{
		case GGMR_CLIENT_TYPE.player:
			//Add the CSS player
			var _id = css_player_add
				(
				_player[@ PLAYER_DATA.device],
				_player[@ PLAYER_DATA.device_type],
				_player[@ PLAYER_DATA.profile],
				_player[@ PLAYER_DATA.is_cpu],
				_player[@ PLAYER_DATA.custom],
				);
			css_player_set(_id, CSS_PLAYER.team, _player[@ PLAYER_DATA.team]);
			
			//If they are the local player, the id is stored
			if (_custom.location == GGMR_LOCATION_TYPE.local)
				{
				local_player_id = _id;
				local_player_number = i;
				token_held = _id;
				//Currently only 1 local player is supported
				}
			break;
		case GGMR_CLIENT_TYPE.spectator:
			//Don't add spectators to the CSS, so they won't be included in the game!
			break;
		}
	}
	
//Create the UI for remote players / spectators
var _x = 736;
var _y = 352;
for (var i = 0; i < array_length(engine().client_data); i++)
	{
	var _client = engine().client_data[@ i];
	var _location = _client[@ CLIENT_DATA.location];
	if (_location == GGMR_LOCATION_TYPE.remote)
		{
		with (instance_create_layer(_x + 32, _y, "UI_Players_Layer", obj_ui_label))
			{
			text = _client[@ CLIENT_DATA.name];
			halign = -1;
			image_yscale = 0.5;
			ui_set_group(id, other.group_start_number + i);
			}
		if (_client[@ CLIENT_DATA.client_type] == GGMR_CLIENT_TYPE.spectator)
			{
			with (instance_create_layer(_x + 16, _y + 8, "UI_Players_Layer", obj_ui_image))
				{
				sprite = spr_spectator;
				ui_set_group(id, other.group_start_number + i);
				}
			}
		else
			{
			with (instance_create_layer(_x + 16, _y + 8, "UI_Players_Layer", obj_ui_image))
				{
				name = _client[@ CLIENT_DATA.connection]; //Player connection
				sprite = spr_ready_up;
				frame = 0;
				ui_set_group(id, other.group_start_number + i);
				}
			}
		with (instance_create_layer(_x, _y, "UI_Players_Layer", obj_ui_section))
			{
			image_blend = $4C4C4C;
			image_xscale = 6.5;
			image_yscale = 0.5;
			ui_set_group(id, other.group_start_number + i);
			}
		_y += 24;
		}
	}
	
//Set the input delay to the suggested delay
engine().online_input_delay = max(GGMR_INPUT_DELAY_DEFAULT, online_css_calculate_input_delay());
/* Copyright 2024 Springroll Games / Yosi */