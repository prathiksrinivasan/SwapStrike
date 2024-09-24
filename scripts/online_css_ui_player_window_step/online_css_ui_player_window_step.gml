function online_css_ui_player_window_step()
	{
	var _player_id = obj_online_css_ui.local_player_id;
	
	//Exit if a popup is open
	if (popup_is_open()) then exit;
	
	//Exit out if it's a CPU
	if (css_player_get(_player_id, CSS_PLAYER.is_cpu)) then return;
	
	//If you already readied up, you can't make any changes
	var _custom = css_player_get(_player_id, CSS_PLAYER.custom);
	if (_custom.ready) then return;
		
	//Get input from all devices
	var _device_id = _custom.device_id;
	var _stick_press = mis_device_stick_press_repeated(_device_id);
	var _stick_values = mis_device_stick_values(_device_id);
	var _rl = sign(_stick_values.x);
	var _ud = sign(_stick_values.y);
	
	//Collect inputs from all MIS devices
	var _device_id = _custom.device_id; //Default to the device the player first used on the previous menu
	var _confirm = false;
	var _option = false;
	var _back = false;
	//var _delete = false;
	var _next = false;
	var _last = false;
	//var _confirm_repeated = false;
	//var _back_repeated = false;
	var _stick_press = { x : false, y : false };
	var _rl = 0;
	var _ud = 0;
	var _array = mis_devices_get_array();
	for (var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		if (mis_device_input(_id, MIS_INPUT.confirm)) 
			{
			_confirm = true;
			_device_id = _array[i];
			}
		if (mis_device_input(_id, MIS_INPUT.option)) 
			{
			_option = true;
			_device_id = _array[i];
			}
		if (mis_device_input(_id, MIS_INPUT.back))
			{
			_back = true;
			_device_id = _array[i];
			}
		if (mis_device_input(_id, MIS_INPUT.page_next))
			{
			_next = true;
			_device_id = _array[i];
			}
		if (mis_device_input(_id, MIS_INPUT.page_last))
			{
			_last = true;
			_device_id = _array[i];
			}
		var _temp = mis_device_stick_press_repeated(_id);
		if (_temp.x || _temp.y)
			{
			_stick_press = _temp;
			_device_id = _array[i];
			
			var _stick_values = mis_device_stick_values(_id);
			_rl = sign(_stick_values.x);
			_ud = sign(_stick_values.y);
			}
		}
	
	//States
	switch (state)
		{
		case CSS_PLAYER_WINDOW_STATE.select_character:
			//Recall token
			if (_back && obj_online_css_ui.token_held == noone)
				{
				obj_online_css_ui.token_held = _player_id;
				}
					
			//Change color
			if (_option || _next || _last)
				{
				var _current = css_player_get(_player_id, CSS_PLAYER.color);
				var _char = css_player_get(_player_id, CSS_PLAYER.character);
				var _dir = (_option ? 1 : sign(_next - _last));
				var _num_of_colors = character_data_get(_char, CHARACTER_DATA.palette_data).columns;
				var _col = _current + _dir;
				if (_col >= _num_of_colors)
					{
					_col = 1;
					}
				else if (_col < 1)
					{
					_col = _num_of_colors - 1;
					}
				css_player_set
					(
					_player_id, 
					CSS_PLAYER.color, 
					//Note: The script css_character_color_get_next() is NOT used, since it prevents players from choosing the same color.
					//This would let players figure out what character the opponent was using.
					_col,
					);
					
				//Store the favorite color
				var _favorite_colors = profile_get(css_player_get(_player_id, CSS_PLAYER.profile), PROFILE.favorite_colors);
				_favorite_colors[@ _char] = css_player_get(_player_id, CSS_PLAYER.color);
				}
			break;
		case CSS_PLAYER_WINDOW_STATE.select_profile:
			//Scrolling
			if (_stick_press.y)
				{
				menu_sound_play(snd_menu_move);
				profile_current = modulo(profile_current + _ud, profile_count());
				while (profile_current > profile_scroll + 3) 
					{
					profile_scroll++;
					}
				while (profile_current < profile_scroll) 
					{
					profile_scroll--;
					}
				}
		
			//Selecting a profile
			if (_confirm)
				{
				menu_sound_play(snd_menu_select);
				css_player_set(_player_id, CSS_PLAYER.profile, profile_current);
				state = CSS_PLAYER_WINDOW_STATE.select_character;
				//Re activate cursor
				obj_online_css_ui.cursor_active = true;
				break;
				}
					
			//Cancel (don't change the profile)
			if (_back)
				{
				state = CSS_PLAYER_WINDOW_STATE.select_character;
				//Re activate cursor
				obj_online_css_ui.cursor_active = true;
				break;
				}
			break;
		case CSS_PLAYER_WINDOW_STATE.create_profile:
			state = CSS_PLAYER_WINDOW_STATE.select_profile;
			break;
		case CSS_PLAYER_WINDOW_STATE.ready:
			//Nothing
			break;
		}
	}
/* Copyright 2024 Springroll Games / Yosi */