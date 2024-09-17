///@param {real} x0			The x coordinate of the top left corner
///@param {real} y0			The y coordinate of the top left corner
///@param {real} x1			The x coordinate of the top right corner
///@param {real} y1			The y coordinate of the top right corner
///@param {real} x2			The x coordinate of the bottom right corner
///@param {real} y2			The y coordinate of the bottom right corner
///@param {real} x3			The x coordinate of the bottom left corner
///@param {real} y3			The y coordinate of the bottom right corner
///@param {real} percent_x	How far across the point is in the x direction, from 0 to 1
///@param {real} percent_y	How far down the point is in the y direction, from 0 to 1
/*
Given a shape with 4 corners, this function returns a struct with the following properties:
	- x : The x coordinate of a point "percent_x" across the shape and "percent_y" down the shape
	- y : The y coordinate of a point "percent_x" across the shape and "percent_y" down the shape

This is the inverse of the <spread_percents_get> function.
*/
function spread_positions_get()
	{
	var _ax = argument[0];
	var _ay = argument[1];
	var _bx = argument[2];
	var _by = argument[3];
	var _cx = argument[4];
	var _cy = argument[5];
	var _dx = argument[6];
	var _dy = argument[7];
	var _u = argument[8];
	var _v = argument[9];
	
	return
		{
		x : _ax + ((_bx - _ax) * _u) + ((_dx - _ax) * _v) + ((_ax - _bx + _cx - _dx) * _u * _v),
		y : _ay + ((_by - _ay) * _u) + ((_dy - _ay) * _v) + ((_ay - _by + _cy - _dy) * _u * _v),
		};
	}
/* Copyright 2024 Springroll Games / Yosi */