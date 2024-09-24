///@category Collisions
///@param {int} x0				The first point of the line
///@param {int} y0				The first point of the line
///@param {int} x1				The second point of the line
///@param {int} y1				The second point of the line
///@param {asset} object		The object to check for collisions
///@param {bool} precise		Whether to use precise collision checking or not
///@param {bool} not_me			Whether to exclude the calling object from collisions or not
/*
Finds the first point of collision with a specific object along a line.
It returns a struct with the following properties:
	- id : The instance id found in the collision.
	- x : The x position of the collision.
	- y : The y position of the collision.
*/
function collision_line_point()
	{
	var _x0 = argument[0];
	var _y0 = argument[1];
	var _x1 = argument[2];
	var _y1 = argument[3];
	var _obj = argument[4];
	var _prec = argument[5];
	var _notme = argument[6];
	
	//Struct to return
	var _results =
		{
		id : noone,
		x : _x1,
		y : _y1,
		};
	
	//Original check
	_results.id = collision_line(_x0, _y0, _x1, _y1, _obj, _prec, _notme);
	if (_results.id != noone)
		{
		//Use binary search
		var _percent = 0.5;
		var _x_len = (_x1 - _x0);
		var _y_len = (_y1 - _y0);
		repeat (ceil(log2(point_distance(_x0, _y0, _x1, _y1))))
			{
			var _x_mid = _x0 + (_x_len * _percent);
			var _y_mid = _y0 + (_y_len * _percent);
			
			//Check the first half for a collision
			var _middle_check = collision_line(_x0, _y0, _x_mid, _y_mid, _obj, _prec, _notme);
			if (_middle_check != noone)
				{
				//If there is a collision in the first half, continue checking that part
				_results.id = _middle_check;
				_results.x = _x_mid;
				_results.y = _y_mid;
				}
			else
				{
				//If there is no collision in the first half, check the second half next
				_x0 = _x_mid;
				_y0 = _y_mid;
				}
			
			//Check half the length next time
			_percent *= 0.5;
			}
		}
	
	return _results;
	}
/* Copyright 2024 Springroll Games / Yosi */