///@description Update
if (!visible) then exit;

var _click = false;
var _held = false;
var _any_inside = false;

pressed = false;
image_index = 0;

for (var i = 0; i < touch_devices_limit; i++)
	{
	var _x = device_mouse_x_to_gui(i);
	var _y = device_mouse_y_to_gui(i);
	var _hold = device_mouse_check_button(i, mb_left);
	_click = device_mouse_check_button_pressed(i, mb_left);
	if (point_in_rectangle(_x, _y, bbox_left, bbox_top, (bbox_right - 1), (bbox_bottom - 1)))
		{
		image_index = 1;
		if (_click)
			{
			pressed = true;
			mouse_inside = true;
			image_index = 2;
			_any_inside = true;
			break;
			}
		else if (_hold && mouse_inside)
			{
			_held = true;
			image_index = 2;
			_any_inside = true;
			break;
			}
		}
	}

if (!_any_inside)
	{
	mouse_inside = false;
	}

if (_held || _click)
	{
	held_time++;
	}
else
	{
	held_time = 0;
	}
	
/* Copyright 2024 Springroll Games / Yosi */