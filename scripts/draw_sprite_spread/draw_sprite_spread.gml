///@param {asset} sprite	The sprite to draw
///@param {int} frame		The subimage of the sprite to draw
///@param {real} x0			The x coordinate of the top left corner
///@param {real} y0			The y coordinate of the top left corner
///@param {real} x1			The x coordinate of the top right corner
///@param {real} y1			The y coordinate of the top right corner
///@param {real} x2			The x coordinate of the bottom right corner
///@param {real} y2			The y coordinate of the bottom right corner
///@param {real} x3			The x coordinate of the bottom left corner
///@param {real} y3			The y coordinate of the bottom right corner
/*
Draws a sprite evenly spread over an area defined by the 4 corners given.
*/
function draw_sprite_spread()
	{
	var _sprite = argument[0];
	var _frame = argument[1];
	var _x0 = floor(argument[2] + 0.5);
	var _y0 = floor(argument[3] + 0.5);
	var _x1 = floor(argument[4] + 0.5);
	var _y1 = floor(argument[5] + 0.5);
	var _x2 = floor(argument[6] + 0.5);
	var _y2 = floor(argument[7] + 0.5);
	var _x3 = floor(argument[8] + 0.5);
	var _y3 = floor(argument[9] + 0.5);
	
	var _uvs = sprite_get_uvs(_sprite, _frame);
	
	shader_set(shd_spread_sprite);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_sprite, "corners_AB"), [_x0, _y0, _x1, _y1]);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_sprite, "corners_CD"), [_x2, _y2, _x3, _y3]);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_sprite, "sprite_uvs"), _uvs);
	draw_sprite_pos(_sprite, _frame, _x0, _y0, _x1, _y1, _x2, _y2, _x3, _y3, 1.0);
	shader_reset();
	}
/* Copyright 2024 Springroll Games / Yosi */