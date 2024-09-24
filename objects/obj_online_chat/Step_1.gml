///@description
//Exit if a popup is open
if (popup_is_open()) then exit;

if (display_chat)
	{
	var _array = mis_devices_get_array();
	for (var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i]; 
		var _confirm = mis_device_input(_id, MIS_INPUT.confirm);
		var _back = mis_device_input(_id, MIS_INPUT.back);
		var _option = mis_device_input(_id, MIS_INPUT.option);
		var _remove = mis_device_input(_id, MIS_INPUT.remove);
		var _start = mis_device_input(_id, MIS_INPUT.start);
		var _select = mis_device_input(_id, MIS_INPUT.select);
		var _stickv = (mis_device_stick_press_repeated(_id).y);
		var _ud = sign(mis_device_stick_values(_id).y);
	
		//Selecting a message
		if (_stickv)
			{
			menu_sound_play(snd_menu_move);
			current_preset = modulo(current_preset + _ud, array_length(obj_ggmr_chat.chat_preset_messages));
			redraw = true;
			}
		
		//Sending a message
		if (_confirm || _option || _start)
			{
			menu_sound_play(snd_menu_select);
			ggmr_chat_send(current_preset);
			}
		
		//Closing the chat
		if (_back || _remove || _select)
			{
			//Delete the "select" input so the chat isn't immediately opened up again
			mis_device_input_delete(_id, MIS_INPUT.select);
			display_chat = false;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */