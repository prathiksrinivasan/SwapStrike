///@param {real} x0			The x coordinate of the top left corner
///@param {real} y0			The y coordinate of the top left corner
///@param {real} x1			The x coordinate of the top right corner
///@param {real} y1			The y coordinate of the top right corner
///@param {real} x2			The x coordinate of the bottom right corner
///@param {real} y2			The y coordinate of the bottom right corner
///@param {real} x3			The x coordinate of the bottom left corner
///@param {real} y3			The y coordinate of the bottom right corner
///@param {real} x			The x coordinate of the point
///@param {real} y			The y coordinate of the point
/*
Given a shape with 4 corners, this function returns a struct with the following properties:
	- x : How far across the shape the given "x" coordinate was, from 0 to 1
	- y : How far down the shape the given "y" coordinate was, from 0 to 1

This is the inverse of the <spread_positions_get> function.
*/
function spread_percents_get()
	{
	var _ax = argument[0];
	var _ay = argument[1];
	var _bx = argument[2];
	var _by = argument[3];
	var _cx = argument[4];
	var _cy = argument[5];
	var _dx = argument[6];
	var _dy = argument[7];
	var _x = argument[8];
	var _y = argument[9];
	
	//Calculate the constants for the formula
	var _ex = _bx - _ax;
	var _ey = _by - _ay;
	var _fx = _dx - _ax;
	var _fy = _dy - _ay;
	var _gx = (_ax - _bx) + (_cx - _dx);
	var _gy = (_ay - _by) + (_cy - _dy);
	var _hx = _x - _ax;
	var _hy = _y - _ay;
	
	//Calculate more constants (cross products)
	var _k2 = (_gx * _fy) - (_gy * _fx);
	var _k1 = ((_ex * _fy) - (_ey * _fx)) + ((_hx * _gy) - (_hy * _gx));
	var _k0 = (_hx * _ey) - (_hy * _ex);
	
	//Check if the edges are parallel (gets rid of the squared term)
	if (abs(_k2) < 0.001)
		{
		return
			{
			x :	((_hx * _k1) + (_fx * _k0)) / ((_ex * _k1) - (_gx * _k0)),
			y : -(_k0 / _k1),
			};
		}
	else
		{
		//Use the quadratic formula to solve
		var _intermediate = (_k1 * _k1) - (4.0 * _k0 * _k2);
		
		//Avoid doing a negative square root (from invalid coordinates)
		if (_intermediate < 0.0) then return { x : 0, y : 0 };
		
		//Finish solving for y
		_intermediate = sqrt(_intermediate);
		var _bottom = (0.5 / _k2);
		var _percent_y = (-_k1 - _intermediate) * _bottom;
		
		//Find x
		var _percent_x = (_hx - (_fx * _percent_y)) / (_ex + (_gx * _percent_y));
		
		//Get the positive square root instead of the negative one if the percentages aren't in range
		if (_percent_x < 0.0 || _percent_x > 1.0 || _percent_y < 0.0 || _percent_y > 1.0)
			{
			_percent_y = (-_k1 + _intermediate) * _bottom;
			_percent_x = (_hx - (_fx * _percent_y)) / (_ex + (_gx * _percent_y));
			}
		
		return
			{
			x : _percent_x,
			y : _percent_y,
			};
		}
	}
/* Copyright 2024 Springroll Games / Yosi */