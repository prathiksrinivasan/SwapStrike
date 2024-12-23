///@category Buffers
///@param {buffer} buffer				The buffer to write to
///@param {string} name					The name of the variable
///@param {buffer_type} type			The data type of the variable
///@param {any} value					The variable's current value
/*
Writes a variable to a buffer. This is primarily designed to be used in conjunction with <instance_load_all_vars> / <game_state_load_objects_init>.
The type must be one of the built-in "buffer_" constants.
Please note: As of version 1.3.0, this function is no longer used in the base engine.
*/
function buffer_write_var()
	{
	var _b = argument[0];
	var _name = argument[1];
	var _type = argument[2];
	var _val = argument[3];
	
	buffer_write(_b, buffer_string, _name);
	buffer_write(_b, buffer_s8, _type);
	buffer_write(_b, _type, _val);
	}

/* Copyright 2024 Springroll Games / Yosi */