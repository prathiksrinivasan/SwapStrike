///@category Spectator Engine Scripts
///@param {int} spectator_number		The spectator to set data for
///@param {int} data					The data to set, from the SPECTATOR_DATA enum
///@param {any} value					The value to set the data to
/*
Sets data for the given spectator.
*/
function spectator_data_set()
	{
	var _spectator = engine().spectator_data[argument[0]];
	_spectator[@ argument[1]] = argument[2];
	}
/* Copyright 2024 Springroll Games / Yosi */