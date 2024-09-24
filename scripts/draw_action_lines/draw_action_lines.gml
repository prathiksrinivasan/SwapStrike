///@category FX
///@param {real} x					The x position the action lines are centered around
///@param {real} y					The y position the action lines are centered around
///@param {real} w					The width of the screen
///@param {real} h					The height of the screen
///@param {int} [number]			The number of lines to draw
///@param {real} [line_width]		The maximum width of the lines
///@param {real} [deadzone]			The area around the center coordinates that the lines do not cover
///@param {real} [variation]		The maximum variation in the length of the lines
///@param {color} [color]			The color of the lines
///@param {real} [random]			A number to randomize the lines with
/*
Draws actions lines centered around the given x and y.
*/
function draw_action_lines()
	{
	var _x = argument[0];
	var _y = argument[1];
	var _w = argument[2];
	var _h = argument[3];
	var _number = argument_count > 4 ? argument[4] : 20;
	var _line_width = argument_count > 5 ? argument[5] : 50;
	var _deadzone = argument_count > 6 ? argument[6] : 200;
	var _variation = argument_count > 7 ? argument[7] : 100;
	var _color = argument_count > 8 ? argument[8] : c_white;
	var _random = argument_count > 9 ? argument[9] : 1;
	var _angle_variation = 20;
	var _dir = 0;
	var _inc = 360 / _number;
	var _length = sqrt((_w * _w) + (_h * _h));

	draw_set_color(_color);
	draw_primitive_begin(pr_trianglelist);
	for (var i = 0; i < _number; i++)
		{
		var _r = sin(i + _random);
		var _dir = (_inc * i) + (_r * _angle_variation);
		var _x_outer = _x + lengthdir_x(_length, _dir);
		var _y_outer = _y + lengthdir_y(_length, _dir);
		var _length_inner = _deadzone + (_r * _variation);
		var _x_inner = _x + lengthdir_x(_length_inner, _dir);
		var _y_inner = _y + lengthdir_y(_length_inner, _dir);
		var _length_offset = (_r * _line_width);
		var _x_outer_offset = _x_outer + lengthdir_x(_length_offset, _dir + 90);
		var _y_outer_offset = _y_outer + lengthdir_y(_length_offset, _dir + 90);
		draw_vertex(_x_outer, _y_outer);
		draw_vertex(_x_inner, _y_inner);
		draw_vertex(_x_outer_offset, _y_outer_offset);
		}
	draw_primitive_end();
	}
/* Copyright 2024 Springroll Games / Yosi */