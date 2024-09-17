///@param {int} texture		The texture to draw
///@param {real} x0			The x coordinate of the top left corner
///@param {real} y0			The y coordinate of the top left corner
///@param {real} x1			The x coordinate of the top right corner
///@param {real} y1			The y coordinate of the top right corner
///@param {real} x2			The x coordinate of the bottom right corner
///@param {real} y2			The y coordinate of the bottom right corner
///@param {real} x3			The x coordinate of the bottom left corner
///@param {real} y3			The y coordinate of the bottom right corner
/*
Draws a texture evenly spread over an area defined by the 4 corners given.
*/
function draw_texture_spread()
	{
	var _texture = argument[0];
	var _x0 = floor(argument[1] + 0.5);
	var _y0 = floor(argument[2] + 0.5);
	var _x1 = floor(argument[3] + 0.5);
	var _y1 = floor(argument[4] + 0.5);
	var _x2 = floor(argument[5] + 0.5);
	var _y2 = floor(argument[6] + 0.5);
	var _x3 = floor(argument[7] + 0.5);
	var _y3 = floor(argument[8] + 0.5);
	
	var _uvs = texture_get_uvs(_texture);
	var _buff = global.draw_texture_spread_buffer;
	var _format = global.draw_texture_spread_format;
	
	shader_set(shd_spread_texture);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_texture, "corners_AB"), [_x0, _y0, _x1, _y1]);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_texture, "corners_CD"), [_x2, _y2, _x3, _y3]);
	shader_set_uniform_f_array(shader_get_uniform(shd_spread_texture, "texture_uvs"), _uvs);
	vertex_begin(_buff, _format);
	vertex_position(_buff, _x0, _y0);
	vertex_position(_buff, _x1, _y1);
	vertex_position(_buff, _x3, _y3);
	vertex_position(_buff, _x3, _y3);
	vertex_position(_buff, _x1, _y1);
	vertex_position(_buff, _x2, _y2);
	vertex_end(_buff);
	vertex_submit(_buff, pr_trianglestrip, _texture);
	shader_reset();
	}

//Vertex format
vertex_format_begin();
vertex_format_add_position();
global.draw_texture_spread_format = vertex_format_end();
global.draw_texture_spread_buffer = vertex_create_buffer();
/* Copyright 2024 Springroll Games / Yosi */