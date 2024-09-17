///@description

//Timer
popup_timer = max(--popup_timer, 0);

//Player inputs
var _array = mis_devices_get_array();
for (var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i]; 
	var _confirm = mis_device_input_repeated(_id, MIS_INPUT.confirm);
	var _back = mis_device_input_repeated(_id, MIS_INPUT.back);
	var _start = mis_device_input_repeated(_id, MIS_INPUT.start);
	var _stickv = (mis_device_stick_press_repeated(_id).y);
	var _ud = sign(mis_device_stick_values(_id).y);

	//Choices
	if (_stickv && array_length(popup_choices) > 0)
		{
		menu_sound_play(snd_menu_move);
		popup_current = modulo(popup_current + _ud, array_length(popup_choices));
		}
	
	//Selecting a choice
	if (popup_timer == 0)
		{
		if (_confirm || _start)
			{
			menu_sound_play(snd_menu_select);
			if (!is_undefined(popup_callback))
				{
				popup_callback(popup_choices[@ popup_current], popup_custom);
				}
			instance_destroy();
			exit;
			}
	
		//Default to the last choice
		if (_back)
			{
			menu_sound_play(snd_menu_back);
			if (!is_undefined(popup_callback))
				{
				popup_callback(popup_choices[@ array_length(popup_choices) - 1], popup_custom);
				}
			instance_destroy();
			exit;
			}
		}
	}
/* Copyright 2024 Springroll Games / Yosi */