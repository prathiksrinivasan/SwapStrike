///@description Update
if (!visible) then exit;

//Check if any of the touch devices click inside the circle, and store which one does
for (var i = 0; i < touch_devices_limit; i++)
	{
	var _mx = device_mouse_x_to_gui(i);
	var _my = device_mouse_y_to_gui(i);
	
	//If the device started a click on this frame
	if (device_mouse_check_button_pressed(i, mb_left))
		{
		//Relative
		if (engine().touch_stick_type == TOUCH_STICK_TYPE.relative)
			{
			if (_mx < screen_width div 2)
				{
				stick_device_index = i;
				x = anchor_x;
				y = anchor_y;
				mouse_x_previous = _mx;
				mouse_y_previous = _my;
				mouse_x_initial = _mx;
				mouse_y_initial = _my;
				}
			}
		//Absolute
		else
			{
			//If the click was within the anchored circle
			var _extra_checking_distance = 50;
			if (point_distance(anchor_x, anchor_y, _mx, _my) < stick_distance + _extra_checking_distance)
				{
				stick_device_index = i;
				break;
				}
			}
		}
	}

//Move the control stick if the touch device is still being held down
if (stick_device_index != -1)
	{
	if (device_mouse_check_button(stick_device_index, mb_left))
		{
		var _mx = device_mouse_x_to_gui(stick_device_index);
		var _my = device_mouse_y_to_gui(stick_device_index);
		
		//Relative
		if (engine().touch_stick_type == TOUCH_STICK_TYPE.relative)
			{
			//Actual values
			x += (_mx - mouse_x_previous) * touch_stick_sensitivity;
			y += (_my - mouse_y_previous) * touch_stick_sensitivity;
			var _dir = point_direction(anchor_x, anchor_y, x, y);
			var _len = min(point_distance(anchor_x, anchor_y, x, y) / stick_distance, 1);
			stick_x = lengthdir_x(_len, _dir);
			stick_y = lengthdir_y(_len, _dir);
			
			//Drawn position
			var _len = min(point_distance(anchor_x, anchor_y, x, y), stick_distance);
			draw_x = lengthdir_x(_len, _dir);
			draw_y = lengthdir_y(_len, _dir);
			x = anchor_x + draw_x;
			y = anchor_y + draw_y;
			
			mouse_x_previous = _mx;
			mouse_y_previous = _my;
			}
		//Absolute
		else
			{
			var _dir = point_direction(x, y, _mx, _my);
		
			//Actual values
			var _len = min((point_distance(x, y, _mx, _my) * touch_stick_sensitivity) / stick_distance, 1);
			stick_x = lengthdir_x(_len, _dir);
			stick_y = lengthdir_y(_len, _dir);
		
			//Drawn position
			_len = min(point_distance(x, y, _mx, _my), stick_distance);
			draw_x = lengthdir_x(_len, _dir);
			draw_y = lengthdir_y(_len, _dir);
			}
		}
	else
		{
		stick_device_index = -1;
		}
	}

//Return control stick to neutral
if (stick_device_index == -1)
	{
	stick_x = lerp(stick_x, 0, 0.5);
	stick_y = lerp(stick_y, 0, 0.5);
	draw_x = lerp(draw_x, 0, 0.5);
	draw_y = lerp(draw_y, 0, 0.5);
	}

/* Copyright 2024 Springroll Games / Yosi */