///@args number,name,location,connection,[client_type],[ready]
///@desc Adds the UI elements for a given lobby member.
function private_lobby_ui_create_member()
	{
	var _n = argument[0];
	var _x = 96;
	var _y = 112 + (48 * _n);
	var _layer = "UI_Member_Layer"; 
	var _group = (group_start_number + _n);
	var _name = argument[1];
	var _location = argument[2];
	var _connection = argument[3];
	var _player_type = argument_count > 4 ? argument[4] : GGMR_CLIENT_TYPE.player;
	var _ready = argument_count > 5 ? argument[5] : false;
	
	//Group
	with (instance_create_layer(_x, _y, _layer, obj_ui_group))
		{
		ui_set_group(id, _group);
		}
	//Ready
	with (instance_create_layer(_x + 32, _y + 16, _layer, obj_ui_image))
		{
		member_index = _n;
		ui_script_step = private_lobby_ui_ready_image_step;
		sprite = spr_ready_up;
		frame = (_ready ? 1 : 0);
		ui_set_group(id, _group);
		}
	//Name
	with (instance_create_layer(_x + 48, _y, _layer, obj_ui_label))
		{
		image_xscale = 5.5;
		text = string(_name);
		halign = -1;
		ui_set_group(id, _group);
		}
	//Spectator Button (can only be pressed if you are the leader)
	with (instance_create_layer(_x + 336, _y, _layer, obj_ui_button))
		{
		member_index = _n;
		image_xscale = 3;
		text = (_player_type == GGMR_CLIENT_TYPE.player) ? "Player" : "Spectator";
		ui_script_step = private_lobby_ui_type_button_step;
		ui_set_group(id, _group);
		}
	//Team Button (can only be pressed if you are the leader)
	with (instance_create_layer(_x + 426, _y, _layer, obj_ui_button))
		{
		member_index = _n;
		image_xscale = 3;
		var _teams = obj_ggmr_lobby.lobby_custom_data.teams;
		text = "Team " + string(_teams[@ member_index] + 1);
		ui_script_step = private_lobby_ui_team_button_step;
		ui_set_group(id, _group);
		}
	//Remote players only:
	if (_location == GGMR_LOCATION_TYPE.remote)
		{
		//Kick Button - if you are the leader
		if (ggmr_lobby_is_leader())
			{
			with (instance_create_layer(_x + 576, _y, _layer, obj_ui_button))
				{
				member_index = _n;
				image_xscale = 2.5;
				text = "Kick";
				ui_script_step = private_lobby_ui_kick_button_step;
				ui_set_group(id, _group);
				}
			}
		//Ping
		with (instance_create_layer(_x + 704, _y + 16, _layer, obj_ui_image))
			{
			connection = _connection;
			ui_script_step = private_lobby_ui_ping_image_step;
			sprite = spr_ping;
			frame = 1;
			ui_set_group(id, _group);
			}
		with (instance_create_layer(_x + 720, _y, _layer, obj_ui_label))
			{
			connection = _connection;
			text = "---";
			halign = -1;
			ui_script_step = private_lobby_ui_ping_label_step;
			ui_set_group(id, _group);
			}
		}
	//Personal marker
	if (_n == obj_ggmr_lobby.lobby_member_number)
		{
		with (instance_create_layer(_x, _y, _layer, obj_ui_section))
			{
			image_xscale = 0.25;
			image_yscale = 1;
			image_blend = $777777;
			ui_set_group(id, _group);
			}
		}
	//Background
	with (instance_create_layer(_x, _y, _layer, obj_ui_section))
		{
		depth += 1;
		image_xscale = 24;
		image_yscale = 1;
		image_blend = $444444;
		ui_set_group(id, _group);
		}
	}
/* Copyright 2024 Springroll Games / Yosi */