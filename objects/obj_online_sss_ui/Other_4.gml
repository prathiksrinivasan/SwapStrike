///@description
//MIS
mis_init();

//Background animation
menu_background_color_set($7FB252);

//Universal Cursor
ui_cursor_add(0, room_width div 2, room_height div 2);

//Important instances (you can get instance names from the room editor!)
stage_name_label = inst_7F2CD651;
stage_preview_image = inst_22AC303E;
stage_select_timer_label = inst_4AFF8335;

//Selection
stage_selected = false;
stage_select_timer = 5 * 60;
stage_select_timer_label.text = "Starting in 5 seconds...";

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
			case "stage_data":
				//Get the stage data
				setting().match_stage = _struct.stage;
				
				//Start
				online_sss_start();
				break;
			case "disconnect":
				popup_create("Disconnected from opponent (Trigger: Disconnect packet)", [], c_red);
				engine().private_lobby_resume = false;
				room_goto(rm_main_menu);
				break;
			default: log("[obj_online_sss_ui: Room Start] Received a packet with an unrecognized packet_type: ", _struct.packet_type); break;
			}
		}
	);
/* Copyright 2024 Springroll Games / Yosi */