///@description
//Input - accept from all devices
var _confirm = false;
var _start = false;
var _select = false;
var _option = false;
var _array = mis_devices_get_array();
var _skip = false;
for (var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i];
	if (mis_device_input(_id, MIS_INPUT.confirm)) then _confirm = true;
	if (mis_device_input(_id, MIS_INPUT.start)) then _start = true;
	if (mis_device_input(_id, MIS_INPUT.select)) then _select = true;
	if (mis_device_input(_id, MIS_INPUT.option)) then _option = true;
	}

//Offset animations
if (state_phase == 0)
	{
	//Winner phase
	state_timer = lerp(state_timer, 0, 0.1);
	if (state_timer <= 0.1)
		{
		state_phase++;
		state_timer_max = 100;
		state_timer = state_timer_max;
		}
	}
else if (state_phase == 1)
	{
	//All players phase
	state_timer = lerp(state_timer, 0, 0.15);
	if (state_timer <= 0.1)
		{
		state_timer = 0;
		//Press a button to go to the next phase
		if (!popup_is_open())
			{
			if (_confirm || _start)
				{
				state_phase++;
				state_timer_max = 100;
				state_timer = state_timer_max;
				if (setting().replay_mode || !setting().replay_record)
					{
					_skip = true;
					}
				_confirm = false;
				_start = false;
				}
			}
		}
	}
else if (state_phase == 2)
	{
	//Data phase
	state_timer = lerp(state_timer, 0, 0.15);
	if (state_timer <= 0.1)
		{
		state_timer = 0;
		}
	}

//Save replay
if (!popup_is_open() && _option)
	{	
	if (!setting().replay_mode && setting().replay_record && can_save_replay)
		{
		menu_sound_play(snd_menu_alert);
		can_save_replay = false;
		
		//Save replays to the main folder on web exports
		if (web_export)
			{
			replay_save(replay_name + ".pfe");
			}
		else	
			{
			replay_save(version_string + "/" + replay_name + ".pfe");
			}
		}
	}

//Rename replay
if (state_phase >= 2 && _select && can_save_replay)
	{
	if (!popup_is_open())
		{
		var _inputter = string_inputter_get_string
			(
			"Enter the new name for the replay:",
			replay_name,
			function(_string)
				{
				obj_win_screen.replay_name = _string;
				},
			undefined,
			32,
			valid_string_replay_name,
			);
		_inputter.layer = layer_get_id("Top_Layer");
		exit;
		}
	}
	
//Time Limit
var _time_up = false;
time_left--;
if (time_left <= 0 && engine().win_screen_time_limit != -1)
	{
	_time_up = true;
	}

//Go to the preset next room (default is rm_css)
if ((state_phase >= 2 && (_confirm || _start) && !popup_is_open()) || _time_up || _skip)
	{
	//Stop victory theme
	audio_stop_all();
	menu_sound_play(snd_menu_start);
	room_goto(engine().win_screen_next_room);
	exit;
	}

/* Copyright 2024 Springroll Games / Yosi */